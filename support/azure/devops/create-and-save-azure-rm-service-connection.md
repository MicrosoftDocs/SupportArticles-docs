---
title: Create and save an Azure RM service connection
description: This article guides you in creating and saving an Azure RM service connection. 
ms.date: 04/26/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
---

# Create an Azure RM service connection

To create an Azure RM service connection, navigate to the project settings in the Azure DevOps project:

https://dev.azure.com/ <OrgName>/<Project-Name>/_settings/adminservices -> **New service connection -> Azure Resource Manager -> Service principal (automatic)**

## Save an Azure RM service connection

After you save the Azure RM service connection, the connection takes the following actions:

- Connects to the Azure Active Directory (Azure AD) tenant for the selected subscription.

- Creates an application in Azure AD on behalf of the user.

- Creates an Azure Resource Manager service connection by using this application's details.

After you successfully create the application, assign the application as a contributor to the selected subscription.

For more information, see [What happens when you create an Azure RM service connection?](/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops&preserve-view=true).
