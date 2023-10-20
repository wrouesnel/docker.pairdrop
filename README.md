# Pairdrop Self-Contained Docker Container

# Execution Requirements
The container is designed to work with a read-only filesystem.

It requires `/run` and `/tmp` to be writeable but not persistent (i.e. `--tmpfs /run:exec,suid` in `docker run`).
