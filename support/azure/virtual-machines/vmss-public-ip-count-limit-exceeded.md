---
title: PublicIPCountLimitExceededByVMScaleSet error when you create virtual machine scale set
description: Describes how to file a support ticket for Public IP quotes increase.
ms.date: 09/03/2021
ms.prod-support-area-path: 
ms.reviewer: 
ms.service: virtual-machines
---
# PublicIPCountLimitExceededByVMScaleSet error when you create virtual machine scale set

## Symptom

When you create a new virtual machine scale set, the following error message is received:

>Error: Code='PublicIPCountLimitExceededByVMScaleSet' Message='The requested number of publicIPAddresses &lt;number&gt; for VM Scale Set &lt;Resource-ID&gt; will exceed the maximum number of publicIPAddresses allowed &lt;maximum number&gt; for subscription.


## Cause

This issue occurs because the maximum number of public IP addresses allowed for your subscription is reached. For more information, see [Public IP address limits](azure/azure-resource-manager/management/azure-subscription-service-limits#publicip-address).

## Solution

To raise the limit or quota, go to the [Azure portal]( https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest), file a **Service and subscription limits (quotes)** support ticket and set the quota type to **Networking**.

:::image type="content" source="./media/vmss-public-ip-count-limit-exceeded/increase-public-ip.png" alt-text="The image about filing a support ticket":::

For more information, see [How to file a support ticket for quotes increase](/azure/azure-resource-manager/templates/error-resource-quota#solution).



