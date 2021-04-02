---
title: The Outlook ribbon disappears
description: The Outlook ribbon disappears after you use the Microsoft Dynamics CRM Client for Microsoft Office Outlook.
ms.reviewer: chanson, henningp
ms.topic: troubleshooting
ms.date: 
---
# The Outlook ribbon disappears from Outlook when you use the Microsoft Dynamics CRM Client for Outlook

This article helps you fix an issue in which the Outlook ribbon disappears after you use the Microsoft Dynamics CRM Client for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2494581

## Symptoms

After you install the Microsoft Dynamics CRM Client for Microsoft Office Outlook and then locate the Microsoft Dynamics CRM folders in Microsoft Office Outlook, the Outlook and CRM ribbons disappear. Additionally, the Office Outlook ribbon doesn't reappear unless you disable Microsoft Dynamics CRM.

## Cause

This behavior may occur because of registry keys that are left over from an earlier version of Microsoft Outlook.

## Resolution

> [!IMPORTANT]
> This article contains information about how to change the registry. Make sure that you back up the registry before you change it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and change the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Exit Outlook.
2. Click **Start**, click **Run**, type `regedit`, and then click **OK**.
3. Locate the following registry subkey:

    `HKEY_CLASSES_ROOT\TypeLib\{2DF8D04C-5BFA-101B-BDE5-00AA0044DE52}`

4. In this location, you may find folders corresponding to the Office releases below:

    - 2.4 for Office 2007 (Version 12.0.0.0)
    - 2.5 for Office 2010 (Version 14.0.0.0)
    - 2.6 and 2.7 for Office 2013 (Version 15.0.0.0) (2.6 and 2.7 are okay for Office 2016 as well, if there is a reference to Office16 under 2.7.)
    - 2.8 for Office 2016 (Version 16.0.0.0)

5. Right-click the registry key for the incorrect version of Office, and then select **Export**. Save the export to your desktop to create a backup.
6. Right-click on key for the incorrect version of Office, select **Delete**.
7. Start Outlook.
