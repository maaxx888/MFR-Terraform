Created VPC with 2 public and 2 private subnets, Internet Gateways, Routing Tbale and 2 nats if 1 goes down we still have a second one to work with.
There are routing tables created to for the communication between everything.
There is a security group created that allows port 443, 80, 22.
created a network interface that has an ip that is in the subnet. Also there is an elastic ip assigned to the network interface.
There are 3 ec2 instances that have apache webserver on it and also php. There is also an extre encrypted volume attached to 1 instance
an S3 bucket with versioning enables is also created. Multiple files are uploaded to the bucket aswell.
There is also an EFS mounted to the subnet of an ec2 instance
A database is also created 
I also created a lambda function that contains python code.
There is also autoscaling created for ec2 instances. So if the cpu usage is to high there will be created a new ec2 insatnce.max 3 ec2 instances min 1
The last thing that I created was an application loadbalanbcer

