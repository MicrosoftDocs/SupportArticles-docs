---
title: You do not have permission to open this file error when starting Microsoft Dynamics GP
description: Describes various problems that occur if the Dynamics.set file is corrupted or contains an incorrect path of a dictionary file. Resolutions are provided.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/19/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "You do not have permission to open this file" error when you try to start Microsoft Dynamics GP

This article provides resolutions for the "You do not have permission to open this file" error that you receive when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 843755

## Symptoms

When you try to start Microsoft Dynamics GP, you receive the following error message:

> You do not have permission to open this file.

## Cause 1

The _Dynamics.set_ file may be damaged.

#### Resolution

To resolve this problem, copy the _Dynamics.set file_ from a computer that does not receive the error message.

> [!NOTE]
> When you copy a _Dynamics.set_ file from one computer to another, keep in mind the same products should be listed in each file.

## Cause 2

The _Dynamics.set_ file may contain an incorrect path of a dictionary file.

#### Resolution 

To resolve this problem, follow these steps:

1. Locate the _Dynamics.set_ file. By default, this file is located in the installation folder.

   In Microsoft Dynamics GP, the path of the installation folder is _C:\Program Files\Microsoft Dynamics\GP_.

3. Right-click the _Dynamics.set_ file, select **Open with** > **Select the program from a list** > **OK** > **Notepad**, and then select **OK**.
4. Verify that all paths that are listed for the dictionary files are correct. Then, make sure that you can open all the listed folders. 

## Cause 3

A dictionary that is referenced in the _Dynamics.set_ file may be marked as read-only.

#### Resolution

To resolve this problem, follow these steps:

1. Locate the _Dynamics.set_ file. By default, this file is located in the installation folder. 

   In Microsoft Dynamics GP, the path of the installation folder is _C:\Program Files\Microsoft Dynamics\GP_.
   
2. Right-click the _Dynamics.set_ file, select **Open with** > **Select the program from a list** > **OK** > **Notepad**, and then select **OK**.
3. Note the locations for all the dictionary files.
4. Verify the properties of each dictionary file. To do this, right-click the file, and then select **Properties**.
5. If a dictionary file is marked as read-only, disable the read-only attribute, and then select **OK**.

## Cause 4

A folder where a dictionary file is located may have incorrect permissions settings. The dictionary file is referenced in the _Dynamics.set_ file. 

#### Resolution

1. Locate the _Dynamics.set_ file. By default, this file is located in the installation folder. 

   In Microsoft Dynamics GP, the path of the installation folder is _C:\Program Files\Microsoft Dynamics\GP_.
   
2. Right-click the _Dynamics.set_ file, select **Open with** > **Select the program from a list** > **OK** > **Notepad**, and then select **OK**.
3. Note the locations for all the dictionary files.

4. Verify the permissions to the folders where the dictionary files are located. To verify the permissions, right-click the folder, select **Properties**, and then select the **Security** tab. Make sure that the user or the user group that is receiving the error message has full control.

    > [!NOTE]
    > If the dictionary file is located in a shared folder, verify the permissions to the share folder where the dictionary file is located. By default, users and groups are given only read permissions. To do this, follow the appropriate steps:
    >
    > - If you use Windows Server:
    >   1. Right-click the folder, select **Properties**, select the **Sharing** tab, and then select **Advanced Sharing**.
    >   2. Select **Permissions**, and then make sure that the user or the user group that is receiving the error message has full control.
    
