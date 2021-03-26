Task:
    1. Create container with Dockerfile.
    2. Create infrastructure in AWS (VPC, ASG, EC2) with Terraform and deploy docker container on EC2 .


Prerequisits:
    1. Create (or use existing) user with AWS IAM and grant necessary permissions (on VPC, EC2, S3)
    2. Create AWS S3 bucket with name that correspondes bucket name in providers.tf "backend" section
       (in this example "mtf-state-bucket") into region "us-east-1"
    3. Create AWS DynamoDB table "mtf-project"
    4. Install and configure awscli for credentials from p.1
    5. Account at hub.docker.com

Solution:
    1.  To create container with service I used httpd docker image.
        I created Docerfile file where described how to create new image and copy simple html file 
        inside new image.
        To create new image type command:
            docker build -t nindium/myapp:latest service/

        Then we need to be authorized into hub.docker.com.
        To push our new image to the dockerhub registry:
        docker push nindium/myapp:latest
    2. Make sure that we used correct profile to deploy our project into AWS
        (for example use export AWS_PROFILE=<our_user>)
        Then run:
        terraform apply --auto-approve
        It will create VPC, 2 Public subnets, Public Routing Table, 2 Security groups, Internet GW,
        Autoscaling group, Application Load Balancer.

    3. To check result get load balancer dns name from 'web_url' terraform output and put it in a browser.


