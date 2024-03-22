---
title: An integration leaves 0.01 instead of zero in On Account
description: Discusses that the On Account field of an invoice contains $0.01 instead of zero when you integrate a multi-currency Sales Order Processing invoice that has a payment in Dynamics GP and in Great Plains. A service pack is available to fix this problem.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# An integration of a multi-currency Sales Order Processing invoice that has a payment leaves $0.01 instead of zero in the "On Account" field

This article provides a resolution for the issue that an integration of a multi-currency Sales Order Processing invoice that has a payment leaves $0.01 instead of zero in the On Account field in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917919

## Symptoms

When you integrate a multi-currency Sales Order Processing invoice that has a payment amount in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, the **On Account** field of the invoice contains a value of $0.01 even though the values that are in the **Amount Received** and the **Total** fields on the invoice are the same.

When the values that are in the **Amount Received** and the **Total** fields on the invoice are the same, the value that is in the **On Account** field should be zero.

## Resolution

To resolve this problem, obtain the latest service pack for Integration Manager for Microsoft Dynamics GP.
