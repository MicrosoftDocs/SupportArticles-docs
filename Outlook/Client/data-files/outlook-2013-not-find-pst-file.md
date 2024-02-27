---
title: Outlook 2013 can't find .pst file
description: This article helps fix an error (The file \<file name>.pst cannot be found.) that occurs when you open or send/receive email messages in Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2013
ms.date: 01/30/2024
---
# Error when you send, receive email or open Outlook 2013: Cannot find xxx.pst

_Original KB number:_ &nbsp; 2812016

## Symptoms

You can't open or send/receive email messages in Outlook because of the following error:

> The file C:\Users\\\<username>\documents\Outlook Files\\\<file name>.pst cannot be found. Your .pst file has been deleted or moved.

> [!NOTE]
> If Outlook is reporting that your .pst file is damaged or corrupt, refer to [Repair Outlook data files (.pst and .ost)](https://support.microsoft.com/office/repair-outlook-data-files-pst-and-ost-25663bc3-11ec-4412-86c4-60458afc5253).

To fix this error, try the following steps:

## Confirm that Outlook can't find your .pst file

1. When you receive the error that your .pst file can't be found, copy down the file name for future reference and click **OK**.

    :::image type="content" source="./media/outlook-2013-not-find-pst-file/error-message.png" alt-text="Screenshot for the Outlook error message." border="false":::  

    The default name that Outlook uses for a .pst file is \<Your email address>.pst.

2. The next window that opens will be either the default .pst file location or the location you specified when creating your email account.

    :::image type="content" source="./media/outlook-2013-not-find-pst-file/pst-file-location.png" alt-text="Screenshot for .pst file location." border="false":::

    Keep this window open and continue with the next section.  

## Check your Recycle Bin

If your .pst has been deleted and your Recycle Bin hasn't been emptied, it can be restored.

1. Go to your desktop and double-click on your Recycle Bin icon.

    If your .pst file isn't there, don't continue with this section, jump to the next section.

    If your .pst file is there, right-click on it and select **Restore**.

    :::image type="content" source="./media/outlook-2013-not-find-pst-file/restore-pst-file.png" alt-text="Screenshot for restoring .pst file." border="false":::

2. Look in the window you kept open in the first section. If your .pst file appears, click **Open**.

    :::image type="content" source="./media/outlook-2013-not-find-pst-file/open-pst-file.png" alt-text="Screenshot for opening the .pst location." border="false":::

3. Outlook should start normally.  

## Search for your .pst file

Perform a search for the .pst file:

1. Hit the Windows button + F to bring up your Search window.
2. For Windows 7, type **.pst*. For Windows 8, type *.pst*.
3. If your .pst file isn't found, don't continue with this section, jump to the next section
4. If this search finds your .pst file, cut and paste it into the window left open from the first section.
5. Click **Open** and Outlook should start normally.  

## Create a new data file

Unfortunately, if you've reached this section, your .pst file isn't recoverable, the only option is to create a new one:

1. In the window left open from the first section, type the name you would like to have for your new Outlook data file and click **Open**.

    :::image type="content" source="./media/outlook-2013-not-find-pst-file/type-name-for-new-pst-file.png" alt-text="Screenshot for creating a new Outlook data file." border="false":::

2. Outlook will then ask you if you want to password protect your new .pst file. If you select to use a password for your data file, enter and verify it in this window. Otherwise, click **OK**.

    :::image type="content" source="./media/outlook-2013-not-find-pst-file/add-password.png" alt-text="Screenshot for .pst file password." border="false":::

    > [!NOTE]
    > Check and save this password in your password list if you want Windows to remember it.
  
## More information

You can also get help from the [Microsoft Community](https://answers.microsoft.com/) online, search for more information on [Office Help & Training](https://support.microsoft.com/office?legredir=true&correlationid=df6f1c48-dd3a-4c35-a4c8-decf031e3fa4).
