---
title: How to block additional attachment file name extensions
description: Provides a step-by-step guideline about how to customize your security settings to block attachment file name extensions in both an Exchange environment and a non-Exchange environment for different versions of Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 10/30/2023
---
# How to configure Outlook to block additional attachment file name extensions

_Original KB number:_ &nbsp; 837388

## Summary

This article describes how to configure Microsoft Outlook to block attachment file name extensions that Outlook does not block by default. If you use Outlook in a Microsoft Exchange environment, you can configure the server to block certain attachment file name extensions by using the Outlook E-mail Security Administrator Package.

Additionally, this article includes information about how to customize your security settings for different Outlook configurations with and without Exchange.

## How to customize your security settings to block additional attachment file name extensions

The following methods describe how to customize your security settings for different Outlook configurations with and without Exchange.

### How to block attachment file name extensions in an Exchange environment with the Outlook Security Administrator Package

If you have an Exchange environment that uses the Outlook Security Administrator Package and you want to add more attachment file name extensions that you want to block in your Outlook configuration, you can add more attachment file name extensions to the Level 1 file list. To do this, follow these steps:

1. Start Outlook with an account that has permissions to change the Outlook Security Form in the Outlook 10 Security Settings public folder.
2. In the **folder list** pane, locate the version-specific Outlook Security Settings public folder.

    > [!NOTE]
    > For Outlook 2000, the name of the public folder is Outlook Security Settings. For Outlook 2002 and Office Outlook 2003, the name of the public folder is Outlook 10 Security Settings.

3. Double-click **Default Security Form**.

4. Under **Miscellaneous Attachment Settings**, clear the **Show level 1 attachments** check box.

5. Under **Level 1 File Extensions**, type the attachment file name extensions that you want to block in the **Add** box.

   If you want to add more attachment file name extensions in the **Add** box, you can separate them with a semicolon. For example, if you want to block both the .zip and the .gif attachment file name extensions, type .zip; .gif

6. Select **Close**, and then select **Yes** to save your changes.
7. Repeat these steps for each Outlook Security Form that you have in the public folder for each security group that you want to add more attachment file name extensions to.

The next time that your users start Outlook, the new settings will be applied.

> [!NOTE]
> If you the **Show Level 1 File Attachments** check box from step 4 was already selected to allow all Level 1 attachment file name extensions types to appear in the e-mail message as an attachment, you must add the attachment file name extensions that you do not want to appear in the e-mail message as an attachment by following this one additional step:
>
> - Under **Level 1 File Extensions**, locate the **Remove** box. In the **Remove** box, type the attachment file name extensions that you do not want to appear in the e-mail message as an attachment.
>
> If you want to add more attachment file name extensions in the **Add** box, you can separate them with a semicolon. For example, if you want to block both the .zip and the .gif attachment file name extensions, type .zip; .gif

### How to block attachments in a non-Exchange environment

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Use the information that is in this section if you are running Outlook in a non-Exchange environment and you want to block more attachment file name extensions than those that Outlook already blocks.

If you are using Outlook 2000, Office 2000 Service Pack 3 (SP3) or later must be installed on your computer so that you can configure Outlook 2000 to block certain attachment file name extensions.

If you are using Outlook 2002, Microsoft Office XP Service Pack 1 (SP1) or later must be installed on your computer so that you can configure Outlook 2002 to block certain attachment file name extensions.

Outlook uses the `Level1Add` registry key to permit you to add additional attachment file name extensions types that you want to block.

To add additional attachment file name extensions types that you want to block, you must add the `Level1Add` key to the registry. To do this, follow these steps.

### Outlook 2010

Follow these steps, and then quit Registry Editor:

1. Select **Start**, select **Run**, type *regedit*, and then select **OK**.

2. Locate and then select the following key in the registry:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Security`

3. On the **Edit** menu, point to **New**, and then select **String Value**.
4. Type *Level1Add*, and then press Enter.
5. On the **Edit** menu, select **Modify**.
6. Type \<file_name_extensions>, and then select **OK**.

> [!NOTE]
> **file_name_extensions** is a list of the attachment file name extensions. Each attachment file name extension is separated by a semicolon. For example, type .zip; .gif if you want to block both .zip and .gif files from appearing in the e-mail message as an attachment.

### Outlook 2007

Follow these steps, and then quit Registry Editor:

1. Select **Start**, select **Run**, type *regedit*, and then select **OK**.

2. Locate and then select the following key in the registry:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Outlook\Security`

3. On the **Edit** menu, point to **New**, and then select **String Value**.
4. Type *Level1Add*, and then press Enter.
5. On the **Edit** menu, select **Modify**.
6. Type \<file_name_extensions>, and then select **OK**.

> [!NOTE]
> **file_name_extensions** is a list of the attachment file name extensions. Each attachment file name extension is separated by a semicolon. For example, type .zip; .gif if you want to block both .zip and .gif files from appearing in the e-mail message as an attachment.

### Outlook 2003

Follow these steps, and then quit Registry Editor:

1. Select **Start**, select **Run**, type *regedit*, and then select **OK**.

2. Locate and then select the following key in the registry:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Outlook\Security`

3. On the **Edit** menu, point to **New**, and then select **String Value**.
4. Type *Level1Add*, and then press Enter.
5. On the **Edit** menu, select **Modify**.
6. Type \<file_name_extensions>, and then select **OK**.

> [!NOTE]
> **file_name_extensions** is a list of the attachment file name extensions. Each attachment file name extension is separated by a semicolon. For example, type .zip; .gif if you want to block both .zip and .gif files from appearing in the e-mail message as an attachment.

### Outlook 2002

Follow these steps, and then quit Registry Editor:

1. Select **Start**, select **Run**, type *regedit*, and then select **OK**.

2. Locate and then select the key in the registry:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\10.0\Outlook\Security`

3. On the **Edit** menu, point to **New**, and then select **String Value**.
4. Type Level1Add, and then press Enter.
5. On the **Edit** menu, select **Modify**.
6. Type \<file_name_extensions>, and then select **OK**.

> [!NOTE]
> **file_name_extensions** is a list of the attachment file name extensions. Each attachment file name extension is separated by a semicolon. For example, type .zip; .gif if you want to block both .zip and .gif files from appearing in the e-mail message as an attachment.

Additionally, you can add additional attachment file name extensions types that you want blocked by using system policies to add the following registry key for Outlook:

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\10.0\Outlook\Security`

### For Outlook 2000

Follow these steps, and then quit Registry Editor:

1. Select **Start**, select **Run**, type *regedit*, and then select **OK**.

2. Locate and then select the following key in the registry:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Outlook\Security`

3. On the **Edit** menu, point to **New**, and then select **String Value**.
4. Type *Level1Add*, and then press Enter.
5. On the **Edit** menu, select **Modify**.
6. Type \<file_name_extensions>, and then select **OK**.

> [!NOTE]
> **file_name_extensions** is a list of the attachment file name extensions. Each attachment file name extension is separated by a semicolon. For example, type .zip; .gif if you want to block both .zip and .gif files from appearing in the e-mail message as an attachment.
