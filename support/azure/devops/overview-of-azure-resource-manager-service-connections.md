---
title: Introduction to Azure RM service connection
description: Provides an overview of Azure RM service connection, types of connection modes, and lists the tools used to troubleshoot various scenarios.
ms.date: 04/25/2023
ms.custom: sap:Pipelines
ms.service: azure-devops
ms.subservice: ts-pipelines
---

# Troubleshoot connection issues in Azure Resource Manager service connection

There are various causes for connectivity issues in Azure Resource Manager service connection. This article series helps you troubleshoot various service connection problems and describes the tools and methods you can use for troubleshooting.

## Introduction to Azure RM service connection

An Azure Resource Manager service connection is used to connect to a Microsoft Azure subscription or Azure resources by using Service Principal Authentication (SPA) or an Azure-Managed Service Identity.

The connection dialog box offers two main connection modes.

- **Automated subscription detection**: In this mode, Azure Pipelines queries Azure for all the subscriptions and instances to which you have access. These subscriptions use the credentials that you currently use to sign in to Azure Pipelines (including Microsoft accounts and School or Work accounts).

If you don't see the subscription that you want to use, sign out of Azure Pipelines, and then sign in again by using the appropriate account credentials.

- **Manual subscription pipeline**: In this mode, you must specify the service principal that you want to use to connect to Azure. The service principal specifies the resources and the access levels that are available over the connection.

Use this approach when you have to connect to an Azure account by using credentials that differ from the credentials that you currently use to sign in to Azure Pipelines. This is a useful method to maximize security and limit access. Service principals are valid for two years.

## Common connection issues

Use the list below to navigate to the appropriate article page for detailed troubleshooting steps for your scenario:




## Tools used for troubleshooting

Many of the troubleshooting scenarios that are discussed in these topics involve the F12 developer tools in your web browser and the Fiddler debugging tool. The following sections discuss these tools.

### F12 developer tools

To capture an F12 trace, follow the steps in [Capture a browser trace for troubleshooting](/azure/azure-portal/capture-browser-trace).

> [!NOTE]
> We recommend that you try to capture a minimum of events in an F12 trace. Start capturing the trace just before the step that is causing the issue instead of starting the trace as soon as you log in to the Azure DevOps portal.

### Fiddler trace

1. Install the [Fiddler](https://docs.telerik.com/fiddler/configure-fiddler/tasks/decrypthttps) tool.

1. Run Fiddler.

1. Press **F12** to stop the traffic capture, and then press **CTRL+X** to clear any traffic log.

> [!IMPORTANT]
> Configure Fiddler to capture and decrypt HTTPS traffic. To do this, select **Tools > Options > HTTPS**. Select both checkboxes on this tab (**Capture HTTPS CONNECTs** and **Decrypt HTTPS traffic**), and then select **YES** to all prompts. For more information, see [Configure Fiddler Classic to Decrypt HTTPS Traffic](https://docs.telerik.com/fiddler/configure-fiddler/tasks/decrypthttps).

## Various connectivity issues





[!INCLUDE [third-party-disclaimer](../../includes/third-party-disclaimer.md)]

## See also

["Azure Resource Manager service connection"](/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml&preserve-view=true) section of [Manage service connections](/azure/devops/pipelines/library/service-endpoints?view=azure-devops&preserve-view=true&tabs=yaml)
[Troubleshoot ARM service connections](/azure/devops/pipelines/release/azure-rm-endpoint?view=azure-devops&preserve-view=true)
