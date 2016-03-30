# AMP Dockerfile
Dockerfile for a container that installs and starts the Application Management Panel from CubeCoders.com

Installs the Application Management Panel from CubeCoders.

Also installs and starts the ADS module which allows configuring further modules via a web interface.

This container requires a valid AMP license to run

## Running minecraft (with an AMP licence)

`docker run -p 8080:8080 -p 25565:25565 othrayte/amp ./start.sh --module Minecraft --licence-key your-licence-key-xxxx +MinecraftModule.Minecraft.PortNumber 25565`

This creates a docker container with the Minecraft module for AMP. You can login to the administrative console at port 8080 with the username "admin" and password "password"; change the password when you first login. From here it is a standard AMP Minecraft module.
