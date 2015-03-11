#
# Cookbook Name:: pxeserver
# Recipe:: httpd
#
# Copyright (C) 2015 Andreas Loibl
#

package 'mini-httpd' do 
    action :upgrade
end

service "mini-httpd" do
    supports :restart => true
end

remote_file "#{node['tftp']['directory']}/undionly.kpxe" do
    owner 'root'
    group 'root'
    source "file:///usr/lib/ipxe/undionly.kpxe"
    action :create
end

template "/etc/default/mini-httpd" do
    source "mini-httpd.erb"
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template "/etc/mini-httpd.conf" do
    source "mini-httpd.conf.erb"
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    notifies :restart, resources(:service => "mini-httpd")
end


