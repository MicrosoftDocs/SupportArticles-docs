---
title: A get or change next operation on table GL_Account_MSTR is for an invalid key error
description: Error occurs when using the scroll buttons in the GL Summary Inquiry window or other GL reports in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# "A get/change next operation on table 'GL_Account_MSTR' is for an invalid key" message when scrolling in GL reports

This article provides a resolution for the issue that you can't use the scroll buttons in the GL Summary Inquiry window or other GL reports in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3091328

## Symptoms

The message below appears when using the scroll buttons in the GL Summary Inquiry window or other GL reports in Microsoft Dynamics GP:

> A get/change next operation on table 'GL_Account_MSTR' is for an invalid key.

## Cause

Invalid key on GL00105 account index master table.

## Resolution

Use the steps from the following article to rebuild the GL00105 table:

[How to re-create the Account Index Master table (GL00105) in Microsoft Dynamics GP](https://support.microsoft.com/topic/how-to-re-create-the-account-index-master-table-gl00105-in-microsoft-dynamics-gp-8a6bc0d9-cc0f-8d34-2be0-4138ccc1aec5)
