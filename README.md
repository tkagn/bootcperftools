# bootcperftools


Repository for Fedora-based image mode artifacts for running performance tools. 

A GitHub action workflow builds the image a pushes the image to Quay.io. The container can be instantiated with podman.

To run as a container:

```bash
podman run -it --name bootcperftools quay.io/tkagn/bootcperftools:latest /bin/bash
```

To run as a VM:

```bash
mkdir output
sudo podman pull registry.redhat.io/rhel10/bootc-image-builder
sudo podman run --rm -it -v ./output:/output -v /var/lib/containers/storage:/var/lib/containers/storage 



 -itregistry.redhat.io/rhel9/bootc-image-builder:9.4:latest --type qcow2 quay.io/tkagn/bootcperftools:latest
```


