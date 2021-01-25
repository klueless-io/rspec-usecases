#!/bin/bash

source 'common.sh'

kl_heading 'Give execute rights to files'

kl_subheading 'pwd'
pwd

kl_cmd 'chmod +x ../k'
chmod +x ../k
kl_cmd_end

kl_cmd 'chmod +x ../kgitsync'
chmod +x ../kgitsync
kl_cmd_end

kl_cmd 'chmod +x ../khotfix'
chmod +x ../khotfix
kl_cmd_end

kl_cmd 'chmod +x ../../hooks/pre-commit'
chmod +x ../../hooks/pre-commit
kl_cmd_end

kl_cmd 'chmod +x ../../hooks/update-version'
chmod +x ../../hooks/update-version
kl_cmd_end
