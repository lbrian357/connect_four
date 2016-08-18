#!/bin/bash

#creates GEMFILE
echo -e "source 'https://rubygems.org'\n
gem 'rspec'" > Gemfile

#executes GEMFILE
bundle install --path .bundle

#make filesystem
mkdir spec
mkdir lib

#message
printf "run 'bundle exec rspec' to test\n"
