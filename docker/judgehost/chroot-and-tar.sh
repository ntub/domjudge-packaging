#!/bin/bash
/opt/domjudge/judgehost/bin/dj_make_chroot -i "nodejs,ruby"

/opt/domjudge/judgehost/bin/dj_run_chroot "apt-get update && \
apt-get install -y apt-transport-https dirmngr gnupg ca-certificates && \
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
echo 'deb https://download.mono-project.com/repo/debian stable-buster main' | tee /etc/apt/sources.list.d/mono-official-stable.list && \
apt-get update && \
apt-get install -y mono-devel mono-basic-dbg && \
rm -rf /var/lib/apt/lists/*"

cd /
tar -czvpf /chroot.tar.gz /chroot
tar -czvpf /judgehost.tar.gz /opt/domjudge/judgehost
