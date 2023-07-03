# will organize this in the future

# mounting of SSD
lsblk # to find location of SSD
sudo mkdir /ssd
sudo mount /dev/sda1 /ssd

# SSH
sudo apt install net-tools
ifconfig # to get IP address

sudo apt-get install openssh-server
sudo nano /etc/ssh/sshd_config 
# remove "#" from port 22 
sudo service ssh start
sudo systemctl enable ssh
# from another machine
ssh username@192.168.1.100

# setting up SSH key based authentication (no need to key in passevery every time
# on laptop
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub

# on ubuntu
mkdir ~/.ssh
nano ~/.ssh/authorized_keys
# paste content from id_rsa.pub into authorized_keys
chmod 600 ~/.ssh/authorized_keys
# update vscode config
Host mylee-workstation
    HostName 10.65.168.93
    IdentityFile C:\Users\melee\.ssh\id_rsa
    User mengyong

# docker
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
docker --version
# reboot
sudo reboot
docker run hello-world

# docker-compose
sudo apt update
sudo apt install -y curl
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

#install vscode extension
python
docker
github copilot
gitlens

# install ZSH
sudo apt-get install zsh
zsh --version
chsh -s $(which zsh) # set as default shell

# conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
conda --version
conda init zsh
conda activate base

# ZSH auto suggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
nano ~/.zshrc
# update plugin
plugins=(git zsh-autosuggestions)
source ~/.zshrc
# set vscode default shell to ZSH

# terraform https://developer.hashicorp.com/terraform/downloads
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# login to artifactory
sudo touch /etc/docker/daemon.json
sudo nano /etc/docker/daemon.json
# add to /etc/docker/daemon.json
sudo echo '{"insecure-registries" : ["artifactory.dyson.global.corp"]}' >> /etc/docker/daemon.json
docker login artifactory.dyson.global.corp -u melee

# generate credentials from artifactory > set me up > generic client > n682_dev > configure
touch $HOME/artifactory.cred
echo 'ARTIFACTORY_USERNAME="your_username"' >> $HOME/artifactory.cred
echo 'ARTIFACTORY_PASSWORD="generated_credentials"' >> $HOME/artifactory.cred
	
# git
sudo apt install git
ssh-keygen
cat ~/.ssh/id_rsa.pub
Go github/stash settings, settings, copy id_rsa.pub to SSH

ssh-keygen -t ed25519 -C "your.email@dyson.com"
chmod 400 ~/.ssh/id_ed25519
eval `ssh-agent -s`
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub 
git config --global user.name "Mengyong Lee"
git config --global user.email "mengyong.lee@dyson.com"
# paste into stash SSH

# optional, connecting docker back to SSH
sudo service docker stop
# add "data-root": "/ssd/docker" to /etc/docker/daemon.json
sudo service docker start
# using SSD for docker volumes: https://www.guguweb.com/2019/02/07/how-to-move-docker-data-directory-to-another-location-on-ubuntu/

#tmux
sudo apt install tmux

# setup sonarqube
curl --location https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip -o sonar-scanner-cli.zip 
curl --location https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.7.0.2747-linux.zip.asc -o sonar-scanner-cli.zip.asc 
curl --location https://binaries.sonarsource.com/sonarsource-public.key -o sonarsource-public.key 
gpg --import sonarsource-public.key 
gpg --verify sonar-scanner-cli.zip.asc sonar-scanner-cli.zip 
sudo unzip sonar-scanner-cli.zip -d /opt 
rm sonar-scanner-cli.zip sonar-scanner-cli.zip.asc sonarsource-public.key 
sudo apt-get install -y npm 
npm install -g typescript@3.7.5 

# login to AWS
aws configure
# add in access key / secret obtained from IAM

#jfrog
wget -qO - https://releases.jfrog.io/artifactory/jfrog-gpg-public/jfrog_public_gpg.key | sudo apt-key add -
echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee -a /etc/apt/sources.list &&    sudo apt update &&
sudo apt install -y jfrog-cli-v2-jf &&
jf intro
