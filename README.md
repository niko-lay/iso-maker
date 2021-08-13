# iso-maker
Generate .iso image with all necessary .deb packages to install it in air-gapped servers

By default, following DEBs and it dependencies will be download and add into iso "lldpd ifenslave net-tools"

To change this provide list of necessary packages as argument for container

```
docker build . -t deb-iso-maker
docker run --rm -it -v $(pwd)/iso:/iso-out deb-iso-maker
```