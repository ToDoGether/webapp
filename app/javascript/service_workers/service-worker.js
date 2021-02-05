// Multimediaprojekt 1 (MMP1) von Bernhard Schmidhuber
// Studiengang Multimedia Technology (MMT), FH Salzburg

const cacheName = 'todogether_v1';

self.addEventListener('install', event =>
{
    console.log("Service Worker: Install");
});

self.addEventListener('activate', event =>
{
    event.waitUntil(
        caches.keys().then(cacheNames =>
        {
            return Promise.all(
                cacheNames.map(cache =>
                {
                    if (cache !== cacheName)
                    {
                        console.log("Service Worker: Clearing Old Cache");
                        return caches.delete(cache);
                    }
                })
            )
        })
    )
});

self.addEventListener('fetch', event =>
{
    const request = event.request;
    event.respondWith(
        fetch(request)
            .then(response =>
            {
                const responseClone = response.clone();
                caches
                    .open(cacheName)
                    .then(cache =>
                    {
                        cache.put(request, responseClone);
                    });
                return response;
            })
            .catch(() => caches.match(request)));
});
