# Yandex cloud | Flask app pipline
Easy Deployment Application. Contains the Flask-images library and its demo application on Flask.

Warning: Use this repository as an example. It may contain errors and silly solutions. 

Pipeline:
-Terraform | Cloud Configuration
--terraform/[main.tf, network.tf, output.tf, variables.tf]
-Cloud-init | VM tools
--terraform/init/metadata.yaml
-Docker | VM container
--app/Dockerfile
-Flask | Python library
--app/main.py
-Flask-images | Python library
--app/lib