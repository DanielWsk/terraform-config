# terraform-config
Code Companion to medium article on how to abstract terraform for developer use: https://medium.com/@danielaaronw/how-to-abstract-away-terraform-fe85b694ea4d

The purpose of this repo is to demonstate how to use a config file written in YAML to provide variables for terraform modules. The intended purpose is to create an easy to read and maintain configuration file for terraform that developers who are not familiar with terraform can use to build and maintain their own cloud resources.

For more information, please reference the medium article. I explain how the config file works using terraform workspaces and give some examples how we can access the yaml values inside the terraform main.tf code.
