FROM linuxserver/webtop:ubuntu-mate

COPY ./scripts/00-install-pkgs.sh /tmp/00-install-pkgs.sh

RUN bash /tmp/00-install-pkgs.sh

VOLUME /workspace
