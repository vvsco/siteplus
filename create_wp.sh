#!/bin/bash
git pull wp master && ansible-playbook --check create_wp.yml
