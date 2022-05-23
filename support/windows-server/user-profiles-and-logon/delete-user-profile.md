---
title: Delete a user profile in Windows
description: Describes steps to delete a user profile in Windows.
ms.date: 05/23/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-profiles, csstroubleshoot
ms.technology: windows-server-user-profiles
---
# Delete a user profile in Windows

The following methods instruct on how to delete a user's profile on a Windows-based device.

> [!NOTE]
> To perform these methods, you must be a member of the Administrators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure.

_Applies to:_ &nbsp; Windows Server; Windows Client  
_Original KB number:_ &nbsp; 2462308

## Using Control Panel

1. Select **Start**, search for _Control Panel_, and then select **Control Panel** in the result.
2. Select **Category** in **View by:**, and then select **User Accounts**.
3. Select the **Remove user accounts** link.
4. Select the account that you want to delete.
5. On the next screen, select the **Delete the account** link.
6. If you are asked whether you want to keep the files saved by the user, select the **Delete files** button if you don't want the files.

## Using User Accounts Interface

1. Press the Windows Key + R button to open the Run dialog box. In the Run dialog box, type _netplwiz_ and press Enter.
2. On the User Accounts interface, select the **Users** tab and select the account that you want to remove.
3. Select the **Remove** button.
4. On the confirmation prompt, select the **Yes** button.

## Using Registry Editor (for advanced users only)

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

1. Ensure the user account that you want to remove is signed out.
2. Open the **File Explorer** on your computer, and then go to the folder of **C:\Users**.
3. Find the profile folder of the user account that you want to delete, right click the folder, and then select **Delete** to delete it.
4. Press the Windows Key + R button to open the Run dialog box. In the Run dialog box, type _regedit_ and press Enter.
5. In the Registry Editor, navigate to the following key:  
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList`

6. From the left panel, go through each subkeys under the **ProfileList** key. Find the subkey in which the **ProfileImagePath** value matches the path of the profile folder that you just deleted. Then, right click the subkey and select **Delete**.
7. Select the **Yes** button to confirm.

> [!NOTE]
> The user account will be re-created by using defaults at the next time when the user signs in.
