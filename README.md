![](https://www.docker.com/sites/all/themes/docker/assets/images/logo.png)
# Overview

This Docker container makes easier to get an instance of Pyload up and running in ARMv7 (armhf) platform such as Raspberry 2, Utilite, Cubox-i, Odroid...

Base Image used [armv7/armhf-archlinux](https://registry.hub.docker.com/u/armv7/armhf-archlinux/), thanks to[@umiddelb](https://github.com/umiddelb)

# Quick Start

The Pyload config directory is used to store all the configuration, I recommend mounting it as a host directory using the [data volume](https://docs.docker.com/userguide/dockervolumes/#mount-a-host-directory-as-a-data-volume)

Please first copy the config folder on your desired path. This will setup the Web Interface users. (the first user is admin/admin). You can change the password later on using shh into the docker container with command ```python2 pyLoadCore.py -u```

Pyload will be run by daemon user. The first step is to make sure that daemon user is the owner of the ```config``` folder:
	
	docker run -u root -v /host/data/pyload:/config gerardribas/armhf-pyload chown -R daemon /config

The container accepts another volume to be passed on ```/downloads``` which is the folder to place the downloads.

The container exposes the Web Interface Port on 8001 and the Remote Interface 7227.

### Start Pyload Container:

	docker run -v /host/data/pyload:/config -v /host/downloads:/downloads --name="pyload" -d -p 7227:7227 -p 8001:8001 gerardribas/armhf-pyload

**Success**. Your Pyload Server is now ready to be used! Well done! 

Should be available on http://<your_domain>:8001

# Issue tracker

Please raise an [issue](https://github.com/GerardRibas/armhf-pyload/issues/new) if you encounter any problems with this Dockerfile.