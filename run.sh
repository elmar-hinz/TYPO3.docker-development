#!/usr/bin/env sh

docker run \
    --name typo3-development \
    --volume /Volumes/Work/OpenSource/TYPO3.CMS.sources/:/var/www/html/typo3_src \
    --volume /Volumes/Work/OpenSource/TYPO3.CMS.installation/fileadmin:/var/www/html/fileadmin \
    --volume /Volumes/Work/OpenSource/TYPO3.CMS.installation/uploads:/var/www/html/uploads \
    --volume /Volumes/Work/OpenSource/TYPO3.CMS.installation/typo3conf:/var/www/html/typo3conf \
    --volume /Volumes/Work/OpenSource/TYPO3.CMS.installation/typo3temp:/var/www/html/typo3temp \
    --publish 80:80 \
    --env XDEBUG_CONFIG='remote_host=192.168.56.1 remote_enable=1 idekey=PHPSTORM' \
    --env TYPO3_CONTEXT=Development \
    --detach \
    elmarhinz/typo3-development:latest

