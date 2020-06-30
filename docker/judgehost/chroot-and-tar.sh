#!/bin/bash
/opt/domjudge/judgehost/bin/dj_make_chroot -i "ruby"

/opt/domjudge/judgehost/bin/dj_run_chroot "apt-get update && \
apt-get install -y apt-transport-https dirmngr gnupg ca-certificates && \
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
echo 'deb https://download.mono-project.com/repo/debian stable-buster main' | tee /etc/apt/sources.list.d/mono-official-stable.list && \
apt-get update && \
apt-get install -y mono-devel mono-basic-dbg && \
apt-get install -y curl unzip && \
curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
apt-get install -y nodejs && \
apt-get remove --auto-remove -y curl unzip && \
npm install -g typescript && \
npm install -g ts-node && \
rm -rf /var/lib/apt/lists/*"

cd /
tar -czvpf /chroot.tar.gz /chroot
tar -czvpf /judgehost.tar.gz /opt/domjudge/judgehost
