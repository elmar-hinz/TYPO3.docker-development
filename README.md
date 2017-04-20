TYPO3.docker-development
========================

A docker container designed to support the developement of the TYPO3 sources.

This is the Dockerfile of the container **elmarhinz/typo3.docker-development**.

You find the Container on [hub.docker.com](https://hub.docker.com/r/elmarhinz/typo3.docker-development/).
You find the Dockerfile on [github.com](https://github.com/elmar-hinz/TYPO3.docker-development).
There you will also find the latest version of this documentation.

Versioning
----------

Tags e.g. **v9.b**:

* v8, v9, v10: Siutable for TYPO3 versions 8, 9, 10.
* a, b, c, d, e, ... : Versions of the container.

Features
--------

* Sources are to be mounted from the local machine into the container.
* Directories *typo3conf*, *uploads*, *fileadmin* and *typo3temp* are to be mounted.
* Remote debugging with *Xdebug* is built in and tested to be run with *PHPStorm*.
* Can connect to any Database. No container linking required.
* Works within *Kitematic*.

![debugger](https://raw.githubusercontent.com/elmar-hinz/TYPO3.docker-development/master/img/debugger.png)

Motivation
----------

The target is to provide an easy start with core development by leveraging the
often tedious setup of **Xdebug** for *remote* debugging.

There are many containers available, that ship the TYPO3 sources of a dedicated
version. In contrast this container is designed to mount sources from the local
machine. By this it supports countinous editing and testing of the sources.

Requirements
------------

The container has been developed with the following setup:

* Mac OS X
* Native Mac Docker
* Kitematic
* An already prepared  Maria DB
* TYPO3 sources cloned from the master branch

It should be usable in other setups, as it is a single container and the
database connection is done the classical way by host and port.

The mounting of volumes by NFS hasn't been tested yet.

Preparations
------------

Have your docker environment running.

### Option1: Fresh installation

1. Install the TYPO3 sources into a directory on the local machine.
2. Create an empty local directory *typo3conf*.
3. Create an empty local directory *typo3temp*.
4. Create an empty local directory *uploads*.
5. Create an empty local directory *fileadmin*.
6. Prepare an empty database to install into.

### Option2: Existing installation

1. Install the TYPO3 sources into a directory on the local machine.
2. Use your existing directories typo3conf, typo3temp, uploads, fileadmin.
3. Use your existing DB to connect to.

Configuration
-------------

When you are using a GUI like Kitematic, you will configure the container
interactively. One the commandline you will configure the conatiner with the
startup call. Best put the call into a shell script, to be able to run
it repeatedly.

### Option1: Interactive configuration with GUI like Kitematic

#### Environment variables

Use the IP of your host and the session key of your IDE.

* XDEBUG_CONFIG: 'remote_host=192.168.56.1 remote_enable=1 idekey=PHPSTORM'
* TYPO3_CONTEXT: Development

![environment](https://raw.githubusercontent.com/elmar-hinz/TYPO3.docker-development/master/img/environment.png)

#### Ports

Map the port 80 of the container to a port on your local machine.

* 80 => 80

![ports](https://raw.githubusercontent.com/elmar-hinz/TYPO3.docker-development/master/img/ports.png)

#### Mounts

Map the directories of the container to the directories on your local
machine.

* /var/www/html/typo3_src => local/sources
* /var/www/html/fileadmin => local/fileadmin
* /var/www/html/uploads   => local/uploads
* /var/www/html/typo3conf => local/typo3conf
* /var/www/html/typo3temp => local/typo3temp

![mounts](https://raw.githubusercontent.com/elmar-hinz/TYPO3.docker-development/master/img/mounts.png)

### Option2: Startup script

See https://github.com/elmar-hinz/TYPO3.docker-development/blob/master/run.sh.

Adjust the script to your needs.

![script](https://raw.githubusercontent.com/elmar-hinz/TYPO3.docker-development/master/img/script.png)

Running
-------

### Option1: Fresh installation

Log into the container and create the file **FIRST_INSTALLATION**.

    touch /var/www/html/FIRST_INSTALLATION

Execute the usual TYPO3 setup in your web browser.

### Option2: Fresh installation

If the setup of the DB in *typo3conf/* was not changed, you should be done.

Xdebug with PHPStorm
--------------------

The setting of the environment variable is alpha and omega.

* XDEBUG_CONFIG: 'remote_host=192.168.56.1 remote_enable=1 idekey=PHPSTORM'

Call *ifconfig* to find out the IP of your machine.

In PHPStorm there is a button looking like an ancient Telephone
*"Start listening for PHP debug connections"*.

![connected](https://raw.githubusercontent.com/elmar-hinz/TYPO3.docker-development/master/img/connected.png)

Use it to turn debugging on and off. You don't need an extension in the browser
to turn debugging on and off. Debugging is triggered by the __idekey__ in the
environment varible.

![disconnected](https://raw.githubusercontent.com/elmar-hinz/TYPO3.docker-development/master/img/disconnected.png)

Upon the first connection PHPStorm will ask you to map

    /var/www/html/typo3_src/index.php

inside the container to the path of the script on your local machine.

![mapping](https://raw.githubusercontent.com/elmar-hinz/TYPO3.docker-development/master/img/mapping.png)

Happy debugging!

![debugger](https://raw.githubusercontent.com/elmar-hinz/TYPO3.docker-development/master/img/debugger.png)

