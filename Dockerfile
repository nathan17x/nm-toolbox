FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y sudo zsh git curl wget python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages chromaterm

RUN useradd --create-home --shell /bin/zsh nm && \
    adduser nm sudo && \
    echo "nm ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER nm
WORKDIR /home/nm

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

CMD ["zsh"]
