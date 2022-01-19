#!/bin/bash

{
    # Remove old box
    rm output/archlinux.box
    #Stops any vm running
    vagrant destroy -f
    # Update configuration file
    packer hcl2_upgrade -with-annotations archlinux.json
    #Remove old install for vagrant
    vagrant box remove eseo/arch
    #Build
    packer build archlinux.json.pkr.hcl
    #Add box to vagrant local boxes
    vagrant box add output/archlinux.box --name eseo/arch
    #Start box for testing
    vagrant up

} || {
    echo "[!!!] - An error occurred during the build"
}