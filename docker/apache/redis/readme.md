##
docker run -p 6379:6379 --name redis -d  redis redis-server --requirepass "redis" --appendonly yes

docker run -p 6379:6379 --name redis -v $PWD/data:/data  -d redis redis-server --requirepass "redis" --appendonly yes




docker exec -it redis redis-cli

https://hub.docker.com/_/redis/
https://github.com/docker-library/redis/blob/403f00a0ba7556f33850a88e27e70509aa2814dd/5.0-rc/32bit/Dockerfile