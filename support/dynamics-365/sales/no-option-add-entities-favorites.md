---
title: No option to add entities to favorites
description: This article provides a workaround for the problem that occurs when you are using Microsoft Dynamics CRM Client for Outlook with Microsoft Office Outlook 2010.
ms.reviewer: chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# There is no option to add Microsoft Dynamics CRM entities to favorites in Microsoft Office Outlook 2010

This article helps you resolve the problem that occurs when you are using Microsoft Dynamics CRM Client for Outlook with Microsoft Office Outlook 2010.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2494600

## Symptoms

There is no option available to add the Microsoft Dynamics CRM entities to the Microsoft Outlook favorites when you are using Microsoft Dynamics CRM Client for Outlook with Microsoft Office Outlook 2010.

> [!IMPORTANT]
> This article contains information about how to change the registry. Make sure that you back up the registry before you change it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and change the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

## Cause

This is the result of a limitation in the Solution Module in Outlook.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require you to reinstall the operating system. Microsoft cannot guarantee that these problems can be resolved. Change the registry at your own risk.

To work around this limitation, you can disable the Solutions Module in Outlook. To do this, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
1. Locate `HKEY_CURRENT_USER\Software\Microsoft\MSCRMClient`.
1. Right-click **MSCRMClient**, point to **New**, and then select **DWORD (32-bit) Value**.
1. Enter **DisableSolutionsModule** as the **name**.
1. Right-click the **DisableSolutionsModule REG_DWORD** subkey, select **Modify**, and then set the **value** to **1**.
1. Exit and then restart Outlook.
