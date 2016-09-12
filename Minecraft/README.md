# AMP Dockerfile
Dockerfile for a container that installs and starts the Minecraft module for the Application Management Panel from CubeCoders.com

This container requires a valid AMP license to run

## Running minecraft (with an AMP licence)

### Using environment vars

Create an enviroment variable file (called something like "amp-env.list") with ther following contents

```
LICENCE=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

Running the container is then as simple as:

`docker run -p 8080:8080 -p 25565:25565 --env-file ./amp-env.list othrayte/amp-minecraft`

### Directly passing options

Another method is to pass the required options directly to the container.

`docker run -p 8080:8080 -p 25565:25565 othrayte/amp-minecraft --licence-key your-licence-key-xxxx`

Both of these methods create a docker container with the Minecraft module for AMP. You can login to the administrative console at port 8080 with the username "admin" and password "password"; change the password when you first login. From here it is a standard AMP Minecraft module.
