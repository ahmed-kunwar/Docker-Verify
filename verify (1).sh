#! /bin/bash

echo "Enter User Name"
read userName

echo "Enter Repo Name"
read repoName

echo "Enter Container Tag"
read tag

imageName=$userName
imageName+="/"
imageName+=$repoName
imageName+=":"
imageName+=$tag

if ! sudo docker pull $imageName; then
	echo "$imageName does not exist"
fi

sudo docker run -d -p 80:80 --name pull-container $imageName

curl localhost

mkdir docker-share

cp pull-container:/usr/share/nginx/html/index.html docker-share

cmp --silent index.html docker-share/index.html || echo "Files are Different" 
