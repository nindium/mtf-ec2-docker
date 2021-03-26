Prerequisits:
    1. Create (or use existing) user with AWS IAM and grant necessary permissions
    2. Create AWS S3 bucket with name that correspondes bucket name in providers.tf "backend" section
       (for example "mtf-state-bucket") into region "us-east-1"
    3. Create AWS DynamoDB table "mtf-project"
    4. Install and configure awscli for credentials from p.1


