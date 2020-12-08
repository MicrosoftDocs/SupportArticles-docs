---
title: FIX: Identify a Damaged User Profile and Create a New Profile in Windows 2003
description: 
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# FIX: Identify a Damaged User Profile and Create a New Profile in Windows 2003

For a Microsoft Windows 2000 version of this article, see
 [305506](/EN-US/help/305506).  

_Original product version:_ &nbsp; Microsoft Windows Server 2003 Datacenter Edition (32-bit x86), Microsoft Windows Server 2003 Enterprise Edition (32-bit x86), Microsoft Windows Server 2003 Standard Edition (32-bit x86), Microsoft Windows Server 2003 Web Edition, Microsoft Windows Server 2003 Enterprise x64 Edition  
_Original KB number:_ &nbsp; 816593

### IN THIS TASK


- [Summary](#Summary) 
  - [Identify a Damaged Profile](#Identify-a-Damaged-Profile) 
  - [Delete and Re-create a Profile](#Delete-and-Re-create-a-Profile) 

### Summary

This article describes how to determine whether a user profile is damaged and how to create a new profile if the profile is damaged.
User profiles automatically create and maintain the desktop settings for each user's work environment on the local computer. A user profile is created for each user when the user logs on to a computer for the first time.

[back to the top](#toc) 

### Identify a Damaged Profile

To determine whether a user account has a damaged user profile, follow these steps:

1. Create a new user account. Give it the same rights and group memberships or associations as the account that has the profile that you suspect may be damaged.
2. Copy the user settings in the suspect profile to the profile of the newly created user account. To do this, follow these steps:

1. Click **Start**, point to **Control Panel**, and then click **System**.
  2. Click **Advanced**, and then under
 **User Profiles**, click **Settings**.
  3. Under **Profiles stored on this computer**, click the suspect user profile, and then click **Copy To**.
  4. In the **Copy To** dialog box, click
 **Browse**.
  5. Locate the **drive** :\Documents and Settings\ **user_profile** folder, where
 **drive** is the drive where Windows is installed, and where **user_profile** is the name of the newly created user profile, and then click **OK**.
  6. Click **OK**, click **Yes** to overwrite the folder contents, and then click **OK** two times.
3. Use the newly-created user account to log on. If you experience the same errors that led you to question the suspect user profile, the user profile is damaged. If you do not experience any errors, it is the user account that is damaged.

[back to the top](#toc) 

### Delete and Re-create a Profile

If the user profile is damaged, you must delete the profile, and then create a new profile for that user. To do this, follow these steps:
1. Use an administrator account to log on to the computer that contains the damaged user profile.
2. Open Control Panel, and then select System .
3. Click the **Advanced** tab, and in the **User Profiles** area, click **Settings**.

4. In the **Profiles stored on this computer** list, select the appropriate user profile, and then click **Delete**.

5. When you are prompted, click **Yes**.

6. Log off with the administrator account.

7. Use the account that had the damaged user profile to log on. A new user profile is created for the user.
 [back to the top](#toc)
