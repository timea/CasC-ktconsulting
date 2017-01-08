# Bootstrapping a node

    knife bootstrap 95.85.33.141 --ssh-user root --sudo --identity-file /Users/timea/Repos/ktconsulting-chef/chef-repo/.chef/timea.pem  --node-name jenkins-server --run-list 'recipe[olhus_db]'

# Upload cookbook
    knife cookbook upload olhus_db --force

# Run the run-list on a node

    knife ssh 'name:test-node' 'sudo chef-client' --ssh-user root --identity-file /Users/timea/Repos/ktconsulting-chef/chef-repo/.chef/timea.pem --attribute ipaddress

# Prepare uploading cookbooks with Berks

    berks install


# Uploading cookbooks with Berks

    berks upload

# Uploading cookbooks with Berks without freezing them

    berks upload --no-freeze
