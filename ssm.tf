# data "aws_ssm_document" "ansible_ssm" {
#   name            = "AWS-ApplyAnsiblePlaybooks"
# }
 
# output "content" {
#   value = data.aws_ssm_document.foo.content
# }

# resource "aws_ssm_document" "ansible_ssm" {
#   name            = "test_document"
#   document_format = "YAML"
#   document_type   = "Command"
#   content = output.content

# resource "aws_ssm_association" "kibana_ansible_ssm_association" {
#   name             = aws_ssm_document.ansible_ssm.name

#   targets {
#     key = "InstanceIds"
#     values = [
#       aws_instance.kibana_server.id
#     ]
#   }

#   parameters = {
#     SourceType = "GitHub"
#     SourceInfo = <<EOJ

#     {
#       "owner":"KlToti",
#       "repository":"group-3-Kibana-AMI",
#       "path":"https://github.com/KlToti/group-3-Kibana-AMI/tree/Create_AMI_for_Kibana_Application/configuration",
#       "getOptions":"branch:Create_AMI_for_Kibana_Application"
#     } 

# EOJ
#     InstallDependencies = "True"
#     PlaybookFile = "main-playbook.yml"
#     ExtraVariables = "SSM=True"
#     Check = "False"
#     Verbose = "-v"
#   }

# }