---
title: Attachments remain in the Outlook Secure Temporary File folder when you exit Outlook 2010, Outlook 2007, or Outlook 2003
description: Describes a problem that occurs because Outlook cannot remove the attachments while they are open.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Office Outlook 2003
- Microsoft Office Outlook 2007 
- Microsoft Outlook 2010
search.appverid: MET150
ms.reviewer: aruiz, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Attachment issues in Outlook 2010, Outlook 2007, or Outlook 2003

## Symptoms

One of the following issues occurs in Outlook 2010, Outlook 2007, or Outlook 2003:

- When exiting (or when Outlook closes unexpectedly) while email attachments are open, the attachments remain in the _Outlook Secure Temporary File folder_. (Even if the attachments are closed.)
- When you open the attachment from the **Reading** pane, you do not receive a prompt to save changes when you exit Outlook.
- When you try to open or save an email attachment, you receive the following error message:

    > Error  
     Cannot create file: **file name**. Right-click the folder that you want to create the file in and then click Properties on the shortcut menu to check your permissions for the folder.

## Cause

This problem occurs for one of the following reasons:

- The temporary files or the temporary secure folders that the files are located in cannot be deleted or removed while the attachments are open.
- The Temporary Internet Files folder is stored on a server on which you do not have sufficient permissions.

## Resolution

This problem is resolved in Microsoft Outlook 2010 Service Pack 1 (SP1) and in the Microsoft Office Outlook 2007 hotfix package dated June 29, 2010. These updates are described in the following Microsoft Knowledge Base articles.

### Outlook 2010

[Description of Office 2010 SP1](https://support.microsoft.com/topic/description-of-office-2010-service-pack-2-5f8554ef-252d-2bf4-681f-0246c6112cde)

### Outlook 2007

[Description of the Office Outlook 2007 hotfix package (Outlook-x-none.msp): June 29, 2010](https://support.microsoft.com/topic/description-of-the-office-outlook-2007-hotfix-package-outlook-x-none-msp-june-29-2010-d3765718-f3c6-b4b2-5439-0462de1d0a2d)

## More information

When you open file attachments that are considered safe, Outlook 2010, Outlook 2007, and Outlook 2003 puts these attachments in a subdirectory of the Temporary Internet Files directory as an additional precaution. When Outlook first tries to use a temporary file, it examines the registry to determine whether one of the following value exists, depending on your version of Outlook:

`HKEY_CURRENT_USER\Software\Microsoft\Office\<version>\Outlook\Security`  
`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<version>\Outlook\Security`  
`Value Name: OutlookSecureTempFolder`  
`Data Type: REG_SZ`  

The value in \<version\> is 14.0 for Outlook 2010, 12.0 for Outlook 2007, and 11.0 for Outlook 2003.

If the value exists, and if the value contains a valid path, Outlook uses that location for its temporary files.

If the registry value does not exist, or if the value points to an invalid location, Outlook creates a new subdirectory under the Temporary Internet Files directory and then puts the temporary file in the new subdirectory. The name of the new subdirectory is unknown and is randomly generated, depending on your version of Outlook. In this situation, to locate this subdirectory, depending on your version of Windows and your version of Outlook, follow these steps.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

### Windows XP clients

1. Select **Start**, and then select **My Computer**.
2. On the **Tools** menu, select **Folder Options**.
3. On the **View** tab, make the following changes:
    1. Select the **Show hidden files and folders** option.
    2. Select to clear the **Hide protected operating system files (Recommended)** check box.
4. Select **OK**.
5. Continue with the next set of steps based on your version of Outlook.

    For Outlook 2010 and Outlook 2007:

    1. Select **Start**, select **Run**, type the following command (including the quotation marks), and then select **OK**.  

        ```powershell
        C:\Documents and Settings\ username \Local Settings\Temporary Internet Files\Content.Outlook
        ```

    2. Open the subfolder under the _Content.Outlook_ folder whose folder name is a randomly generated sequence of letters and numbers. For example, FW0B6RID.

        > [!NOTE]
        > There may be more than one subfolder with a randomly generated name under the Content.Outlook folder .

    For Outlook 2003:

    1. Select **Start**, select **Run**, type _Regedit_, and then select **OK**.
    2. Locate and then select the following registry subkey:  

       `HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Outlook\Security`

    3. Double-select the **OutlookSecureTempFolder** string value to examine and then note the specified folder path.
    4. Select **Cancel**.
    5. On the **File** menu, select **Exit** to exit Registry Editor.
    6. Select **Start**, select **Run**, type the following command (including the quotation marks), and then select **OK** :

        ```powershell
        C:\Documents and Settings\<username>\Local Settings\Temporary Internet Files\<OLKfoldername>
        ```

        > [!NOTE]
        > The placeholder **OLKFoldername** in this path represents the last subfolder that you noted for the OutlookSecureTempFolder value in Step 3.

### Windows 7 and Windows Vista clients

1. Select **Start**, and then select **Computer**.
2. Select **Organize**, and then select **Folder and search options**.
3. On the **View** tab, make the following changes:
    1. Select the **Show hidden files, folders, and drives** option.
    2. Select to clear the **Hide protected operating system files (Recommended)** check box.
4. Select **OK**.
5. Continue with the next set of steps based on your version of Outlook.

    For Outlook 2010 and Outlook 2007:

    1. Select **Start**, select **All Programs**, select **Accessories**, and then select **Run**.
    2. In the **Run** dialog box, type the following command (including the quotation marks), and then select **OK**.

        ```powershell
        C:\Users\ username \AppData\Local\Microsoft\Windows\Temporary Internet Files\Content.Outlook
        ```

    3. Open the subfolder under the _Content.Outlook_ folder whose folder name is a randomly generated sequence of letters and numbers. For example, FW0B6RID.

        > [!NOTE]
        > There may be more than one subfolder with a randomly generated name under the Content.Outlook folder.

    For Outlook 2003:

    1. Select **Start**, select **All Programs**, select **Accessories**, and then select **Run**.
    2. In the **Run** dialog box, type _Regedit_, and then select **OK**.
    3. Locate and then select the following registry subkey:

       `HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Outlook\Security`

    4. Double-select the **OutlookSecureTempFolder** string value to examine and then note the specified folder path.
    5. Select **Cancel**.
    6. On the **File** menu, select **Exit** to exit Registry Editor.
    7. Select **Start**, select **All Programs**, select **Accessories** and then select **Run**.
    8. In the **Run** dialog box, type the following command (including the quotation marks), and then select **OK**:

        ```powershell
        C:\Users\<username>\AppData\Local\Microsoft\Windows\Temporary Internet Files\<OLKFoldername>
        ```

        > [!NOTE]
        > The placeholder **OLKFoldername** in this path represents the last folder that you noted for the OutlookSecureTempFolder value in Step 4.
