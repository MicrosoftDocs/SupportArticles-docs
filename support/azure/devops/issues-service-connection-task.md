---
title: Issues with the service connection in the task
description: Provides solutions for issues related to the service connection in the task.
ms.date: 04/27/2023
ms.custom: sap:Pipelines
ms.reviewer: 
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Issues with the service connection in the task

When you use the Azure RM (Resource Manager) service connection to connect while working with Azure services deployment, most issues are related to Azure RM service connections. They can be reviewed from the debug logs of the task.

## Common issues and solutions

> [!NOTE]
> For more common issues and solutions, see [Troubleshoot ARM service connections](/azure/devops/pipelines/release/azure-rm-endpoint).

- **I can't renew the client secret for a service connection created through the automatic method.**

  To generate a client secret for a service connection created via the "automatic" method, navigate to the service connection in the Azure DevOps Services UI, and select **edit** > **verify**. This will generate a new client secret for the service principal backing the service connection. For more information, see [Service principal's token expired](/azure/devops/pipelines/release/azure-rm-endpoint#service-principals-token-expired).

  When performing the operation, ensure you have the proper permission on the Azure subscription and AAD (Azure Active Directory), as it will update the secret for the app registered for the service principal. For more information, see [Troubleshoot ARM service connections](/azure/devops/pipelines/release/azure-rm-endpoint#what-happens-when-you-create-a-resource-manager-service-connection) and [Create an Azure Resource Manager service connection using automated security](/azure/devops/pipelines/library/connect-to-azure#create-an-azure-resource-manager-service-connection-using-automated-security).

- **I don't have permission on the Azure subscription and AAD. How can I create the service principal to be used in Azure DevOps?**

  You can use a service principal created manually by a user who has permission on the Azure subscription and AAD and then add the service principal details manually in Azure DevOps. For more information, see [Create an Azure Resource Manager service connection with an existing service principal](/azure/devops/pipelines/library/connect-to-azure#create-an-azure-resource-manager-service-connection-with-an-existing-service-principal).

- **My pipeline tasks are failing with an error like: "AuthorizationFailed : The client '\<ClientName\>' with object id '\<ObjectId\>' does not have authorization to perform action '\<ActionName\>' over scope …."**

  Make sure the service principal used with the task has the proper permission on the Azure resource and scope mentioned in the error message. The client and object ID in the error message are related to the service principal.

- **I can't assign an Azure subscription to a new release.**

  Make sure you're using a subscription with a resource group you're authorized to deploy to. To push a release, ensure you have the appropriate [user roles/access](/azure/role-based-access-control/rbac-and-directory-admin-roles) for the subscription.  

- **Unable to select a subscription even if I'm the Admin and Owner of it. I also can't create a new service connection.**

  Check the role of the user for **App Registration**. Update the role of the user for **App Registration** manually and retry [creating a new service connection](/azure/devops/pipelines/library/service-endpoints). This issue often happens if you have an existing service connection and the service principal associated with it has expired. While trying to renew it, the App Registration may have lost the proper role, which might cause conflicts when you try to use it.  

- **How do I create a service connection that can manage all my subscriptions?**

  At this time, service connections can only be scoped to a single Azure subscription. Management-Group scoped service connections can be created, but most tasks don't support using them yet.

- **I'm unable to authenticate the service principal in my CI/CD pipeline.**

  Check your [Azure AD permissions](/azure/active-directory/develop/howto-create-service-principal-portal#check-azure-ad-permissions) and [assign the appropriate roles](/azure/active-directory/fundamentals/active-directory-users-assign-role-azure-portal).  

- **Can I use an Azure RM service connection of managed service identity (MSI) type on Microsoft-hosted agents?**

  No. If you're using an Azure RM service connection of managed service identity (MSI) type, you're required to use a self-hosted agent. For more information, see [Create an Azure Resource Manager service connection to a VM with a managed service identity](/azure/devops/pipelines/library/connect-to-azure#create-an-azure-resource-manager-service-connection-to-a-vm-with-a-managed-service-identity).  

- **I'm unable to create a service connection.**

  Make sure you have the appropriate [user roles/access](/azure/role-based-access-control/rbac-and-directory-admin-roles) assigned.  

- **Failed to authorize the service connection resource for the pipeline.**

  Make sure the right service connection is selected in the pipeline and the necessary [pipeline permissions](/azure/devops/pipelines/library/service-endpoints#pipeline-permissions) are granted to access this service connection.  

- **I'm unable to see my Azure subscriptions while creating a service connection, even after having the necessary permissions.**

  If you're using some part of Azure DevOps that interacts with Azure and it appears not to be working, we recommend logging out and logging back in from an incognito or inPrivate browser. This will generate a new, valid token Azure DevOps can use to authenticate the request to Azure, which will query the subscriptions and generate the service connection.
  
- **You can also explore [Service connection APIs](/rest/api/azure/devops/serviceendpoint/endpoints) to get, create, and update them.**

## Recommended documents

- [Service connections](/azure/devops/pipelines/library/service-endpoints#use-a-service-connection)
- [Azure Resource Manager service connection](/azure/devops/pipelines/library/connect-to-azure)
- [Troubleshoot Azure Resource Manager service connections](/azure/devops/pipelines/release/azure-rm-endpoint)
- [Azure Resource Manager service connection using automated security](/azure/devops/pipelines/library/connect-to-azure)
- For service-impacting issues, see [Azure DevOps Services Status](https://status.dev.azure.com/)

## See related

- [Capture logs for further debugging with the tasks](logs-capture-further-debugging-tasks.md)
- [Failure scenarios related to Azure web app tasks](failure-scenarios-related-azure-web-app-tasks.md)
- [Initial debugging for Azure Web App and services related issues](initial-debugging-azure-web-app-services.md)
- [Resource doesn't exist error with services deployment](resource-not-exist-error-services-deployment.md)
