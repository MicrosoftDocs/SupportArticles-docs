---
title: Duplicate check numbers are not allowed or Data entry errors exist error
description: Describes errors when EFT computer batch goes to Batch Recovery in Payables Management for Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Payables Management
---
# EFT computer batch goes to Batch Recovery and produces error message in Payables Management for Microsoft Dynamics GP: "Duplicate check numbers are not allowed" or "Data entry errors exist"

This article helps resolve the errors that occur when EFT computer batch goes to Batch Recovery in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2620452

## Symptoms

EFT computer batch goes to Batch Recovery and produces error message on the Edit List in Payables Management for Microsoft Dynamics GP:

>Duplicate check numbers are not allowed.
This transaction contains errors. It won't be posted.
>
>Data entry errors exist

## Cause 1

The **Next EFT Payment Number** defined in the Checkbook setup for Payables Options starts with the prefix **REMIT**. It's a problem because REMIT was used in prior versions for EFT and the next number has probably already been used if you start it over at 1. Plus the system still uses the REMIT number for zero-dollar checks for EFT so it could interfere with process. To resolve this issue, see Resolution 1.

## Resolution 1

Change the prefix for the Next EFT Payment Number to start with **EFT** instead of **REMIT** by following these steps:

1. On the **Cards** menu, point to **Financial** and click **Checkbook**.
2. Enter the appropriate checkbook used for EFT.
3. Click the **EFT Bank** button.
4. Click **Payables Options**.
5. In the EFT Payment Numbers section, change the prefix on the number in the **Next EFT Payment Number** field to be **EFT**.
6. Click **OK** twice to exit the windows and click **Save**.

## Cause 2

The user is selecting to sort the checks by NAME in the Print window. (Sorting functionality may be available with third-party products such as Mekorma.) See Resolution 2.

## Resolution 2

Leave the default sort or disable the third-party product. Contact the third party for further assistance with the issue.
