---
title: Error when you integrate a transaction
description: This article provides a resolution for the problem that occurs when Sales Tax Detail Summary data is mapped for the invoice.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# Error message when you integrate a transaction in Microsoft Dynamics GP 9.0 or in Microsoft Great Plains 8.0

This article helps you resolve the problem that occurs when Sales Tax Detail Summary data is mapped for the invoice.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918083

## Symptoms

When you integrate a transaction in Integration Manager for Microsoft Dynamics GP 9.0 or in Integration Manager for Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:

> DOC 1 ERROR: Macro execution error, Dynamics.DEXTERITY_IM_MACRO_INVISIBLE_ITEM (error 8192): MoveTo line 1 scrollwin 'Tax_Scroll' field '(L) Tax Amount'

The behavior occurs when the transaction has the following characteristics:

- All items have positive quantity amounts except one line item that has a quantity of (-1) mapped in the **Items** mapping folder.

- **Sales Tax Detail Summary** data is mapped for the invoice.

## Resolution

- Integration Manager for Microsoft Dynamics GP 9.0

  To resolve this problem, obtain the latest service pack for Integration Manager for Microsoft Dynamics GP 9.0.

- Integration Manager for Microsoft Business Solutions - Great Plains 8.0

  To resolve this problem, obtain Service Pack 5 for Integration Manager.

- Integration Manager for Microsoft Dynamics GP 9.0

  Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the **Applies to** section. This problem was corrected in Service Pack 1 for Integration Manager for Microsoft Dynamics GP 9.0.  

- Integration Manager for Microsoft Business Solutions - Great Plains 8.0

  Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the **Applies to** section. This problem was corrected in Service Pack 5 for Integration Manager in Microsoft Business Solutions - Great Plains 8.0.
