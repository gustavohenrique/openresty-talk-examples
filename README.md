Talk: Advanced Nginx
===

> Talk and slides in pt-br in 2020-10-29

## Examples

- SSI (Server Side Includes)
- Dyamic Cache
- Rate Limit
- Load Balancer
- JWT decode

## Organization

```
.
├── conf/             # Nginx config files
├── helloworld/       # APIs in Go, Python and NodeJS
├── www/              # Examples using SSI and Micro-frontend
├── lua/              # Lua code used by A/B testing and authentication using JWT
├── lxd/              # Profile to help me to configure a LXD container
├── slides/           # Slides created using Inkscape
```

## Setup

Sorry, I'm lazy to create a `docker-compose.yml` or some shell script.  
So, you need to:

- Install OpenResty (or run via Docker/LXD)
- Move `conf` to `/usr/local/openresty/nginx/`
- Move `www` and `lua` to `/home/ubuntu`
- Restart: `sudo systemctl restart openresty`

And add entries to OpenResty server in `/etc/hosts`. Example:

```sh
openresty_server_ip=10.0.2.10
cat /etc/hosts
10.0.2.10  blog.local
10.0.2.10  api.local
10.0.2.10  clock.local
10.0.2.10  iframe.local
10.0.2.10  lua.local
```
