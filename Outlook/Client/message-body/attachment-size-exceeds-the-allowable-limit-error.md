---
title: Attachment size exceeds the allowable limit error
description: Describes the circumstances surrounding an error that occurs when you add a large attachment to an email message in Outlook. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: sercast
appliesto: 
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Attachment size exceeds the allowable limit error when you add a large attachment to an email message in Outlook

_Original KB number:_ &nbsp; 2813269

## Symptoms

When you add an attachment to an email message in Microsoft Outlook 2013 or later versions, you receive the following error message:

> The file you're attaching is bigger than the server allows. Try putting the file in a shared location and sending a link instead.

## Cause

This problem occurs for one of the following reasons, depending on the kind of email account that you are using.

Internet email account (POP3, IMAP, HTTP)

You receive this error message because Outlook 2013 and later versions have a default attachment size limit of 20 megabytes (20480 KB) for Internet email accounts. This limit prevents your computer from continually trying to upload very large attachments that exceed the limits of most Internet service providers. This limit applies whether you are adding one large attachment that is greater than 20 megabytes (MB) or several attachments whose sum total size is greater than 20 MB.

Microsoft Exchange Server email account

If you are using an Exchange Server mailbox, you receive this error message (by default) if you attach one or more items to a message, and if the sum total of the attachments is greater than 10 MB (10240 KB). This attachment limit is not related to the limit in Outlook for Internet email accounts. This limit for an Exchange mailbox stems from the Maximum send size setting that is configured in the **Transport Settings Properties** dialog box by the Exchange administrator (Refer the following screenshot).

:::image type="content" source="media/attachment-size-exceeds-the-allowable-limit-error/transport-settings-properties.png" alt-text="Screenshot of the Transport Settings Properties dialog box." border="false":::

## Resolution

The steps to modify the default attachment limit depend on the type of email account that you are using with Outlook.

> [!IMPORTANT]
> This article contains information about how to modify the registry . Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

### Internet email account (POP3, IMAP, HTTP)

To modify the default attachment limit size in Outlook for an Internet email account yourself, follow these steps:

1. Exit Outlook.
2. Start Registry Editor.
3. Locate and then select one of the following registry subkeys:

   HKEY_CURRENT_USER\Software\Microsoft\Office\\<x.0>\Outlook\Preferences  
   HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\ *x.0* \Outlook\Preferences

   > [!NOTE]
   >
   > - The <x.0> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Microsoft 365, 15.0 = Office 2013).
   > - Manually create the path in the registry if it does not currently exist.

4. Add the following registry data under this subkey:

    Value type: DWORD  
    Value name: MaximumAttachmentSize  
    Value data: An integer that specifies the total maximum allowable attachment size. For example, specify 30720 (Decimal) to configure a 30-MB limit.

   > [!NOTE]
   >
   > - Specify a value of zero (0) if you want to configure no limit for attachments.
   > - Specify a value that is less than 20 MB if you want to configure a limit that is less than the default 20 MB.

5. Exit Registry Editor
6. Start Outlook.

### Microsoft Exchange Server email account

If you are using an Exchange Server account, the 20-MB attachment limit for Internet email accounts is not used by Outlook. Instead, Outlook uses the limit that is configured on your Exchange server. To modify the setting that is used to control the size of a message that is sent through an Exchange Server account, follow these steps.

> [!IMPORTANT]
>
> - These steps apply to Exchange Server 2007. Similar steps should be used for other versions of Exchange.
> - This Exchange Server setting applies to all versions of Outlook.
>
>    Note Outlook 2016 is not supported when connected to Exchange Server 2007. For more information, see [Error: Stop, you should wait to install Office 2016. You won't be able to receive mail from a current mailbox](https://support.microsoft.com/office/error-stop-you-should-wait-to-install-office-2016-you-won-t-be-able-to-receive-mail-from-a-current-mailbox-2ab9e8ef-4cd9-4041-9426-73e8f6c5aacc).
>
> - You must be an Exchange administrator to make the changes in the following steps. Regular users do not have access to the Exchange Management Console.

1. Start the Exchange Management Console.
2. Under **Organization Configuration**, select **Hub Transport**. (The screenshot for step 2 and 3 is listed below)
3. On the **Global Settings** tab, select **Transport Settings**.

   :::image type="content" source="media/attachment-size-exceeds-the-allowable-limit-error/transport-settings.png" alt-text="Screenshot shows steps to select Transport Settings.":::

4. In the **Transport Settings** section of the **Actions** pane, select **Properties**.
5. On the **General** tab in the **Transport Settings Properties** dialog box, configure the value for Maximum send size (KB).
6. Select **OK**.

> [!NOTE]
> Because the Exchange server has a cache for various settings, this change does not take effect immediately. You may have to wait several hours before this change is recognized by Outlook.
