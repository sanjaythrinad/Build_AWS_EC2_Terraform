# Build_AWS_EC2_Terraform

<h3>Introduction</h3>
This repository contains Terraform and Ansible scripts to automate the process of creating and configuring an AWS EC2 instance. Terraform is used for provisioning the infrastructure (EC2 Instance) in AWS, and Ansible is used for configuring the instance and perform installation of Python, Java and Jenkins.

<h3>Prerequisites</h3>
<b>Note:</b> Make sure your machine contains below prerequisites installed for executing these scripts.

1. [Terraform](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
2. [Ansible](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
4. [Git](https://git-scm.com/downloads)

<h3>Setup</h3>

1. Clone the repository  on to your local machine and start with below steps.

    ```
    git clone https://github.com/sanjaythrinad/Build_AWS_EC2_Terraform.git
    ```

2. Navigate to the Repository Directory

    ```
    cd Build_AWS_EC2_Terraform
    ```

<h3>Building and Configuring AWS EC2 Instance</h3>

1. Configure AWS credentials. Paste the required details when prompted for.

    ```
    aws configure
    ```

2. Update the credentials file with session token by editing the credentials file  " ~/.aws/credentials" for creating authentication with your AWS Account. 
    
    ```
    vi ~/.aws/credentials
    ```

    <img src="screenshots/aws_secret_keys.png" align="left"/><br>


3. Export public key in Terraform variables which is used for deploying and authenticating with your AWS EC2 Instance.  

    <img src="screenshots/export_pub_key.png" align="left"/><br>

    You can validate if key has been exported by running below command

    ```
    echo $TF_VAR_public_key
    ```

4. Switch into Terraform Directory present in the cloned repository.

    ```
    cd Terraform/
    ```


5. Run below commands to initialize the aws provider, plan and apply the plan.
    
    ```
    terraform init
    terraform plan -out=aws_ec2_deploy
    terraform apply aws_ec2_deploy
    ```

    <img src="screenshots/terraform_run_out.png" align="left"/><br>


6. Once the Terraform script execution completes, you will be able to see above outputs provided by output.tf file and you can validate the new instance details in AWS Portal. 

    <img src="screenshots/aws_ec2_console.png" align="left"/><br>


7. Copy the Public IP address of the AWS Instance and add it to Ansible Inventory File located under "Ansible" directory for executing the ansible playbook for Configuring the Instance.


8. Along with IP address, update ansible user and private key path used for connecting to the Instance in the inventory file as mentioned below.

    ```
    cd ../Ansible
    vi inventory
    ```

    ```
    [projectserver]
    <Server IP Address> ansible_user=<username> ansible_ssh_private_key_file=<File Path>
    ```
    Sample Screenshot:

    <img src="screenshots/ansible_inventory_sample.png" align="left"/><br>


9. Execute the Ansible playbook to Install Python, Java 21 and Jenkins on the EC2 Instance.

    ```
    ansible-playbook install_tools.yml -i inventory
    ```

    <img src="screenshots/ansible_run_out.png" align="left"/><br>


10. Once the playbook executes successfully, you will be able to see the status and initalAdminPassword required for configuring Jenkins.


11. You can access the URL by typing in http://<AWS_SERVER_PUBLIC_IP>:8080" in the web browser and paste in the initalAdminPassword for further configuration.
    
    Note: Replace <AWS_SERVER_PUBLIC_IP> with your public IP of EC2 Instance

    <img src="screenshots/jenkins_demo.png" align="left"/><br>


<h3>Rollback/Cleanup</h3>

1. Run terraform destroy to destroy the EC2 instance built.

    ```
    cd ../terraform
    terraform destroy
    ```


2. Type in yes when prompted for confirmation and you can see the status once execution completed.

    <img src="screenshots/destroy_instance.png" align="left"/><br>


3. Validate the status of the Instance in the AWS Console to confirm Instance is no longer running.


<h3>Conclusion</h3>

This repository provides a robust and automated way to provision and configure AWS EC2 instances using Terraform and Ansible. By following the steps outlined in this README, you can quickly set up and manage your infrastructure with minimal manual intervention. If you have any questions or run into issues, feel free to open an issue or contribute to the project. Thank you for using our automation scripts!