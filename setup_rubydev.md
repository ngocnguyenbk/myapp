# Setup My App on rubydev server

## Information Rubydev

```
Cloud Server: AWS
OS: Amazon Linux 2
```

## Prepare the system


1. Prepare the system

`sudo yum install -y curl gpg gcc gcc-c++ make cmake`

2. Install [RVM](https://rvm.io/rvm/install)

```
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /home/deploy/.rvm/scripts/rvm
```

3. Install Ruby 2.6.6, bundle, Node.js, Git

```
# Ruby 2.6.6
rvm install ruby-2.6.6
rvm --default use ruby-2.6.6

# Bundler
gem install bundler -v 2.1.4

# Node JS
sudo yum install -y epel-release
sudo yum install -y --enablerepo=epel nodejs npm

# Git
sudo yum install git
```

4. Install [MySQL 5.7](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-centos-7)

```
sudo yum install wget
wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
sudo yum install mysql-server
sudo yum install mysql-devel
sudo systemctl start mysqld # Start service
sudo systemctl status mysqld # Check status service
print "Password for account root:"
sudo grep 'temporary password' /var/log/mysqld.log
# Set password for account root
sudo mysql_secure_installation
mysql -u root -p Root@1234
```

5. Install Nginx

```
sudo amazon-linux-extras install epel
sudo yum install -y nginx
# Copy config on project and remove config default in /etc/nginx/nginx.conf
cp myapp/nginx/conf.d/myapp.conf /etc/nginx/conf.d/myapp.conf
sudo systemctl start nginx # Start service
sudo systemctl status nginx # Check status service
```

6. Config puma

```
sudo touch /etc/systemd/system/puma.service
sudo vi /etc/systemd/system/puma.service
sudo systemctl daemon-reload
sudo systemctl enable puma
sudo systemctl restart puma
```

## Deploy

1. Create user deploy

```
# On server
sudo adduser deploy
sudo passwd deploy
sudo usermod -aG wheel deploy
```

2. Add .ssh/authorized_keys

```
# On server
su - deploy
mkdir .ssh
sudo chmod 700 -R .ssh/
ssh-keygen -t rsa
mv id_rsa.pub authorized_keys
sudo chmod 600 .ssh/authorized_keys
```

```
# On local project
mkdir .ssh
vi .ssh/deploy_cloudwatch_details.pem # (add private key)
sudo chmod 400 .ssh/deploy_cloudwatch_details.pem
ssh -i .ssh/deploy_cloudwatch_details.pem deploy@54.237.68.111
```

3. Create folder `/var/wwww`

```
sudo mkdir /var/www
sudo chown -R deploy:deploy /var/www/
mkdir /var/www/myapp/shared/config/
vi /var/www/myapp/shared/config/secrets.yml # add secrets
vi /var/www/myapp/shared/config/database.yml # add config database
```

4. Deploy

```
# Ruby Dev server
bundle exec cap development deploy
```

5. Create admin

```
cp myapp/.env.sample myapp/.env
bundle exec rails db:seed_fu
```
