---
title: Reduce Principal Amount on Scheduled Payment
description: This article describes how to reduce the Principal amount on a Scheduled Payment in Receivables for Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.topic: how-to
ms.date: 03/13/2024
---
# How to reduce the Principal Amount on a Scheduled Payment in Receivables Management

This article describes how to reduce the Principal amount on a Scheduled Payment in Receivables for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2844603

If you have an overage on a cash receipt, you may apply this overage to the principal amount using Principal Payments functionality in the Apply Sales Documents window.

> [!NOTE]
> This functionality is not available for a credit memo.

## More information

When a customer sends a payment that has an additional amount that is to be applied to the principal, you can use the Principal Payments functionality to apply the overage to reduce the remaining principal on a scheduled payment. To do this, follow these steps:

1. While keying the cash receipt, select the **Apply** button. Or you can post the cash receipt and then open the Apply Sales Documents window. To do this, select **Transactions**, point to **Sales** and select **Apply Sales Documents**.

2. In the Apply Sales Documents window, mark the scheduled payment invoice to apply to.
3. Select **OK**.
4. If your cash receipt has a larger amount than the scheduled payment invoice is for, you will be prompted with the following message:

    > Would you like to apply the principal payment amount to the principal?

    > [!NOTE]
    > Having more than one open scheduled payment will prevent you from applying the overage to the principal payment, and therefore, the above message will not pop up for you when you apply a cash receipt with an overage to only one of the open scheduled payment documents. For the Principal Payment window to pop up, you would have to first apply to all the open scheduled payments first. If you apply to just one open scheduled payment, and not any others that are open, the Principal Payment window will not pop up. This is by design.
    >
    > There was a known issue in earlier versions that this message would not pop up if Project Accounting was installed, but this was fixed in SP5 for Microsoft Dynamics GP 10.0 and SP1 for Microsoft Dynamics GP 2010.

5. Select **Yes**. The Principal Payment window appears to confirm the action.
6. Select **OK** to apply the amount listed to the principal for the Schedule Number listed. It will recalculate the Principal and interest amounts on this scheduled payment to adjust.
7. Select **OK** in the Apply Sales Documents window.
8. Select **Post** to post the cash receipt, if applicable.

> [!NOTE]
> After the principal amounts have been adjusted, the overage will be displayed in Inquiry as a separate document with a sequence number of A01. (The regular released scheduled payments had 001, 002, etc as the sequence numbers.)
