# Pairdrop Self-Contained Docker Container

# Locations

`/certs` is provided in the image as a mountpoint for TLS certificate secrets for use with the `SSL_SERVER_CERT` and
`SSL_SERVER_KEY` variables.

# Environment Variable Options

* `SSL_SERVER_CERT` - literal certificate or path to TLS certificate
* `SSL_SERVER_CERTCHAIN` - certificates to append as the certificate chain
* `SSL_SERVER_KEY` - literal private key or path to TLS private key for certificate
* `HOSTNAME` - set the hostname of the container
* `DEV_ALLOW_SELF_SIGNED` - set to `yes` in order to have the container generate certificates automatically
* `DEV_ALLOW_EPHEMERAL_DATA` - defaults to `yes`, can be set to `no` in order to require `/data` to be mounted.

# Execution Requirements
The container is designed to work with a read-only filesystem.

It requires `/run` and `/tmp` to be writeable but not persistent (i.e. `--tmpfs /run:exec,suid` in `docker run`).
