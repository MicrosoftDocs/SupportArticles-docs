---
title: Troubleshoot the failed deployment of a Kubernetes application offer
description: Troubleshoot the failed deployment of a Kubernetes application offer that was made on the Azure Marketplace.
ms.date: 04/22/2025
ms.reviewer: chiragpa, atchub, v-leedennis, mnasser
editor: v-jsitser
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Marketplace user, I want to troubleshoot the failed deployment of a Kubernetes application after I accept an offer on the Marketplace.
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshoot the failed deployment of a Kubernetes application offer

This article discusses how to troubleshoot a failed deployment of a Kubernetes application offer that was accepted on the Microsoft Azure Marketplace. When you initiate the purchase of a Kubernetes offer, Azure deploys an Azure Resource Manager template (ARM template) that tries to install the required resources to fulfill the offer. However, the ARM template deployment might fail for various reasons.

## Troubleshooting checklist

#### Examine the deployment operation logs

To determine the cause of the deployment failure, you have to examine the [deployment operation logs][deployment-operations]. If you're still viewing the **Your deployment failed** page in the Azure portal, begin at step 5 of the following procedure. If, instead, you exited the Azure portal or navigated to another portal page, follow all these steps:

1. In the [Azure portal][azure-portal], search for and select **Resource groups**.
1. In the list of resource groups, select the name of the resource group in which you tried to deploy the Kubernetes application.
1. On the **Overview** page of your resource group, locate the **Essentials** section, and then select the hyperlinked text that appears next to the **Deployments** field. This text displays the success rate of your resource group's resource deployment history (for example, **4 failed, 30 succeeded**).
1. In the list of attempted deployments for your resource group, select the **Deployment name** value of the deployment that failed, based on the following corresponding fields:
   - **Last modified** (a time stamp)
   - **Duration**
   - **Status** (shows **Failed** instead of **Succeeded**)
1. In the **Deployment details** list on the deployment page, locate the **Resource** for which the **Status** field has a value of **Conflict**. Select the **Operation details** link for that resource.

   :::image type="content" source="./media/troubleshoot-failed-kubernetes-deployment-offer/deployment-details.png" alt-text="Screenshot of the 'Your deployment failed' page and the list of deployment details for a failed Kubernetes resource deployment." lightbox="./media/troubleshoot-failed-kubernetes-deployment-offer/deployment-details.png":::

1. In the **Operation details** pane, locate the **Status** property (shows a value of **Conflict**), and examine the **Status message** box below the property.

   :::image type="content" source="./media/troubleshoot-failed-kubernetes-deployment-offer/operation-details.png" alt-text="Screenshot of the 'Operation details' pane on the 'Your deployment failed' page for a failed Kubernetes resource deployment." lightbox="./media/troubleshoot-failed-kubernetes-deployment-offer/operation-details.png":::

   The JSON code within the status message shows a `status` property of `Failed`. It also shows an `error` property that contains the child properties of `code` (an error code name, such as "ExtensionOperationFailed") and `message` (an error message description, such as "The extension operation failed with the following error: Failed to resolve the extension version from the given values."). The JSON code resembles the following text:

   ```json
   {
       "status": "Failed",
       "error": {
           "code": "ExtensionOperationFailed",
           "message": "The extension operation failed with the following error: Failed to resolve the extension version from the given values."
       }
   }
   ```

The following sections discuss the cause and solution for some common failure scenarios.

## Cause 1: The application didn't install on the selected AKS cluster

If the Kubernetes application didn't install on the selected Azure Kubernetes Service (AKS) cluster, you receive an error message that resembles the following text:

> Request failed to https\://management.azure.com/subscriptions/\<subscription-guid>/resourceGroups/resourceGroup/providers/Microsoft.ContainerService/managedclusters/aks-cluster/extensionaddons/default?api-version=2021-03-01. Error code: Forbidden. Reason: Forbidden.  
> ```json
> {  
>   "error": {  
>     "code": "AuthorizationFailed",  
>     "message": "The client '<client-guid>' with object id '<client-guid>' does not have authorization to perform action 'Microsoft.ContainerService/managedclusters/extensionaddons/read' over scope '/subscriptions/<subscription-guid>/resourceGroups/resourceGroup/providers/Microsoft.ContainerService/managedclusters/aks-cluster/extensionaddons/default' or the scope is invalid. If access was recently granted, please refresh your credentials."  
>   }  
> } 
> ```

#### Solution 1a: Register the Microsoft.KubernetesConfiguration resource provider

Register the Microsoft.KubernetesConfiguration resource provider. In this case, the installation failed because the Microsoft.KubernetesConfiguration resource provider is required for you to deploy the Kubernetes application. For registration instructions, see the "[Register resource providers][register-resource-providers]" section in the *Deploy a container offer from Azure Marketplace* article.

#### Solution 1b: Maintain the health of the AKS cluster

In general, you should [check the health of the AKS cluster][aks-cluster-health] to prevent other issues from occurring during the installation period. To make sure that the cluster is healthy, resolve issues that are identified on the cluster.

#### Solution 1c: Examine the Azure Monitor activity log

What if the cluster is healthy, but the installation still fails? In that case, examine the [Azure Monitor activity log][azure-monitor-activity-log] within the AKS cluster to find the cause of the failure at that stage of the installation.

## Cause 2: The subscription has resource constraints

Because your Azure subscription has resource constraints, you experience a failure that produces an error message that's similar to the following text:

> The 'unknown' payment instrument(s) is not supported for offer with OfferId: '\<offer-name>', PlanId '\<subscription-plan-name>'.

#### Solution 2: Make sure your subscription meets the necessary billing configuration

Verify the subscription's billing configuration to make sure that it meets the resource requirements of the Kubernetes application. For more information, see [Purchase validation checks][purchase-validation-checks].

## Cause 3: The offer wasn't available in your region

You receive an error message that states that the offer can't be sold in a certain geographical region. The error message might resemble the following text:

> The Offer: '\<offer-name>' cannot be purchased by subscription: '\<subscription-guid>' as it is not to be sold in market: '\<two-letter-region-code'.

#### Solution 3: Recheck whether and where the offer is still available

Verify that the offer is still available, and double-check the regions that the offer applies to.

## Cause 4: An internal server error occurred

The Kubernetes application didn't install because an extension resource didn't install. This failure generates the following error message:

> Extension failed to deploy with Internal server error

#### Solution 4: Delete and reinstall the extension

First, delete the extension resource that's a part of the offer purchase. Then, reinstall the extension.

## Cause 5: The Helm chart didn't install

Errors in the Helm chart generate the following error message:

> Failed to install chart from path [] for release

#### Solution 5: Recheck the entries that you made in the ARM template

Make sure that the values and selections that you entered on the Azure portal for the ARM template deployment are acceptable in the Kubernetes application.

## Cause 6: You haven't accepted the legal terms on the subscription for this plan

Before the subscription can be used, you need to accept the legal terms of the image. Otherwise, you get the following error message:

> You have not accepted the legal terms on this subscription: '\<subscription-guid>' for this plan. Before the subscription can be used, you need to accept the legal terms of the image. 

#### Solution 6: Accept the legal terms

#### [Portal](#tab/azure-portal)

You can deploy through the [Azure portal](https://portal.azure.com). The Azure portal provides a UI experience for reading and accepting the legal terms.

#### [CLI](#tab/CLI)

You can use the Azure CLI commands that are described in the [Azure CLI legal terms](/cli/azure/vm/image/terms). Although the commands are for VMs, the commands also work for containers.

#### [PowerShell](#tab/PowerShell)

To accept the legal terms through PowerShell, run the cmdlets that are described in the [PowerShell legal terms](/powershell/module/az.marketplaceordering).

---

## Next steps

[Troubleshoot errors when deploying AKS cluster extensions](cluster-extension-deployment-errors.md)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[azure-portal]: https://portal.azure.com

[deployment-operations]: /azure/azure-resource-manager/templates/deployment-history#deployment-operations-and-error-message

[register-resource-providers]: /azure/aks/deploy-marketplace#register-resource-providers

[aks-cluster-health]: /azure/architecture/operator-guides/aks/aks-triage-cluster-health

[azure-monitor-activity-log]: /azure/azure-monitor/essentials/activity-log

[purchase-validation-checks]: /marketplace/azure-purchasing-invoicing#purchase-validation-checks
