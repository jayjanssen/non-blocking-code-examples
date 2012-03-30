These sample scripts work on a Vagrant setup using Virtualbox.  You should be able to simply check out this repository and type:

    vagrant up



Software Used:

*   Vagrant 1.0.2
*   VirtualBox 4.1.10
*   Host Machine: OSX Lion 10.7.3
  
  
Then connect to the box using:

    vagrant ssh
    cd /vagrant/code
    # run the scripts of your choice
    
    
    
Note that JS scripts need to be run with the 'node' command, example:

    node node_httpd.js

