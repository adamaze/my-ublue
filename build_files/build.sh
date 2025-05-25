#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux \
                nmap

echo "alias sshc='ssh root@castion10.adammaryniuk.com'" >> /etc/profile 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File
flatpak install -y --noninteractive com.prusa3d.PrusaSlicer
flatpak install -y --noninteractive io.podman_desktop.PodmanDesktop
flatpak install -y --noninteractive net.cozic.joplin_desktop
flatpak install -y --noninteractive org.fedoraproject.MediaWriter
flatpak install -y --noninteractive org.kde.qrca
flatpak install -y --noninteractive org.kde.yakuake
flatpak install -y --noninteractive org.raspberrypi.rpi-imager
flatpak install -y --noninteractive org.signal.Signal

systemctl enable podman.socket
systemctl enable sshd

mkdir -p /root/.ssh/
curl https://github.com/adamaze.keys >> /root/.ssh/authorized_keys
