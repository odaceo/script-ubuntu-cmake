#!/bin/bash

# Copyright (C) 2017 Odaceo. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CMAKE_VERSION=${1:-'3.8.2'}
CMAKE_SHORT_VERSION=${CMAKE_VERSION%.*}

# Uninstall the current version if any
sudo apt-get purge -y cmake

# Install CMake
wget --no-check-certificate https://cmake.org/files/v${CMAKE_SHORT_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh
sudo mkdir --parent /opt/cmake
sudo sh cmake-${CMAKE_VERSION}-Linux-x86_64.sh --prefix=/opt/cmake --skip-license

# Configure the user environment
echo 'source ~/.bash_profile_cmake' | tee -a ~/.bash_profile
cat <<EOF > ~/.bash_profile_cmake
export PATH=/opt/cmake/bin:$PATH
EOF

# Init environment
source ~/.bash_profile_cmake

# Make sure cmake is working properly
cmake --version
