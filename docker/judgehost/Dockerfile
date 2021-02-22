FROM debian:latest
MAINTAINER DOMjudge team <team@domjudge.org>

ENV DEBIAN_FRONTEND=noninteractive \
	CONTAINER_TIMEZONE=Europe/Amsterdam \
	DOMSERVER_BASEURL=http://domserver/ \
	JUDGEDAEMON_USERNAME=judgehost \
	JUDGEDAEMON_PASSWORD=password \
	DAEMON_ID=0 \
	DOMJUDGE_CREATE_WRITABLE_TEMP_DIR=0 \
	RUN_USER_UID_GID=62860

# Install required packages for running of judgehost
RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
	acl zip unzip supervisor sudo procps libcgroup1 \
	php-cli php-zip php-gd php-curl php-mysql php-json \
	php-gmp php-xml php-mbstring python3 \
	gcc g++ default-jre-headless default-jdk ghc fp-compiler \
	apt-transport-https dirmngr gnupg ca-certificates \
	\
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
	&& echo 'deb https://download.mono-project.com/repo/debian stable-buster main' | tee /etc/apt/sources.list.d/mono-official-stable.list \
	&& apt-get update \
	&& apt-get install -y ruby mono-devel mono-basic-dbg \
	\
	&& apt-get -y install clang libcurl4 libpython2.7 libpython2.7-dev libncurses5 curl \
	&& curl https://swift.org/builds/swift-5.2.4-release/ubuntu1804/swift-5.2.4-RELEASE/swift-5.2.4-RELEASE-ubuntu18.04.tar.gz --output swift.tar.gz \
	&& mkdir swift \
	&& tar -xvzf swift.tar.gz -C swift --strip-components 1 \
	&& cp -rv swift/usr/ / \
	&& rm -rfv swift swift.tar.gz \
	\
	&& curl -sL https://deb.nodesource.com/setup_12.x | bash - \
	&& apt-get install -y nodejs \
	&& npm install -g typescript ts-node \
	\
	&& rm -rf /var/lib/apt/lists/*

# Add chroot and judgehost data
ADD chroot.tar.gz /
ADD judgehost.tar.gz /
RUN cp /opt/domjudge/judgehost/etc/sudoers-domjudge /etc/sudoers.d/

# Add scripts
COPY ["judgehost/scripts", "/scripts/"]

# Change start script permissions, add user and fix permissions
RUN chmod +x /scripts/start.sh \
	&& useradd -m domjudge \
	&& chown -R domjudge: /opt/domjudge

# Make the scripts available to the root user
ENV PATH="$PATH:/opt/domjudge/judgehost/bin"

CMD ["/scripts/start.sh"]
