# voltaQTdocker
Docker QT for Volta | https://volta.im  

create a file like voltaqt.sh  
```
!/bin/bash
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker-xauth
mkdir -p ${HOME}/.volta
xauth nlist ${DISPLAY} | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -
docker run -ti --rm -e "XAUTHORITY=${XAUTH}" -e "DISPLAY=${DISPLAY}" -v ${HOME}/.volta:/volta -v ${XAUTH}:${XAUTH} -v ${XSOCK}:${XSOCK} --name="volta-qt-xvt" --user="${UID}:${GID}" buzzkillb/voltaqt:latest
```
then make it run  
```
chmod +x voltaqt.sh
```
then run the script 
```
./voltaqt.sh
```
