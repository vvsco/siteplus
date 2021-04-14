#!/bin/bash
git pull wp master && ansible-galaxy install -r requirements.yml && ansible-playbook --check create_wp.yml
