---
title: Create security-enhanced redirected folder
description: Describes how to dynamically create security-enhanced redirected folders or home folders.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, CCLAY
ms.custom: sap:user-profiles, csstroubleshoot
---
# How to dynamically create security-enhanced redirected folders or home folders  

This article describes how to dynamically create security-enhanced redirected folders or home folders.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 274443

## Summary

In Microsoft Windows Server Active Directory, as an administrator, you can customize desktops by using Folder Redirection or assign a server-based home folder. Additionally, you can redirect the following folders by using Active Directory and Group Policy:

- Application Data
- Desktop
- My Documents
- My Documents/My Pictures
- Start Menu

You can find more information about Folder Redirection by searching Windows Help for Folder Redirection.

When you redirect folders to a shared location on a network, you need both read and write access to this location so that you can read the contents of these folders. However, in some scenarios, you may not want to grant read access to other users.

## Create security-enhanced redirected folders

To make sure that only the user and the domain administrators have permissions to open a particular redirected folder, do the following steps:

1. Select a central location in your environment where you would like to store Folder Redirection, and then share this folder. In this example, FLDREDIR, and HOMEDIR are used.
2. Set **Share Permissions** for the Everyone group to **Full Control**.
3. Use the following settings for NTFS Permissions:
   - CREATOR OWNER - Full Control (Apply onto: Subfolders and Files Only)
   - System - Full Control (Apply onto: This Folder, Subfolders, and Files)
   - Domain Admins - Full Control (Apply onto: This Folder, Subfolders, and Files)
   - Everyone - Create Folder/Append Data (Apply onto: This Folder Only)
   - Everyone - List Folder/Read Data (Apply onto: This Folder Only)
   - Everyone - Read Attributes (Apply onto: This Folder Only)
   - Everyone - Traverse Folder/Execute File (Apply onto: This Folder Only)

4. Configure Folder Redirection Policy as outlined in Windows Help. Use a path similar to `\\server\FLDREDIR\%username%` to create a folder under the shared folder, FLDREDIR.

    You can also configure a home folder "HOMEDIR" in a similar manner by copying a template user with a home folder like `\\server\HOMEDIR\%username%`, or create the user and folder with that name.

    > [!NOTE]
    > For home folders, the scenario isn't common, because when you add the home folder for a user, Active Directory Users and Computers will create the folder. But if you use a custom provisioning, Active Directory Users and Computers doesn't create the folder. Therefore, you have to do it by yourself.  

## Why these permissions help improve the security of the share folders

Because the Everyone group has the Create Folder/Append Data right, the group members have the proper permissions to create the folder; however, the members aren't able to read the data afterwards. The Username group is the name of the user that was logged on when you created the folder. Because the folder is a child of the parent folder, it inherits the permissions that you assigned to FLDREDIR. Also, because the user is creating the folder, the user gains full control of the folder because of the **Creator Owner Permission** setting.

## More information

The article was initially written for Windows Server 2003, and the access control entry (ACE) for CreatorOwner was likely converted to:  
*\<Folder-User> - Full Control (Apply onto: This Folder, Subfolders, and Files)*

But there's no proof that this has happened. The earlier versions of the article don't mention the result of the access control list (ACL), and the versions of the operating systems that this article was written for aren't supported any longer.

By the end of May 2017, all supported operating systems converted the ACE to:  
*\<Folder-User> - Full Control (Apply onto: This Object only)*

But this doesn't affect the daily operations of the folders for the users. It makes a difference when the administrator has to work on the contents of the home folders or redirected folders.

If you want to make sure that the user gets the inheritable full control on all child objects, you've to:

1. Create the folder matching for the users samaccountname by yourself.
2. Set the permissions that are needed for the folder, omit the Everyone ACEs above, and make sure that you have the ACE:

    *\<Folder-User> - Full Control (Apply onto: This Folder, Subfolders, and Files)*

## References

For more information, see [Folder Redirection Overview](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732275(v=ws.11)).
