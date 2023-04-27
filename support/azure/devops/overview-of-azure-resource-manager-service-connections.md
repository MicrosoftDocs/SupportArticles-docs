---
title: Troubleshoot connection issues in Azure Resource Manager service connection
description: Provides an overview of Azure RM service connection, types of connection modes, and lists the tools used to troubleshoot various scenarios.
ms.date: 04/25/2023
author: padmajayaraman
ms.author: v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Troubleshoot connection issues in Azure Resource Manager service connection

There are various causes for connectivity issues in Azure Resource Manager service connection. This article series helps you troubleshoot various service connection problems and describes the tools and methods you can use for troubleshooting.

## Introduction to Azure RM service connection

An Azure Resource Manager service connection is used to connect to a Microsoft Azure subscription or Azure resources by using Service Principal Authentication (SPA) or an Azure-Managed Service Identity.

The **Connections** dialog box offers two main connection modes.

- **Automated subscription detection**: In this mode, Azure Pipelines queries Azure for all the subscriptions and instances to which you have access. These subscriptions use the credentials that you currently use to sign in to Azure Pipelines (including Microsoft accounts and School or Work accounts).

If you don't see the subscription that you want to use, sign out of Azure Pipelines, and then sign in again by using the appropriate account credentials.

- **Manual subscription pipeline**: In this mode, you must specify the service principal that you want to use to connect to Azure. The service principal specifies the resources and the access levels that are available over the connection.

Use this approach when you have to connect to an Azure account by using credentials that differ from the credentials that you currently use to sign in to Azure Pipelines. This is an useful method to maximize security and limit access. Service principals are valid for two years.

## Create an Azure RM service connection

To create an Azure RM service connection, navigate to the project settings in the Azure DevOps project:

https://dev.azure.com/ /<OrgName><Project-Name>/_settings/adminservices -> **New service connection -> Azure Resource Manager -> Service principal (automatic)**

### Save an Azure RM service connection

After you save the Azure RM service connection, the connection takes the following actions:

- Connects to the Azure Active Directory (Azure AD) tenant for the selected subscription.

- Creates an application in Azure AD on behalf of the user.

- Creates an Azure Resource Manager service connection by using this application's details.

After you successfully create the application, assign the application as a contributor to the selected subscription.

For more information, see [What happens when you create an Azure RM service connection?](/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops&preserve-view=true).

## Tools used for troubleshooting Azure RM service connection scenarios

Many of the troubleshooting scenarios that are discussed in these topics involve the F12 developer tools in your web browser and the Fiddler debugging tool. The following sections discusses these tools.

### F12 developer tools

To capture an F12 trace, follow the steps in [Capture a browser trace for troubleshooting](/azure/azure-portal/capture-browser-trace).

> [!NOTE]
> We recommend that you try to capture a minimum of events in an F12 trace. Start capturing the trace just before the step that's causing the issue instead of starting the trace as soon as you log in to the Azure DevOps portal.

### Fiddler trace

1. Install the [Fiddler](https://docs.telerik.com/fiddler/configure-fiddler/tasks/decrypthttps) tool.

1. Run Fiddler.

1. Press **F12** to stop the traffic capture, and then press **CTRL+X** to clear any traffic log.

> [!IMPORTANT]
> Configure Fiddler to capture and decrypt HTTPS traffic. To do this, select **Tools > Options > HTTPS**. Select both checkboxes on this tab (**Capture HTTPS CONNECTs** and **Decrypt HTTPS traffic**), and then select **YES** to all prompts. For more information, see [Configure Fiddler Classic to Decrypt HTTPS Traffic](https://docs.telerik.com/fiddler/configure-fiddler/tasks/decrypthttps&preserve-view=true).

## Common service connection issues

Use the following list to navigate to the appropriate article or section for detailed troubleshooting steps:

**Subscription loading issues**

- [Loading subscriptions window shows spinning wheel when trying to create a service connection](troubleshoot-subscription-related-scenarios.md#loading-subscriptions-window-shows-spinning-wheel-when-trying-to-create-a-service-connection)

- [Subscription isn't listed when creating a service connection](troubleshoot-subscription-related-scenarios.md#subscription-isnt-listed-when-creating-a-service-connection)

- [There is no active Azure subscription](troubleshoot-subscription-related-scenarios.md#you-dont-appear-to-have-an-active-azure-subscription-error)

- ["Failed to set Azure permission" error when trying to save a service connection](troubleshoot-subscription-related-scenarios.md#failed-to-set-azure-permission-error-when-trying-to-save-a-service-connection)

**Service connection creation issues**

- [Error when verifying the manual Azure RM service connection](fail-to-verify-service-connection.md#error-when-verifying-the-manual-azure-rm-service-connection)

- [Azure RM Service connection not listed for a task](azure-rm-service-connection-not-listed-for-a-task.md#azure-rm-service-connection-not-listed-for-a-task)

- [User is not able to delete an existing Azure RM service connection](user-is-not-able-to-delete-existing-service-connection.md#user-is-not-able-to-delete-an-existing-azure-rm-service-connection)

- ["Failed to get Azure DevOps Service access token" error](fail-to-verify-service-connection.md)

- [Fail to verify the service connection](fail-to-verify-service-connection.md)

- [Create Azure RM service principal (manual)](fail-to-verify-service-connection.md#create-azure-rm-service-principal-manual)

## See also

["Azure Resource Manager service connection"](/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml&preserve-view=true) section of [Manage service connections](/azure/devops/pipelines/library/service-endpoints?view=azure-devops&preserve-view=true&tabs=yaml)
[Troubleshoot ARM service connections](/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops&preserve-view=true)

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]