#
#	MetaCall Python NodeJS Scala Example by Parra Studios
#	An example of using Python and NodeJS from Scala.
#
#	Copyright (C) 2016 - 2020 Vicente Eduardo Ferrer Garcia <vic798@gmail.com>
#
#	Licensed under the Apache License, Version 2.0 (the "License");
#	you may not use this file except in compliance with the License.
#	You may obtain a copy of the License at
#
#		http://www.apache.org/licenses/LICENSE-2.0
#
#	Unless required by applicable law or agreed to in writing, software
#	distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#	See the License for the specific language governing permissions and
#	limitations under the License.
#

FROM metacall/core:runtime AS builder

# Image descriptor
LABEL copyright.name="Vicente Eduardo Ferrer Garcia" \
	copyright.address="vic798@gmail.com" \
	maintainer.name="Vicente Eduardo Ferrer Garcia" \
	maintainer.address="vic798@gmail.com" \
	vendor="MetaCall Inc." \
	version="0.1"

# Install dependencies
RUN apt-get update \
	&& mkdir -p /usr/share/man/man1 \
	&& apt-get install -y --no-install-recommends \
		openjdk-11-jre-headless \
		openjdk-11-jdk-headless \
		scala

# Force rebuild for latest version
ARG DISABLE_CACHE=0

# Copy MetaCall Scala Port
ADD https://raw.githubusercontent.com/metacall/core/develop/source/ports/scala_port/metacall.scala .

# Copy scripts
COPY scripts/ .

# Environment variables for MetaCall
ENV LOADER_LIBRARY_PATH=/usr/local/lib \
	LOADER_SCRIPT_PATH=/usr/local/metacall

# Build the scala project
RUN scalac main.scala

# Set up the entry point
CMD [ "scala", "Main" ]
