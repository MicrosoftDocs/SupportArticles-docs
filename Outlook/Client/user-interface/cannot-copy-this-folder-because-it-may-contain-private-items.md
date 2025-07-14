---
title: '"Cannot Copy This Folder Because It May Contain Private Items" Error'
description: Fixes the "Cannot copy this folder because it may contain private items" error in Outlook.
author: cloud-writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Outlook for Microsoft 365
ms.date: 07/14/2025
---
# "Cannot copy this folder because it may contain private items" error in Outlook

_Original KB number:_ &nbsp; 3205975

## Symptoms

Consider the following scenario:

- In Microsoft Outlook, you have a shared mailbox open.
- You try to move a folder from the shared mailbox into your own mailbox.
- The folder that you're trying to move contains one or more subfolders.

In this scenario, you receive the following error message:

> Cannot move the items. Cannot copy this folder because it may contain private items.

## Cause

This behavior is by design when there are one or more folders under the folder that you're trying to move.

## Workaround

To work around this behavior, use one of the following methods.

### Method 1: Create the folder structure in your mailbox, and then move the items from the shared mailbox into the new folder structure in your mailbox

1. In your mailbox, replicate the folder structure of the folders that you want to move from the shared mailbox. You can do this by creating a new folder and then creating any other folders under this folder. To do this, follow these steps:

    1. Right-click the folder in your mailbox under which you want to create the new folder, and then select **New Folder**.

        For example, if you want to create the new folder in the **Inbox**, right-click Inbox. If you want to create the new folder under your main mailbox, right-click the top-level folder. This is displayed as your email address.

    1. Type the preferred name for the folder. This folder name will likely be the same as the original folder in the shared mailbox name. However, it can be a different name if you prefer.

    1. Right-click the new folder that you created, and then select **New Folder**. Enter a name for this folder.

    1. Repeat step 1C for any other folders that you must create to replicate the original folder structure.

1. Move items from the original folders in the shared mailbox to the new folders that you created in step 1:

    1. In the shared mailbox, select the folder that you want to move.

    1. Press <kbd>CTRL</kbd>+<kbd>A</kbd> to select all the items in the folder.

    1. On the **Home** tab on the ribbon, select **Move**, and then select **Other Folder**.

    1. Select the folder that you created in step 1, and then select **OK**.

    1. Repeat steps 2A through 2D for the other folders under this folder.

### Method 2: Export the folder that you want to move to a .pst file, and then import it into your own mailbox

1. Export the folder from the shared mailbox to a **.pst** file:

    1. In Outlook, select the folder in the shared mailbox that you want to move.

    1. Open the Import and Export Wizard. To do this, follow the step for your version of Outlook:

        - Outlook 2013 and later versions: Select **File**, and then select **Open & Export**. Select **Import/Export**.

        - Outlook 2010: Select **File**, and then select **Options**. Select **Advanced**, and then select **Export**.

    1. Select **Export to a file**, and then select **Next**.

    1. Select **Outlook Data File (.pst)**, and then select **Next**.

    1. Make sure that the folder in the shared mailbox that you want to move is selected, enable **Include subfolders**, and then select **Next**.

    1. Select **Browse**.

    1. Browse to a location where you want to save the **.pst** file, enter a file name, and then select **OK**.

    1. Select **Finish**.

1. Import the **.pst** file to your mailbox:

    1. Open the Import and Export Wizard. To do this, follow the step for your version of Outlook:

        - Outlook 2013 and later versions: Select **File**, and then select **Open & Export**. Select **Import/Export**.

        - Outlook 2010: Select **File**, and then select **Options**. Select **Advanced**, and then select **Export**.

    1. Select **Import from another program or file**, and then select **Next**.

    1. Select **Outlook Data File (.pst)**, and then select **Next**.

    1. Select **Browse**.

    1. Browse to and select the **.pst** file that you created in step 1, and then select **Open**.

    1. Select **Next**.

    1. Select **Import items into the same folder in:**, and then select your mailbox from the drop-down list.

    1. Select **Finish**.

### Method 3: Set yourself as a Delegate of the shared mailbox, and assign Owner permissions to the folders

> [!IMPORTANT]
> When you set yourself as a delegate of the mailbox, you're also setting other permissions that you may not require. For example, delegates can send email, and receive and respond to meeting requests on the manager's behalf. If you don't require these permissions for the shared mailbox, use one of the other methods to work around this behavior or remove yourself as the shared mailboxes delegate after you have successfully moved the folder. For more information about delegate access, see the following article:

[Allow someone else to manage your mail and calendar](https://support.microsoft.com/office/41c40c04-3bd1-4d22-963a-28eafec25926)

Sign in to the shared mailbox in Outlook, and provide delegate permissions to yourself:

1. Sign in to Outlook as the shared mailbox.

1. Select **File**, select **Account Settings**, and then select **Delegate Access**.

1. Select **Add**.

1. Type your name, or search for and then select your name in the search results list.

1. Select **Add**, and then select **OK**.

1. In the **Delegate Permissions** dialog box, select **Editor** permissions for the **Inbox**, and then select any other custom access levels that you prefer.

1. Enable the **Delegate can see my private items** option, and then select **OK**.

1. Right-click the top-level folder, and then select **Folder Permissions**. The top-level folder is displayed as the shared mailbox email address.

1. If you aren't listed on the **Permissions** tab, add your name. To do this, follow these steps:

    1. Select **Add**.

    1. Select your name from the list, or search for and select your name from the search results.

    1. Select **Add**, and then select **OK**.

1. Select your name, and then select **Owner** for the **Permission Level**.

1. Select **OK**.

1. Right-click the folder that you want to move, and then select **Properties**.

1. On the **Permissions** tab, if you aren't listed, add your name. To do this, follow these steps:

    1. Select **Add**.

    1. Select your name from the list, or search for and select your name from the search results.

    1. Select **Add**, and then select **OK**.

1. Select your name, and then select **Owner** for the **Permission Level**.

1. Select **OK**.
