---
title: Save/Delete and Tax Detail ID Lookup buttons is grayed out on VAT Daybook Column Codes window
description: The Save/Delete buttons grayed out and Lookup button for Tax Detail ID is grayed out on the VAT Daybook Column Codes window in Microsoft Dynamics GP. This article provides a solution to this issue.
ms.topic: troubleshooting
ms.reviewer: theley, cwaswick
ms.date: 03/20/2024
ms.custom: sap:Europe, Latin America, Africa, Asia, and Australia
---
# The Save/Delete buttons and Tax Detail ID Lookup button is grayed out on VAT Daybook Column Codes window in Microsoft Dynamics GP

This article provides a solution to an issue where the **Save**/**Delete** buttons and **Lookup** button for Tax Detail ID is grayed out on the **VAT Daybook Column Codes** window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2901810

## Symptoms

The **Save**/**Delete** buttons are grayed out, the **Lookup** button for the **Tax Detail ID** column is grayed out, and the **Edit** - **Insert Row**/**Delete Row** menu options do not function on the **VAT Daybook Column Codes** window in Microsoft Dynamics GP, so the user is not able to make changes to a VAT Daybook report ID.

## Cause

Once the VAT Report ID has been printed on an Audit Report, the report details are locked down. This is by design and the system does not allow the report to be modified after it has been printed on an Audit Report.

## Resolution

The supported method would be to create a new VAT Report ID and re-add the tax details (or use the Copy feature [**Copy** button] from the **VAT Daybook Reports** window and copy your existing report ID. At least this feature will copy the existing tax details over to a new report and allow you to make modifications to it).
