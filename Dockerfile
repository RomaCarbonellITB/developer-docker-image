# Developer Dockerfile
FROM ubuntu:24.04

# Instal·lar paquets necessaris
RUN apt-get update && \
    apt-get install -y \
    gnome-terminal \
    xvfb \
    dbus-x11 \
    xorg \
    x11-utils \
    xauth \
    tightvncserver \
    xfce4 \
    x11vnc \
    novnc \
    openssh-server \
    sudo \
    python3 \
    python3-pip \
    postgresql-client \
    curl && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscode.list && \
    apt-get update && \
    apt-get install -y code && \
    rm -rf /var/lib/apt/lists/*

# Crear usuari non-root
RUN useradd -m -s /bin/bash developer && echo "developer:@ITB2025" | chpasswd && adduser developer sudo

# Configurar SSH
RUN mkdir /var/run/sshd

# Configurar VNC
RUN mkdir /home/developer/.vnc && echo "@ITB2025" | vncpasswd -f > /home/developer/.vnc/passwd && chmod 600 /home/developer/.vnc/passwd

# Copiar scripts de configuració
COPY start_vnc.sh /usr/local/bin/start_vnc.sh
RUN chmod +x /usr/local/bin/start_vnc.sh

# Exposar ports
EXPOSE 5900 22

CMD ["/usr/local/bin/start_vnc.sh"]
