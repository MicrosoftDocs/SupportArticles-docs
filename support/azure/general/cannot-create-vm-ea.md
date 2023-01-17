---
title: Retail prices displayed here error for Azure EA user when creating VM
description: Provides several solutions to an issue in which you can't create a VM as an Azure Enterprise Agreement (EA) user in portal.
ms.date: 09/16/2021
ms.service: azure-common-issues-support
ms.author: genli
author: genlin
ms.reviewer: 
---
# Error when creating a VM as an Azure Enterprise user: Contact your reseller for accurate pricing

This article provides several solutions to an issue in which you can't create a VM as an Azure Enterprise Agreement (EA) user in portal.

_Original product version:_ &nbsp; Billing  
_Original KB number:_ &nbsp; 4091792

## Symptoms

When you create a VM as an Azure EA user in the [Microsoft Azure portal](https://portal.azure.com/), you receive the following message:

> Retail prices displayed here. Contact your reseller for accurate pricing.

:::image type="content" source="media/cannot-create-vm-ea/price-error.png" alt-text="Screenshot of the price error message.":::

## Cause

This issue occurs in one of the following scenarios:

- You are a direct EA user, and **AO view charges** or **DA view charges**  is disabled.
- You are an indirect EA user who has **release markup** enabled and **AO view charges** or **DA view charges** disabled.
- You are an indirect EA user who has **release markup** not enabled.
- You use  an EA dev/test subscription under an account that is not marked as dev/test in the EA portal.

## Resolution

### Scenario 1

When you are a direct or indirect EA user who has **release markup** enabled and **AO view charges** or **DA view charges** disabled, you can use the following workaround:

1. Go to the [Azure EA portal](https://ea.azure.com/)  by using the Enrollment Admin role.
2. Click the **Manage** panel on the left.
3. Enable **DA view charges** and **AO view charges** at the **Enrollment** level.

    :::image type="content" source="media/cannot-create-vm-ea/enrollment.png" alt-text="Screenshot of the enrollment detail, where DA view charges and AO view charges at the Enrollment level are enabled.":::

### Scenario 2

When you are an indirect EA user who has **release markup** disabled, you can contact the reseller for accurate pricing.

### Scenario 3

When you use an EA dev/test subscription under an account that is not marked as dev/test in the EA portal, you can use the following workaround:

1. Go to the [Azure EA portal](https://ea.azure.com/) by using the Enrollment Admin role.
2. Click the **Manage** panel on the left side.
3. Select the **Account** level at the top.
4. Find the account that has this issue in Azure portal.
5. Click the pencil icon :::image type="icon" source="media/cannot-create-vm-ea/pencil-icon.png"::: on the right side.
6. Check the **Dev/Test** box :::image type="icon" source="media/cannot-create-vm-ea/devtest-box.png":::, and then click **Save**.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
