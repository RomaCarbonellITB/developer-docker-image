### **README for the Developer Docker Image**

# Developer Docker Image

This repository contains a Dockerfile to build a Docker image for a development environment with VNC and Visual Studio Code.

## Steps to run the image:

1. Clone the repository:

   ```bash
   git clone https://github.com/your_user/developer-docker-image.git
   cd developer-docker-image
   ```
2. Build the Docker image:
   ```bash
   docker build -t developer-env .
   ```
3. Run the container:
   ```bash
   docker run -p 5900:5900 -p 2223:22 developer-env
   ```
4. Access VNC using the VNC viewer on port 5900.

## NOTES
- The VNC password is @ITB2025.
