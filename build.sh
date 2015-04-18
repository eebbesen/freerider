#!/bin/bash

gem build freerider.gemspec
echo 'built'
gem install freerider
echo 'installed'
