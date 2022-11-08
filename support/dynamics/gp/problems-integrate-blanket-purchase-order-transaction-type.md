---
title: Problems occur if you integrate a blanket purchase order transaction type when you use Integration Manager together with either Microsoft Dynamics GP 9.0 or Great Plains 8.0
description: Describes problems that occur if you integrate a blanket purchase order transaction. To resolve these problems, obtain Service Pack 1 for Integration Manager for Microsoft Dynamics GP 9.0.
ms.reviewer: lmuelle
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Problems occur if you integrate a blanket purchase order transaction type when you use Integration Manager together with either Microsoft Dynamics GP 9.0 or Great Plains 8.0

This article describes issues that occur when you integrate a blanket purchase order transaction.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918082

## Symptoms

When you use Integration Manager together with either Microsoft Dynamics GP 9.0 or Microsoft Business Solutions - Great Plains 8.0, one of the following problems occurs. Specifically, one of these problems occurs if you integrate a blanket purchase order transaction type:

- If you integrate a blanket purchase order with three line items, the first line item is the control line item. When you examine the transaction in the POP10110 table, the **ORD** field for this first line item is displayed as 8192. However, when you enter the transaction in the Purchase Order Entry window, the **ORD** field for the first line item is displayed as 16384.
- If you integrate a blanket purchase order with only the information in line 0, the information isn't shown in the Purchasing Blanket Detail Entry window until you save the line item in the purchase order transaction again.

## Resolution

### Integration Manager for Microsoft Dynamics GP 9.0

To resolve this problem, obtain Service Pack 1 for Integration Manager.

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. This problem was corrected in Service Pack 1 for Integration Manager in Microsoft Dynamics GP 9.0.

### Integration Manager for Microsoft Business Solutions - Great Plains 8.0

To resolve this problem, obtain Service Pack 5 for Integration Manager.

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. This problem was corrected in Service Pack 5 for Integration Manager in Microsoft Business Solutions - Great Plains 8.0.
