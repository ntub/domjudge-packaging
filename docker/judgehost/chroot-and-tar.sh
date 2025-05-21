#!/bin/bash

set -euo pipefail

# NOTE:
#   在 7.3.4 版本中 dj_make_chroot 會試圖安裝 pypy 這個套件，但是在新版的 Debian 中已經沒有這個套件了
#   所以先備份舊版程式後，再把 dj_make_chroot 中的 pypy 取代成 pypy3
#   DOMjudge 在新版本中已經修改了這個錯誤，但是 7.3.4 版本中還沒有修改才需要此 workaround
cp /opt/domjudge/judgehost/bin/dj_make_chroot /opt/domjudge/judgehost/bin/dj_make_chroot.bak
sed -i 's/pypy/pypy3/g' /opt/domjudge/judgehost/bin/dj_make_chroot

# Usage: https://github.com/DOMjudge/domjudge/blob/main/misc-tools/dj_make_chroot.in#L58-L87
/opt/domjudge/judgehost/bin/dj_make_chroot

/opt/domjudge/judgehost/bin/dj_run_chroot "apt-get update && \
\
apt-get install -y php-cli && \
\
apt-get install -y curl unzip && \
curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
apt-get install -y nodejs && \
apt-get remove --auto-remove -y curl unzip && \
\
rm -rf /var/lib/apt/lists/*"

cd /
echo "[..] Compressing chroot"
tar -czpf /chroot.tar.gz --exclude=/chroot/tmp --exclude=/chroot/proc --exclude=/chroot/sys --exclude=/chroot/mnt --exclude=/chroot/media --exclude=/chroot/dev --one-file-system /chroot
echo "[..] Compressing judge"
tar -czpf /judgehost.tar.gz /opt/domjudge/judgehost
