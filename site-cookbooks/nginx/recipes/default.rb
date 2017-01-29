#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# # rpm install
# package "nginx" do
#   action :install
# end

# rpm install
# %w(vim java-1.8.0-openjdk-devel java-1.8.0-openjdk postgresql-server).each do |pkg|
#   package pkg do
#     action :install
#   end
# end

# rpm uninstall

# hoge = %w(java-1.8.0-openjdk-devel java-1.8.0-openjdk java-1.8.0-openjdk-headless)
# hoge.each do |pkg|
#   package pkg do
#     action :remove
#   end
# end

package "git" do
  action :install
end

# # service setting
# service "nginx" do
#   supports :status => true, :restart => true, :reload => true
#   action [ :disable ,:start ]
# end

#  Make group
group 'test' do
  group_name 'test'
  gid 777
  action [:create]
end

# Make groups
make_groups = %w(test1 test2 test3)
make_groups.each do |mg|
  group mg do
    group_name mg
    action [:create]
  end
end

# Make user
user 'nagakuray' do
  comment 'Create user nagakuray'
  uid 777
  group 'test'
  home '/home/nagakuray'
  shell '/bin/bash'
  password '$1$hKdhVM19$nKeLiC.7Jot3QJ0eq4Ta3/'
  action [:create, :manage]
end

# create system user
user 'vagrant2' do
  comment "Create system user vagrant2"
  home "/home/vagrant2"
  manage_home true
  shell "/bin/bash"
  system true
  password "$1$4vm27EE4$1gB406eCcUCucoD7cBJOt1"
  action [:create]
end


# Make users
create_users = %w(hoge fuga kurara)
create_users.each do |cu|
  user cu do
    comment 'Create user #{cu}'
    group 'test'
    home '/home/' + cu
    manage_home true
    shell '/bin/bash'
    password '$1$hKdhVM19$nKeLiC.7Jot3QJ0eq4Ta3/'
    action [:create,:manage]
  end
end

#  Modify group
group 'test1' do
  group_name 'test1'
  members create_users << "nagakuray"
  action [:modify]
end

# Make directory sample
dirs = {"nagakuray" => "/tmp/test"}
create_users.each do |cu|
  dirs[cu] = "/tmp/test/#{cu}"
end
dirs.each do |key,value|
  directory value do
    owner key
    group 'test'
    mode '0777'
    action :create
  end
end

# gem package install
# gem_package "rake" do
#   action :install
# end

template "/tmp/template_test.txt" do
  source "template_test.txt.erb"
  mode 0644
end


# cookbook_file and package

# rpmfile = "jdk-8u121-linux-x64.rpm"
# cookbook_file "/tmp/#{rpmfile}" do
#   source rpmfile
#   mode 0644
# end
# package "jdk-8" do
#   source "/tmp/#{rpmfile}"
#   action :install
# end

# git sample
git "/tmp/microposts" do
  # user node["user"]["name"]
  repository "https://github.com/nagakuray/microposts.git"
  revision "master"
  action :sync
end
