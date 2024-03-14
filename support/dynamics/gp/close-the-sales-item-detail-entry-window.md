---
title: Close the Sales Item Detail Entry window
description: Provides a solution to an error that occurs when you run a sales transaction integration that has extended pricing enabled for an item on promotion.
ms.reviewer: theley, kvogel, bgardner
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Please close the Sales Item Detail Entry window before continuing" Error message when you run a sales transaction integration that has extended pricing enabled for an item on promotion in Integration Manager for Microsoft Dynamics GP

This article provides a solution to an error that occurs when you run a sales transaction integration that has extended pricing enabled for an item on promotion.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 938562

## Symptoms

When you run a sales transaction integration that has extended pricing enabled for an item on promotion, you receive the following error message:
> Please close the Sales Item Detail Entry window before continuing.
This problem occurs in Integration Manager in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0.

This problem occurs if the **Override Prices** option isn't enabled on the **Options** tab in the Sales Order Processing window.

> [!NOTE]
> When you run the sales transaction integration in Integration Manager in Microsoft Dynamics GP 9.0, no window is open.

## Cause

This problem occurs because Microsoft Dynamics GP is using the promotion price together with the extended price option.

> [!NOTE]
> When you run an integration for an item on promotion, the Promotion Alert window opens. In this window, users can accept or reject the promotion price. However, Integration Manager cannot use the information in this window.

## Resolution

Integration Manager in Microsoft Business Solutions - Great Plains 8.0

To resolve this problem, obtain the latest service pack for Integration Manager in Microsoft Business Solutions - Great Plains 8.0.

> [!NOTE]
> This service pack adds a **Promotion Alert** option to the **Sales Transactions Options** tab. Users can accept or reject the promotion price. The default setting is to accept the promotion price.

## Status

- Integration Manager in Microsoft Dynamics GP 9.0

    Microsoft is researching this problem and will post more information in this article when the information becomes available.  

- Integration Manager in Microsoft Business Solutions - Great Plains 8.0

    Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section.

    This problem was corrected in Service Pack 5 for Integration Manager in Microsoft Business Solutions - Great Plains 8.0.
