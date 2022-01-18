#!/bin/sh
{
    pacman -S -q --noconfirm \
        docker \
        docker-compose 
    usermod -aG docker eseoquali

} || {
    echo "[!!!] - An error occurred while installing tools"
}