# Use the Fedora 42 base image from the Fedora project.
FROM quay.io/fedora/fedora-bootc:42

# Set a descriptive label for the container.
LABEL name="Fedora42-performance-tools"
LABEL version="1.0"
LABEL description="Fedora image with performance tools for network and disk I/O."

# Use the 'dnf' package manager to install the required tools.
# The 'dnf install' command is chained to reduce the number of layers and optimize image size.
# We also use 'dnf clean all' to remove downloaded package data.

# Performance tools included:
# - iperf3: A powerful tool for active measurements of the maximum achievable bandwidth on IP networks.
# - netperf: Another network performance testing tool, useful for measuring TCP and UDP throughput.
# - sysstat: Provides tools like 'iostat' for monitoring disk I/O and 'sar' for general system stats.
# - fio: A flexible I/O tester for benchmarking disk and file system performance.
# - tcpdump: A command-line packet analyzer.
# - iproute-tc: Provides 'ss' for viewing socket statistics.
RUN dnf install -y jq yq iperf3 netperf sysstat fio tcpdump iproute-tc cloud-init pcp pcp-system-tools pcp-zeroconf \
&& ln -s ../cloud-init.target /usr/lib/systemd/system/default.target.wants \
&& systemctl enable pmcd \
&& dnf clean all \
&& rm -rf /var/cache/yum \
&& history -c

# Set the default command to start a shell when the container is run.
# This allows you to interact with the container and run the tools manually.
CMD ["/bin/bash"]

## podman build --force-rm --squash-all -t perftools:f42 .
## podman run --rm --it --name perftools-f42 perftools:f42

## podman pull registry.redhat.io/rhel9/bootc-image-builder
## podman run --rm -it --privileged --security-opt label=type:unconfined_t -v ./output:/output bootc-image-builder --type qcow2 perftools:f42
