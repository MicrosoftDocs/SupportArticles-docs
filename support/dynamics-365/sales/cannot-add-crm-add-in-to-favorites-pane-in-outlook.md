---
title: Cannot add CRM add-in to the Favorites pane in Outlook 2010
description: You cannot add Microsoft Dynamics CRM entities to the Microsoft Outlook favorites. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Cannot add Microsoft Dynamics CRM add-in to the Favorites pane in Outlook 2010

This article provides a resolution for the issue that you can't add Microsoft Dynamics CRM add-in to the Favorites pane in Microsoft Outlook 2010.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2676948

## Symptoms

A user is unable to add Microsoft Dynamics CRM entities to the Microsoft Outlook favorites when using Microsoft Dynamics CRM Client for Outlook with Microsoft Outlook 2010.

## Cause

Solutions Module in Outlook 2010 prevents Microsoft Dynamics CRM folders from being added to the favorites section.

## Resolution

To fix this issue, follow these steps:

1. Close Outlook.
2. Select **Start**, select **Run**, type *regedit*, and then select **OK**.
3. Locate `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient`.
4. Right-click MSCRMClient, point to **New**, and then select DWORD (32-bit) Value.
5. Enter *DisableSolutionsModule* as the name.
6. Right-click the `DisableSolutionsModule` REG_DWORD subkey, select **Modify**, and then set the value to **1**.
7. Run the Outlook.exe file as admin.
8. C:\Program Files (x86)\Microsoft Office\Office14\Outlook.exe.
9. Right-click the Outlook.exe file and run as administrator.
10. Now try to add the Microsoft Dynamics CRM add-in under the favorites in Outlook 2010.
