#!/bin/bash
git pull wp master && ansible-playbook --syntax-check create_wp.yml
