---
title: Error when VAT Return is generated
description: When running the VAT return, an error message appears. This article provides a solution to this error.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# Error on VAT Return in Microsoft Dynamics GP: The Input tax for this range hasn't been entered

This article provides a solution to an error that happens when the VAT Return is generated.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2876052

## Symptoms

The following error happens when the VAT Return is generated:

> The Input tax for this range hasn't been entered. Do you want to continue calculating?

## Cause

If the error didn't happen in the past, either something changed, the tax rate was removed, the EU options were just marked, the effective date needs to be updated, or there are now EU transactions.  
This can be caused by:

- EU transactions were entered
- EU settings were turned on
- The EU Tax rate was removed
- The effective date on the EU tax rate is not valid

## Resolution

This relates to EU transaction tracking and applies an additional rate for European Union transactions. If there are no European transactions taking place, you can enter a dummy rate in this window so the message no longer appears. But if there are EU transactions, then enter the appropriate tax rate and applicable date.

1. Click on **Tools** under **Microsoft Dynamics GP**, point to **Setup**, point to **Company** and click on **EU Input Tax Rate**.

2. In the **EU Input Tax Rate Maintenance** window, enter an **Effective Date** and **Tax Percentage**. Click **OK**.

    The Effective Date should be one day prior to the date returned by this script:

    ```sql
    select min (Docdate) from TX30000 where ECTRX = 1
    ```
