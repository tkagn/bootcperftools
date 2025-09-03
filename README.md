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
sudo podman run --rm -it --privileged -v ./output:/output -v /var/lib/containers/storage:/var/lib/containers/storage registry.redhat.io/rhel10/bootc-image-builder:latest --rootfs xfs --type qcow2 quay.io/tkagn/bootcperftools:latest
mkdir /var/lib/libvirt/images/perftest1
cp ./output/qcow2/disk.qcow2 /var/lib/libvirt/images/perftest1/perftest1.qcow2
qemu-img resize /var/lib/libvirt/images/perftest1/perftest1.qcow2 30G 
sudo virt-install -v -n perftest1.tkagn.io --vcpus 4 --memory 4096 --os-variant rhel9.4 --machine q35 --import --disk 'path=/var/lib/libvirt/images/perftest1/perftest1.qcow2',bus=virtio,format=qcow2,cache=none --cloud-init meta-data='/var/lib/libvirt/images/perftest1/meta-data',user-data='/var/lib/libvirt/images/perftest1/user-data' --network network=default,model=virtio --network bridge=bridge-vlan103,model=virtio --virt-type kvm --graphics spice --video virtio --console pty,target_type=serial --noautoconsole --no-audio
```


/var/lib/libvirt/images/

## References

- [Getting Started with Bootable Containers](https://docs.fedoraproject.org/en-US/bootc/getting-started/)
- [https://github.com/osbuild/bootc-image-builder](https://github.com/osbuild/bootc-image-builder)
- [2.5. Using bootc-image-builder to build disk images based on a container](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/composing_installing_and_managing_rhel_for_edge_images/migrating-from-rpm-ostree-based-deployed-systems-to-bootc-based-systems#using_bootc_image_builder_to_build_disk_images_based_on_a_container)

