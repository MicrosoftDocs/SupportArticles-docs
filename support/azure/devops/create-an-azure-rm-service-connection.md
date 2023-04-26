---
title: Create an Azure RM service connection
description: This article guides you in creating an Azure RM service connection. 
ms.date: 04/21/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# Create an Azure RM service connection

To create an Azure RM service connection, navigate to the project settings in the Azure DevOps project:

https://dev.azure.com/ \<org name>/<project name\>/_settings/adminservices > New service connection > Azure Resource Manager > Service principal (automatic)

## What happens when you save to your new Azure RM service connection?

After you save the Azure RM service connection, the connection takes the following actions:

- Connects to the Azure Active Directory (Azure AD) tenant for the selected subscription.

- Creates an application in Azure AD on behalf of the user.

- Creates an Azure Resource Manager service connection by using this application's details.

After you successfully create the application, assign the application as a contributor to the selected subscription.

For more information, see [What happens when you create an Azure RM service connection?](/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops&preserve-view=true).

## Azure RM service principal (manual)

Per company policy and security protocols, some Azure DevOps admins don't have permissions to manage Azure subscriptions. To create service principal names (SPNs), these admins can use the manual Azure RM service principal option.

To create SPNs, users who have permissions for Azure subscriptions and Azure Active Directory (Azure AD) can follow these steps:

1. Sign in to the [Azure portal](https://ms.portal.azure.com/#home).

1. Select **Azure Active Directory > App registrations**.

1. Select your application on the list, and then select **Client secrets > New client secret**.

1. Provide a description and duration for the application secret (password-based authentication), and then select **Add**.

For more information, see [Create a new application secret](/azure/active-directory/develop/howto-create-service-principal-portal).

Provide this SPN Contributor role or similar RBAC permissions on the subscription. You can even provide the Reader role at the subscription level. However, make sure that you provide Contributor access on the resource and resource group that these roles would update or deploy.

To get the subscription details and create an ARM service connection by using the manual Azure RM service principal option, see [Create an Azure Resource Manager service connection with an existing service principal](/azure/devops/pipelines/library/connect-to-azure?view=azure-devops&preserve-view=true).

Subscription details include the following information:

- Subscription ID
- Subscription Name
- Service principal ID (client ID)
- Service principal key (the value of the secret that you created in step 3)
- Tenant ID (Directory ID)**

To get this information, download and run this [PowerShell script](https://github.com/microsoft/azure-pipelines-extensions/blob/master/TaskModules/powershell/Azure/SPNCreation.ps1) in an Azure PowerShell window. When you are prompted, enter your subscription name, password, role (optional), and the cloud type, such as Azure Cloud (default), Azure Stack, or Azure Government Cloud.