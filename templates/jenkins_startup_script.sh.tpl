#!/bin/bash
echo "Installing system dependencies"
  while fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
    echo "Waiting for apt to finish..."
    sleep 0.5
  done
  echo "Apt finished; continuing..."
  sleep 60
  sudo apt-get update
  echo "Installing python"
 # apt-get install -y -qq python-pip
  echo "Installing maven"
  apt-get install -y -qq maven 
  echo "Installing kubectl"
  apt-get install -y -qq kubectl
  sudo apt-get install -y -qq apt-transport-https ca-certificates curl gnupg2 software-properties-common
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get install -y -qq -f docker-ce 
  #docker-ce-cli containerd.io
  sudo apt-get install acl -y
  echo "setfacl"
  sudo setfacl -m user:tomcat:rw /var/run/docker.sock
  sudo docker run hello-world

  echo "Downloading jenkins cli"
  wget -O /tmp/jenkins-cli.jar http://localhost/jenkins/jnlpJars/jenkins-cli.jar
   echo "Installing plugins"

  /opt/bitnami/java/bin/java -jar /tmp/jenkins-cli.jar -ssh -i /root/.ssh/id_rsa -s http://127.0.0.1/jenkins/ -user user install-plugin swarm google-compute-engine google-storage-plugin google-oauth-plugin google-container-registry-auth-plugin

  restart_jenkins

  echo "Completed installing system dependencies"