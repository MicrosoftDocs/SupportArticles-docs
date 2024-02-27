---
title: Items that are deleted from a shared mailbox go to the wrong folder in Outlook
description: Deleting items from a shared mailbox  go to your own Deleted Items instead of the mailbox owner's.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - MET150
ms.custom: 
  - Outlook for Windows
  - CI 148804
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
ms.date: 01/30/2024
---

# Items that are deleted from a shared mailbox go to the wrong folder in Outlook

## Summary

When you use Microsoft Outlook to delete items from a mailbox folder of another user for whom you have deletion privileges, the deleted items go to your own Deleted Items folder instead of the Deleted Items folder of the mailbox owner.

## More information

> **Warning:** Serious problems might occur if you modify the registry incorrectly. These problems could cause you to have to reinstall the operating system or even prevent your computer from starting. Microsoft can't guarantee that these problems can be solved. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur. Modify the registry at your own risk.

### Switch the destination of deleted items

Outlook provides a Windows registry setting that you can use to switch the destination of deleted items to the mailbox owner's Deleted Items folder.

To change this registry setting, follow these steps:

1. Exit Outlook.

1. Start Registry Editor. To do this, use one of the following methods, as appropriate for your version of Windows:

    - Windows 10 and Windows 8.1: Press Windows logo key+R to open a **Run** dialog box. Type *regedit.exe*, and then press OK.

    - Windows 7: Select **Start**, type *regedit.exe* in the search box, and then press Enter.

1. Locate the following registry subkey:

    **HKEY_CURRENT_USER\Software\Microsoft\Office\\<x.0>\Outlook\Options\General**

    **Note:** The *<x.0>* placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Microsoft 365, 15.0 = Office 2013).

1. Right-click the *DelegateWastebasketStyle* value, and then select **Modify**.

    If this registry value is not present, follow these steps to create it:

    1. Right-click the *General* folder in the path that's defined in step 3.

    1. Point to **New**, and then select **DWORD Value**.

    1. Type *DelegateWastebasketStyle*, and then press Enter.

1. Change the value data in the *Edit DWORD Value* dialog box to one of the following values:

    - 8 = Stores deleted items in your folder.

    - 4 = Stores deleted items in the mailbox owner's folder.

        **Note:** Make sure that the delegate user has at least Author-level permissions for the Deleted Items folder of the owner's mailbox. If the delegate does not have these permissions, and this registry option is set to **4**, then either the item is deleted permanently or the user receives one of the following error messages:

    - The item could not be deleted, it was either moved or already deleted, or access was denied.

    - Operation Failed.

    - Some items cannot be deleted. They were either moved or already deleted, or access was denied.
    - Could not complete the deletion. The items may have been already deleted or moved.

1. Exit Registry Editor.

1. Restart Outlook.

### Determine whether DelegateWasteBasketStyle was applied by using Group Policy

If this registry value has no effect, an administrator might have applied the setting by using a Group Policy setting. Group Policy registry values override settings that are configured in the user settings section of the registry.

If you determine that the "DelegateWasteBasketStyle" value exists in the following registry subkey, it's likely because Group Policy settings are used in your organization:

**HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\\<x.0>\Outlook\Options\General**

**Note** The *<x.0>* placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Microsoft 365, 15.0 = Office 2013).

To review Group Policy settings that apply to your user or computer account, contact your Active Directory administrator.

Did this fix the problem? If the problem isn't fixed, contact [Microsoft Support](https://support.microsoft.com/contactus).