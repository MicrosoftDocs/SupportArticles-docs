--- 
title: Troubleshoot Azure Monitor Change Analysis
description: Learn how to troubleshoot resource provider problems when you're using Azure Monitor's Change Analysis.
ms.date: 03/06/2023
ms.reviewer: cawa, aaronmax, hannahhunter, v-leedennis, v-jsitser, v-weizhu
ms.service: azure-monitor
ms.subservice: change-analysis
#Customer intent: As an Azure Monitor Change Analysis user, I want to know how to troubleshoot common resource provider problems so I can use the service effectively.
---
# Troubleshoot Azure Monitor's Change Analysis

This article provides troubleshooting information for Azure Monitor's Change Analysis resource provider.

## Trouble registering Microsoft.ChangeAnalysis resource provider from the Change history tab

If you're viewing the **Change history** tab after its first integration with Azure Monitor's Change Analysis, you'll see it automatically registering the `Microsoft.ChangeAnalysis` resource provider. The resource may fail and incur the following error messages:

* [You don't have enough permissions to register Microsoft.ChangeAnalysis resource provider](#not-enough-permission-to-register).
* [Failed to register Microsoft.ChangeAnalysis resource provider](#failed-to-register).
* [This is taking longer than expected](#taking-longer-than-expected).

### <a id="not-enough-permission-to-register"></a>You don't have enough permissions to register Microsoft.ChangeAnalysis resource provider

You're receiving this error message because your role in the current subscription isn't associated with the `Microsoft.Support/register/action` scope. For example, you aren't the owner of your subscription and instead received shared access permissions through a coworker (for example, view access to a resource group).

To resolve the issue, contact the owner of your subscription to register the `Microsoft.ChangeAnalysis` resource provider. To do this, follow these steps:

1. In the Azure portal, search for **Subscriptions**.
1. Select your subscription.
1. Navigate to **Resource providers** under **Settings** in the side menu.
1. Search for `Microsoft.ChangeAnalysis` and register via the Azure portal, Azure PowerShell, or Azure CLI.

    Here's an example for registering the resource provider through PowerShell:

    ```PowerShell
    # Register resource provider
    Register-AzResourceProvider -ProviderNamespace "Microsoft.ChangeAnalysis"
    ```

### <a id="failed-to-register"></a>Failed to register Microsoft.ChangeAnalysis resource provider

This error message is likely a temporary internet connectivity issue since:

* The UI sent the resource provider a registration request.
* You've resolved your [permissions issue](#not-enough-permission-to-register).

Try refreshing the page and checking your internet connection. If the error persists, [submit an Azure support ticket](https://azure.microsoft.com/support/).

### <a id="taking-longer-than-expected"></a>This is taking longer than expected

You receive this error message when the registration takes longer than two minutes. While unusual, it doesn't mean something went wrong.

To resolve this issue, follow these steps:

1. Prepare for downtime.
1. Restart your web app to see your registration changes.

Changes should show up within a few hours of the app restart. If your changes still don't show after six hours, [submit an Azure support ticket](https://azure.microsoft.com/support/).

## <a id="azure-lighthouse-subscription-not-supported"></a>Azure Lighthouse subscription is not supported

### Unauthorized to get changes

Often, this error message includes the following text:

> Azure Lighthouse subscription is not supported, the changes are only available in the subscription's home tenant.

Azure Lighthouse allows for cross-tenant resource administration. However, cross-tenant support needs to be built for each resource provider. Currently, Change Analysis hasn't built this support. If you're signed in to one tenant, you can't query for resource or subscription changes whose home is in another tenant.

If this is a blocking issue for you, [submit an Azure support ticket](https://azure.microsoft.com/support/) to describe how you're trying to use Change Analysis.

## <a id="error-getting-changes"></a>An error occurred while getting changes. Please refresh this page or come back later to view changes

When changes can't be loaded, Azure Monitor's Change Analysis service presents this general error message. Here are a few known causes:

* Internet connectivity error from the client device
* Change Analysis service being temporarily unavailable

Refreshing the page after a few minutes usually fixes this issue. If the error persists, [submit an Azure support ticket](https://azure.microsoft.com/support/).

## <a id="partial-data-loaded"></a>Only partial data loaded

This error message may occur in the Azure portal when loading change data via the Change Analysis home page. Typically, the Change Analysis service calculates and returns all change data. However, in a network failure or a temporary outage of service, you may receive an error message indicating only partial data was loaded.

To load all change data, try waiting a few minutes and refreshing the page. If you're still only receiving partial data, [submit an Azure support ticket](https://azure.microsoft.com/support/).

## <a id="not-enough-permission-to-view-some-changes"></a>You don't have enough permissions to view some changes. Contact your Azure subscription administrator

This general unauthorized error message occurs when the current user doesn't have sufficient permissions to view the change. At a minimum, the following permissions are required for these corresponding actions:

* To view infrastructure changes returned by Azure Resource Graph and Azure Resource Manager, reader access is required.
* For web app in-guest file changes and configuration changes, a contributor role is required.

## Cannot see in-guest changes for newly enabled Web App

You may not immediately see web app in-guest file changes and configuration changes. Prepare for brief downtime and restart your web app. After that, you should be able to view changes within 30 minutes. If not, [submit an Azure support ticket](https://azure.microsoft.com/support/).

## "Diagnose and solve problems" tool for virtual machines

To troubleshoot virtual machine issues by using the troubleshooting tool in the Azure portal, follow these steps:

1. Navigate to your virtual machine.
1. Select **Diagnose and solve problems** from the side menu.
1. Browse and select the troubleshooting tool that fits your issue.

:::image type="content" source="./media/change-analysis-troubleshoot/vm-dnsp-troubleshooting-tools.png" alt-text="Screenshot of the Diagnose and Solve Problems tool for a Virtual Machine with Troubleshooting tools selected.":::

## Can't filter to your resource to view changes

When filtering down to a particular resource in the Change Analysis standalone page, you may encounter a known limitation that only returns 1,000 resource results. To filter through and pinpoint changes for one of your 1,000+ resources:

1. In the Azure portal, select **All resources**.
1. Select the actual resource you want to view.
1. In that resource's left side menu, select **Diagnose and solve problems**.
1. In the **Change Analysis** card, select **View change details**.

   :::image type="content" source="./media/change-analysis-troubleshoot/change-details-card.png" alt-text="Screenshot of viewing change details from the Change Analysis card in the Diagnose and solve problems tool.":::

From here, you'll be able to view all of the changes for that one resource.

## Next steps

Learn more about [Azure Resource Graph](/azure/governance/resource-graph/overview), which helps power Change Analysis.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
