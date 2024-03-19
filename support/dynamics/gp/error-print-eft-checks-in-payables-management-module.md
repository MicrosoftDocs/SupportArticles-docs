---
title: Error when you print EFT checks in the Payables Management module in Microsoft Dynamics GP
description: Describes an error that occurs when you print EFT checks in the Payables Management module in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error when you print EFT checks in the Payables Management module in Microsoft Dynamics GP: "Please set up security for the alternate check form to print EFTs with checks"

This article helps fix an issue where you can't print Electronic Funds Transfer (EFT) checks in Payables Management.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850765

## Symptoms

When you print EFT checks in Payables Management in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:

> Please set up security for the alternate check form to print EFTs with checks.

## Cause

This issue occurs when security is incorrectly set up for the alternate report of EFT for Payables Management.

## Resolution

To resolve this issue in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, follow these steps:

1. On the **Tools** menu, point to **Setup**, and then click **Security** to open the Security Setup window.
    > [!NOTE]
    > If you're prompted to use advanced security, click **No**.
1. Set the values for the fields in the Security Setup window as follows:
    - **User ID**: User ID that you want
    - **Company**: Company that you want
    - **Product**: EFT for Payables Management
    - **Type**: Reports
    - **Series**: Purchasing
1. Click **Mark All** > **OK**.
1. Print an EFT check to test the solution.
