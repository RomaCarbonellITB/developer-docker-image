#!/bin/bash

# Cambiar al usuario developer
if [ "$(whoami)" != "developer" ]; then
    echo "Este script debe ejecutarse como el usuario 'developer'"
    exec sudo -u developer "$0" "$@"
    exit 1
fi

# Crear el directorio y establecer la contraseña de VNC
mkdir -p /home/developer/.vnc
echo "@ITB2025" | vncpasswd -f > /home/developer/.vnc/passwd
chmod 600 /home/developer/.vnc/passwd
chown -R developer:developer /home/developer/.vnc

# Crear archivo .Xauthority
touch /home/developer/.Xauthority
chown developer:developer /home/developer/.Xauthority

# Iniciar Xvfb para emular un servidor X
Xvfb :0 -screen 0 1024x768x24 &

# Establecer la variable DISPLAY
export DISPLAY=:0

# Iniciar VNC
x11vnc -forever -display :0 -passwd @ITB2025 &

# Iniciar servicio SSH
sudo service ssh start

# Inicia GNOME Terminal
gnome-terminal --display=:0 &

# Iniciar el entorno XFCE
exec xfce4-session

