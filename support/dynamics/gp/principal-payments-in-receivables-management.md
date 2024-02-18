---
title: Principal payments functionality in Receivables Management in Microsoft Dynamics GP
description: Describes how the principal payments functionality can be used as an enhancement to the scheduled payments functionality in Receivables Management in Microsoft Dynamics GP
ms.topic: how-to
ms.date: 02/18/2024
---
# Description of the principal payments functionality in Receivables Management in Microsoft Dynamics GP

This article describes how the principal payments functionality can be used as an enhancement to the scheduled payments functionality in Receivables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 919718

When a customer sends a payment that has an additional amount that is to be applied to the principal, you can use the principal payments functionality to apply the amount to the remaining principal balance on a scheduled payment. The scheduled payment will be reamortized. To do this, follow these steps:

1. To open the Apply Sales Documents window, click **Transactions**, point to **Sales**, and then select **Apply Sales Documents**.
2. If you try to apply a payment transaction to a scheduled payment document that has a smaller amount than the payment, you receive the following message:

    > Would you like to apply principal payment amount to the principal?

3. Select **Yes**. The Principal Payment window appears to confirm the action.

