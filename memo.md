# 作業用メモ

```pwsh
podman build . -t ubuntu-jammy-ja-test

podman run -it --rm localhost/ubuntu-jammy-ja-test echo hello

# remove
podman rmi localhost/ubuntu-jammy-ja-test:latest
```
