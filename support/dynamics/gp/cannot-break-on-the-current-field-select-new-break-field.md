---
title: Cannot break on the current field. Select new break field error 
description: Describes a problem that occurs because a break field is not selected. Explains how to resolve the problem.
ms.reviewer: theley, ryanklev
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Bank Reconciliation
---
# "Cannot break on the current field. Select new break field" error when viewing the dist total additional footer in Report Writer

This article provides a resolution for the issue that you receive an error message when you try to view the dist total additional footer in Report Writer in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 905638

## Symptoms

When you try to view the **dist total** additional footer of the Bank Transaction Posting Journal, you receive the following error message:

> Cannot break on the current field. Select new break field.

This problem occurs in Report Writer in Microsoft Dynamics GP.

## Cause

This problem occurs because a break field is not selected.

## Resolution

To resolve this problem, follow these steps:

1. When you receive the error message, select **OK**.
2. In the **Footer Options** dialog box, select the field on which you want to break in the **Field** list.
3. Select **OK** to close the **Footer Options** dialog box.
4. Select **OK** to close the **Report Section Options** dialog box.

> [!NOTE]
> You may also want to change the **Transaction** additional header to break on the field that you selected in step 2 so that the header is printed every time that the footer changes.

## Steps to reproduce the problem

1. On the **Tools** menu, point to **Customize**, and then select **Report Writer**.
2. In the **Product** list, select **Microsoft Dynamics GP**, and then select **OK**.
3. Select **Reports**.
4. In the **Original Reports** list, select **Bank Transaction Posting Journal**, and then select **Insert**.
5. In the **Modified Reports** list, select **Bank Transaction Posting Journal**, and then select **Open**.
6. Select **Layout**.
7. On the **Tools** menu, select **Section Options**.
8. In the **Additional Footers** area, select **dist total**, and then select **Open**.
