#!/bin/bash
git add .
HOSTNAME=$(hostname)
sudo nixos-rebuild switch --flake .#$HOSTNAME
