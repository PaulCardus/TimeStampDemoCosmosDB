az login

# get the current default subscription using show
az account show --output table

# get the current default subscription using list
az account list --query "[?isDefault]"

# get a list of subscriptions except for the default subscription
az account list --query "[?isDefault == \`false\`]"

# get the details of a specific subscription
az account show --subscription MySubscriptionName

# select specific subscription by sub name
az account set --subscription "SUB NAME HERE"

# make sure terraform CLI is installed
terraform

# initialize terraform Azure modules
terraform init

# upgrades terraform Azure modules to latest version
terraform init -upgrade

# plan and save the infra changes into tfplan file
terraform plan -out tfplan

# show the tfplan file
terraform show -json tfplan
terraform show -json tfplan >> tfplan.json

# Format tfplan.json file
terraform show -json tfplan | jq '.' > tfplan.json

# show only the changes
cat tfplan.json | jq '[.resource_changes[] | {type: .type, name: .change.after.name, actions: .change.actions[]}]' 
cat tfplan.json | jq -r '(.resource_changes[] | [.change.actions[], .type, .change.after.name]) | @tsv'

# apply the infra changes
terraform apply tfplan

# view sensitive values in terminal 
terraform output -json

# delete the infra
terraform destroy

# cleanup files
rm terraform.tfstate
rm terraform.tfstate.backup
rm tfplan
rm tfplan.json
rm -r .terraform/