# docker-registry
This is a Docker Registry with automatic cleanup of orphaned resources to avoid waste of storage

### How it works

* From time to time (configured with cron string using CLEANUP_CRON ENV) the following will happen:
  1. Registry process is killed
  2. Registry garbage collection is called with "remove-untagged"
  3. Registry process is relaunched

* By default, CLEANUP_CRON is "15 3 * * 7", which means the garbage collector will run every saturday at 03:15 am

* This container supports the same configurations as the official 'registry:2' Docker container


# Usage

* create docker-compose.yml
```yml
version: '3.5'

services:

  registry:
    image: flaviostutz/docker-registry
    ports:
      - 5000:5000
    volumes:
      - registry:/var/lib/registry    
    environment:
      - CLEANUP_CRON="* * * * *"
      # use only to see cleanup every 1m. In production, run fewer times

volumes:
  registry:
```

* run
```
docker-compose up
```
