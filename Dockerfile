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


#  -- about 5 minutes
#  _______________________________________
#      _     _
#      /|   /     ,               ,
#  ---/-| -/-----------__--------------__-
#    /  | /     /    /   )      /    /   )
#  _/___|/_____/____/___/______/____(___(_
#                             /
#                         (_ /

# ############################################################################
#                                                                     ┏┓┓ ┓
#   All architectures maintenance for Ninja build system              ┣┫┃ ┃
#                                                                     ┛┗┗┛┗┛
# ############################################################################

FROM cmake AS ninja-all

#
# Ninja runtime versions
# https://ninja-build.org/
# https://github.com/ninja-build/ninja/releases
# https://github.com/asdf-community/asdf-ninja
# https://github.com/asdf-community/asdf-ninja/commits
#

# ############################################################################
#
#   AMD/x86 64-bit architecture maintenance for               /||\/||\ / /|
#   Ninja build system                                       /-||  ||/(_)~|~
#
# ############################################################################

FROM ninja-all AS ninja-amd64

# Define Ninja versions to be installed via ASDF
ENV TSN_ASDF_NINJA_VERSION=1.12.1

# ############################################################################

# Install Ninja versions and set default version
RUN asdf install ninja $TSN_ASDF_NINJA_VERSION \
 && asdf global  ninja $TSN_ASDF_NINJA_VERSION \
 && asdf reshim  ninja \
    \
 && asdf local   ninja $TSN_ASDF_NINJA_VERSION \
 && asdf list    ninja \
    \
 && ninja --version

# ############################################################################
#
#   ARMv7 32-bit architecture maintenance for                       /||)|\/|
#   Ninja build system                                             /-||\|  |
#
#   -- not supported by ASDF plugin, fall back to system package
#
# ############################################################################

FROM ninja-all AS ninja-arm

# Define Ninja version to be installed via Apt/Dpkg
ENV TSN_ASDF_NINJA_VERSION=1.11.1

# ############################################################################

# switch to superuser
USER root
WORKDIR /

# ############################################################################

# Install requirements
RUN apt-get --assume-yes update \
 && apt-get --assume-yes install --no-install-recommends \
    ninja-build \
 && apt-get --assume-yes autoremove --purge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
 && ninja --version

# ############################################################################

# switch to workspace user
USER $WSUSER_NAME
WORKDIR $WSUSER_HOME

# ############################################################################
#
#   ARMv8 64-bit architecture maintenance for                 /||)|\/| / /|
#   Ninja build system                                       /-||\|  |(_)~|~
#
#   -- HOTFIX: Avoid silent failure, with reason inside of cURL
#      <- curl: (55) Send failure: Broken pipe
#      <- OpenSSL SSL_write: Broken pipe, errno 32
#
# ############################################################################

FROM ninja-all AS ninja-arm64

# Define Ninja versions to be installed via ASDF
ENV TSN_ASDF_NINJA_VERSION=1.12.1

# ############################################################################

# Install Ninja versions and set default version (with cURL HOTFIX)
RUN echo "--insecure" > $WSUSER_HOME/.curlrc \
 && asdf install ninja $TSN_ASDF_NINJA_VERSION \
 && asdf global  ninja $TSN_ASDF_NINJA_VERSION \
 && asdf reshim  ninja \
    \
 && rm -f $WSUSER_HOME/.curlrc \
    \
 && asdf local   ninja $TSN_ASDF_NINJA_VERSION \
 && asdf list    ninja \
    \
 && ninja --version

# ############################################################################
#
#   RISC-V 64-bit architecture maintenance for               |)|(`/`| // /|
#   Ninja build system                                       |\|_)\,|/(_)~|~
#
#   -- not supported by ASDF plugin, fall back to system package
#
# ############################################################################

FROM ninja-all AS ninja-riscv64

# Define Ninja version to be installed via Apt/Dpkg
ENV TSN_ASDF_NINJA_VERSION=1.11.1

# ############################################################################

# switch to superuser
USER root
WORKDIR /

# ############################################################################

# Install requirements
RUN apt-get --assume-yes update \
 && apt-get --assume-yes install --no-install-recommends \
    ninja-build \
 && apt-get --assume-yes autoremove --purge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
 && ninja --version

# ############################################################################

# switch to workspace user
USER $WSUSER_NAME
WORKDIR $WSUSER_HOME

# ############################################################################
#
#   IBM POWER8 architecture maintenance for                 |)|)/` / /| | [~
#   Ninja build system                                      | | \,(_)~|~|_[_
#
#   -- not supported by ASDF plugin, fall back to system package
#
# ############################################################################

FROM ninja-all AS ninja-ppc64le

# Define Ninja version to be installed via Apt/Dpkg
ENV TSN_ASDF_NINJA_VERSION=1.11.1

# ############################################################################

# switch to superuser
USER root
WORKDIR /

# ############################################################################

# Install requirements
RUN apt-get --assume-yes update \
 && apt-get --assume-yes install --no-install-recommends \
    ninja-build \
 && apt-get --assume-yes autoremove --purge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
 && ninja --version

# ############################################################################

# switch to workspace user
USER $WSUSER_NAME
WORKDIR $WSUSER_HOME

# ############################################################################
#
#   IBM z-Systems architecture maintenance for                   (`')(~)/\\/
#   Ninja build system                                           _).) / \//\
#
#   -- not supported by ASDF plugin, fall back to system package
#
# ############################################################################

FROM ninja-all AS ninja-s390x

# Define Ninja version to be installed via Apt/Dpkg
ENV TSN_ASDF_NINJA_VERSION=1.11.1

# ############################################################################

# switch to superuser
USER root
WORKDIR /

# ############################################################################

# Install requirements
RUN apt-get --assume-yes update \
 && apt-get --assume-yes install --no-install-recommends \
    ninja-build \
 && apt-get --assume-yes autoremove --purge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
 && ninja --version

# ############################################################################

# switch to workspace user
USER $WSUSER_NAME
WORKDIR $WSUSER_HOME

# ############################################################################
#                                                                  ┏┓┳┳┓┏┓┓
#   Final maintenance for Ninja build system                       ┣ ┃┃┃┣┫┃
#                                                                  ┻ ┻┛┗┛┗┗┛
# ############################################################################

FROM ninja-${TARGETARCH} AS ninja

# Adding labels for external usage
LABEL ninja.version=$TSN_ASDF_NINJA_VERSION


#  -- about 10 minutes
#  ______________________________
#      ____
#      /    )
#  ---/___ /------------__---_/_-
#    /    |    /   /   (_ `  /
#  _/_____|___(___(___(__)__(_ __
#
#

# ############################################################################
#                                                                     ┏┓┓ ┓
#   All architectures maintenance for Rust runtime environments       ┣┫┃ ┃
#                                                                     ┛┗┗┛┗┛
# ############################################################################

FROM ninja AS rust-all

#
# Rust runtime versions
# https://releases.rs/
# https://github.com/code-lever/asdf-rust
# https://github.com/code-lever/asdf-rust/commits
#

# Define Rust versions to be installed via ASDF
ENV TSN_ASDF_RUST_VERSION_2022=1.67.1
ENV TSN_ASDF_RUST_VERSION_2023=1.76.0
ENV TSN_ASDF_RUST_VERSION_2024=1.82.0
ENV TSN_ASDF_RUST_VERSION=$TSN_ASDF_RUST_VERSION_2023

# ############################################################################

# Install Rust versions and set default version
RUN asdf install rust $TSN_ASDF_RUST_VERSION_2022 \
 && asdf global  rust $TSN_ASDF_RUST_VERSION_2022 \
 && asdf reshim  rust \
    \
 && asdf install rust $TSN_ASDF_RUST_VERSION_2023 \
 && asdf global  rust $TSN_ASDF_RUST_VERSION_2023 \
 && asdf reshim  rust \
    \
 && asdf install rust $TSN_ASDF_RUST_VERSION_2024 \
 && asdf global  rust $TSN_ASDF_RUST_VERSION_2024 \
 && asdf reshim  rust \
    \
 && asdf local   rust $TSN_ASDF_RUST_VERSION \
 && asdf list    rust \
    \
 && cargo --version \
 && cargo-fmt --version \
 && cargo-clippy --version \
 && rustfmt --version \
 && rustdoc --version \
 && rustc --version \
 && rustup --version \
 && rustup component list --installed \
 && rustup target list --installed \
 && rustup toolchain list --verbose \
 && rustup show active-toolchain \
 && rustup show home

# ############################################################################
#                                                                  ┏┓┳┳┓┏┓┓
#   Final maintenance for Rust runtime environments                ┣ ┃┃┃┣┫┃
#                                                                  ┻ ┻┛┗┛┗┗┛
# ############################################################################

FROM rust-all AS rust

# Adding labels for external usage
LABEL rust.version_2022=$TSN_ASDF_RUST_VERSION_2022
LABEL rust.version_2023=$TSN_ASDF_RUST_VERSION_2023
LABEL rust.version_2024=$TSN_ASDF_RUST_VERSION_2024
LABEL rust.version=$TSN_ASDF_RUST_VERSION


#  -- about 2 hours
#  ____________________________________________
#      ____
#      /    )                 /
#  ---/____/----------_/_----/__-----__-----__-
#    /         /   /  /     /   )  /   )  /   )
#  _/_________(___/__(_ ___/___/__(___/__/___/_
#                /
#            (_ /

# ############################################################################
#                                                                     ┏┓┓ ┓
#   All architectures maintenance for Python runtime environments     ┣┫┃ ┃
#                                                                     ┛┗┗┛┗┛
# ############################################################################

FROM rust AS python-all

#
# Python runtime versions
# https://www.python.org/downloads
# https://devguide.python.org/versions
# https://github.com/asdf-community/asdf-python
# https://github.com/asdf-community/asdf-python/commits
#

# Define Python package versions to be installed via pip
# - https://pypi.org/project/pip/24.3.1
# - https://pypi.org/project/setuptools/75.3.0
# - https://pypi.org/project/virtualenv/20.27.1
# - https://pypi.org/project/wheel/0.44.0
# - https://pypi.org/project/poetry/1.8.4
# - https://pypi.org/project/west/1.3.0
ENV TSN_ASDF_PYPI_PIP_VERSION=24.3.1
ENV TSN_ASDF_PYPI_SETUPTOOLS_VERSION=75.3.0
ENV TSN_ASDF_PYPI_VIRTUALENV_VERSION=20.27.1
ENV TSN_ASDF_PYPI_WHEEL_VERSION=0.44.0
ENV TSN_ASDF_PYPI_POETRY_VERSION=1.8.4
ENV TSN_ASDF_PYPI_WEST_VERSION=1.3.0

# Define CPython default behaviour for compilations (shared libraries)
# ENV PYTHON_BUILD_OPTS="--verbose"
ENV PYTHON_CONFIGURE_OPTS="--enable-shared"

# ############################################################################
#
#   AMD/x86 64-bit architecture maintenance for               /||\/||\ / /|
#   Python runtime environments                              /-||  ||/(_)~|~
#
# ############################################################################

FROM python-all AS python-amd64

# Define Python versions to be installed via ASDF
ENV TSN_ASDF_PYTHON_VERSION_310=3.10.15
ENV TSN_ASDF_PYTHON_VERSION_312=3.12.7
ENV TSN_ASDF_PYTHON_VERSION_313=3.13.0
ENV TSN_ASDF_PYTHON_VERSION=$TSN_ASDF_PYTHON_VERSION_312

### NOT YET ### # Define CPython default optimization for compilations (PGO and LTO active)
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --enable-optimizations"
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --with-lto"

# ############################################################################

# Install Python versions and set default version
RUN echo "pip==$TSN_ASDF_PYPI_PIP_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "setuptools==$TSN_ASDF_PYPI_SETUPTOOLS_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "virtualenv==$TSN_ASDF_PYPI_VIRTUALENV_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "wheel==$TSN_ASDF_PYPI_WHEEL_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "poetry==$TSN_ASDF_PYPI_POETRY_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "west==$TSN_ASDF_PYPI_WEST_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION_310 \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION_310 \
 && asdf reshim  python \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION_312 \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION_312 \
 && asdf reshim  python \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION_313 \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION_313 \
 && asdf reshim  python \
    \
 && asdf local   python $TSN_ASDF_PYTHON_VERSION \
 && asdf list    python \
    \
 && pip --version \
 && pip3 --version \
 && pip3.12 --version \
 && python --version \
 && python3 --version \
 && python3.12 --version \
 && python-config --help \
 && python3-config --help \
 && python3.12-config --help \
 && pip list --verbose

# ############################################################################

# Adding labels for external usage
LABEL python.version_310=$TSN_ASDF_PYTHON_VERSION_310
LABEL python.version_312=$TSN_ASDF_PYTHON_VERSION_312
LABEL python.version_313=$TSN_ASDF_PYTHON_VERSION_313

# ############################################################################
#
#   ARMv7 32-bit architecture maintenance for                       /||)|\/|
#   Python runtime environments                                    /-||\|  |
#
# ############################################################################

FROM python-all AS python-arm

# Define Python versions to be installed via ASDF
ENV TSN_ASDF_PYTHON_VERSION_312=3.12.7
ENV TSN_ASDF_PYTHON_VERSION=$TSN_ASDF_PYTHON_VERSION_312

### NOT YET ### # Define CPython default optimization for compilations (PGO and LTO active)
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --enable-optimizations"
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --with-lto"

# ############################################################################

# Install Python versions and set default version
RUN echo "pip==$TSN_ASDF_PYPI_PIP_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "setuptools==$TSN_ASDF_PYPI_SETUPTOOLS_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "virtualenv==$TSN_ASDF_PYPI_VIRTUALENV_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "wheel==$TSN_ASDF_PYPI_WHEEL_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "poetry==$TSN_ASDF_PYPI_POETRY_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "west==$TSN_ASDF_PYPI_WEST_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION \
 && asdf reshim  python \
    \
 && asdf local   python $TSN_ASDF_PYTHON_VERSION \
 && asdf list    python \
    \
 && pip --version \
 && pip3 --version \
 && pip3.12 --version \
 && python --version \
 && python3 --version \
 && python3.12 --version \
 && python-config --help \
 && python3-config --help \
 && python3.12-config --help \
 && pip list --verbose

# ############################################################################

# Adding labels for external usage
LABEL python.version_312=$TSN_ASDF_PYTHON_VERSION_312

# ############################################################################
#
#   ARMv8 64-bit architecture maintenance for                /||)|\/| / /|
#   Python runtime environments                             /-||\|  |(_)~|~
#
# ############################################################################

FROM python-all AS python-arm64

# Define Python versions to be installed via ASDF
ENV TSN_ASDF_PYTHON_VERSION_310=3.10.15
ENV TSN_ASDF_PYTHON_VERSION_312=3.12.7
ENV TSN_ASDF_PYTHON_VERSION_313=3.13.0
ENV TSN_ASDF_PYTHON_VERSION=$TSN_ASDF_PYTHON_VERSION_312

### NOT YET ### # Define CPython default optimization for compilations (PGO and LTO active)
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --enable-optimizations"
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --with-lto"

# ############################################################################

# Install Python versions and set default version
RUN echo "pip==$TSN_ASDF_PYPI_PIP_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "setuptools==$TSN_ASDF_PYPI_SETUPTOOLS_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "virtualenv==$TSN_ASDF_PYPI_VIRTUALENV_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "wheel==$TSN_ASDF_PYPI_WHEEL_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "poetry==$TSN_ASDF_PYPI_POETRY_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "west==$TSN_ASDF_PYPI_WEST_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION_310 \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION_310 \
 && asdf reshim  python \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION_312 \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION_312 \
 && asdf reshim  python \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION_313 \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION_313 \
 && asdf reshim  python \
    \
 && asdf local   python $TSN_ASDF_PYTHON_VERSION \
 && asdf list    python \
    \
 && pip --version \
 && pip3 --version \
 && pip3.12 --version \
 && python --version \
 && python3 --version \
 && python3.12 --version \
 && python-config --help \
 && python3-config --help \
 && python3.12-config --help \
 && pip list --verbose

# ############################################################################

# Adding labels for external usage
LABEL python.version_310=$TSN_ASDF_PYTHON_VERSION_310
LABEL python.version_312=$TSN_ASDF_PYTHON_VERSION_312
LABEL python.version_313=$TSN_ASDF_PYTHON_VERSION_313

# ############################################################################
#
#   RISC-V 64-bit architecture maintenance for               |)|(`/`| // /|
#   Python runtime environments                              |\|_)\,|/(_)~|~
#
# ############################################################################

FROM python-all AS python-riscv64

# Define Python versions to be installed via ASDF
ENV TSN_ASDF_PYTHON_VERSION_312=3.12.7
ENV TSN_ASDF_PYTHON_VERSION=$TSN_ASDF_PYTHON_VERSION_312

### NOT YET ### # Define CPython default optimization for compilations (PGO and LTO active)
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --enable-optimizations"
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --with-lto"

# ############################################################################

# Install Python versions and set default version
RUN echo "pip==$TSN_ASDF_PYPI_PIP_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "setuptools==$TSN_ASDF_PYPI_SETUPTOOLS_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "virtualenv==$TSN_ASDF_PYPI_VIRTUALENV_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "wheel==$TSN_ASDF_PYPI_WHEEL_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "poetry==$TSN_ASDF_PYPI_POETRY_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "west==$TSN_ASDF_PYPI_WEST_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION \
 && asdf reshim  python \
    \
 && asdf local   python $TSN_ASDF_PYTHON_VERSION \
 && asdf list    python \
    \
 && pip --version \
 && pip3 --version \
 && pip3.12 --version \
 && python --version \
 && python3 --version \
 && python3.12 --version \
 && python-config --help \
 && python3-config --help \
 && python3.12-config --help \
 && pip list --verbose

# ############################################################################

# Adding labels for external usage
LABEL python.version_312=$TSN_ASDF_PYTHON_VERSION_312

# ############################################################################
#
#   IBM POWER8 architecture maintenance for                 |)|)/` / /| | [~
#   Python runtime environments                             | | \,(_)~|~|_[_
#
# ############################################################################

FROM python-all AS python-ppc64le

# Define Python versions to be installed via ASDF
ENV TSN_ASDF_PYTHON_VERSION_312=3.12.7
ENV TSN_ASDF_PYTHON_VERSION=$TSN_ASDF_PYTHON_VERSION_312

### NOT YET ### # Define CPython default optimization for compilations (PGO and LTO active)
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --enable-optimizations"
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --with-lto"

# ############################################################################

# Install Python versions and set default version
RUN echo "pip==$TSN_ASDF_PYPI_PIP_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "setuptools==$TSN_ASDF_PYPI_SETUPTOOLS_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "virtualenv==$TSN_ASDF_PYPI_VIRTUALENV_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "wheel==$TSN_ASDF_PYPI_WHEEL_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "poetry==$TSN_ASDF_PYPI_POETRY_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "west==$TSN_ASDF_PYPI_WEST_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION \
 && asdf reshim  python \
    \
 && asdf local   python $TSN_ASDF_PYTHON_VERSION \
 && asdf list    python \
    \
 && pip --version \
 && pip3 --version \
 && pip3.12 --version \
 && python --version \
 && python3 --version \
 && python3.12 --version \
 && python-config --help \
 && python3-config --help \
 && python3.12-config --help \
 && pip list --verbose

# ############################################################################

# Adding labels for external usage
LABEL python.version_312=$TSN_ASDF_PYTHON_VERSION_312

# ############################################################################
#
#   IBM z-Systems architecture maintenance for                   (`')(~)/\\/
#   Python runtime environments                                  _).) / \//\
#
# ############################################################################

FROM python-all AS python-s390x

# Define Python versions to be installed via ASDF
ENV TSN_ASDF_PYTHON_VERSION_312=3.12.7
ENV TSN_ASDF_PYTHON_VERSION=$TSN_ASDF_PYTHON_VERSION_312

### NOT YET ### # Define CPython default optimization for compilations (PGO and LTO active)
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --enable-optimizations"
### NOT YET ### ENV PYTHON_CONFIGURE_OPTS="$PYTHON_CONFIGURE_OPTS --with-lto"

# ############################################################################

# Install Python versions and set default version
RUN echo "pip==$TSN_ASDF_PYPI_PIP_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "setuptools==$TSN_ASDF_PYPI_SETUPTOOLS_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "virtualenv==$TSN_ASDF_PYPI_VIRTUALENV_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "wheel==$TSN_ASDF_PYPI_WHEEL_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "poetry==$TSN_ASDF_PYPI_POETRY_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
 && echo "west==$TSN_ASDF_PYPI_WEST_VERSION" \
 >> $WSUSER_HOME/.default-python-packages \
    \
 && asdf install python $TSN_ASDF_PYTHON_VERSION \
 && asdf global  python $TSN_ASDF_PYTHON_VERSION \
 && asdf reshim  python \
    \
 && asdf local   python $TSN_ASDF_PYTHON_VERSION \
 && asdf list    python \
    \
 && pip --version \
 && pip3 --version \
 && pip3.12 --version \
 && python --version \
 && python3 --version \
 && python3.12 --version \
 && python-config --help \
 && python3-config --help \
 && python3.12-config --help \
 && pip list --verbose

# ############################################################################

# Adding labels for external usage
LABEL python.version_312=$TSN_ASDF_PYTHON_VERSION_312

# ############################################################################
#                                                                  ┏┓┳┳┓┏┓┓
#   Final maintenance for Python runtime environments              ┣ ┃┃┃┣┫┃
#                                                                  ┻ ┻┛┗┛┗┗┛
# ############################################################################

FROM python-${TARGETARCH} AS python

# ############################################################################

# Adding labels for external usage
LABEL python.version=$TSN_ASDF_PYTHON_VERSION
LABEL python.pip.version=$TSN_ASDF_PYPI_PIP_VERSION
LABEL python.setuptools.version=$TSN_ASDF_PYPI_SETUPTOOLS_VERSION
LABEL python.virtualenv.version=$TSN_ASDF_PYPI_VIRTUALENV_VERSION
LABEL python.wheel.version=$TSN_ASDF_PYPI_WHEEL_VERSION
LABEL python.poetry.version=$TSN_ASDF_PYPI_POETRY_VERSION
LABEL python.west.version=$TSN_ASDF_PYPI_WEST_VERSION


#  -- about 10 minutes
#  ___________________________________________
#        __
#      /    )           /
#  ---/----------__----/-----__-----__-----__-
#    /  --,    /   )  /    /   )  /   )  /   )
#  _(____/____(___/__/____(___(__/___/__(___/_
#                                          /
#                                      (_ /

# ############################################################################
#                                                                     ┏┓┓ ┓
#   All architectures maintenance for Golang runtime environments     ┣┫┃ ┃
#                                                                     ┛┗┗┛┗┛
# ############################################################################

FROM python AS golang-all

#
# Golang runtime versions
# https://go.dev/doc/devel/release
# https://go.dev/dl
# https://github.com/asdf-community/asdf-golang
# https://github.com/asdf-community/asdf-golang/commits
#

# ############################################################################
#
#   AMD/x86 64-bit architecture maintenance for               /||\/||\ / /|
#   Golang runtime environments                              /-||  ||/(_)~|~
#
# ############################################################################

FROM golang-all AS golang-amd64

# Define Golang versions to be installed via ASDF
ENV TSN_ASDF_GOLANG_VERSION_2022=1.19.13
ENV TSN_ASDF_GOLANG_VERSION_2023=1.21.13
ENV TSN_ASDF_GOLANG_VERSION_2024=1.23.2
ENV TSN_ASDF_GOLANG_VERSION=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################

# Install Golang versions and set default version
RUN asdf install golang $TSN_ASDF_GOLANG_VERSION_2022 \
 && asdf global  golang $TSN_ASDF_GOLANG_VERSION_2022 \
 && asdf reshim  golang \
    \
 && asdf install golang $TSN_ASDF_GOLANG_VERSION_2023 \
 && asdf global  golang $TSN_ASDF_GOLANG_VERSION_2023 \
 && asdf reshim  golang \
    \
 && asdf install golang $TSN_ASDF_GOLANG_VERSION_2024 \
 && asdf global  golang $TSN_ASDF_GOLANG_VERSION_2024 \
 && asdf reshim  golang \
    \
 && asdf local   golang $TSN_ASDF_GOLANG_VERSION \
 && asdf list    golang \
    \
 && go version \
 && go env

# ############################################################################

# Adding labels for external usage
LABEL golang.version_2022=$TSN_ASDF_GOLANG_VERSION_2022
LABEL golang.version_2023=$TSN_ASDF_GOLANG_VERSION_2023
LABEL golang.version_2024=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################
#
#   ARMv7 32-bit architecture maintenance for                       /||)|\/|
#   Golang runtime environments                                    /-||\|  |
#
# ############################################################################

FROM golang-all AS golang-arm

# Define Golang versions to be installed via ASDF
ENV TSN_ASDF_GOLANG_VERSION_2024=1.23.2
ENV TSN_ASDF_GOLANG_VERSION=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################

# Install Golang versions and set default version
RUN asdf install golang $TSN_ASDF_GOLANG_VERSION \
 && asdf global  golang $TSN_ASDF_GOLANG_VERSION \
 && asdf reshim  golang \
    \
 && asdf local   golang $TSN_ASDF_GOLANG_VERSION \
 && asdf list    golang \
    \
 && go version \
 && go env

# ############################################################################

# Adding labels for external usage
LABEL golang.version_2024=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################
#
#   ARMv8 64-bit architecture maintenance for                 /||)|\/| / /|
#   Golang runtime environments                              /-||\|  |(_)~|~
#
#   -- HOTFIX: Avoid silent failure, with reason inside of cURL
#      <- curl: (55) Send failure: Broken pipe
#      <- OpenSSL SSL_write: Broken pipe, errno 32
#
# ############################################################################

FROM golang-all AS golang-arm64

# Define Golang versions to be installed via ASDF
ENV TSN_ASDF_GOLANG_VERSION_2022=1.19.13
ENV TSN_ASDF_GOLANG_VERSION_2023=1.21.13
ENV TSN_ASDF_GOLANG_VERSION_2024=1.23.2
ENV TSN_ASDF_GOLANG_VERSION=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################

# Install Golang versions and set default version (with cURL HOTFIX)
RUN echo "--insecure" > $WSUSER_HOME/.curlrc \
 && asdf install golang $TSN_ASDF_GOLANG_VERSION_2022 \
 && asdf global  golang $TSN_ASDF_GOLANG_VERSION_2022 \
 && asdf reshim  golang \
    \
 && asdf install golang $TSN_ASDF_GOLANG_VERSION_2023 \
 && asdf global  golang $TSN_ASDF_GOLANG_VERSION_2023 \
 && asdf reshim  golang \
    \
 && asdf install golang $TSN_ASDF_GOLANG_VERSION_2024 \
 && asdf global  golang $TSN_ASDF_GOLANG_VERSION_2024 \
 && asdf reshim  golang \
    \
 && rm -f $WSUSER_HOME/.curlrc \
    \
 && asdf local   golang $TSN_ASDF_GOLANG_VERSION \
 && asdf list    golang \
    \
 && go version \
 && go env

# ############################################################################

# Adding labels for external usage
LABEL golang.version_2022=$TSN_ASDF_GOLANG_VERSION_2022
LABEL golang.version_2023=$TSN_ASDF_GOLANG_VERSION_2023
LABEL golang.version_2024=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################
#
#   RISC-V 64-bit architecture maintenance for               |)|(`/`| // /|
#   Golang runtime environments                              |\|_)\,|/(_)~|~
#
# ############################################################################

FROM golang-all AS golang-riscv64

# Define Golang versions to be installed via ASDF
ENV TSN_ASDF_GOLANG_VERSION_2024=1.23.2
ENV TSN_ASDF_GOLANG_VERSION=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################

# Install Golang versions and set default version
RUN asdf install golang $TSN_ASDF_GOLANG_VERSION \
 && asdf global  golang $TSN_ASDF_GOLANG_VERSION \
 && asdf reshim  golang \
    \
 && asdf local   golang $TSN_ASDF_GOLANG_VERSION \
 && asdf list    golang \
    \
 && go version \
 && go env

# ############################################################################

# Adding labels for external usage
LABEL golang.version_2024=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################
#
#   IBM POWER8 architecture maintenance for                 |)|)/` / /| | [~
#   Golang runtime environments                             | | \,(_)~|~|_[_
#
# ############################################################################

FROM golang-all AS golang-ppc64le

# Define Golang versions to be installed via ASDF
ENV TSN_ASDF_GOLANG_VERSION_2024=1.23.2
ENV TSN_ASDF_GOLANG_VERSION=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################

# Install Golang versions and set default version
RUN asdf install golang $TSN_ASDF_GOLANG_VERSION \
 && asdf global  golang $TSN_ASDF_GOLANG_VERSION \
 && asdf reshim  golang \
    \
 && asdf local   golang $TSN_ASDF_GOLANG_VERSION \
 && asdf list    golang \
    \
 && go version \
 && go env

# ############################################################################

# Adding labels for external usage
LABEL golang.version_2024=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################
#
#   IBM z-Systems architecture maintenance for                   (`')(~)/\\/
#   Golang runtime environments                                  _).) / \//\
#
#   -- not supported by Golang cross compiling, fall back to system package
#
# ############################################################################

FROM golang-all AS golang-s390x

# Define Golang versions to be installed via ASDF
ENV TSN_ASDF_GOLANG_VERSION_2023=1.21.9
ENV TSN_ASDF_GOLANG_VERSION_2024=1.22.2
ENV TSN_ASDF_GOLANG_VERSION=$TSN_ASDF_GOLANG_VERSION_2024

# ############################################################################

# switch to superuser
USER root
WORKDIR /

# ############################################################################

# Install requirements
RUN apt-get --assume-yes update \
 && apt-get --assume-yes install --no-install-recommends \
    golang-go \
    golang-1.23-go \
    golang-1.22-go \
    golang-1.21-go \
 && apt-get --assume-yes autoremove --purge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
 && go version \
 && go env

# ############################################################################

# switch to workspace user
USER $WSUSER_NAME
WORKDIR $WSUSER_HOME

# ############################################################################

# Adding labels for external usage
LABEL golang.version_2024=$TSN_ASDF_GOLANG_VERSION_2024
LABEL golang.version_2023=$TSN_ASDF_GOLANG_VERSION_2023

# ############################################################################
#                                                                  ┏┓┳┳┓┏┓┓
#   Final maintenance for Golang runtime environments              ┣ ┃┃┃┣┫┃
#                                                                  ┻ ┻┛┗┛┗┗┛
# ############################################################################

FROM golang-${TARGETARCH} AS golang

# Adding labels for external usage
LABEL golang.version=$TSN_ASDF_GOLANG_VERSION


#  -- about 20 minutes
#  ____________________________________________________
#      _     _
#      /|   /                /                  ,
#  ---/-| -/------__-----__-/-----__----------------__-
#    /  | /     /   )  /   /    /___)         /    (_ `
#  _/___|/_____(___/__(___/____(___ __o______/____(__)_
#                                           /
#                                       (_ /

# ############################################################################
#                                                                     ┏┓┓ ┓
#   All architectures maintenance for Node.js runtime environments    ┣┫┃ ┃
#                                                                     ┛┗┗┛┗┛
# ############################################################################

FROM golang AS nodejs-all

#
# Node.js runtime versions
# https://nodejs.org/en/about/previous-releases
# https://nodejs.org/download/release
# https://github.com/asdf-vm/asdf-nodejs
# https://github.com/asdf-vm/asdf-nodejs/commits
#

# Define Node.js package versions to be installed via npm
# - https://www.npmjs.com/package/corepack/v/0.29.4
# - https://www.npmjs.com/package/decktape/v/3.14.0
# - https://www.npmjs.com/package/svg-term-cli/v/2.1.1
ENV TSN_ASDF_NPM_COREPACK_VERSION=0.29.4
ENV TSN_ASDF_NPM_DECKTAPE_VERSION=3.14.0
ENV TSN_ASDF_NPM_SVG_TERM_CLI_VERSION=2.1.1

# ############################################################################
#
#   AMD/x86 64-bit architecture maintenance for               /||\/||\ / /|
#   Node.js runtime environments                             /-||  ||/(_)~|~
#
# ############################################################################

FROM nodejs-all AS nodejs-amd64

# Define Node.js versions to be installed via ASDF
ENV TSN_ASDF_NODEJS_VERSION_18=18.20.4
ENV TSN_ASDF_NODEJS_VERSION_20=20.18.0
ENV TSN_ASDF_NODEJS_VERSION_22=22.10.0
ENV TSN_ASDF_NODEJS_VERSION=$TSN_ASDF_NODEJS_VERSION_20

# ############################################################################

# Install Node.js versions and set default version
RUN echo "corepack@$TSN_ASDF_NPM_COREPACK_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "decktape@$TSN_ASDF_NPM_DECKTAPE_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "svg-term-cli@$TSN_ASDF_NPM_SVG_TERM_CLI_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
    \
 && ASDF_NODEJS_VERBOSE_INSTALL=yes \
    asdf install nodejs $TSN_ASDF_NODEJS_VERSION_18 \
 && asdf global  nodejs $TSN_ASDF_NODEJS_VERSION_18 \
 && asdf reshim  nodejs \
    \
 && ASDF_NODEJS_VERBOSE_INSTALL=yes \
    asdf install nodejs $TSN_ASDF_NODEJS_VERSION_20 \
 && asdf global  nodejs $TSN_ASDF_NODEJS_VERSION_20 \
 && asdf reshim  nodejs \
    \
 && ASDF_NODEJS_VERBOSE_INSTALL=yes \
    asdf install nodejs $TSN_ASDF_NODEJS_VERSION_22 \
 && asdf global  nodejs $TSN_ASDF_NODEJS_VERSION_22 \
 && asdf reshim  nodejs \
    \
 && asdf local   nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf list    nodejs \
    \
 && npm --version \
 && npx --version \
 && node --version \
 && npm list --global \
 && corepack --version \
    \
 && decktape version \
 && svg-term --version

# ############################################################################

# Adding labels for external usage
LABEL nodejs.version_18=$TSN_ASDF_NODEJS_VERSION_18
LABEL nodejs.version_20=$TSN_ASDF_NODEJS_VERSION_20
LABEL nodejs.version_22=$TSN_ASDF_NODEJS_VERSION_22

# ############################################################################
#
#   ARMv7 32-bit architecture maintenance for                       /||)|\/|
#   Node.js runtime environments                                   /-||\|  |
#
# ############################################################################

FROM nodejs-all AS nodejs-arm

# Define Node.js versions to be installed via ASDF
ENV TSN_ASDF_NODEJS_VERSION_20=20.18.0
ENV TSN_ASDF_NODEJS_VERSION=$TSN_ASDF_NODEJS_VERSION_20

# ############################################################################

# Install Node.js versions and set default version
RUN echo "corepack@$TSN_ASDF_NPM_COREPACK_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "decktape@$TSN_ASDF_NPM_DECKTAPE_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "svg-term-cli@$TSN_ASDF_NPM_SVG_TERM_CLI_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
    \
 && ASDF_NODEJS_VERBOSE_INSTALL=yes \
    asdf install nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf global  nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf reshim  nodejs \
    \
 && asdf local   nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf list    nodejs \
    \
 && npm --version \
 && npx --version \
 && node --version \
 && npm list --global \
 && corepack --version \
    \
 && decktape version \
 && svg-term --version

# ############################################################################

# Adding labels for external usage
LABEL nodejs.version_20=$TSN_ASDF_NODEJS_VERSION_20

# ############################################################################
#
#   ARMv8 64-bit architecture maintenance for                 /||)|\/| / /|
#   Node.js runtime environments                             /-||\|  |(_)~|~
#
# ############################################################################

FROM nodejs-all AS nodejs-arm64

# Define Node.js versions to be installed via ASDF
ENV TSN_ASDF_NODEJS_VERSION_18=18.20.4
ENV TSN_ASDF_NODEJS_VERSION_20=20.18.0
ENV TSN_ASDF_NODEJS_VERSION_22=22.10.0
ENV TSN_ASDF_NODEJS_VERSION=$TSN_ASDF_NODEJS_VERSION_20

# ############################################################################

# Install Node.js versions and set default version
RUN echo "corepack@$TSN_ASDF_NPM_COREPACK_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "decktape@$TSN_ASDF_NPM_DECKTAPE_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "svg-term-cli@$TSN_ASDF_NPM_SVG_TERM_CLI_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
    \
 && ASDF_NODEJS_VERBOSE_INSTALL=yes \
    asdf install nodejs $TSN_ASDF_NODEJS_VERSION_18 \
 && asdf global  nodejs $TSN_ASDF_NODEJS_VERSION_18 \
 && asdf reshim  nodejs \
    \
 && ASDF_NODEJS_VERBOSE_INSTALL=yes \
    asdf install nodejs $TSN_ASDF_NODEJS_VERSION_20 \
 && asdf global  nodejs $TSN_ASDF_NODEJS_VERSION_20 \
 && asdf reshim  nodejs \
    \
 && ASDF_NODEJS_VERBOSE_INSTALL=yes \
    asdf install nodejs $TSN_ASDF_NODEJS_VERSION_22 \
 && asdf global  nodejs $TSN_ASDF_NODEJS_VERSION_22 \
 && asdf reshim  nodejs \
    \
 && asdf local   nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf list    nodejs \
    \
 && npm --version \
 && npx --version \
 && node --version \
 && npm list --global \
 && corepack --version \
    \
 && decktape version \
 && svg-term --version

# ############################################################################

# Adding labels for external usage
LABEL nodejs.version_18=$TSN_ASDF_NODEJS_VERSION_18
LABEL nodejs.version_20=$TSN_ASDF_NODEJS_VERSION_20
LABEL nodejs.version_22=$TSN_ASDF_NODEJS_VERSION_22

# ############################################################################
#
#   RISC-V 64-bit architecture maintenance for               |)|(`/`| // /|
#   Node.js runtime environments                             |\|_)\,|/(_)~|~
#
#   -- not supported by Node.js cross compiling, fall back to system package
#
# ############################################################################

FROM nodejs-all AS nodejs-riscv64

# Define Node.js versions to be installed via ASDF
ENV TSN_ASDF_NODEJS_VERSION_18=18.19.1
ENV TSN_ASDF_NODEJS_VERSION=$TSN_ASDF_NODEJS_VERSION_18

# ############################################################################

# switch to superuser
USER root
WORKDIR /

# ############################################################################

# Install requirements
RUN apt-get --assume-yes update \
 && apt-get --assume-yes install --no-install-recommends \
    nodejs \
    npm \
 && apt-get --assume-yes autoremove --purge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
 && npm install --global corepack@$TSN_ASDF_NPM_COREPACK_VERSION \
 && npm install --global decktape@$TSN_ASDF_NPM_DECKTAPE_VERSION \
 && npm install --global svg-term-cli@$TSN_ASDF_NPM_SVG_TERM_CLI_VERSION \
    \
 && npm --version \
 && npx --version \
 && node --version \
 && npm list --global \
 && corepack --version \
    \
 && decktape version \
 && svg-term --version

# ############################################################################

# switch to workspace user
USER $WSUSER_NAME
WORKDIR $WSUSER_HOME

# ############################################################################

# Adding labels for external usage
LABEL nodejs.version_18=$TSN_ASDF_NODEJS_VERSION_18

# ############################################################################
#
#   IBM POWER8 architecture maintenance for                 |)|)/` / /| | [~
#   Node.js runtime environments                            | | \,(_)~|~|_[_
#
# ############################################################################

FROM nodejs-all AS nodejs-ppc64le

# Define Node.js versions to be installed via ASDF
ENV TSN_ASDF_NODEJS_VERSION_20=20.18.0
ENV TSN_ASDF_NODEJS_VERSION=$TSN_ASDF_NODEJS_VERSION_20

# ############################################################################

# Install Node.js versions and set default version
RUN echo "corepack@$TSN_ASDF_NPM_COREPACK_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "decktape@$TSN_ASDF_NPM_DECKTAPE_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "svg-term-cli@$TSN_ASDF_NPM_SVG_TERM_CLI_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
    \
 && ASDF_NODEJS_VERBOSE_INSTALL=yes \
    asdf install nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf global  nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf reshim  nodejs \
    \
 && asdf local   nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf list    nodejs \
    \
 && npm --version \
 && npx --version \
 && node --version \
 && npm list --global \
 && corepack --version \
    \
 && decktape version \
 && svg-term --version

# ############################################################################

# Adding labels for external usage
LABEL nodejs.version_20=$TSN_ASDF_NODEJS_VERSION_20

# ############################################################################
#
#   IBM z-Systems architecture maintenance for                   (`')(~)/\\/
#   Node.js runtime environments                                 _).) / \//\
#
# ############################################################################

FROM nodejs-all AS nodejs-s390x

# Define Node.js versions to be installed via ASDF
ENV TSN_ASDF_NODEJS_VERSION_20=20.18.0
ENV TSN_ASDF_NODEJS_VERSION=$TSN_ASDF_NODEJS_VERSION_20

# ############################################################################

# Install Node.js versions and set default version
RUN echo "corepack@$TSN_ASDF_NPM_COREPACK_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "decktape@$TSN_ASDF_NPM_DECKTAPE_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
 && echo "svg-term-cli@$TSN_ASDF_NPM_SVG_TERM_CLI_VERSION" \
 >> $WSUSER_HOME/.default-npm-packages \
    \
 && ASDF_NODEJS_VERBOSE_INSTALL=yes \
    asdf install nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf global  nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf reshim  nodejs \
    \
 && asdf local   nodejs $TSN_ASDF_NODEJS_VERSION \
 && asdf list    nodejs \
    \
 && npm --version \
 && npx --version \
 && node --version \
 && npm list --global \
 && corepack --version \
    \
 && decktape version \
 && svg-term --version

# ############################################################################

# Adding labels for external usage
LABEL nodejs.version_20=$TSN_ASDF_NODEJS_VERSION_20

# ############################################################################
#                                                                  ┏┓┳┳┓┏┓┓
#   Final maintenance for Node.js runtime environments             ┣ ┃┃┃┣┫┃
#                                                                  ┻ ┻┛┗┛┗┗┛
# ############################################################################

FROM nodejs-${TARGETARCH} AS nodejs

# Adding labels for external usage
LABEL nodejs.version=$TSN_ASDF_NODEJS_VERSION
LABEL nodejs.corepack.version=$TSN_ASDF_NPM_COREPACK_VERSION
LABEL nodejs.decktape.version=$TSN_ASDF_NPM_DECKTAPE_VERSION
LABEL nodejs.svg-term-cli.version=$TSN_ASDF_NPM_SVG_TERM_CLI_VERSION


#  -- about 3 hours
#  ________________________________
#      ____
#      /    )            /
#  ---/___ /------------/__--------
#    /    |    /   /   /   )  /   /
#  _/_____|___(___(___(___/__(___/_
#                               /
#                           (_ /

# ############################################################################
#                                                                     ┏┓┓ ┓
#   All architectures maintenance for Ruby runtime environments       ┣┫┃ ┃
#                                                                     ┛┗┗┛┗┛
# ############################################################################

FROM nodejs AS ruby-all

#
# Ruby runtime versions
# https://www.ruby-lang.org/en/downloads/branches
# https://www.ruby-lang.org/en/downloads/releases
# https://github.com/asdf-vm/asdf-ruby
# https://github.com/asdf-vm/asdf-ruby/commits
#

# Define Ruby default behaviour for compilations (no documentation)
# ENV RUBY_BUILD_OPTS="--verbose"
ENV RUBY_CONFIGURE_OPTS="--with-mantype=doc"
ENV RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --disable-install-doc"
ENV RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --disable-install-rdoc"
ENV RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --disable-install-capi"

# Define Ruby default behaviour for compilations (JIT compiler with Ruby)
# - https://docs.ruby-lang.org/en/master/rjit/rjit_md.html
ENV RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --enable-rjit"

# ############################################################################
#
#   AMD/x86 64-bit architecture maintenance for               /||\/||\ / /|
#   Ruby runtime environments                                /-||  ||/(_)~|~
#
# ############################################################################

FROM ruby-all AS ruby-amd64

# Define Ruby versions to be installed via ASDF
ENV TSN_ASDF_RUBY_VERSION_31=3.1.6
ENV TSN_ASDF_RUBY_VERSION_32=3.2.5
ENV TSN_ASDF_RUBY_VERSION_33=3.3.5
ENV TSN_ASDF_RUBY_VERSION=$TSN_ASDF_RUBY_VERSION_33

# Define Ruby default behaviour for compilations (JIT compiler with Rust)
# - https://docs.ruby-lang.org/en/master/yjit/yjit_md.html
ENV RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --enable-yjit"

# ############################################################################

# Install Ruby versions and set default version
RUN asdf install ruby $TSN_ASDF_RUBY_VERSION_31 \
 && asdf global  ruby $TSN_ASDF_RUBY_VERSION_31 \
 && asdf reshim  ruby \
    \
 && asdf install ruby $TSN_ASDF_RUBY_VERSION_32 \
 && asdf global  ruby $TSN_ASDF_RUBY_VERSION_32 \
 && asdf reshim  ruby \
    \
 && asdf install ruby $TSN_ASDF_RUBY_VERSION_33 \
 && asdf global  ruby $TSN_ASDF_RUBY_VERSION_33 \
 && asdf reshim  ruby \
    \
 && asdf local   ruby $TSN_ASDF_RUBY_VERSION \
 && asdf list    ruby \
    \
 && bundle --version \
 && bundler --version \
 && erb --version \
 && irb --version \
 && racc --version \
 && rake --version \
 && rbs --version \
 && rdbg --version \
 && rdoc --version \
 && ri --version \
 && ruby --version \
 && gem --version \
 && gem list

# ############################################################################

# Adding labels for external usage
LABEL ruby.version_31=$TSN_ASDF_RUBY_VERSION_31
LABEL ruby.version_32=$TSN_ASDF_RUBY_VERSION_32
LABEL ruby.version_33=$TSN_ASDF_RUBY_VERSION_33

# ############################################################################
#
#   ARMv7 32-bit architecture maintenance for                       /||)|\/|
#   Ruby runtime environments                                      /-||\|  |
#
#   -- not supported by Ruby cross compiling, fall back to system package
#
# ############################################################################

FROM ruby-all AS ruby-arm

# Define Ruby versions to be installed via ASDF
ENV TSN_ASDF_RUBY_VERSION_32=3.2.3
ENV TSN_ASDF_RUBY_VERSION=$TSN_ASDF_RUBY_VERSION_32

# ############################################################################

# switch to superuser
USER root
WORKDIR /

# ############################################################################

# Install requirements
RUN apt-get --assume-yes update \
 && apt-get --assume-yes install --no-install-recommends \
    racc \
    ruby-bundler \
    ruby-rubygems \
    ruby-full \
 && apt-get --assume-yes autoremove --purge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
 && bundle --version \
 && bundler --version \
 && erb --version \
 && irb --version \
 && racc --version \
 && rake --version \
 && rbs3.2 --version \
 && rdbg3.2 --version \
 && rdoc --version \
 && ri --version \
 && ruby --version \
 && gem --version \
 && gem list

# ############################################################################

# switch to workspace user
USER $WSUSER_NAME
WORKDIR $WSUSER_HOME

# ############################################################################

# Adding labels for external usage
LABEL ruby.version_32=$TSN_ASDF_RUBY_VERSION_32

# ############################################################################
#
#   ARMv8 64-bit architecture maintenance for                 /||)|\/| / /|
#   Ruby runtime environments                                /-||\|  |(_)~|~
#
# ############################################################################

FROM ruby-all AS ruby-arm64

# Define Ruby versions to be installed via ASDF
ENV TSN_ASDF_RUBY_VERSION_31=3.1.6
ENV TSN_ASDF_RUBY_VERSION_32=3.2.5
ENV TSN_ASDF_RUBY_VERSION_33=3.3.5
ENV TSN_ASDF_RUBY_VERSION=$TSN_ASDF_RUBY_VERSION_33

# Define Ruby default behaviour for compilations (JIT compiler with Rust)
# - https://docs.ruby-lang.org/en/master/yjit/yjit_md.html
ENV RUBY_CONFIGURE_OPTS="$RUBY_CONFIGURE_OPTS --enable-yjit"

# ############################################################################

# Install Ruby versions and set default version
RUN asdf install ruby $TSN_ASDF_RUBY_VERSION_31 \
 && asdf global  ruby $TSN_ASDF_RUBY_VERSION_31 \
 && asdf reshim  ruby \
    \
 && asdf install ruby $TSN_ASDF_RUBY_VERSION_32 \
 && asdf global  ruby $TSN_ASDF_RUBY_VERSION_32 \
 && asdf reshim  ruby \
    \
 && asdf install ruby $TSN_ASDF_RUBY_VERSION_33 \
 && asdf global  ruby $TSN_ASDF_RUBY_VERSION_33 \
 && asdf reshim  ruby \
    \
 && asdf local   ruby $TSN_ASDF_RUBY_VERSION \
 && asdf list    ruby \
    \
 && bundle --version \
 && bundler --version \
 && erb --version \
 && irb --version \
 && racc --version \
 && rake --version \
 && rbs --version \
 && rdbg --version \
 && rdoc --version \
 && ri --version \
 && ruby --version \
 && gem --version \
 && gem list

# ############################################################################

# Adding labels for external usage
LABEL ruby.version_31=$TSN_ASDF_RUBY_VERSION_31
LABEL ruby.version_32=$TSN_ASDF_RUBY_VERSION_32
LABEL ruby.version_33=$TSN_ASDF_RUBY_VERSION_33

# ############################################################################
#
#   RISC-V 64-bit architecture maintenance for               |)|(`/`| // /|
#   Ruby runtime environments                                |\|_)\,|/(_)~|~
#
#   -- not supported by Ruby cross compiling, fall back to system package
#
# ############################################################################

FROM ruby-all AS ruby-riscv64

# Define Ruby versions to be installed via ASDF
ENV TSN_ASDF_RUBY_VERSION_32=3.2.3
ENV TSN_ASDF_RUBY_VERSION=$TSN_ASDF_RUBY_VERSION_32

# ############################################################################

# switch to superuser
USER root
WORKDIR /

# ############################################################################

# Install requirements
RUN apt-get --assume-yes update \
 && apt-get --assume-yes install --no-install-recommends \
    racc \
    ruby-bundler \
    ruby-rubygems \
    ruby-full \
 && apt-get --assume-yes autoremove --purge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    \
 && bundle --version \
 && bundler --version \
 && erb --version \
 && irb --version \
 && racc --version \
 && rake --version \
 && rbs3.2 --version \
 && rdbg3.2 --version \
 && rdoc --version \
 && ri --version \
 && ruby --version \
 && gem --version \
 && gem list

# ############################################################################

# switch to workspace user
USER $WSUSER_NAME
WORKDIR $WSUSER_HOME

# ############################################################################

# Adding labels for external usage
LABEL ruby.version_32=$TSN_ASDF_RUBY_VERSION_32

# ############################################################################
#
#   IBM POWER8 architecture maintenance for                 |)|)/` / /| | [~
#   Ruby runtime environments                               | | \,(_)~|~|_[_
#
# ############################################################################

FROM ruby-all AS ruby-ppc64le

# Define Ruby versions to be installed via ASDF
ENV TSN_ASDF_RUBY_VERSION_33=3.3.5
ENV TSN_ASDF_RUBY_VERSION=$TSN_ASDF_RUBY_VERSION_33

# ############################################################################

# Install Ruby versions and set default version
RUN asdf install ruby $TSN_ASDF_RUBY_VERSION \
 && asdf global  ruby $TSN_ASDF_RUBY_VERSION \
 && asdf reshim  ruby \
    \
 && asdf local   ruby $TSN_ASDF_RUBY_VERSION \
 && asdf list    ruby \
    \
 && bundle --version \
 && bundler --version \
 && erb --version \
 && irb --version \
 && racc --version \
 && rake --version \
 && rbs --version \
 && rdbg --version \
 && rdoc --version \
 && ri --version \
 && ruby --version \
 && gem --version \
 && gem list

# ############################################################################

# Adding labels for external usage
LABEL ruby.version_33=$TSN_ASDF_RUBY_VERSION_33

# ############################################################################
#
#   IBM z-Systems architecture maintenance for                   (`')(~)/\\/
#   Ruby runtime environments                                    _).) / \//\
#
# ############################################################################

FROM ruby-all AS ruby-s390x

# Define Ruby versions to be installed via ASDF
ENV TSN_ASDF_RUBY_VERSION_33=3.3.5
ENV TSN_ASDF_RUBY_VERSION=$TSN_ASDF_RUBY_VERSION_33

# ############################################################################

# Install Ruby versions and set default version
RUN asdf install ruby $TSN_ASDF_RUBY_VERSION \
 && asdf global  ruby $TSN_ASDF_RUBY_VERSION \
 && asdf reshim  ruby \
    \
 && asdf local   ruby $TSN_ASDF_RUBY_VERSION \
 && asdf list    ruby \
    \
 && bundle --version \
 && bundler --version \
 && erb --version \
 && irb --version \
 && racc --version \
 && rake --version \
 && rbs --version \
 && rdbg --version \
 && rdoc --version \
 && ri --version \
 && ruby --version \
 && gem --version \
 && gem list

# ############################################################################

# Adding labels for external usage
LABEL ruby.version_33=$TSN_ASDF_RUBY_VERSION_33

# ############################################################################
#                                                                  ┏┓┳┳┓┏┓┓
#   Final maintenance for Ruby runtime environments                ┣ ┃┃┃┣┫┃
#                                                                  ┻ ┻┛┗┛┗┗┛
# ############################################################################

FROM ruby-${TARGETARCH} AS ruby

# Adding labels for external usage
LABEL ruby.version=$TSN_ASDF_RUBY_VERSION


#  -- about 20 minutes
#  ___________________________________________________________
#      ____           ____     __
#      /    )         /    )   / |               ,
#  ---/____/---------/____/---/__|---------__----------__---|/
#    /        /   / /        /   |       /   ) /     /   )  |
#  _/________(___/_/________/____|______/___/_/_____/___/__/|_
#               /                      /           /      /
#           (_ /                      /           /

# ############################################################################
#                                                                     ┏┓┓ ┓
#   All architectures maintenance for PyPA pipx version packaging     ┣┫┃ ┃
#                                                                     ┛┗┗┛┗┛
# ############################################################################

FROM ruby AS pipx-all

#
# PyPA pipx multi-version packaging
# https://pipx.pypa.io/
# https://pipx.pypa.io/stable/CHANGELOG
# https://github.com/pypa/pipx/releases
# https://github.com/yozachar/asdf-pipx
# https://github.com/yozachar/asdf-pipx/commits
#

# Define PyPA pipx versions to be installed via ASDF
# - https://pypi.org/project/pipx/1.7.1
# - https://pypi.org/project/argcomplete/3.5.1
ENV TSN_ASDF_PIPX_VERSION=1.7.1
ENV TSN_ASDF_PIPX_ARGCOMPLETE_VERSION=3.5.1

# Define Python package versions to be installed via PyPA pipx
# - https://pypi.org/project/poetry/1.8.4
# - https://pypi.org/project/poetry/1.7.1
# - https://pypi.org/project/poetry/1.6.1
# - https://pypi.org/project/poetry/1.5.1
# - https://pypi.org/project/poetry/1.4.2
# - https://pypi.org/project/poetry/1.3.2
# - https://pypi.org/project/poetry/1.2.2
# - https://pypi.org/project/poetry/1.1.15
ENV TSN_ASDF_PIPX_POETRY_VERSION_18=1.8.4
ENV TSN_ASDF_PIPX_POETRY_VERSION_17=1.7.1
ENV TSN_ASDF_PIPX_POETRY_VERSION_16=1.6.1
ENV TSN_ASDF_PIPX_POETRY_VERSION_15=1.5.1
ENV TSN_ASDF_PIPX_POETRY_VERSION_14=1.4.2
ENV TSN_ASDF_PIPX_POETRY_VERSION_13=1.3.2
ENV TSN_ASDF_PIPX_POETRY_VERSION_12=1.2.2

# ############################################################################

# Install PyPA pipx versions, set default version, ensure PATH environment
# variable for PyPA pipx, enable shell completions for PyPA pipx, and install
# Python package versions into the defaul local Python environment.
RUN asdf install pipx $TSN_ASDF_PIPX_VERSION \
 && asdf global  pipx $TSN_ASDF_PIPX_VERSION \
 && asdf reshim  pipx \
    \
 && asdf local   pipx $TSN_ASDF_PIPX_VERSION \
 && asdf list    pipx \
    \
 && pipx install argcomplete==$TSN_ASDF_PIPX_ARGCOMPLETE_VERSION \
 && pipx pin     argcomplete \
    \
 && pipx ensurepath \
 && echo "eval \"\$(register-python-argcomplete --shell bash pipx)\"" \
 >> $WSUSER_HOME/.bashrc \
    \
 && pipx install --suffix=@$TSN_ASDF_PIPX_POETRY_VERSION_18 \
                   poetry==$TSN_ASDF_PIPX_POETRY_VERSION_18 \
 && pipx pin       poetry@$TSN_ASDF_PIPX_POETRY_VERSION_18 \
    \
 && pipx install --suffix=@$TSN_ASDF_PIPX_POETRY_VERSION_17 \
                   poetry==$TSN_ASDF_PIPX_POETRY_VERSION_17 \
 && pipx pin       poetry@$TSN_ASDF_PIPX_POETRY_VERSION_17 \
    \
 && pipx install --suffix=@$TSN_ASDF_PIPX_POETRY_VERSION_16 \
                   poetry==$TSN_ASDF_PIPX_POETRY_VERSION_16 \
 && pipx pin       poetry@$TSN_ASDF_PIPX_POETRY_VERSION_16 \
    \
 && pipx install --suffix=@$TSN_ASDF_PIPX_POETRY_VERSION_15 \
                   poetry==$TSN_ASDF_PIPX_POETRY_VERSION_15 \
 && pipx pin       poetry@$TSN_ASDF_PIPX_POETRY_VERSION_15 \
    \
 && pipx install --suffix=@$TSN_ASDF_PIPX_POETRY_VERSION_14 \
                   poetry==$TSN_ASDF_PIPX_POETRY_VERSION_14 \
 && pipx pin       poetry@$TSN_ASDF_PIPX_POETRY_VERSION_14 \
    \
 && pipx install --suffix=@$TSN_ASDF_PIPX_POETRY_VERSION_13 \
                   poetry==$TSN_ASDF_PIPX_POETRY_VERSION_13 \
 && pipx pin       poetry@$TSN_ASDF_PIPX_POETRY_VERSION_13 \
    \
 && pipx install --suffix=@$TSN_ASDF_PIPX_POETRY_VERSION_12 \
                   poetry==$TSN_ASDF_PIPX_POETRY_VERSION_12 \
 && pipx pin       poetry@$TSN_ASDF_PIPX_POETRY_VERSION_12 \
    \
 && pipx --version \
 && pipx environment --verbose \
 && pipx list --verbose \
    \
 && eval "PATH=\${PATH}:\$(pipx environment --value PIPX_BIN_DIR)" \
 && poetry@$TSN_ASDF_PIPX_POETRY_VERSION_18 --version \
 && poetry@$TSN_ASDF_PIPX_POETRY_VERSION_17 --version \
 && poetry@$TSN_ASDF_PIPX_POETRY_VERSION_16 --version \
 && poetry@$TSN_ASDF_PIPX_POETRY_VERSION_15 --version \
 && poetry@$TSN_ASDF_PIPX_POETRY_VERSION_14 --version \
 && poetry@$TSN_ASDF_PIPX_POETRY_VERSION_13 --version \
 && poetry@$TSN_ASDF_PIPX_POETRY_VERSION_12 --version

# ############################################################################
#                                                                  ┏┓┳┳┓┏┓┓
#   Final maintenance for PyPA pipx version packaging              ┣ ┃┃┃┣┫┃
#                                                                  ┻ ┻┛┗┛┗┗┛
# ############################################################################

FROM pipx-all AS pipx

# ############################################################################

# Adding labels for external usage
LABEL pipx.version=$TSN_ASDF_PIPX_VERSION
LABEL pipx.argcomplete.version=$TSN_ASDF_PIPX_ARGCOMPLETE_VERSION
LABEL pipx.poetry.version_18=$TSN_ASDF_PIPX_POETRY_VERSION_18
LABEL pipx.poetry.version_17=$TSN_ASDF_PIPX_POETRY_VERSION_17
LABEL pipx.poetry.version_16=$TSN_ASDF_PIPX_POETRY_VERSION_16
LABEL pipx.poetry.version_15=$TSN_ASDF_PIPX_POETRY_VERSION_15
LABEL pipx.poetry.version_14=$TSN_ASDF_PIPX_POETRY_VERSION_14
LABEL pipx.poetry.version_13=$TSN_ASDF_PIPX_POETRY_VERSION_13
LABEL pipx.poetry.version_12=$TSN_ASDF_PIPX_POETRY_VERSION_12
