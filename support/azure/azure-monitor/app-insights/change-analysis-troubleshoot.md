--- 
title: Troubleshoot Azure Monitor Change Analysis
description: Learn how to troubleshoot resource provider problems when you're using Azure Monitor's Change Analysis.
ms.date: 6/22/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: aaronmax
ms.service: azure-monitor
ms.subservice: change-analysis
#Customer intent: As an Azure Monitor Change Analysis user, I want to know how to troubleshoot common resource provider problems so I can use the service effectively.  
---

# Troubleshoot Azure Monitor's Change Analysis (preview)

This article provides troubleshooting information for Azure Monitor's Change Analysis resource provider. 

## Trouble registering Microsoft.ChangeAnalysis resource provider from the Change history tab

If you're viewing the **Change history** tab after its first integration with Azure Monitor's Change Analysis, you'll see it automatically registering the **Microsoft.ChangeAnalysis** resource provider. The resource may fail and return the following error messages:

#### "You don't have enough permissions to register Microsoft.ChangeAnalysis resource provider" error message
  
This error message occurs when your role in the current subscription isn't associated with the **Microsoft.Support/register/action** scope. For example, you're not the owner of your subscription, and instead received shared access permissions (like view access to a resource group) through a coworker. 

To resolve the issue, contact the owner of your subscription to register the **Microsoft.ChangeAnalysis** resource provider. 

To register the Change Analysis resource provider through the Azure portal, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Subscriptions**.

1. Select your subscription.
1. In the menu pane, go to the **Settings** heading and select **Resource providers**.
1. Search for **Microsoft.ChangeAnalysis**, select the line containing that resource provider, and then select **Register**.

To register the Change Analysis resource provider through PowerShell, run the following command:

```azurepowershell
# Register resource provider
Register-AzResourceProvider -ProviderNamespace "Microsoft.ChangeAnalysis"
```

#### "Failed to register Microsoft.ChangeAnalysis resource provider" error message

This error message is likely a temporary internet connectivity issue, because of the following factors:

* The UI sent the resource provider registration request.

* You've resolved your [permissions issue](#you-dont-have-enough-permissions-to-register-microsoftchangeanalysis-resource-provider-error-message).

Try refreshing the page and checking your internet connection. If the error persists, contact the [Change Analysis help team](mailto:changeanalysishelp@microsoft.com).

#### "This is taking longer than expected" error message

You'll receive this error message when the registration takes longer than two minutes. While this type of situation is unusual, it doesn't mean something went wrong. Restart your web app to see your registration changes. Changes should show up within a few hours of the app restart.

If your changes still don't show after six hours, contact the [Change Analysis help team](mailto:changeanalysishelp@microsoft.com). 

## Resolve "Azure Lighthouse subscription isn't supported" error message

#### "Failed to query Microsoft.ChangeAnalysis resource provider" error message

Often, this message includes the following text:

> Azure Lighthouse subscription is not supported, the changes are only available in the subscription's home tenant

Currently, the Change Analysis resource provider is limited to registration through an Azure Lighthouse subscription for users outside of the home tenant. We're working on addressing this limitation.

If this limitation is a blocking issue, we can provide a workaround that involves creating a service principal and explicitly assigning the role to allow the access. Contact the [Change Analysis help team](mailto:changeanalysishelp@microsoft.com) to learn more about it.

## Resolve "An error occurred while getting changes. Please refresh this page or come back later to view changes" error message

When changes can't be loaded, Azure Monitor's Change Analysis service presents this general error message. Here are a few known causes:

* There's an internet connectivity error from the client device.

* Change Analysis service is temporarily unavailable.

Refreshing the page after a few minutes usually fixes this issue. If the error persists, contact the [Change Analysis help team](mailto:changeanalysishelp@microsoft.com).

## Resolve "You don't have enough permissions to view some changes. Contact your Azure subscription administrator" error message

This general unauthorized error message occurs when the current user doesn't have sufficient permissions to view the change. At a minimum, the following permissions are required for these corresponding actions:

* To view infrastructure changes returned by Azure Resource Graph and Azure Resource Manager, reader access is required. 

* For web app in-guest file changes and configuration changes, a contributor role is required. 

## Resolve "Cannot see in-guest changes for newly enabled Web App" error message

You may not immediately see web app in-guest file changes and configuration changes. Restart your web app, and then you should be able to view changes within 30 minutes. If you still can't see the changes, contact the [Change Analysis help team](mailto:changeanalysishelp@microsoft.com).

## Diagnose and solve problems for virtual machines

To troubleshoot issues with Azure virtual machines (VMs) by using the troubleshooting tool, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Virtual machines**.
1. In the list of virtual machines, select the name of your VM.
1. In the menu pane, select **Diagnose and solve problems**.

1. Select **Troubleshooting tools**, and then select the tool that fits your issue.

:::image type="content" source="./media/change-analysis-troubleshoot/vm-dnsp-troubleshooting-tools.png" alt-text="Screenshot of the Diagnose and solve problems tool for a virtual machine.":::

:::image type="content" source="./media/change-analysis-troubleshoot/analyze-recent-changes.png" alt-text="Screenshot of the Analyze recent changes section of the Diagnose and solve problems tool for a virtual machine." border="false":::

## Next steps

Learn more about the [Azure Resource Graph](/azure/governance/resource-graph/overview), which helps power Change Analysis.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
