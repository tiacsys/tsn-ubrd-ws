# syntax=docker/dockerfile:1
#
# TiaC Systems Network - Ubuntu Read-our-Docs Workspace
#
#  -- derived from TSN TeX Live Workspace Docker image
#  -- see: https://github.com/tiacsys/tsn-ubtl-ws/pkgs/container/tsn-ubtl-ws
#  -- see: https://github.com/tiacsys/tsn-ubtl-ws
#
#  -- derived from Read the Docs Docker images
#  -- see: https://github.com/readthedocs/readthedocs-docker-images
#  -- see: https://github.com/readthedocs/readthedocs-docker-images/blob/main/Dockerfile
#
#  -- support Docker multi-platform image build
#  -- see: https://docs.docker.com/build/building/multi-platform
#  -- see: https://docs.docker.com/build/building/variables/#multi-platform-build-arguments
#
#  -- TARGETPLATFORM=linux/amd64: TARGETOS=linux, TARGETARCH=amd64, TARGETVARIANT=
#  -- TARGETPLATFORM=linux/arm/v7: TARGETOS=linux, TARGETARCH=arm, TARGETVARIANT=v7
#  -- TARGETPLATFORM=linux/arm64/v8: TARGETOS=linux, TARGETARCH=arm64, TARGETVARIANT=v8
#  -- TARGETPLATFORM=linux/riscv64: TARGETOS=linux, TARGETARCH=riscv64, TARGETVARIANT=
#  -- TARGETPLATFORM=linux/ppc64le: TARGETOS=linux, TARGETARCH=ppc64le, TARGETVARIANT=
#  -- TARGETPLATFORM=linux/s390x: TARGETOS=linux, TARGETARCH=s390x, TARGETVARIANT=
#

# ############################################################################
#
# Base system maintenance with TSN TeX Live Workspace Docker image
#
# ############################################################################

FROM ghcr.io/tiacsys/tsn-ubtl-ws:main AS base

# overwrite Ubuntu default metadata
LABEL mantainer="Stephan Linz <stephan.linz@tiac-systems.de>"
LABEL version="unstable"

# ############################################################################

# workspace user definitions (copied from tiacsys/tsn-asdf-ws Dockerfile)
ARG WSUSER_HOME=/home/tsn
ARG WSUSER_NAME=tsn

# ############################################################################

# switch to superuser
USER root
WORKDIR /

# ############################################################################

# Install requirements
RUN apt-get --assume-yes update \
 && apt-get --assume-yes dist-upgrade \
 && apt-get --assume-yes install --no-install-recommends \
    autoconf \
    bash \
    build-essential \
    bzr \
    clang \
    coreutils \
    curl \
    default-jre \
    dirmngr \
    doxygen \
    git-core \
    gpg \
    graphviz \
    graphviz-dev \
    imagemagick \
    libbz2-dev \
    libcairo2-dev \
    libdb-dev \
    libenchant-2-dev \
    libevent-dev \
    libffi-dev \
    libfreetype-dev \
    libgdbm-dev \
    libgmp-dev \
    libgraphviz-dev \
    libjpeg8-dev \
    libjpeg-dev \
    liblcms2-dev \
    liblzma-dev \
    libmysqlclient-dev \
    libncurses-dev \
    libpq-dev \
    libreadline-dev \
    librsvg2-bin \
    librsvg2-dev \
    libsqlite3-dev \
    libssl-dev \
    libtiff5-dev \
    libwebp-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libxslt1-dev \
    libxslt-dev \
    libyaml-dev \
    llvm \
    mercurial \
    pandoc \
    pandoc-sidenote \
    pandoc-plantuml-filter \
    patch \
    pdf2svg \
    pkg-config \
    plantuml \
    poppler-utils \
    postgresql-client \
    python3 \
    python3-clang \
    subversion \
    swig \
    tar \
    tk-dev \
    unzip \
    uuid-dev \
    wget \
    xz-utils \
    zlib1g-dev \
 && apt-get --assume-yes autoremove --purge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ############################################################################

# switch to workspace user
USER $WSUSER_NAME
WORKDIR $WSUSER_HOME

# ############################################################################

#
# Manage multiple runtime versions with the
# ASDF version manager in workspace user space.
# https://github.com/asdf-vm/asdf
#

# Create on demand reqired patches
COPY <<-"EO-ASDF-VM-PATCH" asdf-vm.patch
--- .asdf/plugins/cmake/lib/utils.bash.orig
+++ .asdf/plugins/cmake/lib/utils.bash
@@ -53,10 +53,10 @@ get_source_download_url() {

   if [[ "$version" =~ ^[0-9]+\.* ]]; then
     # if version is a release number, prepend v
-    echo "https://github.com/Kitware/CMake/archive/v${version}.zip"
+    echo "https://github.com/Kitware/CMake/archive/v${version}.tar.gz"
   else
     # otherwise it can be a branch name or commit sha
-    echo "https://github.com/Kitware/CMake/archive/${version}.zip"
+    echo "https://github.com/Kitware/CMake/archive/${version}.tar.gz"
   fi
 }

@@ -107,7 +107,7 @@ binary_download_and_extract() {
   local download_dir=$2

   local extract_dir="${download_dir}/bin"
-  mkdir -p "$extract_dir"
+  mkdir -p "${extract_dir}"

   local download_file="${download_dir}/${TOOL_NAME}-${version}-bin.tar.gz"

@@ -117,6 +117,7 @@ binary_download_and_extract() {
     return 0
   fi

+  rm -rf "${extract_dir}"
   return 1
 }

@@ -127,7 +128,7 @@ source_download_and_extract() {
   local download_dir=$2

   local extract_dir="${download_dir}/src"
-  mkdir -p "$extract_dir"
+  mkdir -p "${extract_dir}"

   local download_file="${download_dir}/${TOOL_NAME}-${version}-src.tar.gz"

@@ -137,6 +138,7 @@ source_download_and_extract() {
     return 0
   fi

+  rm -rf "${extract_dir}"
   return 1
 }
EO-ASDF-VM-PATCH

# Install ASDF required plugins and patch on demand locally
RUN asdf plugin update --all \
 && asdf plugin add \
         ninja \
         https://github.com/asdf-community/asdf-ninja.git \
 && asdf plugin add \
         cmake \
         https://github.com/asdf-community/asdf-cmake.git \
 && asdf plugin add \
         python \
         https://github.com/asdf-community/asdf-python.git \
 && asdf plugin add \
         golang \
         https://github.com/asdf-community/asdf-golang.git \
 && asdf plugin add \
         nodejs \
         https://github.com/asdf-vm/asdf-nodejs.git \
 && asdf plugin add \
         ruby \
         https://github.com/asdf-vm/asdf-ruby.git \
 && asdf plugin add \
         rust \
         https://github.com/code-lever/asdf-rust.git \
    \
 && patch -p0 --verbose < asdf-vm.patch \
 && rm -vf asdf-vm.patch
