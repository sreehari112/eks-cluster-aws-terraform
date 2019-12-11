#!/bin/bash
yum update -y


#AWS CLi Installation:
sudo yum install python3 -y
sudo yum install unzip -y
sudo pip3 install awscli
aws --version


cp /root/eks-getting-started/ekscluster-aws/deployment.yml /root/deployment.yml

mkdir ~/.aws/

echo '[sriahri]
region = us-east-1
output = json' >> ~/.aws/config

echo '[sriahri]
aws_access_key_id = *********
aws_secret_access_key = *******' >> ~/.aws/credentials

aws configure set aws_access_key_id ************
aws configure set aws_secret_access_key **********
aws configure set default.region us-east-1


#echo '[default]
#region = us-east-1
#output = json
#[profile dev-role]
#role_arn = arn:aws:iam::12***815146:role/backing_services_upscale
#source_profile = default
#region = us-east-1' >> ~/.aws/config

#echo '[default]
#aws_access_key_id = ************
#aws_secret_access_key = ***********************************' >> ~/.aws/credentials


#kubectl installation
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version --short --client


#IAM Authenticator installation
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

sleep 100

#Create kubeconfig
aws eks --region us-east-1 update-kubeconfig --name "terraform-eks-automation-cluster"
#aws eks --region us-east-1 update-kubeconfig --name "eks-automation-test" --profile dev-role

cd /root
kubectl apply -f deployment.yml
