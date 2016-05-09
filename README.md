# AMP Dockerfile
Dockerfile for a container that installs and starts the Application Management Panel from CubeCoders.com

Installs the Application Management Panel from CubeCoders.

Also installs and starts the ADS module which allows configuring further modules via a web interface.

This container requires a valid AMP license to run

## Running minecraft (with an AMP licence)

`docker run -p 8080:8080 -p 25565:25565 othrayte/amp Minecraft --licence-key your-licence-key-xxxx +MinecraftModule.Minecraft.PortNumber 25565`

This creates a docker container with the Minecraft module for AMP. You can login to the administrative console at port 8080 with the username "admin" and password "password"; change the password when you first login. From here it is a standard AMP Minecraft module.

## Running inside unRAID (experimental)

As there seems to be no way to use the command and args parts of the docker run script from unRAID all options must be specified as enviroment variables.

## Options

| Argument | Env var | Default | Description |
| -------- | ------- | ------- | ----------- |
| 1st argument | | `MODULE` | No default | The AMP module to make an instance of |
| `-l`, `--licence-key` | `LICENCE` | No default | Your AMP licence key |
| `-n`, `--instance-name` | `INSTANCE_NAME` | "Instance" | The name to call the instance |
| `-p`, `--password` | `PASSWORD` | "password" | Initial password for the admin amp instance user |
| `-u`, `--username` | `USERNAME` | "admin" | Initial username for the admin amp instance user |
| `-h`, `--host` | `HOST` | "0.0.0.0" | The network interface to listen on, "0.0.0.0" is all interfaces |
| `--port` | `PORT` | "8080" | The network port to listen on |
| `+OOOOO` | `EXTRAS` | No default | Extra options that are passed to the AMP module |

Note: Extra options should each be in the format `+MyOption Value`, when specified in the enviroment variable multiple options can be added separated by spaces.
