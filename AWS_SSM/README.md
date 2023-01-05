To upload the AWS SSM (Systems Manager) Automation Document via command line:
```
aws ssm create-document --name ChaosNACL --document-format YAML --document-type Automation --content file://ssma-nacl-faults-with-tga.yml
```
