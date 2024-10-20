TiaC Systems Network (TSN) Ubuntu Read-our-Docs (RoD) Workspace
===============================================================

This repository contains the build configuration of the |Docs-as-Code WS|_
for TiaC Systems Network (TSN) as multi-arch Docker images for Linux. It
will be used for processing our |tutorial|_ and |training|_ materials.

.. |Docs-as-Code WS| replace:: Ubuntu workspace for our Docs-as-Code
   workspace with |reStructuredText|_ and |Sphinx-doc|_
.. _`Docs-as-Code WS`: https://www.writethedocs.org/guide/docs-as-code

.. |tutorial| replace:: :emphasis:`tutorial`
.. _`tutorial`: https://bridle.tiac-systems.net/tutorials

.. |training| replace:: :emphasis:`training`
.. _`training`: https://bridle.tiac-systems.net/trainings

Documentation
-------------

The documentation overview is in this `readme in the project root directory
<README.rst>`_.

Further readings for more inspiration or improvements in future:

- https://github.com/readthedocs/readthedocs-docker-images
- https://hub.docker.com/r/readthedocs/build

Content
-------

Based on our own `TSN TeX Live Workspace Docker image`_, |tsn-ubtl-ws-tag|:

- Docker image architectures:

  - Intel/AMD x86 64-bit (``linux/amd64``)
  - ARMv7 32-bit (``linux/arm/v7``)
  - ARMv8 64-bit (``linux/arm64/v8``)
  - RISC-V 64-bit (``linux/riscv64``)
  - IBM POWER8 (``linux/ppc64le``)
  - IBM z-Systems (``linux/s390x``)

.. _`TSN TeX Live Workspace Docker image`: https://github.com/tiacsys/tsn-ubtl-ws
.. |tsn-ubtl-ws-tag| replace:: :strong:`ghcr.io/tiacsys/tsn-ubtl-ws:2024.10.0`

.. early references:

.. _`ASDF`: https://asdf-vm.com/
.. _`Autoconf`: https://en.wikipedia.org/wiki/Autoconf
.. _`Bash`: https://en.wikipedia.org/wiki/Bash_(Unix_shell)
.. _`Clang`: https://en.wikipedia.org/wiki/Clang
.. _`Clang++`: `Clang`_
.. |CMake| replace:: :strong:`CMake`
.. _`CMake`: https://en.wikipedia.org/wiki/CMake
.. _`cURL`: https://en.wikipedia.org/wiki/cURL
.. _`Doxygen`: https://en.wikipedia.org/wiki/Doxygen
.. _`Enchant`: https://en.wikipedia.org/wiki/Enchant_(software)
.. _`Fortran`: https://en.wikipedia.org/wiki/Fortran
.. _`Git`: https://en.wikipedia.org/wiki/Git
.. _`GNU Aspell`: https://en.wikipedia.org/wiki/GNU_Aspell
.. _`GNU Bazaar`: https://en.wikipedia.org/wiki/GNU_Bazaar
.. _`GNU C Compiler`: https://en.wikipedia.org/wiki/GNU_Compiler_Collection
.. _`GNU C++ Compiler`: `GNU C Compiler`_
.. _`GNU C Preprocessor`: `GNU C Compiler`_
.. _`GNU Core Utilities`: https://en.wikipedia.org/wiki/GNU_Core_Utilities
.. _`GNU Privacy Guard`: https://en.wikipedia.org/wiki/GNU_Privacy_Guard
.. |Golang| replace:: :strong:`Golang`
.. _`Golang`: https://en.wikipedia.org/wiki/Go_(programming_language)
.. _`Graphviz`: https://en.wikipedia.org/wiki/Graphviz
.. _`Hunspell`: https://en.wikipedia.org/wiki/Hunspell
.. _`ImageMagick`: https://en.wikipedia.org/wiki/ImageMagick
.. _`Ispell`: https://en.wikipedia.org/wiki/Ispell
.. _`Java`: https://en.wikipedia.org/wiki/Java_(programming_language)
.. _`Librsvg`: https://en.wikipedia.org/wiki/Librsvg
.. _`Librsvg2`: `Librsvg`_
.. _`LLVM`: https://en.wikipedia.org/wiki/LLVM
.. _`Mercurial`: https://en.wikipedia.org/wiki/Mercurial
.. _`MySpell`: https://en.wikipedia.org/wiki/MySpell
.. |Ninja| replace:: :strong:`Ninja`
.. _`Ninja`: https://en.wikipedia.org/wiki/Ninja_(build_system)
.. |Node.js| replace:: :strong:`Node.js`
.. _`Node.js`: https://en.wikipedia.org/wiki/Node.js
.. |Npm| replace:: :strong:`Npm`
.. _`Npm`: https://en.wikipedia.org/wiki/Npm_(package_manager)
.. _`Npm.js`: `Npm`_
.. _`Nuspell`: https://en.wikipedia.org/wiki/Spell_checker#Unix
.. _`OpenJDK`: https://en.wikipedia.org/wiki/OpenJDK
.. _`Pandoc`: https://en.wikipedia.org/wiki/Pandoc
.. _`Patch`: https://en.wikipedia.org/wiki/Patch_(computing)
.. _`pkg-config`: https://en.wikipedia.org/wiki/pkg-config
.. _`PlantUML`: https://en.wikipedia.org/wiki/PlantUML
.. _`PostgreSQL`: https://en.wikipedia.org/wiki/PostgreSQL
.. _`Poppler`: https://en.wikipedia.org/wiki/Poppler_(software)
.. _`Pspell`: https://en.wikipedia.org/wiki/Pspell
.. |Pip| replace:: :strong:`Pip`
.. _`Pip`: https://en.wikipedia.org/wiki/Pip_(package_manager)
.. |PyPA pipx| replace:: :strong:`PyPA pipx`
.. _`PyPA pipx`: https://en.wikipedia.org/wiki/Pip_(package_manager)
.. |PyPI| replace:: :strong:`PyPI`
.. _`PyPI`: https://en.wikipedia.org/wiki/PyPI
.. |Python| replace:: :strong:`Python`
.. _`Python`: https://en.wikipedia.org/wiki/Python_(programming_language)
.. _`re2c`: https://en.wikipedia.org/wiki/re2c
.. |reStructuredText| replace:: :strong:`reStructuredText`
.. _`reStructuredText`: https://en.wikipedia.org/wiki/reStructuredText
.. |Ruby| replace:: :strong:`Ruby`
.. _`Ruby`: https://en.wikipedia.org/wiki/Ruby_(programming_language)
.. |Rust| replace:: :strong:`Rust`
.. _`Rust`: https://en.wikipedia.org/wiki/Rust_(programming_language)
.. |Setuptools| replace:: :strong:`Setuptools`
.. _`Setuptools`: https://en.wikipedia.org/wiki/Pip_(package_manager)#See_also
.. |Sphinx-doc| replace:: :strong:`Sphinx-doc`
.. _`Sphinx-doc`: https://en.wikipedia.org/wiki/Sphinx_(documentation_generator)
.. _`Subversion`: https://en.wikipedia.org/wiki/Subversion
.. _`SWIG`: https://en.wikipedia.org/wiki/SWIG
.. _`Tar`: https://en.wikipedia.org/wiki/Tar_(computing)
.. _`Tcl/Tk`: https://en.wikipedia.org/wiki/Tk_(software)
.. _`Unzip`: `ZIP`_
.. _`Wget`: https://en.wikipedia.org/wiki/Wget
.. _`XZ Utils`: https://en.wikipedia.org/wiki/XZ_Utils
.. _`ZIP`: https://en.wikipedia.org/wiki/ZIP_(file_format)

Ubuntu system packages
**********************

.. rubric:: Basic development tools

- |build-essential-version|_

  - basic system C/C++ compiler: ``gcc`` / ``g++``
  - basic system API C library: ``<libc-dev>`` / ``<linux-kernel-headers>``
  - basic system API C++ library: ``<libstdc++-dev>``
  - system package development tools: ``dpkg-dev``
  - utility for directing compilation: ``make``

.. |build-essential-version| replace:: list of build-essential packages :strong:`v12.10`
.. _`build-essential-version`: https://packages.ubuntu.com/noble/build-essential

.. rubric:: Recommended build tools and APIs

- **Web Access**: `cURL`_, `Wget`_
- **DB Access**: `PostgreSQL`_ (client)
- **Repository Access**: `Git`_, `GNU Bazaar`_, `Mercurial`_, `Subversion`_
- **Configuration and Build**: `Java`_/`OpenJDK`_ (JRE), `pkg-config`_
- **Development Packages**: ``<lib*-dev>``/``<*-dev>``, `SWIG`_,
  see `Dockerfile <Dockerfile>`_ for complete list
- **Documentation**: `Doxygen`_, `Graphviz`_, `ImageMagick`_, `Librsvg2`_,
  `Pandoc`_, `PlantUML`_, `Poppler`_
- **Spell Checker**: `Enchant`_, `GNU Aspell`_, `Hunspell`_, `Ispell`_,
  `MySpell`_, `Pspell`_, `Nuspell`_

.. rubric:: `Ninja`_ extra requirements for `ASDF`_

- https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file
- https://github.com/asdf-community/asdf-ninja?tab=readme-ov-file
- https://github.com/asdf-community/asdf-ninja?tab=readme-ov-file#prerequirements
- https://github.com/ninja-build/ninja?tab=readme-ov-file#building-ninja-itself

  - **Web Access**: `cURL`_
  - **Repository Access**: `Git`_
  - **Archive Access**: `Unzip`_
  - **Configuration and Build**: `CMake`_, `re2c`_
  - **Development Packages**: `Python`_, `GNU C++ Compiler`_ (``g++``)

::

   asdf plugin-add ninja https://github.com/asdf-community/asdf-ninja.git

.. rubric:: `CMake`_ extra requirements for `ASDF`_

- https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file
- https://github.com/asdf-community/asdf-cmake?tab=readme-ov-file
- https://github.com/asdf-community/asdf-cmake?tab=readme-ov-file#dependencies

  - **Web Access**: `cURL`_
  - **Archive Access**: `Tar`_
  - **Configuration and Build**: `Bash`_
  - **Development Packages**: `Fortran`_ (``gfortran``),
    `GNU C++ Compiler`_ (``g++``)

::

   asdf plugin add cmake https://github.com/asdf-community/asdf-cmake.git

.. rubric:: `Python`_ extra requirements for `ASDF`_

- https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file
- https://github.com/asdf-community/asdf-python?tab=readme-ov-file
- https://github.com/pyenv/pyenv/wiki#suggested-build-environment
- https://github.com/pyenv/pyenv/blob/master/plugins/python-build/README.md
- https://github.com/python/cpython?tab=readme-ov-file#build-instructions

  - **Web Access**: `cURL`_, `Wget`_
  - **Repository Access**: `Git`_
  - **Archive Access**: `XZ Utils`_
  - **Development Packages**: `Clang++`_ (``clang++``), `LLVM`_, `Tcl/Tk`_

::

   asdf plugin add python https://github.com/asdf-community/asdf-python.git

.. rubric:: `Golang`_ extra requirements for `ASDF`_

- https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file
- https://github.com/asdf-community/asdf-golang?tab=readme-ov-file
- https://github.com/asdf-community/asdf-golang?tab=readme-ov-file#linux-debian

  - **Web Access**: `cURL`_
  - **Configuration and Build**: `GNU Core Utilities`_

::

   asdf plugin add golang https://github.com/asdf-community/asdf-golang.git

.. rubric:: `Node.js`_ extra requirements for `ASDF`_

- https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file
- https://github.com/asdf-vm/asdf-nodejs?tab=readme-ov-file
- https://github.com/asdf-vm/asdf-nodejs/tree/9cc4f0a?tab=readme-ov-file#linux-debian
- https://github.com/nodejs/node/blob/main/BUILDING.md#unix-prerequisites

  - **Configuration and Build**: `GNU Privacy Guard`_ (``dirmngr``, ``gpg``)
  - **Development Packages**: `Python`_ **3** (with ``pip``),
    `GNU C++ Compiler`_ (``g++``)

::

   asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

.. rubric:: `Ruby`_ extra requirements for `ASDF`_

- https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file
- https://github.com/asdf-vm/asdf-ruby?tab=readme-ov-file
- https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
- https://docs.ruby-lang.org/en/master/contributing/building_ruby_md.html

  - **Configuration and Build**: `Autoconf`_, `Patch`_
  - **Development Packages**: `Rust`_

::

   asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

.. rubric:: `Rust`_ extra requirements for `ASDF`_

- https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file
- https://github.com/code-lever/asdf-rust?tab=readme-ov-file
- https://github.com/rust-lang/rust/blob/master/INSTALL.md#dependencies

  - **Web Access**: `cURL`_
  - **Repository Access**: `Git`_
  - **Configuration and Build**: `CMake`_, `Ninja`_, `pkg-config`_
  - **Development Packages**: `Python`_ **3**, `Clang++`_ (``clang++``),
    `GNU C++ Compiler`_ (``g++``)

::

   asdf plugin-add rust https://github.com/code-lever/asdf-rust.git

.. rubric:: `PyPA pipx`_ for `Python`_ extra requirements for `ASDF`_

- https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file
- https://github.com/yozachar/asdf-pipx?tab=readme-ov-file
- https://github.com/yozachar/asdf-pipx?tab=readme-ov-file#dependencies
- https://pipx.pypa.io/stable/installation/#system-requirements

  - **Web Access**: `cURL`_
  - **Configuration and Build**: `Bash`_
  - **Development Packages**: `Python`_ **3** (``>=3.7``, with
    ``argcomplete>=1.9.4``, ``colorama>=0.4.4; sys_platform == 'win32'``,
    ``importlib-metadata>=3.3.0; python_version < '3.8'``,
    ``packaging>=20.0``, ``platformdirs>=2.1.0``, ``userpath>=1.6.0``)

::

   asdf plugin add python https://github.com/yozachar/asdf-pipx.git

.. References
.. ----------

.. .. target-notes::

.. unicode replacements:

.. |_| unicode:: 0xA0
   :trim:

.. |__| unicode:: 0xA0 0xA0
   :trim:

.. |___| unicode:: 0xA0 0xA0 0xA0
   :trim:

.. |____| unicode:: 0xA0 0xA0 0xA0 0xA0
   :trim:
