#
# Cookbook Name:: pxeserver
# Recipe:: default
#
# Copyright (C) 2015 Andreas Loibl
#

include_recipe 'tftp'
include_recipe 'nfs::server'

package 'ipxe' do 
    action :upgrade
end

directory "#{node['tftp']['directory']}" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

nfs_export "#{node['tftp']['directory']}" do
    network '*'
    options ['no_root_squash','no_subtree_check']
    writeable false
end

remote_file "#{node['tftp']['directory']}/undionly.kpxe" do
    owner 'root'
    group 'root'
    source "file:///usr/lib/ipxe/undionly.kpxe"
    action :create
end

template "#{node['tftp']['directory']}/boot.ipxe" do
    source "boot.ipxe.erb"
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template "#{node['tftp']['directory']}/boot.ipxe.cfg" do
    source "boot.ipxe.cfg.erb"
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template "#{node['tftp']['directory']}/menu.ipxe" do
    source "menu.ipxe.erb"
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

include_recipe 'pxeserver::httpd'

