---
title: Error when you select a document
description: This article provides a resolution for a problem that occurs when you try to select a document in the Sales Transaction Entry window.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Receivables Management
---
# Error message when you try to select a document in the Sales Transaction Entry window in Microsoft Dynamics GP (This document is being edited by another user)

This article helps you resolve the problem that occurs when you try to select a document in the Sales Transaction Entry window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866440

## Introduction

This article describes a problem that occurs when you try to select a document in the Sales Transaction Entry window. This article also provides possible causes of the problem and a resolution.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Symptoms

When you try to select a document in the Sales Transaction Entry window in Microsoft Dynamics GP, you receive the following error message:

This document is being edited by another user.

## Cause

This problem can occur for many reasons. This includes but is not limited to the following causes:

- One user is trying to access a document from the Sales Transaction Entry window while another user is editing the same document.
- A posting was interrupted. The interruption caused records to be damaged or locked.

## Resolution

- Step 1: Have all users exit Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains

- Step 2: Delete the records

   To have us clear the stuck records for you, follow these steps:

    You must have all users exit out of Microsoft Dynamics GP before running the SQL Scripts.
    To clear stuck records yourself, run the following statements in a Microsoft SQL Query tool:

    ```sql
    DELETE DYNAMICS..ACTIVITY
    DELETE DYNAMICS..SY00800
    DELETE DYNAMICS..SY00801
    DELETE TEMPDB..DEX_LOCK
    DELETE TEMPDB..DEX_SESSION
    ```
