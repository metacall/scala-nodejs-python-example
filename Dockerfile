#
#	MetaCall Scala NodeJS Python Example by Parra Studios
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

# Build Image
FROM metacall/core:runtime AS builder

# Install dependencies
RUN apt-get update \
	&& mkdir -p /usr/share/man/man1 \
	&& apt-get install -y --no-install-recommends \
		openjdk-11-jre-headless \
		openjdk-11-jdk-headless \
		apt-transport-https \
		curl \
		gnupg \
	&& echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list \
	&& echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list \
	&& curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" \
		| gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import \
	&& chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg \
	&& apt-get update \
	&& apt-get install -y sbt

# Force rebuild for latest version
ARG DISABLE_CACHE=0
ARG GITHUB_TOKEN

WORKDIR /root/metacall-scala-nodejs-python-example

COPY . .

RUN GITHUB_TOKEN=${GITHUB_TOKEN} sbt clean assembly

# Runtime image
FROM metacall/core:runtime AS runtime

# Install dependencies
RUN apt-get update \
	&& mkdir -p /usr/share/man/man1 \
	&& apt-get install -y --no-install-recommends \
		openjdk-11-jre-headless \
		scala

WORKDIR /root

ENV LOADER_SCRIPT_PATH=/root/scripts

COPY --from=builder /root/metacall-scala-nodejs-python-example/scripts /root/scripts
COPY --from=builder /root/metacall-scala-nodejs-python-example/target /root

CMD [ "scala", "scala-2.13/metacall-scala-nodejs-python-example-assembly-0.1.0-SNAPSHOT.jar" ]
