---
title: Payables Transaction Integration Manager error Not all required fields have been entered. Required fields appear in bold type
description: Describe the Payables Transaction Integration Manager error - Not all required fields have been entered. Required fields appear in bold type.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Payables Transaction Integration Manager error: Not all required fields have been entered. Required fields appear in bold type

This article describes the **Not all required fields have been entered. Required fields appear in bold type** error that occurs in Payables Transaction Integration Manager.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856157

## Symptoms

When you integrate a Payables Transactions Integration using Integration Manager in Microsoft Dynamics GP, you receive the following error message:

> DOC 1 ERROR: Not all required fields have been entered. Required fields appear in bold type. - Not all required fields have been entered. Required fields appear in bold type.

## Cause

The **Checkbook ID** field is blank in the Payables Management Setup window in Microsoft Dynamics GP.

## Resolution

1. In Microsoft Dynamics GP, click **Purchasing** in the **Navigation** Pane.
2. In **Setup**, click **Payables**.
3. In the Payables Management Setup window, enter or select a Checkbook ID.
4. Click **OK**, and then close the Payables Management Setup window.
5. Run the Payables Transaction Integration in Integration Manager.

## More information

Because you need to save the integrated Payables Management Transactions to a **Batch ID**, and because the **Checkbook ID** is a required field in the Batch Entry window, you need to have the **Checkbook ID** field populated in the Payables Management Setup window in Microsoft Dynamics GP to run a Payables Management Integration without receiving this error message.
