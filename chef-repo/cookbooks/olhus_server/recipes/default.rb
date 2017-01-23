#
# Cookbook:: olhus_server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

file '/root/.profile' do
  content 'export PATH=$PATH:/usr/local/go/bin:/opt/go/bin
  export GOPATH=/home/timea/go
  export GOBIN=/opt/go/bin'
end

user 'timea' do
  manage_home true
  home '/home/timea'
  shell '/bin/bash'
  password 'ubuntu88'
end

file '/home/timea/.profile' do
  content 'export PATH=$PATH:/usr/local/go/bin:/opt/go/bin
  export GOPATH=/home/timea/go
  export GOBIN=/home/timea/go/bin'
end

bash 'clone' do
  code <<-EOH
    rm -rf /home/timea/go/src/github.com/timea
    mkdir -p /home/timea/go/src/github.com/timea
    cd /home/timea/go/src/github.com/timea
    git clone https://github.com/timea/amager-olhus.git
    chown -R timea:timea /home/timea/
    mkdir -p /home/timea/.ssh
    EOH
end

bash 'install code' do
  code <<-EOH
    source ~/.profile
    go get github.com/go-sql-driver/mysql
    go get github.com/gorilla/mux
    go get github.com/huandu/facebook
    cd /home/timea/go/src/github.com/timea/amager-olhus/src/server
    go install
    EOH
end

file '/home/timea/.ssh/authorized_keys' do
  content 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBAT86UgujTWMpNx3xfOf5yTPrlCCjhUvfkvFzDqnY2gWlr4lkUQIo9BP4x9jN0XOgC2elL41OpjTp6aycIJvpqpUZR87YqXkbIlvvBZ4ix2VQ+8rLy/CTq+wvq4UIbvyVnRlvMCaXpa1iGL2VRkXOLthHdrjPpVZ5RzjnVbT4UrTosti6k8wsyJdHMu9I8bu79uUPK5PIHgwn6aN6CSP/5w9ISf2dZIbK+rbLaX0RzAarC/IcT9fsuuqVy/oy/Cm2d57TRlRdNwiIQAohOrsbFgSsYEh4uNEEKiU0LVVcSmJHtNcL1ZNMqZKertWd8uNLjKLQTZSrR9eY3DhYIEgh jenkins@JENKINS-ubuntu-512mb-ams2-01'
end
