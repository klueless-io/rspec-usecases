#!/bin/bash

source 'common.sh'

kl_heading 'Setup git repository'

# kl_subheading 'pwd'
# pwd

kl_subheading "initializing git repository"

cd ../..

# git init
git add .
git commit -am 'first commit'

kl_subheading  'setup git flow'

git flow init -d
git checkout master

kl_subheading  'setup first hotfix version';

# Turn off message dialog
export GIT_MERGE_AUTOEDIT=no

git flow hotfix start v0.0.1
# echo '0.00.001' > kversion
git flow hotfix finish v0.0.1 -m 'version 0.0.1'

unset GIT_MERGE_AUTOEDIT

git checkout master

git remote add origin git@github.com:klueless-io/rspec-usecases.git
git remote -v
git push -u origin master

git checkout develop
git push --set-upstream origin develop

git checkout master

cd bin/runonce
