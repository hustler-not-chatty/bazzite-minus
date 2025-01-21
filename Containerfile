ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-kinoite}"
ARG BASE_IMAGE_FLAVOR="${BASE_IMAGE_FLAVOR:-main}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-main}"
ARG NVIDIA_FLAVOR="${NVIDIA_FLAVOR:-nvidia}"
ARG NVIDIA_BASE="${NVIDIA_BASE:-bazzite}"
ARG KERNEL_FLAVOR="${KERNEL_FLAVOR:-bazzite}"
ARG KERNEL_VERSION="${KERNEL_VERSION:-6.12.5-204.bazzite.fc41.x86_64}"
ARG IMAGE_BRANCH="${IMAGE_BRANCH:-main}"
ARG SOURCE_IMAGE="${SOURCE_IMAGE:-$BASE_IMAGE_NAME-$BASE_IMAGE_FLAVOR}"
ARG BASE_IMAGE="ghcr.io/ublue-os/${SOURCE_IMAGE}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-41}"
ARG JUPITER_FIRMWARE_VERSION="${JUPITER_FIRMWARE_VERSION:-jupiter-20241205.1}"
ARG SHA_HEAD_SHORT="${SHA_HEAD_SHORT}"
ARG VERSION_TAG="${VERSION_TAG}"
ARG VERSION_PRETTY="${VERSION_PRETTY}"

FROM ghcr.io/ublue-os/${KERNEL_FLAVOR}-kernel:${FEDORA_MAJOR_VERSION}-${KERNEL_VERSION} AS kernel
FROM ghcr.io/ublue-os/akmods:${KERNEL_FLAVOR}-${FEDORA_MAJOR_VERSION}-${KERNEL_VERSION} AS akmods
FROM ghcr.io/ublue-os/akmods-extra:${KERNEL_FLAVOR}-${FEDORA_MAJOR_VERSION}-${KERNEL_VERSION} AS akmods-extra

FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION} AS bazzite

ARG IMAGE_NAME="${IMAGE_NAME:-bazzite}"
ARG IMAGE_VENDOR="${IMAGE_VENDOR:-ublue-os}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-main}"
ARG NVIDIA_FLAVOR="${NVIDIA_FLAVOR:-nvidia}"
ARG NVIDIA_BASE="${NVIDIA_BASE:-bazzite}"
ARG KERNEL_FLAVOR="${KERNEL_FLAVOR:-bazzite}"
ARG KERNEL_VERSION="${KERNEL_VERSION:-6.12.5-204.bazzite.fc41.x86_64}"
ARG IMAGE_BRANCH="${IMAGE_BRANCH:-main}"
ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-kinoite}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-41}"
ARG JUPITER_FIRMWARE_VERSION="${JUPITER_FIRMWARE_VERSION:-jupiter-20241205.1}"
ARG SHA_HEAD_SHORT="${SHA_HEAD_SHORT}"
ARG VERSION_TAG="${VERSION_TAG}"
ARG VERSION_PRETTY="${VERSION_PRETTY}"

COPY system_files/desktop/shared system_files/desktop/${BASE_IMAGE_NAME} /

# Update packages that commonly cause build issues
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        vulkan-loader \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        alsa-lib \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        gnutls \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        glib2 \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        nspr \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        nss \
        nss-softokn \
        nss-softokn-freebl \
        nss-sysinit \
        nss-util \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        atk \
        at-spi2-atk \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libaom \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        gstreamer1 \
        gstreamer1-plugins-base \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libdecor \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libtirpc \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libuuid \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libblkid \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libmount \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        cups-libs \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libinput \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libopenmpt \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        llvm-libs \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        zlib-ng-compat \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        fontconfig \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        pciutils-libs \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libdrm \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        cpp \
        libatomic \
        libgcc \
        libgfortran \
        libgomp \
        libobjc \
        libstdc++ \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libX11 \
        libX11-common \
        libX11-xcb \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libv4l \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        elfutils-libelf \
        elfutils-libs \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        glibc \
        glibc-common \
        glibc-all-langpacks \
        glibc-gconv-extra \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        libxcrypt \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        SDL2 \
        || true && \
    rpm-ostree override replace \
    --experimental \
    --from repo=updates \
        openldap \
        || true && \
    if grep -q "kinoite" <<< "${BASE_IMAGE_NAME}"; then \
        rpm-ostree override replace \
        --experimental \
        --from repo=updates \
            qt6-qtbase \
            qt6-qtbase-common \
            qt6-qtbase-mysql \
            qt6-qtbase-gui \
            || true \
    ; fi && \
    rpm-ostree override remove \
        glibc32 \
        || true && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Setup Copr repos
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    curl -Lo /etc/yum.repos.d/_copr_kylegospo-bazzite.repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-bazzite-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-bazzite-multilib-fedora-"${FEDORA_MAJOR_VERSION}".repo?arch=x86_64 && \
    curl -Lo /etc/yum.repos.d/_copr_ublue-os-staging.repo https://copr.fedorainfracloud.org/coprs/ublue-os/staging/repo/fedora-"${FEDORA_MAJOR_VERSION}"/ublue-os-staging-fedora-"${FEDORA_MAJOR_VERSION}".repo?arch=x86_64 && \
    curl -Lo /etc/yum.repos.d/_copr_kylegospo-latencyflex.repo https://copr.fedorainfracloud.org/coprs/kylegospo/LatencyFleX/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-LatencyFleX-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_kylegospo-obs-vkcapture.repo https://copr.fedorainfracloud.org/coprs/kylegospo/obs-vkcapture/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-obs-vkcapture-fedora-"${FEDORA_MAJOR_VERSION}".repo?arch=x86_64 && \
    curl -Lo /etc/yum.repos.d/_copr_kylegospo-wallpaper-engine-kde-plugin.repo https://copr.fedorainfracloud.org/coprs/kylegospo/wallpaper-engine-kde-plugin/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-wallpaper-engine-kde-plugin-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_ycollet-audinux.repo https://copr.fedorainfracloud.org/coprs/ycollet/audinux/repo/fedora-"${FEDORA_MAJOR_VERSION}"/ycollet-audinux-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_kylegospo-rom-properties.repo https://copr.fedorainfracloud.org/coprs/kylegospo/rom-properties/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-rom-properties-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_kylegospo-webapp-manager.repo https://copr.fedorainfracloud.org/coprs/kylegospo/webapp-manager/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-webapp-manager-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_hhd-dev-hhd.repo https://copr.fedorainfracloud.org/coprs/hhd-dev/hhd/repo/fedora-"${FEDORA_MAJOR_VERSION}"/hhd-dev-hhd-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_che-nerd-fonts.repo https://copr.fedorainfracloud.org/coprs/che/nerd-fonts/repo/fedora-"${FEDORA_MAJOR_VERSION}"/che-nerd-fonts-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_sentry-switcheroo-control_discrete.repo https://copr.fedorainfracloud.org/coprs/sentry/switcheroo-control_discrete/repo/fedora-"${FEDORA_MAJOR_VERSION}"/sentry-switcheroo-control_discrete-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_hikariknight-looking-glass-kvmfr.repo https://copr.fedorainfracloud.org/coprs/hikariknight/looking-glass-kvmfr/repo/fedora-"${FEDORA_MAJOR_VERSION}"/hikariknight-looking-glass-kvmfr-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_mavit-discover-overlay.repo https://copr.fedorainfracloud.org/coprs/mavit/discover-overlay/repo/fedora-"${FEDORA_MAJOR_VERSION}"/mavit-discover-overlay-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_lizardbyte-beta.repo https://copr.fedorainfracloud.org/coprs/lizardbyte/beta/repo/fedora-"${FEDORA_MAJOR_VERSION}"/lizardbyte-beta-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_rok-cdemu.repo https://copr.fedorainfracloud.org/coprs/rok/cdemu/repo/fedora-"${FEDORA_MAJOR_VERSION}"/rok-cdemu-fedora-"${FEDORA_MAJOR_VERSION}".rep && \
    curl -Lo /etc/yum.repos.d/_copr_rodoma92-kde-cdemu-manager.repo https://copr.fedorainfracloud.org/coprs/rodoma92/kde-cdemu-manager/repo/fedora-"${FEDORA_MAJOR_VERSION}"/rodoma92-kde-cdemu-manager-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_rodoma92-rmlint.repo https://copr.fedorainfracloud.org/coprs/rodoma92/rmlint/repo/fedora-"${FEDORA_MAJOR_VERSION}"/rodoma92-rmlint-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_ilyaz-lact.repo https://copr.fedorainfracloud.org/coprs/ilyaz/LACT/repo/fedora-"${FEDORA_MAJOR_VERSION}"/ilyaz-LACT-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
    rpm-ostree install \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    sed -i 's@gpgcheck=1@gpgcheck=0@g' /etc/yum.repos.d/tailscale.repo && \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo && \
    curl -Lo /etc/yum.repos.d/negativo17-fedora-steam.repo https://negativo17.org/repos/fedora-steam.repo && \
    curl -Lo /etc/yum.repos.d/negativo17-fedora-rar.repo https://negativo17.org/repos/fedora-rar.repo && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Install kernel
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    --mount=type=bind,from=kernel,src=/tmp/rpms,dst=/tmp/kernel-rpms \
    rpm-ostree cliwrap install-to-root / && \
    echo "Will install ${KERNEL_FLAVOR} kernel" && \
    rpm-ostree override replace \
    --experimental \
        /tmp/kernel-rpms/kernel-[0-9]*.rpm \
        /tmp/kernel-rpms/kernel-core-*.rpm \
        /tmp/kernel-rpms/kernel-modules-*.rpm \
        /tmp/kernel-rpms/kernel-uki-virt-*.rpm && \
    rpm-ostree install \
        scx-scheds && \
    rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:kylegospo:bazzite \
        bootc \
        rpm-ostree \
        rpm-ostree-libs && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Setup firmware
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    mkdir -p /tmp/linux-firmware-neptune && \
    curl -Lo /tmp/linux-firmware-neptune/cs35l41-dsp1-spk-cali.bin https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/cs35l41-dsp1-spk-cali.bin && \
    curl -Lo /tmp/linux-firmware-neptune/cs35l41-dsp1-spk-cali.wmfw https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/cs35l41-dsp1-spk-cali.wmfw && \
    curl -Lo /tmp/linux-firmware-neptune/cs35l41-dsp1-spk-prot.bin https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/cs35l41-dsp1-spk-prot.bin && \
    curl -Lo /tmp/linux-firmware-neptune/cs35l41-dsp1-spk-prot.wmfw https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/cs35l41-dsp1-spk-prot.wmfw && \
    curl -Lo /tmp/linux-firmware-neptune/rtl8822cu_fw.bin https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/rtl_bt/rtl8822cu_fw.bin && \
    xz --check=crc32 /tmp/linux-firmware-neptune/* && \
    mv -vf /tmp/linux-firmware-neptune/rtl8822cu_fw.bin.xz /usr/lib/firmware/rtl_bt/rtl8822cu_fw.bin.xz && \
    mv -vf /tmp/linux-firmware-neptune/* /usr/lib/firmware/cirrus/ && \
    rm -rf /tmp/linux-firmware-neptune && \
    mkdir -p /tmp/linux-firmware-galileo && \
    curl https://gitlab.com/evlaV/linux-firmware-neptune/-/archive/"${JUPITER_FIRMWARE_VERSION}"/linux-firmware-neptune-"${JUPITER_FIRMWARE_VERSION}".tar.gz?path=ath11k/QCA206X -o /tmp/linux-firmware-galileo/ath11k.tar.gz && \
    tar --strip-components 1 --no-same-owner --no-same-permissions --no-overwrite-dir -xvf /tmp/linux-firmware-galileo/ath11k.tar.gz -C /tmp/linux-firmware-galileo && \
    xz --check=crc32 /tmp/linux-firmware-galileo/ath11k/QCA206X/hw2.1/* && \
    rm -f /usr/lib/firmware/ath11k/QCA206X/* && \
    rm -rf /usr/lib/firmware/ath11k/QCA2066 && \
    mv -vf /tmp/linux-firmware-galileo/ath11k/QCA206X /usr/lib/firmware/ath11k/QCA206X && \
    rm -rf /tmp/linux-firmware-galileo/ath11k && \
    rm -rf /tmp/linux-firmware-galileo/ath11k.tar.gz && \
    ln -s QCA206X /usr/lib/firmware/ath11k/QCA2066 && \
    curl -Lo /tmp/linux-firmware-galileo/hpbtfw21.tlv https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/qca/hpbtfw21.tlv && \
    curl -Lo /tmp/linux-firmware-galileo/hpnv21.309 https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/qca/hpnv21.309 && \
    curl -Lo /tmp/linux-firmware-galileo/hpnv21.bin https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/qca/hpnv21.bin && \
    curl -Lo /tmp/linux-firmware-galileo/hpnv21g.309 https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/qca/hpnv21g.309 && \
    curl -Lo /tmp/linux-firmware-galileo/hpnv21g.bin https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/"${JUPITER_FIRMWARE_VERSION}"/qca/hpnv21g.bin && \
    xz --check=crc32 /tmp/linux-firmware-galileo/* && \
    mv -vf /tmp/linux-firmware-galileo/* /usr/lib/firmware/qca/ && \
    rm -rf /tmp/linux-firmware-galileo && \
    rm -rf /usr/share/alsa/ucm2/conf.d/acp5x/Valve-Jupiter-1.conf && \
    ln -s /usr/local/firmware/aw87xxx_acf.bin /usr/lib/firmware/aw87xxx_acf.bin && \
    ln -s /usr/local/firmware/aw87xxx_acf_air1s.bin /usr/lib/firmware/aw87xxx_acf_air1s.bin && \
    ln -s /usr/local/firmware/aw87xxx_acf_kun.bin /usr/lib/firmware/aw87xxx_acf_kun.bin && \
    ln -s /usr/local/firmware/aw87xxx_acf_minipro.bin /usr/lib/firmware/aw87xxx_acf_minipro.bin && \
    ln -s /usr/local/firmware/aw87xxx_acf_orangepi.bin /usr/lib/firmware/aw87xxx_acf_orangepi.bin && \
    ln -s /usr/local/firmware/aw87xxx_acf_airplus.bin /usr/lib/firmware/aw87xxx_acf_airplus.bin && \
    ln -s /usr/local/firmware/aw87xxx_acf_flip.bin /usr/lib/firmware/aw87xxx_acf_flip.bin && \
    if [[ "${IMAGE_FLAVOR}" =~ "asus" ]]; then \
        curl -Lo /etc/yum.repos.d/_copr_lukenukem-asus-linux.repo https://copr.fedorainfracloud.org/coprs/lukenukem/asus-linux/repo/fedora-$(rpm -E %fedora)/lukenukem-asus-linux-fedora-$(rpm -E %fedora).repo && \
        rpm-ostree install \
            asusctl \
            asusctl-rog-gui \
    ; elif [[ "${IMAGE_FLAVOR}" == "surface" ]]; then \
        curl -Lo /etc/yum.repos.d/linux-surface.repo https://pkg.surfacelinux.com/fedora/linux-surface.repo && \
        rpm-ostree override remove \
            libwacom \
            libwacom-data \
            --install libwacom-surface \
            --install libwacom-surface-data && \
        rpm-ostree install \
            iptsd \
            libcamera \
            libcamera-tools \
            libcamera-gstreamer \
            libcamera-ipa \
            pipewire-plugin-libcamera && \
        sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/linux-surface.repo \
    ; fi && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Add ublue packages
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    --mount=type=bind,from=akmods,src=/rpms,dst=/tmp/akmods-rpms \
    --mount=type=bind,from=akmods-extra,src=/rpms,dst=/tmp/akmods-extra-rpms \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_ublue-os-akmods.repo && \
    rpm-ostree install \
        /tmp/akmods-rpms/kmods/*kvmfr*.rpm \
        /tmp/akmods-rpms/kmods/*xone*.rpm \
        /tmp/akmods-rpms/kmods/*openrazer*.rpm \
        /tmp/akmods-rpms/kmods/*v4l2loopback*.rpm \
        /tmp/akmods-rpms/kmods/*wl*.rpm \
        /tmp/akmods-rpms/kmods/*framework-laptop*.rpm \
        /tmp/akmods-extra-rpms/kmods/*nct6687*.rpm \
        /tmp/akmods-extra-rpms/kmods/*zenergy*.rpm \
        /tmp/akmods-extra-rpms/kmods/*vhba*.rpm \
        /tmp/akmods-extra-rpms/kmods/*gpd-fan*.rpm \
        /tmp/akmods-extra-rpms/kmods/*bmi260*.rpm \
        /tmp/akmods-extra-rpms/kmods/*ryzen-smu*.rpm \
        /tmp/akmods-extra-rpms/kmods/*evdi*.rpm && \
    rpm-ostree override replace \
        --experimental \
        --from repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
            fwupd \
            fwupd-plugin-flashrom \
            fwupd-plugin-modem-manager \
            fwupd-plugin-uefi-capsule-data && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-*.repo && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Install Valve's patched Mesa, Pipewire, Bluez, and Xwayland#
# Install patched switcheroo control with proper discrete GPU support
# Tempporary fix for GPU Encoding
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    mkdir -p /tmp/mesa-fix64/dri && \
    cp /usr/lib64/libgallium-*.so /tmp/mesa-fix64/ && \
    cp /usr/lib64/dri/kms_swrast_dri.so /tmp/mesa-fix64/dri/ && \
    cp /usr/lib64/dri/libdril_dri.so /tmp/mesa-fix64/dri/ && \
    cp /usr/lib64/dri/swrast_dri.so /tmp/mesa-fix64/dri/ && \
    cp /usr/lib64/dri/virtio_gpu_dri.so /tmp/mesa-fix64/dri/ && \
    rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:kylegospo:bazzite-multilib \
        mesa-libxatracker \
        mesa-libglapi \
        mesa-dri-drivers \
        mesa-libgbm \
        mesa-libEGL \
        mesa-vulkan-drivers \
        mesa-libGL \
        pipewire \
        pipewire-alsa \
        pipewire-gstreamer \
        pipewire-jack-audio-connection-kit \
        pipewire-jack-audio-connection-kit-libs \
        pipewire-libs \
        pipewire-pulseaudio \
        pipewire-utils \
        pipewire-plugin-libcamera \
        bluez \
        bluez-obexd \
        bluez-cups \
        bluez-libs \
        xorg-x11-server-Xwayland && \
    rsync -a /tmp/mesa-fix64/ /usr/lib64/ && \
    rm -rf /tmp/mesa-fix64 && \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/rpmfusion-*.repo && \
    rpm-ostree install \
        libaacs \
        libbdplus \
        libbluray \
        libbluray-utils && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/rpmfusion-*.repo && \
    rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:sentry:switcheroo-control_discrete \
        switcheroo-control && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Remove unneeded packages
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    rpm-ostree override remove \
        ublue-os-update-services \
        firefox \
        firefox-langpacks \
        htop && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Install new packages
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    rpm-ostree install \
        python3-pip \
        libadwaita \
        duperemove \
        cpulimit \
        sqlite \
        xwininfo \
        xrandr \
        compsize \
        ryzenadj \
        input-remapper \
        tuned-profiles-cpu-partitioning \
        i2c-tools \
        udica \
        ladspa-caps-plugins \
        ladspa-noise-suppression-for-voice \
        pipewire-module-filter-chain-sofa \
        python3-icoextract \
        webapp-manager \
        btop \
        duf \
        lshw \
        xdotool \
        wmctrl \
        libcec \
        yad \
        f3 \
        pulseaudio-utils \
        lzip \
        rar \
        libxcrypt-compat \
        mesa-libGLU \
        vulkan-tools \
        xwiimote-ng \
        google-noto-sans-cjk-fonts \
        cascadia-code-fonts \
        cascadia-mono-fonts \
        fastfetch \
        glow \
        gum \
        nano \
        topgrade \
        ydotool \
        yafti \
        stress-ng \
        btrfs-assistant \
        podman-compose \
        lsb_release && \
    rpm-ostree install \
        ublue-update && \
    mkdir -p /etc/xdg/autostart && \
    sed -i '1s/^/[include]\npaths = ["\/etc\/ublue-os\/topgrade.toml"]\n\n/' /usr/share/ublue-update/topgrade-user.toml && \
    sed -i 's/min_battery_percent.*/min_battery_percent = 20.0/' /etc/ublue-update/ublue-update.toml && \
    sed -i 's/max_cpu_load_percent.*/max_cpu_load_percent = 100.0/' /etc/ublue-update/ublue-update.toml && \
    sed -i 's/max_mem_percent.*/max_mem_percent = 90.0/' /etc/ublue-update/ublue-update.toml && \
    sed -i 's/dbus_notify.*/dbus_notify = false/' /etc/ublue-update/ublue-update.toml && \
    sed -i 's/ --xdg-runtime=\\"${XDG_RUNTIME_DIR}\\"//g' /usr/bin/btrfs-assistant-launcher && \
    curl -Lo /usr/bin/installcab https://raw.githubusercontent.com/KyleGospo/steam-proton-mf-wmv/master/installcab.py && \
    chmod +x /usr/bin/installcab && \
    curl -Lo /usr/bin/install-mf-wmv https://github.com/KyleGospo/steam-proton-mf-wmv/blob/master/install-mf-wmv.sh && \
    chmod +x /usr/bin/install-mf-wmv && \
    curl -Lo /tmp/ls-iommu.tar.gz $(curl https://api.github.com/repos/HikariKnight/ls-iommu/releases/latest | jq -r '.assets[] | select(.name| test(".*x86_64.tar.gz$")).browser_download_url') && \
    mkdir -p /tmp/ls-iommu && \
    tar --no-same-owner --no-same-permissions --no-overwrite-dir -xvzf /tmp/ls-iommu.tar.gz -C /tmp/ls-iommu && \
    rm -f /tmp/ls-iommu.tar.gz && \
    cp -r /tmp/ls-iommu/ls-iommu /usr/bin/ && \
    rm -rf /tmp/ls-iommu && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Configure KDE & GNOME
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    if grep -q "kinoite" <<< "${BASE_IMAGE_NAME}"; then \
        rpm-ostree install \
            qt \
            krdp && \
        rpm-ostree override remove \
            plasma-welcome \
            plasma-welcome-fedora && \
        rpm-ostree override replace \
        --experimental \
        --from repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
            kf6-kio-doc \
            kf6-kio-widgets-libs \
            kf6-kio-core-libs \
            kf6-kio-widgets \
            kf6-kio-file-widgets \
            kf6-kio-core \
            kf6-kio-gui && \
        rpm-ostree install \
            steamdeck-kde-presets-desktop \
            wallpaper-engine-kde-plugin \
            kdeconnectd \
            kdeplasma-addons \
            rom-properties-kf6 \
            joystickwake \
            fcitx5-mozc \
            fcitx5-chinese-addons \
            fcitx5-hangul \
            ptyxis && \
        git clone https://github.com/catsout/wallpaper-engine-kde-plugin.git --depth 1 --branch main /tmp/wallpaper-engine-kde-plugin && \
        kpackagetool6 --type=Plasma/Wallpaper --global --install /tmp/wallpaper-engine-kde-plugin/plugin && \
        rm -rf /tmp/wallpaper-engine-kde-plugin && \
        sed -i '/<entry name="launchers" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/browser,applications:steam.desktop,applications:net.lutris.Lutris.desktop,applications:org.gnome.Ptyxis.desktop,applications:org.kde.discover.desktop,preferred:\/\/filemanager<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml && \
        sed -i '/<entry name="favorites" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/browser,steam.desktop,net.lutris.Lutris.desktop,systemsettings.desktop,org.kde.dolphin.desktop,org.kde.kate.desktop,org.gnome.Ptyxis.desktop,org.kde.discover.desktop,system-update.desktop<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml && \
        sed -i 's@\[Desktop Action new-window\]@\[Desktop Action new-window\]\nX-KDE-Shortcuts=Ctrl+Alt+T@g' /usr/share/applications/org.gnome.Ptyxis.desktop && \
        sed -i '/^Comment/d' /usr/share/applications/org.gnome.Ptyxis.desktop && \
        sed -i 's@Exec=ptyxis@Exec=kde-ptyxis@g' /usr/share/applications/org.gnome.Ptyxis.desktop && \
        sed -i 's@Keywords=@Keywords=konsole;console;@g' /usr/share/applications/org.gnome.Ptyxis.desktop && \
        cp /usr/share/applications/org.gnome.Ptyxis.desktop /usr/share/kglobalaccel/org.gnome.Ptyxis.desktop && \
        sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/org.kde.konsole.desktop && \
        rm -f /usr/share/kglobalaccel/org.kde.konsole.desktop && \
        setcap 'cap_net_raw+ep' /usr/libexec/ksysguard/ksgrd_network_helper \
    ; else \
        rpm-ostree override replace \
        --experimental \
        --from repo=copr:copr.fedorainfracloud.org:ublue-os:staging \
            gnome-shell && \
        rpm-ostree install \
            nautilus-gsconnect \
            steamdeck-backgrounds \
            gnome-randr-rust \
            gnome-shell-extension-user-theme \
            gnome-shell-extension-gsconnect \
            gnome-shell-extension-compiz-windows-effect \
            gnome-shell-extension-compiz-alike-magic-lamp-effect \
            gnome-shell-extension-just-perfection \
            gnome-shell-extension-blur-my-shell \
            gnome-shell-extension-hanabi \
            gnome-shell-extension-gamerzilla \
            gnome-shell-extension-bazzite-menu \
            gnome-shell-extension-hotedge \
            gnome-shell-extension-caffeine \
            rom-properties-gtk3 \
            ibus-mozc \
            openssh-askpass && \
        rpm-ostree override remove \
            gnome-classic-session \
            gnome-tour \
            gnome-extensions-app \
            gnome-system-monitor \
            gnome-initial-setup \
            gnome-shell-extension-apps-menu && \
        systemctl enable dconf-update.service \
    ; fi && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Cleanup & Finalize
COPY system_files/overrides /
RUN rm -f /etc/profile.d/toolbox.sh && \
    mkdir -p /var/tmp && chmod 1777 /var/tmp && \
    cp --no-dereference --preserve=links /usr/lib64/libdrm.so.2 /usr/lib64/libdrm.so && \
    sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/nvtop.desktop && \
    sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/btop.desktop && \
    sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/yad-icon-browser.desktop && \
    sed -i 's/#UserspaceHID.*/UserspaceHID=true/' /etc/bluetooth/input.conf && \
    sed -i "s/^SCX_SCHEDULER=.*/SCX_SCHEDULER=scx_lavd/" /etc/default/scx && \
    rm -f /usr/share/vulkan/icd.d/lvp_icd.*.json && \
    mkdir -p "/etc/profile.d/" && \
    ln -s "/usr/share/ublue-os/firstboot/launcher/login-profile.sh" \
    "/etc/profile.d/ublue-firstboot.sh" && \
    mkdir -p "/etc/xdg/autostart" && \
    cp "/usr/share/ublue-os/firstboot/yafti.yml" "/etc/yafti.yml" && \
    echo "import \"/usr/share/ublue-os/just/80-bazzite.just\"" >> /usr/share/ublue-os/justfile && \
    echo "import \"/usr/share/ublue-os/just/81-bazzite-fixes.just\"" >> /usr/share/ublue-os/justfile && \
    echo "import \"/usr/share/ublue-os/just/82-bazzite-apps.just\"" >> /usr/share/ublue-os/justfile && \
    echo "import \"/usr/share/ublue-os/just/82-bazzite-cdemu.just\"" >> /usr/share/ublue-os/justfile && \
    echo "import \"/usr/share/ublue-os/just/82-bazzite-rmlint.just\"" >> /usr/share/ublue-os/justfile && \
    echo "import \"/usr/share/ublue-os/just/83-bazzite-audio.just\"" >> /usr/share/ublue-os/justfile && \
    echo "import \"/usr/share/ublue-os/just/84-bazzite-virt.just\"" >> /usr/share/ublue-os/justfile && \
    echo "import \"/usr/share/ublue-os/just/85-bazzite-image.just\"" >> /usr/share/ublue-os/justfile && \
    echo "import \"/usr/share/ublue-os/just/86-bazzite-windows.just\"" >> /usr/share/ublue-os/justfile && \
    echo "import \"/usr/share/ublue-os/just/90-bazzite-de.just\"" >> /usr/share/ublue-os/justfile && \
    if grep -q "kinoite" <<< "${BASE_IMAGE_NAME}"; then \
      systemctl enable usr-share-sddm-themes.mount && \
      mkdir -p "/usr/share/ublue-os/dconfs/desktop-kinoite/" && \
      cp "/usr/share/glib-2.0/schemas/zz0-"*"-bazzite-desktop-kinoite-"*".gschema.override" "/usr/share/ublue-os/dconfs/desktop-kinoite/" && \
      find "/etc/dconf/db/distro.d/" -maxdepth 1 -type f -exec cp {} "/usr/share/ublue-os/dconfs/desktop-kinoite/" \; && \
      dconf-override-converter to-dconf "/usr/share/ublue-os/dconfs/desktop-kinoite/zz0-"*"-bazzite-desktop-kinoite-"*".gschema.override" && \
      rm "/usr/share/ublue-os/dconfs/desktop-kinoite/zz0-"*"-bazzite-desktop-kinoite-"*".gschema.override" \
    ; else \
      mkdir -p "/usr/share/ublue-os/dconfs/desktop-silverblue/" && \
      cp "/usr/share/glib-2.0/schemas/zz0-"*"-bazzite-desktop-silverblue-"*".gschema.override" "/usr/share/ublue-os/dconfs/desktop-silverblue/" && \
      find "/etc/dconf/db/distro.d/" -maxdepth 1 -type f -exec cp {} "/usr/share/ublue-os/dconfs/desktop-silverblue/" \; && \
      dconf-override-converter to-dconf "/usr/share/ublue-os/dconfs/desktop-silverblue/zz0-"*"-bazzite-desktop-silverblue-"*".gschema.override" && \
      sed -i 's/\[org.gtk.Settings.FileChooser\]/\[org\/gtk\/settings\/file-chooser\]/g; s/\[org.gtk.gtk4.Settings.FileChooser\]/\[org\/gtk\/gtk4\/settings\/file-chooser\]/g' "/usr/share/ublue-os/dconfs/desktop-silverblue/zz0-00-bazzite-desktop-silverblue-global" && \
      rm "/usr/share/ublue-os/dconfs/desktop-silverblue/zz0-"*"-bazzite-desktop-silverblue-"*".gschema.override" \
    ; fi && \
    mkdir -p /tmp/bazzite-schema-test && \
    find "/usr/share/glib-2.0/schemas/" -type f ! -name "*.gschema.override" -exec cp {} "/tmp/bazzite-schema-test/" \; && \
    cp "/usr/share/glib-2.0/schemas/zz0-"*".gschema.override" "/tmp/bazzite-schema-test/" && \
    echo "Running error test for Bazzite Desktop gschema override. Aborting if failed." && \
    glib-compile-schemas --strict /tmp/bazzite-schema-test && \
    echo "Compiling gschema to include Bazzite Desktop setting overrides" && \
    glib-compile-schemas /usr/share/glib-2.0/schemas &>/dev/null && \
    rm -r /tmp/bazzite-schema-test && \
    sed -i 's/stage/none/g' /etc/rpm-ostreed.conf && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_ublue-os-akmods.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_ublue-os-staging.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-latencyflex.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-obs-vkcapture.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-wallpaper-engine-kde-plugin.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_ycollet-audinux.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-rom-properties.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-webapp-manager.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_hhd-dev-hhd.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_che-nerd-fonts.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_sentry-switcheroo-control_discrete.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_mavit-discover-overlay.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_lizardbyte-beta.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_hikariknight-looking-glass-kvmfr.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/tailscale.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/charm.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-steam.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-rar.repo && \
    mkdir -p /etc/flatpak/remotes.d && \
    curl -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo && \
    systemctl disable displaylink.service && \
    systemctl enable input-remapper.service && \
    systemctl enable bazzite-flatpak-manager.service && \
    systemctl disable rpm-ostreed-automatic.timer && \
    systemctl enable ublue-update.timer && \
    systemctl enable incus-workaround.service && \
    systemctl enable bazzite-hardware-setup.service && \
    systemctl enable dev-hugepages1G.mount && \
    systemctl --global enable bazzite-user-setup.service && \
    systemctl --global enable podman.socket && \
    systemctl --global enable systemd-tmpfiles-setup.service && \
    curl -Lo /usr/lib/sysctl.d/99-bore-scheduler.conf https://github.com/CachyOS/CachyOS-Settings/raw/master/usr/lib/sysctl.d/99-bore-scheduler.conf && \
    curl -Lo /etc/distrobox/docker.ini https://github.com/ublue-os/toolboxes/raw/refs/heads/main/apps/docker/distrobox.ini && \
    curl -Lo /etc/distrobox/incus.ini https://github.com/ublue-os/toolboxes/raw/refs/heads/main/apps/docker/incus.ini && \
    /usr/libexec/containerbuild/image-info && \
    /usr/libexec/containerbuild/build-initramfs && \
    /usr/libexec/containerbuild/cleanup.sh && \
    mkdir -p /var/tmp && \
    chmod 1777 /var/tmp && \
    ostree container commit

FROM bazzite AS bazzite-deck

ARG IMAGE_NAME="${IMAGE_NAME:-bazzite-deck}"
ARG IMAGE_VENDOR="${IMAGE_VENDOR:-ublue-os}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-main}"
ARG NVIDIA_FLAVOR="${NVIDIA_FLAVOR:-nvidia}"
ARG NVIDIA_BASE="${NVIDIA_BASE:-bazzite}"
ARG KERNEL_FLAVOR="${KERNEL_FLAVOR:-bazzite}"
ARG KERNEL_VERSION="${KERNEL_VERSION:-6.12.5-204.bazzite.fc41.x86_64}"
ARG IMAGE_BRANCH="${IMAGE_BRANCH:-main}"
ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-kinoite}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-41}"
ARG VERSION_TAG="${VERSION_TAG}"
ARG VERSION_PRETTY="${VERSION_PRETTY}"

COPY system_files/deck/shared system_files/deck/${BASE_IMAGE_NAME} /

# Setup Copr repos
RUN sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_ublue-os-akmods.repo && \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo && \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo && \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_kylegospo-latencyflex.repo && \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_kylegospo-obs-vkcapture.repo && \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_kylegospo-wallpaper-engine-kde-plugin.repo && \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_hhd-dev-hhd.repo && \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/_copr_ycollet-audinux.repo && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Configure KDE & GNOME
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    rpm-ostree override remove \
        jupiter-sd-mounting-btrfs && \
    if grep -q "kinoite" <<< "${BASE_IMAGE_NAME}"; then \
        rpm-ostree override remove \
            steamdeck-kde-presets-desktop && \
        rpm-ostree install \
            steamdeck-kde-presets \
    ; else \
        rpm-ostree install \
            steamdeck-gnome-presets \
            gnome-shell-extension-caribou-blocker \
            sddm \
    ; fi && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Install new packages
# Dock updater - done manually due to proprietary parts preventing it from being on Copr
# Neptune firmware - done manually due to "TBD" license on needed audio firmware
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    rpm-ostree install \
    jupiter-fan-control \
    jupiter-hw-support-btrfs \
    galileo-mura \
    steamdeck-dsp \
    powerbuttond \
    hhd \
    hhd-ui \
    adjustor \
    acpica-tools \
    vpower \
    ds-inhibit \
    steam_notif_daemon \
    sdgyrodsu \
    ibus-pinyin \
    ibus-table-chinese-cangjie \
    ibus-table-chinese-quick \
    socat \
    zstd \
    zenity \
    newt \
    qt6-qtvirtualkeyboard \
    xorg-x11-server-Xvfb \
    python-vdf \
    python-crcmod && \
    git clone https://gitlab.com/evlaV/jupiter-dock-updater-bin.git \
        --depth 1 \
        /tmp/jupiter-dock-updater-bin && \
    mv -v /tmp/jupiter-dock-updater-bin/packaged/usr/lib/jupiter-dock-updater /usr/libexec/jupiter-dock-updater && \
    rm -rf /tmp/jupiter-dock-updater-bin && \
    ln -s /usr/bin/steamos-logger /usr/bin/steamos-info && \
    ln -s /usr/bin/steamos-logger /usr/bin/steamos-notice && \
    ln -s /usr/bin/steamos-logger /usr/bin/steamos-warning && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Install Steam Deck patched UPower, remove Tuned GUI
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    rpm-ostree override replace \
    --experimental \
    --from repo=copr:copr.fedorainfracloud.org:kylegospo:bazzite \
        upower \
        upower-libs && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Install Gamescope Session & Supporting changes
# Add bootstrap_steam.tar.gz used by gamescope-session (Thanks GE & Nobara Project!)
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    mkdir -p /usr/share/gamescope-session-plus/ && \
    curl -Lo /usr/share/gamescope-session-plus/bootstrap_steam.tar.gz https://large-package-sources.nobaraproject.org/bootstrap_steam.tar.gz && \
    rpm-ostree install \
        gamescope-session-plus \
        gamescope-session-steam && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Cleanup & Finalize
RUN /usr/libexec/containerbuild/image-info && \
    mkdir -p "/etc/xdg/autostart" && \
    mv "/etc/skel/.config/autostart/steam.desktop" "/etc/xdg/autostart/steam.desktop" && \
    sed -i 's@Exec=waydroid first-launch@Exec=/usr/bin/waydroid-launcher first-launch\nX-Steam-Library-Capsule=/usr/share/applications/Waydroid/capsule.png\nX-Steam-Library-Hero=/usr/share/applications/Waydroid/hero.png\nX-Steam-Library-Logo=/usr/share/applications/Waydroid/logo.png\nX-Steam-Library-StoreCapsule=/usr/share/applications/Waydroid/store-logo.png\nX-Steam-Controller-Template=Desktop@g' /usr/share/applications/Waydroid.desktop && \
    if grep -q "kinoite" <<< "${BASE_IMAGE_NAME}"; then \
        sed -i 's/Exec=.*/Exec=systemctl start return-to-gamemode.service/' /etc/skel/Desktop/Return.desktop && \
        mkdir -p /usr/share/ublue-os/backup && \
        mv /usr/share/applications/com.github.maliit.keyboard.desktop /usr/share/ublue-os/backup/com.github.maliit.keyboard.desktop \
    ; fi && \
    sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/input-remapper-gtk.desktop && \
    cp "/usr/share/ublue-os/firstboot/yafti.yml" "/etc/yafti.yml" && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_ublue-os-akmods.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-latencyflex.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-obs-vkcapture.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_kylegospo-wallpaper-engine-kde-plugin.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_hhd-dev-hhd.repo && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/_copr_ycollet-audinux.repo && \
    if grep -q "silverblue" <<< "${BASE_IMAGE_NAME}"; then \
        systemctl disable gdm.service && \
        systemctl enable sddm.service \
    ; fi && \
    if grep -q "silverblue" <<< "${BASE_IMAGE_NAME}"; then \
      mkdir -p "/usr/share/ublue-os/dconfs/deck-silverblue/" && \
      cp "/usr/share/glib-2.0/schemas/zz0-"*"-bazzite-deck-silverblue-"*".gschema.override" "/usr/share/ublue-os/dconfs/deck-silverblue/" && \
      find "/etc/dconf/db/distro.d/" -maxdepth 1 -type f -exec cp {} "/usr/share/ublue-os/dconfs/deck-silverblue/" \; && \
      dconf-override-converter to-dconf "/usr/share/ublue-os/dconfs/deck-silverblue/zz0-"*"-bazzite-deck-silverblue-"*".gschema.override" && \
      rm "/usr/share/ublue-os/dconfs/deck-silverblue/zz0-"*"-bazzite-deck-silverblue-"*".gschema.override" \
    ; else \
      systemctl disable usr-share-sddm-themes.mount \
    ; fi && \
    mkdir -p /tmp/bazzite-schema-test && \
    find "/usr/share/glib-2.0/schemas/" -type f ! -name "*.gschema.override" -exec cp {} "/tmp/bazzite-schema-test/" \; && \
    cp "/usr/share/glib-2.0/schemas/zz0-"*".gschema.override" "/tmp/bazzite-schema-test/" && \
    echo "Running error test for Bazzite Deck gschema override. Aborting if failed." && \
    glib-compile-schemas --strict /tmp/bazzite-schema-test && \
    echo "Compiling gschema to include Bazzite Deck setting overrides" && \
    glib-compile-schemas /usr/share/glib-2.0/schemas &>/dev/null && \
    rm -r /tmp/bazzite-schema-test && \
    echo "Removing Steam BPM workaround .desktop file" && \
    { rm -v /usr/share/applications/bazzite-steam-bpm.desktop || true; } && \
    systemctl enable bazzite-autologin.service && \
    systemctl enable wireplumber-workaround.service && \
    systemctl enable wireplumber-sysconf.service && \
    systemctl enable pipewire-workaround.service && \
    systemctl enable pipewire-sysconf.service && \
    systemctl enable ds-inhibit.service && \
    systemctl enable cec-onboot.service && \
    systemctl enable cec-onpoweroff.service && \
    systemctl enable cec-onsleep.service && \
    systemctl enable bazzite-tdpfix.service && \
    systemctl enable bazzite-grub-boot-success.timer && \
    systemctl enable bazzite-grub-boot-success.service && \
    systemctl --global disable sdgyrodsu.service && \
    systemctl --global disable grub-boot-success.timer && \
    systemctl disable grub-boot-indeterminate.service && \
    systemctl disable input-remapper.service && \
    systemctl disable ublue-update.timer && \
    systemctl disable jupiter-fan-control.service && \
    systemctl disable vpower.service && \
    systemctl disable jupiter-biosupdate.service && \
    systemctl disable jupiter-controller-update.service && \
    systemctl disable batterylimit.service && \
    /usr/libexec/containerbuild/cleanup.sh && \
    mkdir -p /var/tmp && chmod 1777 /var/tmp && \
    ostree container commit

FROM ghcr.io/ublue-os/akmods-${NVIDIA_FLAVOR}:${KERNEL_FLAVOR}-${FEDORA_MAJOR_VERSION}-${KERNEL_VERSION} AS nvidia-akmods

FROM ${NVIDIA_BASE} AS bazzite-nvidia

ARG IMAGE_NAME="${IMAGE_NAME:-bazzite-nvidia}"
ARG IMAGE_VENDOR="${IMAGE_VENDOR:-ublue-os}"
ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-nvidia}"
ARG NVIDIA_FLAVOR="${NVIDIA_FLAVOR:-nvidia}"
ARG NVIDIA_BASE="${NVIDIA_BASE:-bazzite}"
ARG KERNEL_FLAVOR="${KERNEL_FLAVOR:-bazzite}"
ARG KERNEL_VERSION="${KERNEL_VERSION:-6.12.5-204.bazzite.fc41.x86_64}"
ARG IMAGE_BRANCH="${IMAGE_BRANCH:-main}"
ARG BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-kinoite}"
ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-41}"
ARG VERSION_TAG="${VERSION_TAG}"
ARG VERSION_PRETTY="${VERSION_PRETTY}"

# Fetch NVIDIA driver
COPY system_files/nvidia/shared system_files/nvidia/${BASE_IMAGE_NAME} /

# Install NVIDIA driver
RUN --mount=type=cache,dst=/var/cache/rpm-ostree \
    --mount=type=bind,from=nvidia-akmods,src=/rpms,dst=/tmp/akmods-rpms \
    sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo && \
    rpm-ostree install \
        mesa-vdpau-drivers.x86_64 \
        mesa-vdpau-drivers.i686 && \
    curl -Lo /tmp/nvidia-install.sh https://raw.githubusercontent.com/ublue-os/hwe/main/nvidia-install.sh && \
    chmod +x /tmp/nvidia-install.sh && \
    IMAGE_NAME="${BASE_IMAGE_NAME}" /tmp/nvidia-install.sh && \
    rm -f /usr/share/vulkan/icd.d/nouveau_icd.*.json && \
    ln -s libnvidia-ml.so.1 /usr/lib64/libnvidia-ml.so && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit

# Cleanup & Finalize
RUN echo "import \"/usr/share/ublue-os/just/95-bazzite-nvidia.just\"" >> /usr/share/ublue-os/justfile && \
    sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo && \
    if grep -q "silverblue" <<< "${BASE_IMAGE_NAME}"; then \
      mkdir -p "/usr/share/ublue-os/dconfs/nvidia-silverblue/" && \
      cp "/usr/share/glib-2.0/schemas/zz0-"*"-bazzite-nvidia-silverblue-"*".gschema.override" "/usr/share/ublue-os/dconfs/nvidia-silverblue/" && \
      dconf-override-converter to-dconf "/usr/share/ublue-os/dconfs/nvidia-silverblue/zz0-"*"-bazzite-nvidia-silverblue-"*".gschema.override" && \
      rm "/usr/share/ublue-os/dconfs/nvidia-silverblue/zz0-"*"-bazzite-nvidia-silverblue-"*".gschema.override" \
    ; fi && \
    mkdir -p /tmp/bazzite-schema-test && \
    find "/usr/share/glib-2.0/schemas/" -type f ! -name "*.gschema.override" -exec cp {} "/tmp/bazzite-schema-test/" \; && \
    cp "/usr/share/glib-2.0/schemas/zz0-"*".gschema.override" "/tmp/bazzite-schema-test/" && \
    echo "Running error test for Bazzite Nvidia gschema override. Aborting if failed." && \
    glib-compile-schemas --strict /tmp/bazzite-schema-test && \
    echo "Compiling gschema to include Bazzite Nvidia setting overrides" && \
    glib-compile-schemas /usr/share/glib-2.0/schemas &>/dev/null && \
    rm -r /tmp/bazzite-schema-test && \
    mkdir -p /var/tmp && chmod 1777 /var/tmp && \
    /usr/libexec/containerbuild/image-info && \
    /usr/libexec/containerbuild/build-initramfs && \
    /usr/libexec/containerbuild/cleanup.sh && \
    mkdir -p /var/tmp && chmod 1777 /var/tmp && \
    ostree container commit
