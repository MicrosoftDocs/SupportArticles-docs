---
title: Name of redirected folder isn't user name
description: Describes a behavior that occurs after you redirect the Documents folder of a Windows Vista-based or Windows 7-based computer to a network share. Describes how to work around this behavior.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# When you redirect the Documents folder on a Windows Vista-based or Windows 7-based computer to a network share, the folder name unexpectedly changes back to Documents

This article provides workaround for the issue where the folder name unexpectedly changes back to Documents when you redirect the Documents folder to a network share.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 947222

## Symptoms

When you redirect the Documents folder on a Windows Vista-based or Windows 7-based computer to a network share, the folder name unexpectedly changes back to Documents. You expect the folder name to be the user name.

This behavior may create many Documents folders on the network share. If you try to rename one Documents folder, all the other Documents folders change to that name.

## Workaround

To work around this behavior, use one of the following methods.

### Method 1

Create a subfolder under the redirected folder in the Universal Naming Convention (UNC) path. For example, use the following UNC path:\\\\**server**\\**users**\\**username**\\Documents.

### Method 2

Grant the user exclusive rights to the redirected folder. To do this, follow these steps:  

1. Log on to the computer by using domain administrator credentials.
2. In the **Start Search** box, type gpmc.msc, right-click **gpmc.msc**, and then click **Run as administrator**.

    > [!NOTE]
    > If you are prompted for an administrator password, type the password. If you are prompted for confirmation, provide confirmation.
3. Right-click the **Group Policy Objects** node, and then click **New**. Type the name of the policy. For example, in the **New GPO** dialog box, type Windows Vista Folder Redirection Policy.
4. Right-click the Group Policy object that you created in step 3, and then click **Edit**.
5. Under **User Configuration**, expand **Windows Settings**, and then expand **Folder Redirection**.
6. Right-click the **Documents** folder, and then click **Properties**.
7. On the **Target** tab, configure the following:
   - In the **Setting** box, click **Basic-redirect everyone's folder to the same location**.
   - In the **Target Folder Location** box, click **Create a folder for each user under the root path**.
   - In the **Root Path** box, type the UNC file path to which you want to redirect the Documents folder.
8. In the **Documents Properties** dialog box, click the **Settings** tab, and then configure the following:
   - Click to select the **Grant the user exclusive rights to Documents** check box.
   - Click to select the **Move the contents of Documents to the new location** check box.
9. Click **OK**.

### Method 3

Do not grant the Read permission to the administrator for the Desktop.ini files on the server. To do this, follow these steps:

> [!NOTE]
> If more than one Desktop.ini file exists, follow these steps for all the Desktop.ini files.

1. Right-click the **Desktop.ini** file, click **Properties**, and then click the **Security** tab.
2. In the **Group or user names** pane, click **Administrators**.
3. Click to select the **Deny** check box for the **Read** permission.
4. Click **OK**.

> [!NOTE]
> Method 2 works only for new users. To update the names of the existing folders on the server, we recommend that you use Method 3.

## Status

This behavior is by design.  

## More information

### Steps to reproduce the behavior

1. Right-click the **Documents** folder, and then click **Properties**.
2. Under the **Location** tab, enter the UNC path of the network share to which you want to redirect the folder.

For example, enter a UNC path that resembles the following:\\\\**server**\\**users**\\**username**  

After you do this, the name of the Documents folder is supposed to change to the user name.
