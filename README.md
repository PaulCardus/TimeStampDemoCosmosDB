# ASP.NET Core 5 API with CosmosDB

[![Build status](https://dev.azure.com/cds-it/Pollinate%20Demo%20API/_apis/build/status/Pollinate%20Demo%20API-ASP.NET%20Core-CI)](https://dev.azure.com/cds-it/Pollinate%20Demo%20API/_build/latest?definitionId=9)

**[Live Demo](https://pollinate-api-demo20210717194521.azurewebsites.net/swagger) and Swagger Documentation.**

## Prerequisites

- Azure Subscription
- Visual Studio or VS Code
- Terraform
---
## Want to run this app locally or host in Azure?
### 1. Provision Azure Resources using Terraform
Open the Terraform folder with your tool of choice for Terraform deployments. You can find a copy of all relevant commands in the Terraform folder within a file named commands.sh.

Lets login to our Azure account and select the subscription we're going to work with:

```sh
az login
```
```sh
az account set --subscription "Enter your Azure Subscription name here"
```
Now lets initialise Terraform. This will download the specified Terraform provider.
```sh
terraform init
```
Lets upgrade to ensure we're using the latest Terraform provider.
```sh
terraform init -upgrade
```
Run Terraform plan to view the intended declerative changes.
```sh
terraform plan -out tfplan
```
Apply the plan and deploy the resources.
```sh
terraform apply tfplan
```
Now lets view the dynamically generated CosmosDB endpoint and Primary Key, we will need to add these to our appsettings.json file within our application to connect to our CosmosDB account.
```sh
terraform output -json
```

{
  "cosmosdb_endpoint": {
    "sensitive": true,
    "type": "string",
    "value": "**Your CosmosDB endpoint will be here**"
  "cosmosdb_key": {
    "sensitive": true,
    "type": "string",
    "value": "**Your key will be here**"
  },
### Open code in Visual Studio
The easiest method to get up and running quickly is to browse to the [repository](https://github.com/PaulCardus/TimeStampDemoCosmosDB) of this app, click the **code** button select "**Open with Visual Studio**".

When the solution has successfully opened in Visual Studio, you can now edit the **appsettings.json** file by replacing "Var1" with your CosmosDB endpoint value that we displayed as the last step of the Terraform stage and also replace Var2 with the CosmosDB primary key.

You can now run the app locally and test the API endpoints against your Azure CosmosDB. You could also decide to publish the app to the App Service that we created with Terraform.

### Clean up Azure Resources to avoid incurring future costs.
Hop back to your Terraform script window and run.
```sh
terraform destroy
```
Thats it, all done!


### CI/CD & Sensitive Information
I am deploying the live demo application using a full CI/CD Azure DevOps pipeline, I'm performing a file transform stage within the pipeline to inject the sensitive values from my Azure estate into appsettings.json during the CI build stage.

### Alternatives & Future Enhancements

- Create a dockerfile and deploy the container to DockerHub.
- Deploy the docker container to an instance of AKS and use Azure ingest controller.
- Store the sensitive values with Azure Key Vault and consume from within the application code using managed identities
