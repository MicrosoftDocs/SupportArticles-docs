---
title: PublicIPCountLimitExceededByVMScaleSet error when you create virtual machine scale set
description: Describes how to file a support ticket for a Public IP quota increase.
ms.date: 09/03/2021
ms.reviewer: 
ms.service: virtual-machine-scale-sets
---
# PublicIPCountLimitExceededByVMScaleSet error when you create virtual machine scale set

## Symptoms

When you create a virtual machine scale set, you receive the following error message:

>Error: Code='PublicIPCountLimitExceededByVMScaleSet' Message='The requested number of publicIPAddresses &lt;number&gt; for VM Scale Set &lt;Resource-ID&gt; will exceed the maximum number of publicIPAddresses allowed &lt;maximum number&gt; for subscription.

## Cause

This issue occurs because you reached the maximum number of public IP addresses that are allowed for your subscription. For more information, see [Public IP address limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#publicip-address).

## Resolution

To raise the limit or quota for your subscription, go to the [Azure portal]( https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest), file a **Service and subscription limits (quotas)** support ticket, and set the quota type to **Networking**.

:::image type="content" source="./media/vmss-public-ip-count-limit-exceeded/increase-public-ip.png" alt-text="The image about filing a support ticket":::

For more information, see [How to file a support ticket for a quota increase](/azure/azure-resource-manager/templates/error-resource-quota#solution).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
