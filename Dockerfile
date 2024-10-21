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
#  -- https://patorjk.com/software/taag/#p=display&c=bash&f=Tmplr&t=ALL
#  -- https://patorjk.com/software/taag/#p=display&c=bash&f=Tmplr&t=FINAL
#  -- https://patorjk.com/software/taag/#p=display&c=bash&f=Tmplr&t=SYS
#  -- https://patorjk.com/software/taag/#p=display&c=bash&f=Big%20Chief&t=Section
#


#  -- about 40 minutes
#  ___________________________
#      ____
#      /   )
#  ---/__ /-----__---__----__-
#    /    )   /   ) (_ ` /___)
#  _/____/___(___(_(__)_(___ _
#
#

# ############################################################################
#                                                                     ┏┓┓┏┏┓
#   System maintenance with TSN TeX Live Workspace Docker image       ┗┓┗┫┗┓
#                                                                     ┗┛┗┛┗┛
# ############################################################################

FROM ghcr.io/tiacsys/tsn-ubtl-ws:2024.10.0 AS base

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
    aspell \
    aspell-de \
    aspell-de-1901 \
    aspell-en \
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
    enchant-2 \
    gfortran \
    git-core \
    gpg \
    graphviz \
    hunspell \
    hunspell-de-at \
    hunspell-de-ch \
    hunspell-de-de \
    hunspell-de-med \
    hunspell-en-au \
    hunspell-en-ca \
    hunspell-en-gb \
    hunspell-en-med \
    hunspell-en-us \
    hunspell-en-za \
    imagemagick \
    ispell \
    iamerican-huge \
    ibritish-huge \
    ingerman \
    libarchive-dev \
    libaspell-dev \
    libasound2-dev \
    libbz2-dev \
    libcairo2-dev \
    libcppdap-dev \
    libcurl4-openssl-dev \
    libdb-dev \
    libenchant-2-dev \
    libevent-dev \
    libexpat1-dev \
    libffi-dev \
    libfreetype-dev \
    libgbm-dev \
    libgdbm-dev \
    libgmp-dev \
    libgraphviz-dev \
    libgtest-dev \
    libhunspell-dev \
    libidn-dev \
    libjpeg8-dev \
    libjpeg-dev \
    libjsoncpp-dev \
    liblapack-dev \
    liblcms2-dev \
    liblzma-dev \
    libmysqlclient-dev \
    libncurses-dev \
    libnuspell-dev \
    libopenblas-dev \
    libpq-dev \
    libpspell-dev \
    libreadline-dev \
    librhash-dev \
    librsvg2-bin \
    librsvg2-dev \
    librtmp-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libssl-dev \
    libtiff5-dev \
    libuv1-dev \
    libwebp-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libxslt1-dev \
    libxslt-dev \
    libyaml-dev \
    llvm \
    mercurial \
    myspell-de-de-1901 \
    nettle-dev \
    nuspell \
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
    python3-dev \
    python3-pip \
    python3-venv \
    re2c \
    spell \
    subversion \
    swig \
    tar \
    tk-dev \
    unzip \
    uuid-dev \
    wamerican-huge \
    wbritish-huge \
    wcanadian-huge \
    wgerman-medical \
    wget \
    wngerman \
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
#                                                                   ┏┓┏┓┳┓┏┓
#   System maintenance for multiple runtime version management      ┣┫┗┓┃┃┣
#                                                                   ┛┗┗┛┻┛┻
# ############################################################################

#
# Manage multiple runtime versions with the
# ASDF version manager in workspace user space.
# https://github.com/asdf-vm/asdf
#

# Create on demand patches (hot-fixes)
COPY <<-"EO-ASDF-VM-PATCH" asdf-vm.patch
diff -purN .asdf-orig/plugins/cmake/lib/utils.bash .asdf/plugins/cmake/lib/utils.bash
--- .asdf-orig/plugins/cmake/lib/utils.bash
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

diff -purN .asdf-orig/plugins/ninja/bin/install .asdf/plugins/ninja/bin/install
--- .asdf-orig/plugins/ninja/bin/install
+++ .asdf/plugins/ninja/bin/install
@@ -31,7 +31,8 @@ install_ninja() {
     fail "asdf-ninja supports release installs only"
   fi

-  local platform
+  local platform=""
+  local arch=""

   case "$OSTYPE" in
     darwin*) platform="mac" ;;
@@ -39,7 +40,13 @@ install_ninja() {
     *) fail "Unsupported platform" ;;
   esac

-  local download_url="https://github.com/ninja-build/ninja/releases/download/v${version}/ninja-${platform}.zip"
+  case "$(uname -m)" in
+    x86_64 | amd64) arch="" ;;
+    aarch64 | arm64) arch="aarch64" ;;
+    *) fail "Unsupported architecture" ;;
+  esac
+
+  local download_url="https://github.com/ninja-build/ninja/releases/download/v${version}/ninja-${platform}${arch:+-$arch}.zip"
   local source_path="${install_path}/bin/ninja.zip"

   (
diff -purN .asdf-orig/plugins/python/bin/install .asdf/plugins/python/bin/install
--- .asdf-orig/plugins/python/bin/install
+++ .asdf/plugins/python/bin/install
@@ -19,14 +19,14 @@ install_python() {
   if [[ -n "${ASDF_PYTHON_PATCH_URL:-}" ]]; then
     echo "python-build --patch $version $install_path"
     echo "with patch file from: $ASDF_PYTHON_PATCH_URL"
-    $(python_build_path) --patch "$version" "$install_path" < <(curl -sSL "$ASDF_PYTHON_PATCH_URL")
+    $(python_build_path) ${PYTHON_BUILD_OPTS} --patch "$version" "$install_path" < <(curl -sSL "$ASDF_PYTHON_PATCH_URL")
   elif [[ -n "${ASDF_PYTHON_PATCHES_DIRECTORY:-}" ]] && [[ -f ${ASDF_PYTHON_PATCHES_DIRECTORY}/${version}.patch ]]; then
     local patch_file=${ASDF_PYTHON_PATCHES_DIRECTORY}/${version}.patch
     echo "python-build $version $install_path -p < $patch_file"
-    $(python_build_path) "$version" "$install_path" -p < $patch_file
+    $(python_build_path) ${PYTHON_BUILD_OPTS} "$version" "$install_path" -p < $patch_file
   else
     echo "python-build $version $install_path"
-    $(python_build_path) "$version" "$install_path"
+    $(python_build_path) ${PYTHON_BUILD_OPTS} "$version" "$install_path"
   fi
 }
EO-ASDF-VM-PATCH

# Install ASDF required plugins and patch on demand locally
# - https://github.com/asdf-community/asdf-python?tab=readme-ov-file#default-python-packages
# - https://github.com/asdf-community/asdf-golang?tab=readme-ov-file#default-go-get-packages
# - https://github.com/asdf-community/asdf-golang?tab=readme-ov-file#goroot
# - https://github.com/asdf-vm/asdf-nodejs?tab=readme-ov-file#default-npm-packages
# - https://github.com/asdf-vm/asdf-ruby?tab=readme-ov-file#default-gems
# - https://github.com/code-lever/asdf-rust?tab=readme-ov-file#default-cargo-crates
RUN asdf plugin update --all \
 && asdf plugin add \
         cmake \
         https://github.com/asdf-community/asdf-cmake.git \
    \
 && asdf plugin add \
         ninja \
         https://github.com/asdf-community/asdf-ninja.git \
    \
 && asdf plugin add \
         python \
         https://github.com/asdf-community/asdf-python.git \
 && touch $WSUSER_HOME/.default-python-packages \
    \
 && asdf plugin add \
         golang \
         https://github.com/asdf-community/asdf-golang.git \
 && touch $WSUSER_HOME/.default-golang-pkgs \
 && echo ". ~/.asdf/plugins/golang/set-env.bash" \
 >> $WSUSER_HOME/.bashrc \
    \
 && asdf plugin add \
         nodejs \
         https://github.com/asdf-vm/asdf-nodejs.git \
 && touch $WSUSER_HOME/.default-npm-packages \
    \
 && asdf plugin add \
         ruby \
         https://github.com/asdf-vm/asdf-ruby.git \
 && touch $WSUSER_HOME/.default-gems \
    \
 && asdf plugin add \
         rust \
         https://github.com/code-lever/asdf-rust.git \
 && touch $WSUSER_HOME/.default-cargo-crates \
    \
 && asdf plugin add \
         pipx \
         https://github.com/yozachar/asdf-pipx.git \
 && echo "export USE_EMOJI=false" \
 >> $WSUSER_HOME/.bashrc \
    \
 && patch -p0 --verbose < asdf-vm.patch \
 && rm -vf asdf-vm.patch


#  -- about 4 hours
#  __________________________________________
#        __      _   _
#      /    )    /  /|            /
#  ---/---------/| /-|-----__----/-__-----__-
#    /         / |/  |   /   )  /(      /___)
#  _(____/____/__/___|__(___(__/___\___(___ _
#
#

# ############################################################################
#                                                                     ┏┓┓ ┓
#   All architectures maintenance for CMake configuration system      ┣┫┃ ┃
#                                                                     ┛┗┗┛┗┛
# ############################################################################

FROM base AS cmake-all

#
# CMake runtime versions
# https://cmake.org/download/#latest
# https://cmake.org/cmake/help/latest/release/index.html
# https://gitlab.kitware.com/cmake/community/-/wikis/home#specific
# https://github.com/asdf-community/asdf-cmake
# https://github.com/asdf-community/asdf-cmake/commits
#

# Define CMake versions to be installed via ASDF
ENV TSN_ASDF_CMAKE_VERSION_320=3.20.6
ENV TSN_ASDF_CMAKE_VERSION_330=3.30.5
ENV TSN_ASDF_CMAKE_VERSION=$TSN_ASDF_CMAKE_VERSION_330

# ############################################################################

# Install CMake versions and set default version
RUN asdf install cmake $TSN_ASDF_CMAKE_VERSION_320 \
 && asdf global  cmake $TSN_ASDF_CMAKE_VERSION_320 \
 && asdf reshim  cmake \
    \
 && asdf install cmake $TSN_ASDF_CMAKE_VERSION_330 \
 && asdf global  cmake $TSN_ASDF_CMAKE_VERSION_330 \
 && asdf reshim  cmake \
    \
 && asdf local   cmake $TSN_ASDF_CMAKE_VERSION \
 && asdf list    cmake \
    \
 && cpack --version \
 && ctest --version \
 && cmake --version \
 && cmake --system-information

# ############################################################################
#                                                                  ┏┓┳┳┓┏┓┓
#   Final maintenance for CMake configuration system               ┣ ┃┃┃┣┫┃
#                                                                  ┻ ┻┛┗┛┗┗┛
# ############################################################################

FROM cmake-all AS cmake

# Adding labels for external usage
LABEL cmake.version_320=$TSN_ASDF_CMAKE_VERSION_320
LABEL cmake.version_330=$TSN_ASDF_CMAKE_VERSION_330
LABEL cmake.version=$TSN_ASDF_CMAKE_VERSION
