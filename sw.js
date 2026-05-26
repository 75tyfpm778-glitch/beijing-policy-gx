/* ============================================================
   Service Worker for 北京城市更新政策问答 PWA
   缓存策略：Cache First + Network Fallback
   版本: 1.0.0
   ============================================================ */

const CACHE_NAME = 'policy-pwa-v1.0.0';
const RUNTIME_CACHE = 'policy-pwa-runtime-v1.0.0';

// 预缓存核心资源列表
const PRECACHE_URLS = [
  './policy_pwa.html',
  './mobile.css',
  './manifest.json',
  './icons/icon-192x192.png',
  './icons/icon-512x512.png'
];

// ==================== Install: 预缓存核心资源 ====================
self.addEventListener('install', (event) => {
  console.log('[SW] Installing...');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('[SW] Precaching core resources');
        return cache.addAll(PRECACHE_URLS);
      })
      .then(() => {
        console.log('[SW] Install completed, skipping waiting');
        return self.skipWaiting();
      })
      .catch((err) => {
        console.error('[SW] Precaching failed:', err);
      })
  );
});

// ==================== Activate: 清理旧缓存 ====================
self.addEventListener('activate', (event) => {
  console.log('[SW] Activating...');
  const cacheWhitelist = [CACHE_NAME, RUNTIME_CACHE];
  event.waitUntil(
    caches.keys()
      .then((cacheNames) => {
        return Promise.all(
          cacheNames.map((cacheName) => {
            if (!cacheWhitelist.includes(cacheName)) {
              console.log('[SW] Deleting old cache:', cacheName);
              return caches.delete(cacheName);
            }
          })
        );
      })
      .then(() => {
        console.log('[SW] Activation complete, claiming clients');
        return self.clients.claim();
      })
  );
});

// ==================== Fetch: Cache First + Network Fallback ====================
self.addEventListener('fetch', (event) => {
  const { request } = event;
  const url = new URL(request.url);

  // 跳过非 GET 请求
  if (request.method !== 'GET') return;

  // 跳过 chrome-extension 等非 HTTP(S) 请求
  if (!url.protocol.startsWith('http')) return;

  // 跳过 analytics / tracking 请求
  if (url.hostname.includes('analytics') || url.hostname.includes('tracking')) {
    return;
  }

  // HTML 页面：Network First（确保获取最新内容）
  if (request.mode === 'navigate' || request.destination === 'document') {
    event.respondWith(networkFirstStrategy(request));
    return;
  }

  // 静态资源（CSS/JS/图片/字体）：Cache First
  if (
    request.destination === 'style' ||
    request.destination === 'script' ||
    request.destination === 'image' ||
    request.destination === 'font' ||
    request.destination === 'manifest'
  ) {
    event.respondWith(cacheFirstStrategy(request));
    return;
  }

  // API / 数据请求：Network First + Runtime Cache
  if (url.pathname.includes('/api/') || request.destination === '') {
    event.respondWith(networkFirstWithRuntimeCache(request));
    return;
  }

  // 其他请求：Cache First 兜底
  event.respondWith(cacheFirstStrategy(request));
});

// ==================== 缓存策略 ====================

/**
 * Cache First：优先使用缓存，缓存未命中时走网络并缓存
 */
async function cacheFirstStrategy(request) {
  const cachedResponse = await caches.match(request);
  if (cachedResponse) {
    return cachedResponse;
  }

  try {
    const networkResponse = await fetch(request);
    if (networkResponse && networkResponse.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, networkResponse.clone());
    }
    return networkResponse;
  } catch (error) {
    console.error('[SW] Cache First fetch failed:', error);
    // 返回离线页面或空响应
    return new Response('Offline - Resource not available', {
      status: 503,
      statusText: 'Service Unavailable'
    });
  }
}

/**
 * Network First：优先网络，网络失败时回退到缓存
 */
async function networkFirstStrategy(request) {
  try {
    const networkResponse = await fetch(request);
    if (networkResponse && networkResponse.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, networkResponse.clone());
    }
    return networkResponse;
  } catch (error) {
    console.log('[SW] Network failed, falling back to cache for:', request.url);
    const cachedResponse = await caches.match(request);
    if (cachedResponse) {
      return cachedResponse;
    }
    // 最终回退：显示离线提示
    return new Response(
      '<html><body style="font-family:sans-serif;text-align:center;padding-top:80px;">' +
      '<h2>📡 网络不可用</h2><p>请检查网络连接后重试</p></body></html>',
      {
        status: 200,
        headers: { 'Content-Type': 'text/html; charset=utf-8' }
      }
    );
  }
}

/**
 * Network First + Runtime Cache：API 数据走网络优先，成功后写入运行时缓存
 */
async function networkFirstWithRuntimeCache(request) {
  try {
    const networkResponse = await fetch(request);
    if (networkResponse && networkResponse.ok) {
      const cache = await caches.open(RUNTIME_CACHE);
      cache.put(request, networkResponse.clone());
    }
    return networkResponse;
  } catch (error) {
    console.log('[SW] API fetch failed, falling back to runtime cache:', request.url);
    const cachedResponse = await caches.match(request);
    if (cachedResponse) {
      return cachedResponse;
    }
    return new Response(
      JSON.stringify({ error: 'Network unavailable', offline: true }),
      {
        status: 503,
        headers: { 'Content-Type': 'application/json; charset=utf-8' }
      }
    );
  }
}

// ==================== 辅助：缓存大小监控 ====================
self.addEventListener('message', (event) => {
  if (event.data && event.data.action === 'getCacheStats') {
    event.waitUntil(
      Promise.all([
        caches.open(CACHE_NAME),
        caches.open(RUNTIME_CACHE)
      ]).then(async ([coreCache, runtimeCache]) => {
        const coreKeys = await coreCache.keys();
        const runtimeKeys = await runtimeCache.keys();

        const client = event.source;
        if (client) {
          client.postMessage({
            action: 'cacheStats',
            core: { name: CACHE_NAME, count: coreKeys.length },
            runtime: { name: RUNTIME_CACHE, count: runtimeKeys.length }
          });
        }
      })
    );
  }

  if (event.data && event.data.action === 'clearRuntimeCache') {
    event.waitUntil(
      caches.delete(RUNTIME_CACHE).then(() => {
        const client = event.source;
        if (client) {
          client.postMessage({ action: 'runtimeCacheCleared' });
        }
      })
    );
  }
});

console.log('[SW] Service Worker registered. Version: 1.0.0');