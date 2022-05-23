---
title: Delete a user profile in Windows
description: Describes steps to delete a user profile in Windows.
ms.date: 05/23/2022
author: kaushika-msft
ms.author: kaushika
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

_Applies to:_ &nbsp; Windows Server; Windows Client  
_Original KB number:_ &nbsp; 2462308

The following methods instruct on how to delete a user's profile on a Windows-based device.

> [!NOTE]
>
> - To perform these methods, you must be a member of the Administrators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure.

## Using Control Panel

1. Select Windows Search and type in **Control Panel**.
2. From the control panel, select the **User Accounts** option.
3. Select on the **Remove user accounts** link on the next page.
4. Now, you need to **select the account** that you want to delete.
5. On the next screen, select **Delete account** link.
6. If you are asked whether you want to keep the files saved by the user. Select on the **Delete files** button if you don’t want the files.

## Using User Accounts Interface
1. Press the Windows Key + R button to open the RUN dialog box. On the RUN dialog box, type in **netplwiz** and hit the **Enter** button.
2. On the User Accounts interface, select the **Users** tab and **select the account** you want to remove.
3. Select the **Remove** button.
4. On the confirmation prompt, select the **Yes** button.

## Using Registry Editor (for advanced users only)
1. Open the **File Explorer** in your computer and then go to the folder of **C:\Users**.
2. Find the profile folder of the user account which you want to delete, and then select **Delete** from the context menu to remove it.
3. Press the Windows Key + R button to open the RUN dialog box. On the RUN dialog box, type in **regedit** and hit the **Enter** button. 
4. In the Registry Editor, navigate to the **ProfileList** key of the following path:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList`

5. From the left panel, go through the subkeys under the registry of **ProfileList** until you find the value data of the **ProfileImagePath** string value for the user account that you want to delete. Then select it and **Delete** to remove it.
6. Select the **Yes** button to confirm delete it.

**Note:** The account will be re-created using defaults the next time the user signs in.
