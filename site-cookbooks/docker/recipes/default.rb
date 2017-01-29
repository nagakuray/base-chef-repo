#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# なぜかIPアドレスで入れないのでやむなしの設定
service "network" do
  supports :status => true
  action [:restart]
end

# docker入れておく設定
package "docker" do
  action :install
end

# 別になくても大丈夫
package "vim" do
  action :install
end

# dockerを起動しておく設定
service "docker" do
  supports :status => true, :reload => true
  action [:enable, :start]
end

# vagrantユーザをdockerグループに所属させておく
group "docker" do
  group_name "docker"
  members "vagrant"
  action [:create]
end
