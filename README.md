# docker-restbed

This is a simple ubuntu docker image with restbed dev libraries and headers built from the latest git repo and installed.
The src is then removed to reduce the size of the docker image.

libraries are installed in /usr/lib
headers installed in /usr/include

All required shared libs are also included so you should be able to compile and link any restbed application by adding your chosen compiler and other dependencies.

