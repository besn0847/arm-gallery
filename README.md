# arm-gallery

To start the container with default config :
```bash
docker run -d -P arm-gallery
```

But you can also use your local datastores :
```bash
docker run -d -P -v <your local gallery folder>:/data/gallery -v <your local cache folder>:/data/cache arm-gallery
```

Make sure you set the cache/ folder directory permissions to 777. 

