# Guide to Amazon Web Services
### Contents
1. Configuration
 * [Launch Server](#launch-server)
 * [Configure Ports](#configure-ports)
 * [Connect to Server](#connect-to-server)
 * [Assign IP Address](#elasticdynamic-ip)
 * [Creating DNS Records](#creating-dns-records)
2. Storage/Backup
 * [EBS Volumes](#ebs)
 * [Simple Storage Service(S3)](#s3)
 * [Glacier](#glacier)
3. Scaling
 * Load Balancer
 * Content Delivery Network - CloudFront
 * Elastic Beanstalk
 * Google Compute Engine
4. Monitoring/Analytics
 *  Cloud Watch
 *  Google Analytics
 
# Before you get Started
There are a few steps that obviously need to be done that I'm not going to get into for brevity's sake but should be very simple to figure out:

* Purchase a domain. Where you decide to purchase it from is purely up to you and honestly doesn't matter since you will be using Amazons Route 53 for DNS management.
* Sign up for Amazon Web Services. You can use an existing amazon account if you like

### Launch Server
First, let's fire up an EC2 instance. Amazon makes this very simple to do and while very serious projects will require some advanced configuration, a simple set up is all we need for our purposes.

* From the AWS Console select EC2
* Select "Launch Instance"
* Select "Quick Launch Wizard"


The quick launch screen is fairly simple and asks you to name your instance and create a key pair. You will use this key to SSH to your server securely with root access without the use of a password (you don't want to use a password for many reasons that I won't get into). Give this new key pair a name and and select download. this will save your key (key_pair.pem) wherever you choose on your machine, but I recommend you move this key pair to a safe place on your machine like ~/.ssh. 

### Configure Ports
Great, now you have an instance up and running but that alone isn't really good for anything. In order for it to actually serve HTTP you need to open up the appropriate ports. The first step is to set up a security group. A security group acts like a configuration file for a firewall. It lets you set which ports are open to the world and which are closed.Click on the Security Groups tab. If you used the quick launch wizard AWS should have created a group for you titled something like "quicklaunch-1". You can use this or create your own security group. 

* Select the desired security group
* At the bottom of the screen, select the "Inbound" tab.
* Select SSH from the "create new rule" drop down and click "Add Rule". This will open up port 22, necessary if you want to have SSH access to your instances.
*  Repeat the process for port 80 (HTTP) and, if desired, port 443 (HTTPS).

### Connect to Server
Now, if you want to SSH to your instance all you have to type is:

```sh
$ ssh -i ~/.ssh/your_key_pair.pem ec2-user@ec2-00-000-000-00.compute-1.amazonaws.com
```
##### Warning, if using Ubuntu or another image the user could be root or ubuntu instead of ec2-user 

Using the Public DNS that you find in your EC2 properties panel for that last part.  If you are unfamiliar with ssh  please jump to [SSH](ssh.md). 

### Elastic/Dynamic IP
Now you have successfully configured your instance you need to be able to point your domain towards the server that you created. For convenience sake you will want to use what Amazon calls Elastic IP. This allows you to assign a unique IP address to your instance which makes managing DNS records easier. You can also easily switch which instance your Elastic IP is associated with, which can be helpful if you have several servers for development and may need to switch which server your domain points to. Adding an Elastic IP is simple:

* From the EC2 console select Elastic IPs
* Select Allocate New Address
* Choose Associate Address and then choose the instance you just created.

### Creating DNS Records
Finally in order for your www.domain.com to point to the server that you just started you need to update the DNS records for the domain. I would recommend using Amazon's Route 53 simply because it consolidates the services that you have to use to make changes. You'll first want to go to the Route 53 page and create a new Hosted Zone. Next, add all of the record sets that you may need (MX, CNAME, A, www, etc.). Finally return to your domain provider and change the name servers to those listed on your zone file at AWS.

# Storage & Backup
One of the best features of Amazon AWS is that it has several storage solutions of varying levels of price, avaialability and durability. The correct usage of Amazon Web Services will probably use all three of the major storage solutions:
* Elastic Block Storage: A large-capacity persistent disk to attach to your server
* Simple Storage Service: For storing large quantities of file with very high availability and durability.
* Glacier: Very low cost, low availability storage for archives

### EBS
Attaching EBS to a server is very simple and is done in the AWS EC2 console. Once you select a disk of an appropriate size and attach it, you will still have to mount this disk on the server:
TODO: ATTACH INSTRUCTIONS

### S3
A great primary solution for cloud storage and backup is Amazon s3. It is very affordably priced for most user's needs and can give you maximum durability and availability. I have found that s3fs, an s3 FUSE based file system is a great way to 
mount a bucket on my server and even local machine for transferring large amounts of files to s3.

```sh
brew install s3fs

# or for linux 
wget http://s3fs.googlecode.com/files/s3fs-1.74.tar.gz
tar xvzf s3fs-1.74.tar.gz
cd s3fs-1.74/
./configure --prefix=/usr
make
sudo make install

# now you need to add your AWS security keys to the server's home dir
emacs .passwd-s3fs
# paste in AWSSECRET:AWSSECRETKEY

chmod 600 ~/.passwd-s3fs

# finally mount an s3 bucket on the server
/usr/local/bin/s3fs mybucket /mnt
```

### Glacier
TODO: write description
