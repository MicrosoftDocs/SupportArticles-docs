---
title: Document attachments open in Protected View
description: Describes an issue that causes Office attachments to unexpectedly Outlook messages to open in Protected View. Resolutions are provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# Office document attachments open in Protected View in Outlook

_Original KB number:_ &nbsp; 2714439

## Symptoms

When you open a Microsoft Office document that's attached to an Outlook email message, the document opens in Protected View. Additionally, the following notification is displayed at the top of the document.

- Outlook 2013

  Be careful - email attachments can contain viruses. Unless you need to edit, it's safer to stay in Protected View.

  :::image type="content" source="media/office-document-attachments-open-in-protected-view/notification-in-outlook-2013.png" alt-text="Screenshot of the notification in Outlook 2013.":::

- Outlook 2010

  This file originated as an e-mail attachment and might be unsafe. Click for more details.

  :::image type="content" source="media/office-document-attachments-open-in-protected-view/notification-in-outlook-2010.png" alt-text="Screenshot of the notification in Outlook 2010.":::

This problem occurs even though the email message was sent to you by another user in your organization (through Microsoft Exchange Server).

## Cause

This problem occurs when the `MarkInternalAsUnsafe` DWORD value is set to **1** under either of the following registry keys.

`HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Security`  
`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Security`

> [!NOTE]
> The x.0 placeholder represents the version of Outlook that you're using (Outlook 2013 = 15.0, Outlook 2010 = 14.0).

## Resolution

To fix this problem, use one of the following methods, as appropriate for your situation.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

- Set the `MarkInternalAsUnsafe` value to **1** under `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Security`.

  To update the value of `MarkInternalAsUnsafe`, follow these steps:

  1. Exit Outlook.
  2. Start Registry Editor:
     - In Windows 8 or Windows 8.1, press the Windows Key+R to open a **Run** dialog box. Type *regedit.exe*, and then press **OK**.
     - In Windows 7 and Windows Vista, select **Start**, type *regedit* in the **Start Search** box, and then press Enter.
     - In Windows XP, select **Run** on the **Start** menu, type *regedit*, and then select **OK**.
  3. Locate and then select the following registry subkey:

     `HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\Outlook\Security`

     > [!NOTE]
     > The x.0 placeholder represents the version of Outlook that you're using (Outlook 2013 = 15.0, Outlook 2010 = 14.0).

  4. Double-click the `MarkInternalAsUnsafe` DWORD value.

  5. Change the value from **1** to **0**, and select **OK**.
  6. Restart Outlook.

- Set `MarkInternalAsUnsafe` to **1** under `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Security`.

  In this configuration, the `MarkInternalAsUnsafe` value is located under the Policies hive in the registry. Therefore, your system administrator must disable the Use Protected View for attachments from internal senders policy in the Group Policy Management Console, as follows:

  1. Start the Group Policy Management Console.
  2. Expand the Microsoft Outlook 2013 or Microsoft Outlook 2010 node, and then select **Security**, per the following screenshot:

     :::image type="content" source="media/office-document-attachments-open-in-protected-view/security-settings.png" alt-text="Screenshot of security group policy settings under Microsoft Outlook 2010." border="false":::

  3. Double-click the Use Protected View for attachments received from internal senders policy.
  4. Select **Not Configured**, and then select **OK**.

## More information

Files from the Internet and from other potentially unsafe locations may contain viruses, worms, and other kinds of malware, and these can harm your computer. To help protect your computer, files from these potentially unsafe locations are opened in Protected View. However, if the email message that contains the Office document attachment originates from within your own Exchange Server organization, the attachment will open in Protected View only if you have `MarkInternalAsUnsafe` set to **1** in the registry. This is not the default setting for an Office configuration. By default, Office document attachments are not opened in Protected View if the email message originates from inside your own Exchange organization.
