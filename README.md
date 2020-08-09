A docker container to receive webhooks to automate deployment.
Dockerfile adapted from https://hub.docker.com/r/almir/webhook.
See https://github.com/adnanh/webhook.

## usage

See `.example.env`

A (good) constraint of running webhook inside this Docker container is that you must keep the part of the filesystem you want it to access contained in a single directory.

Here is an example directory structure for the volume mounted by the container (referenced in `.env` as HOST_VOLUME):

~~~
/home/brendan/webhook
├── hooks.json
├── scripts
│   └── foo
└── sites
    └── brendantang.net
~~~

Say `sites/brendantang.net` is a clone of the repo for my blog.
`hooks.json` defines a webhook which runs the executable `foo`, using `sites/brendantang.net` as its working directory.
`foo`, as an example, might just run `git pull && npm install && npm run build`.

I can symlink `/home/brendan/webhook/sites/brendantang.net` to `/var/www/brendantang.net` on the host machine, and configure nginx to serve static files from there.
I then set up a webhook on my git server with the origin repo (i.e. Github or Gitea) so that whenever I push a commit there, it fires off a request to the webhook receiver on my server, which runs the script to pull the changes from origin and rebuild the site.

> Note that the path to `foo` from the container's point of view is `/etc/webhook/scripts/foo`, whereas on the host machine it is `/home/brendan/webhook/scripts/foo`.
> Paths must be expressed in the `hooks.json` file as seen on the container's filesystem.
