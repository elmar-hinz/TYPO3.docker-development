========================
TYPO3.docker-development
========================

A docker container designed to support the developement of the TYPO3 sources.

This is the Dockerfile the container
https://hub.docker.com/r/elmarhinz/typo3-development/.

Features
========

* Sources are to be mounted from the local machine into the container.
* Directories typo3tconf, uploads, fileadmin and typo3temp are to be mounted.
* Xdebug is built in and tested to be run with PHPStorm.
* Can connect to any Database. No container linking required.
* Works within Kitematic.

Intro
=====

The target is to provide an easy startup with core development including the
difficult setup to connect the IDE into the server to use Xdebug.

There are many containers available that ship the TYPO3 sources of a dedicated
version. In contrast this container is designed to mount sources from the local
machine. It supports the countinous editing and testing of the sources.

Requirements
============

The container has been developed with the following setup:

* Mac OS X
* Native Mac Docker
* Kitematic
* An already prepared  Maria DB
* TYPO3 sources cloned from the master branch

It should be usable in other setups, as it is a single container and the
database connection is done the classical way by host and port.

The mounting of the volumes by NFS hasn't been tested yet.

Preparations
============

Have your docker environment running.

Option1: Fresh installation
---------------------------

1. Install the TYPO3 sources into a directory on the local machine.
2. Create an empty local directory *typo3conf*.
3. Create an empty local directory *typo3temp*.
4. Create an empty local directory *uploads*.
5. Create an empty local directory *fileadmin*.
6. Prepare an empty database to install into.

Option2: Existing installation
------------------------------

1. Install the TYPO3 sources into a directory on the local machine.
2. Use your existing directories typo3conf, typo3temp, uploads, fileadmin.
3. Use your existing DB to connect to.

Configuration
=============

When you are using a GUI like Kitematic, you will configure the container
interactively. One the commandline you will configer the conatiner with the
startup call. Best put the call into a shell script, to be able to run
it repeatedly.

Option1: Interactive configuration with GUI like Kitematic
----------------------------------------------------------

Environment variables
.....................

Use the IP of your host and the session key of your IDE.

* XDEBUG_CONFIG: 'remote_host=192.168.56.1 remote_enable=1 idekey=PHPSTORM'
* TYPO3_CONTEXT: Development

Ports
.....

Map the port 80 of the container to a port on your local machine.

* 80 => 80

Mounts
......

Mount the directories of the container to the directories on your local
machine.

* /var/www/html/typo3_src => local/sources
* /var/www/html/fileadmin => local/fileadmin
* /var/www/html/uploads   => local/uploads
* /var/www/html/typo3conf => local/typo3conf
* /var/www/html/typo3temp => local/typo3temp

Option2: Startup skript
-----------------------

See https://github.com/elmar-hinz/TYPO3.docker-development/blob/master/run.

Adjust the script to your needs.

Running
=======

Option1: Fresh installation
---------------------------

Log into the container and create the file::

    touch /var/www/html/FIRST_INSTALLATION

Execute the usual TYPO3 setup in your web browser.

Option2: Fresh installation
---------------------------

If the setup of the DB in `typo3conf/` was not changed, you should ready.

Xdebug with PHPStorm
====================

The setting of the environment variable is alpha and omega.

* XDEBUG_CONFIG: 'remote_host=192.168.56.1 remote_enable=1 idekey=PHPSTORM'

Call `ifconfig` to find out the IP of you machine.

In PHPStorm there is a button looking like an ancient Telephone::

    `Start listening for PHP debug connections`

Use it to turn debugging on and off. You don't need an extension in the browser
to turn debugging on and off. Debuggin is triggered by the `idekey` in the
environment varible.

Upon the first connection PHPStorm will ask you to map::

    /var/www/html/typo3_src/index.php

in the container to the path of the script on your local machine.



Happy debugging!



