#! /bin/bash
echo "Builds Docker image from Git repository and pushes it to Docker Hub"
read -p "Input Git repository URL: " gitrepo
read -p "Input Docker image tag: " dockertag
read -p "Input Docker Hub user email: " dhemail
read -p "Input Docker Hub username: " dhuser
read -s -p "Input Docker Hub password: " dhpass
token=$(echo "{\"username\": \"${dhuser}\", \"password\": \"${dhpass}\", \"email\": \"${dhemail}\"}" | base64 -w0)
echo "Creating image ${dockertag} from ${gitrepo} as ${dhuser}"
curl --unix-socket /var/run/docker.sock -X POST "http:/v1.24/build?remote=${gitrepo}&t=${dockertag}"
curl --unix-socket /var/run/docker.sock -H "X-Registry-Auth: ${token}" -X POST "http:/v1.24/images/${dockertag}/push"

# Git repositories and Docker tags used for testing:
# https://github.com/mlampola/applyjob.git lampola/applyjob
# https://github.com/mlampola/docker-hy.github.io.git lampola/docker-hy.github.io
# https://github.com/datawire/hello-world.git lampola/hello-world
