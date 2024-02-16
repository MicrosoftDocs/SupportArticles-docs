---
title: You do not have permission to open this file error when starting Microsoft Dynamics GP
description: Describes various problems that occur if the Dynamics.set file is corrupted or contains an incorrect path of a dictionary file. Resolutions are provided.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/16/2024
---
# "You do not have permission to open this file" error when you try to start Microsoft Dynamics GP

This article provides resolutions for the **You do not have permission to open this file** error that you receive when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 843755

## Symptoms

When you try to start Microsoft Dynamics GP, you receive the following error message:

> You do not have permission to open this file.

## Cause

This problem can have any of the following causes.

- Cause 1

  The Dynamics.set file may be damaged. See Resolution 1.

- Cause 2

  The Dynamics.set file may contain an incorrect path of a dictionary file. See Resolution 2.

- Cause 3

  A dictionary that is referenced in the Dynamics.set file may be marked as read-only. See Resolution 3.

- Cause 4

  A folder where a dictionary file is located may have incorrect permissions settings. The dictionary file is referenced in the Dynamics.set file. See Resolution 4.

## Resolution 1

To resolve this problem, copy the Dynamics.set file from a computer that does not receive the error message.

> [!NOTE]
> when you copy a Dynamics.set file from one computer to another, keep in mind the same products should be listed in each file.

## Resolution 2

To resolve this problem, follow these steps:

1. Locate the Dynamics.set file. By default, this file is located in the installation folder. Depending on which version of Microsoft Dynamics GP you use, the path of the installation folder is as follows:

   - In Microsoft Dynamics GP, the path of the installation folder is C:\Program Files\Microsoft Dynamics\GP.
  
2. Right-click the **Dynamics.set** file, select **Open with**, select **Select the program from a list**, select **OK**, select **Notepad**, and then select **OK**.
3. Verify that all paths that are listed for the dictionary files are correct. Then, make sure that you can open all the listed folders.

## Resolution 3

To resolve this problem, follow these steps:

1. Locate the Dynamics.set file. By default, this file is located in the installation folder. 

    - In Microsoft Dynamics GP, the path of the installation folder is C:\Program Files\Microsoft Dynamics\GP.
   
2. Right-click the **Dynamics.set** file, select **Open with**, select **Select the program from a list**, select **OK**, select **Notepad**, and then select **OK**.
3. Note the locations for all the dictionary files.
4. Verify the properties of each dictionary file. To do this, right-click the file, and then select **Properties**.
5. If a dictionary file is marked as read-only, disable the read-only attribute, and then select **OK**.

## Resolution 4

1. Locate the Dynamics.set file. By default, this file is located in the installation folder. 

    - In Microsoft Dynamics GP, the path of the installation folder is C:\Program Files\Microsoft Dynamics\GP.
   
2. Right-click the **Dynamics.set** file, select **Open with**, select **Select the program from a list**, select **OK**, select **Notepad**, and then select **OK**.
3. Note the locations for all the dictionary files.

4. Verify the permissions to the folders where the dictionary files are located. To verify the permissions, right-click the folder, select **Properties**, and then select the **Security** tab. Make sure that the user or the user group that is receiving the error message has full control.

    > [!NOTE]
    > If the dictionary file is located in a shared folder, verify the permissions on the share. By default, users and groups are given only read permissions. To do this, follow the appropriate steps:
    >
    > - If you use Windows Server:
    >   1. Right-click the folder, select **Properties**, select the **Sharing** tab, and then select **Advanced Sharing**.
    >   2. Select **Permissions**, and then make sure that the user or the user group that is receiving the error message has full control.
    
