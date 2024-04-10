---
title: Issues with the service connection in Azure Web App tasks
description: Provides solutions for issues related to the service connection in Azure Web App tasks.
ms.date: 05/10/2023
ms.custom: sap:Pipelines
ms.reviewer: dmittal, cathmill, v-sidong
ms.service: azure-devops
ms.subservice: ts-pipelines
---
# Issues with the service connection in Azure Web App tasks

This article provides troubleshooting steps and solutions for common issues you may encounter with Azure Resource Manager (Azure RM) service connections when working with Azure services deployment.

## Common issues and solutions

> [!NOTE]
> For more common issues and solutions, see [Troubleshoot Azure RM service connections](/azure/devops/pipelines/release/azure-rm-endpoint) and [Troubleshoot common Azure RM service connection issues](overview-of-azure-resource-manager-service-connections.md). You can also explore [Service connection APIs](/rest/api/azure/devops/serviceendpoint/endpoints) to get, create, and update endpoints.

#### Unable to renew the client secret for a service connection created through the automatic method

To generate a client secret for a service connection created via the "automatic" method, follow these steps:

1. Go to **Project settings** > **Service connections**, and then select the service connection you want to modify.
1. Select **Edit** in the upper-right corner, and the select **Verify**.
1. Select **Save**.

This method generates a new client secret for the service principal backing the service connection. For more information, see [Service principal's token expired](/azure/devops/pipelines/release/azure-rm-endpoint#service-principals-token-expired).

When performing the operation, ensure you have the proper permission on the Azure subscription and Microsoft Entra ID, as it updates the secret for the app registered for the service principal. For more information, see [Troubleshoot ARM service connections](/azure/devops/pipelines/release/azure-rm-endpoint#what-happens-when-you-create-a-resource-manager-service-connection) and [Create an Azure Resource Manager service connection using automated security](/azure/devops/pipelines/library/connect-to-azure#create-an-azure-resource-manager-service-connection-using-automated-security).

<a name='how-to-create-the-service-principal-to-be-used-in-azure-devops-without-the-permission-on-the-azure-subscription-and-azure-ad'></a>

#### How to create the service principal to be used in Azure DevOps without the permission on the Azure subscription and Microsoft Entra ID?

You can use a service principal created manually by a user who has permission on the Azure subscription and Microsoft Entra ID and then add the service principal details manually in Azure DevOps. For more information, see [Create an Azure Resource Manager service connection with an existing service principal](/azure/devops/pipelines/library/connect-to-azure#create-an-azure-resource-manager-service-connection-with-an-existing-service-principal).

#### The pipeline tasks are failing with an error like: "AuthorizationFailed: The client '\<ClientName\>' with object id '\<ObjectId\>' does not have authorization to perform action '\<ActionName\>' over scope …"

Make sure the service principal used with the task has the proper permission on the Azure resource and scope mentioned in the error message. The client and object ID in the error message are related to the service principal.

#### Unable to assign an Azure subscription to a new release

Make sure you're using a subscription with a resource group you're authorized to deploy to. To push a release, ensure you have the appropriate [user roles/access](/azure/role-based-access-control/rbac-and-directory-admin-roles) for the subscription.  

#### Unable to create or select a subscription even as the Admin and Owner of it

Check the role of the user for **App Registration**. Update the role of the user for **App Registration** manually and retry [creating a new service connection](/azure/devops/pipelines/library/service-endpoints#create-a-service-connection). This issue often happens if you have an existing service connection and the service principal associated with it has expired. While trying to renew it, the App Registration may have lost the proper role, which might cause conflicts when you try to use it.  

#### How to create a service connection that can manage all the subscriptions?

At this time, service connections can only be scoped to a single Azure subscription. Management-Group scoped service connections can be created, but most tasks don't support using them yet.

#### Unable to authenticate the service principal in CI/CD pipelines

Check your [Microsoft Entra permissions](/azure/active-directory/develop/howto-create-service-principal-portal#check-azure-ad-permissions) and [assign the appropriate roles](/azure/active-directory/fundamentals/active-directory-users-assign-role-azure-portal).  

#### Can an Azure RM service connection of managed service identity (MSI) type be used on Microsoft-hosted agents?

No. If you're using an Azure RM service connection of managed service identity (MSI) type, you're required to use a self-hosted agent. For more information, see [Create an Azure Resource Manager service connection to a VM with a managed service identity](/azure/devops/pipelines/library/connect-to-azure#create-an-azure-resource-manager-service-connection-to-a-vm-with-a-managed-service-identity).  

#### Unable to create a service connection

Make sure you have the appropriate [user roles/access](/azure/role-based-access-control/rbac-and-directory-admin-roles) assigned.  

#### Failed to authorize the service connection resource for the pipeline

Make sure the right service connection is selected in the pipeline and the necessary [pipeline permissions](/azure/devops/pipelines/library/service-endpoints#pipeline-permissions) are granted to access this service connection.  

#### Unable to see the Azure subscriptions while creating a service connection, even after having the necessary permissions

If you're using some part of Azure DevOps that interacts with Azure and it appears not to be working, we recommend that you sign out and sign back in from an incognito or inPrivate browser. This method generates a new, valid token Azure DevOps can use to authenticate the request to Azure, which will query the subscriptions and generate the service connection.

## Recommended documents

- [Use a service connection](/azure/devops/pipelines/library/service-endpoints#use-a-service-connection)
- [Azure Resource Manager service connection](/azure/devops/pipelines/library/connect-to-azure)
- [Troubleshoot Azure Resource Manager service connections](/azure/devops/pipelines/release/azure-rm-endpoint)
- [Azure Resource Manager service connection using automated security](/azure/devops/pipelines/library/connect-to-azure#create-an-azure-resource-manager-service-connection-using-automated-security)

## See related

- [Troubleshoot Azure Web App tasks and deployment issues](troubleshoot-azure-web-apps-tasks-deployments.md)
- [Azure Web App and services related issues](azure-web-app-services-related-issues.md)
- [Resource doesn't exist error with services deployment](resource-not-exist-error-services-deployment.md)
- [Failure scenarios related to Azure Web App tasks](failure-scenarios-related-azure-web-app-tasks.md)
