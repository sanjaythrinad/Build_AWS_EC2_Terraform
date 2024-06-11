# Build_AWS_EC2_Terraform

<h3>Introduction</h3>
This repository contains Terraform and Ansible scripts to automate the process of creating and configuring an AWS EC2 instance. Terraform is used for provisioning the infrastructure (EC2 Instance) in AWS, and Ansible is used for configuring the instance and perform installation of Python, Java and Jenkins.

<h3>Prerequisites</h3>
<b>Note:</b> Make sure your machine meet below prerequisites for executing these scripts.

    1. [Terraform](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
    2. [Ansible](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
    3. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
    4. [Git](https://git-scm.com/downloads)

<h3>Setup</h3>

1. Clone the respository on to your local machine and start with below steps.
    ```
    git clone https://github.com/sanjaythrinad/Build_AWS_EC2_Terraform.git
    ```

2. Navigate to the Repository Directory
    ```
    cd Build_AWS_EC2_Terraform
    ```

<h3>Building and Configuring AWS EC2 Instance</h3>

1. Update the AWS credentials in aws credentials file located under user home directory " ~/.aws/credentials" for creating authentication with your AWS Account. 
    
    ```
    vi ~/.aws/credentials
    ```
    [Edit AWS Credentials file](screenshots/edit_aws_creds.png)
    [Update AWS Credentials](screenshots/aws_secret_keys.png)

2. Export public key in Terraform variables which is used for deploying and authenticating with your AWS EC2 Instance.  
    You can validate if key has been exported by running below command
    ```
    echo $TF_VAR_public_key
    ```
    [AWS Public Key](screenshots/export_pub_key.png)

3. Switch into Terraform Directory present in the cloned repository

    ```
    cd Terraform/
    ```
    
4. Run below commands to initialize the aws provider, plan and apply the plan
    
    ```
    terraform init
    terraform plan -out=aws_ec2_deploy
    terraform apply aws_ec2_deploy
    ```
    [Terraform Output](screenshots/terraform_run_out.png)

5. Once the Terraform script execution completes, you will be able to see below outputs provided by output.tf file and you can validate the new instance details in AWS Portal. 
    [AWS EC2 Instance](screenshots/aws_ec2_console.png)

6. Copy the Public IP address of the AWS Instance and add it to Ansible Inventory File located under "Build_AWS_EC2_Terraform/Ansible" for execting the ansible playbook for Configuring the Instance.

7. Along with IP address, update ansible user private key path used for connecting to the Instance in the inventory file as mentioned below.

    ```
    cd ../Ansible
    vi inventory
    ```
    ```
    [projectserver]
    <Server IP Address> ansible_user=ubuntu ansible_ssh_private_key_file=<File Path>
    ```
    [Inventory](screenshots/ansible_inventory_sample.png)

8. Execute the Ansible playbook to Install Python, Java 21 and Jenkins this EC2 Instance.

    ```
    ansible-playbook install_tools.yml -i inventory
    ```
    [Ansible Play Output](screenshots/ansible_run_out.png)

9. Once the playbook executes successfully, you will be to see the status and initalAdminPassword required for configuring Jenkins.

10. You can access the URL by typing in http://<AWS_SERVER_PUBLIC_IP>:8080" in the web browser and paste in the initalAdminPassword for further configuration
    Note: Replace <AWS_SERVER_PUBLIC_IP> with your public IP of EC2 Instance
    [Jenkins](screenshots/jenkins_demo.png)

<h3>Destroy the instance</h3>

1. Run terraform destroy to destroy the EC2 instance built.
    ```
    cd ../terraform
    terraform destroy
    ```

2. Type in yes when prompted for confirmation. You can see the status once execution completed.
    [Destroy](screenshots/destroy_instance.png)

3. Validate the status of the Instance in the AWS Console to confirm Instance is no longer running.