#!/bin/bash
docker push cc17bul/ci-image

ssh deploy@35.195.131.45 << EOF
docker pull cc17bul/ci-image:latest
docker stop web || true
docker rm web || true
docker rmi cc17bul/ci-image:current || true
docker tag cc17bul/ci-image:latest cc17bul/ci-image:current
docker run -d --restart always --name web -p 80:80 cc17bul/ci-image:current
EOF
