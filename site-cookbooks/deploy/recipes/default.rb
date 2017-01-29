#
# Cookbook Name:: deploy
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Git cloneサンプル
git "/tmp/microposts" do
  repository "https://github.com/nagakuray/microposts.git"
  revision "master"
  action :sync
end
