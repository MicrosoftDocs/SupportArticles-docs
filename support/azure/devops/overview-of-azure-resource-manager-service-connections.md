---
title: Troubleshoot Azure RM service connection issues
description: Provides an overview of Azure RM service connection, types of connection modes, and lists the tools used to troubleshoot various scenarios.
ms.date: 05/19/2023
ms.reviewer: cathmill, kirthishkt, v-jayaramanp
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Troubleshoot Azure RM service connection issues

This article series helps you troubleshoot various Azure RM service connection problems and describes the tools and methods you can use for troubleshooting.

## Introduction to Azure RM service connection

An Azure RM service connection is used to connect to a Microsoft Azure subscription or Azure resources by using Service Principal Authentication (SPA) or an Azure-Managed Service Identity.

The **Connections** dialog box offers two main connection modes.

- **Automated subscription detection**
  
  In this mode, Azure DevOps queries Azure for all the subscriptions and instances to which you have access. These subscriptions use the credentials that you currently use to sign in to Azure DevOps (including Microsoft accounts and School or Work accounts).

  If you don't see the subscription that you want to use, sign out of Azure DevOps, and then sign in again by using the appropriate account credentials.

- **Manual subscription pipeline**
  
  In this mode, you must specify the service principal that you want to use to connect to Azure. The service principal specifies the resources and the access levels that are available over the connection.

  Use this approach when you have to connect to an Azure account by using credentials that differ from the credentials that you currently use to sign in to Azure DevOps. This is an useful method to maximize security and limit access. Service principals are valid for two years.

## Create an Azure RM service connection

To create an Azure RM service connection,

1. Sign in to your organization `(https://dev.azure.com/{yourorganization})` and select your project.

1. In the Azure DevOps project, navigate to the **Project Settings > Service Connections.**

1. Select **New service connection**.

1. In the **New service connection** dialog box, select **Azure Resource Manager**.

1. Select **Next**.

1. Select **Service principal (automatic) authentication** method.

1. Select **Next**.

1. Select the Subscription under which the resource is available.

1. Provide a name for the new connection in **Service connection** name text box.

1. Select **Save**.

### Save an Azure RM service connection

After you save the Azure RM service connection, the connection takes the following actions:

- Connects to the Microsoft Entra tenant for the selected subscription.

- Creates an application in Microsoft Entra ID on behalf of the user.

- Creates an Azure RM service connection by using this application's details.

After you successfully create the application, assign the application as a contributor to the selected subscription.

For more information, see [What happens when you create an Azure RM service connection?](/azure/devops/pipelines/release/azure-rm-endpoint).

## Tools used for troubleshooting Azure RM service connection scenarios

Many of the troubleshooting scenarios that are discussed in these topics involve the use of F12 developer tools in your web browser and the Fiddler debugging tool to capture additional information. These traces can provide important details to help diagnose and troubleshoot the issue. The following sections discusses these tools.

### F12 developer tools

To capture an F12 trace, follow the steps in [Capture a browser trace for troubleshooting](/azure/azure-portal/capture-browser-trace).

> [!NOTE]
> It is recommended that you try to capture a minimum set of events in an F12 trace. Start capturing the trace just before the step that's causing the issue instead of starting the trace as soon as you log in to the Azure DevOps portal.

### Fiddler trace

1. Install the [Fiddler](https://docs.telerik.com/fiddler/configure-fiddler/tasks/decrypthttps) tool.

1. Run Fiddler.

1. Press <kbd>F12</kbd> to stop the traffic capture, and then press <kbd>Ctrl</kbd>+<kbd>X</kbd> to clear any traffic log.

> [!IMPORTANT]
> Configure Fiddler to capture and decrypt HTTPS traffic. To do this, select **Tools > Options > HTTPS**. Select both checkboxes on this tab (**Capture HTTPS CONNECTs** and **Decrypt HTTPS traffic**), and then select **YES** to all prompts. For more information, see [Configure Fiddler Classic to Decrypt HTTPS Traffic](https://docs.telerik.com/fiddler/configure-fiddler/tasks/decrypthttps).

## Common service connection issues

Use the following list to navigate to the appropriate article or section for detailed troubleshooting steps:

**Subscription loading issues**

- [Loading subscriptions window shows spinning wheel when trying to create a service connection](troubleshoot-subscription-related-scenarios.md#loading-subscriptions-window-shows-spinning-wheel-when-trying-to-create-a-service-connection)

- [Subscription isn't listed when creating a service connection](troubleshoot-subscription-related-scenarios.md#subscription-is-not-listed-when-creating-a-service-connection)

- ["You don't appear to have an active Azure subscription" error](troubleshoot-subscription-related-scenarios.md#you-dont-appear-to-have-an-active-azure-subscription-error)

- ["Failed to set Azure permission" error when trying to save a service connection](troubleshoot-subscription-related-scenarios.md#failed-to-set-azure-permission-error-when-saving-a-service-connection)

**Issues when creating, editing, or updating Service connections**

- [Create Azure RM service principal (manual)](create-azure-rm-service-principal-manual.md#create-azure-rm-service-principal-manual)

- [Error when verifying the manual Azure RM service connection](create-azure-rm-service-principal-manual.md#error-when-verifying-the-manual-azure-rm-service-connection)

- ["Failed to get Azure DevOps Service access token" error](failed-to-get-azure-devops-service-access-token.md)

- [Azure RM Service connection not listed for a task](azure-rm-service-connection-not-listed-for-a-task.md)

- [Unable to delete an existing Azure RM service connection](fail-to-delete-existing-service-connection.md)

## See also

- ["Azure Resource Manager service connection"](/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml&preserve-view=true)
- [Troubleshoot Azure RM service connections](/azure/devops/pipelines/release/azure-rm-endpoint)

[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]
