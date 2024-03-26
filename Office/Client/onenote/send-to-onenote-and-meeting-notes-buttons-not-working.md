---
title: Send to OneNote and Meeting Notes buttons in Outlook not working
description: Discusses that the Send to OneNote and Meeting Notes buttons in Outlook do not work. Provides a resolution.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Microsoft OneNote 2010
- Microsoft Outlook 2010
- Outlook 2013
- OneNote 2013
search.appverid: MET150
ms.reviewer: rlindgre, tasitae, lin.gen
author: simonxjx
ms.author: v-six
ms.date: 03/31/2022
---
# Send to OneNote and Meeting Notes buttons in Outlook do not work

Nothing happens when you select the **Send to OneNote** button or the **Meeting Notes** button in Microsoft Outlook 2013 or Microsoft Outlook 2010.

## Cause

This problem occurs because the following registry value disables the ability to send items to OneNote from Microsoft Outlook:

DWORD: **DisableSendEmailtoOneNote**  
Value data: **1**

This registry entry can exist in either of the following subkeys:

`HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\OneNote\Options\OutlookAndWeb`  
`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\OneNote\Options\OutlookAndWeb`

> [!NOTE]
> In this registry entry, *<x.0>* represents your version of Microsoft Office (15.0 = Office 2013, 14.0 = Office 2010).

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur.

1. Exit Outlook and OneNote.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows.

   - Windows 8: Press Windows logo key+R to open a **Run** dialog box. Type *regedit.exe*, and then press **OK**.
   - Windows 7: Select **Start**, type *regedit.exe* in the **Start search** box, and then press Enter.

3. In Registry Editor, locate and then select the following subkeys in the registry:

   `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\OneNote\Options\OutlookAndWeb`  
   `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0\OneNote\Options\OutlookAndWeb`

    > [!NOTE]
    > In this registry entry, *<x.0>* represents your version of Microsoft Office (15.0 = Office 2013, 14.0 = Office 2010).

4. Locate and then double-click the following value:

    **DisableSendEmailtoOneNote**

5. In the **Value Data** box, type *0*, and then select **OK**.
6. Exit Registry Editor.

> [!NOTE]
> If the registry value is located under the Policies hive, it may have been configured by Group Policy. If it was configured by Group Policy, it will be restored when this policy is refreshed on the computer. Your administrator must change the policy to change this setting. See the "More information" section.

## More information

The **Disable Outlook send email to OneNote option** policy setting is located in the Microsoft OneNote 2013 and Microsoft OneNote 2010 administrative templates, under **OneNote Options | Sent to OneNote**.

To allow users to send items to OneNote from Outlook, set this policy setting to either **Not Configured** or **Disabled**.

You can find the **Send to OneNote** button on the **Home** ribbon in Outlook 2013 when you view Mail, Tasks, or People and in Outlook 2010 when you view Mail or Contacts.

:::image type="content" source="./media/send-to-onenote-and-meeting-notes-buttons-not-working/send-to-onenote-button.png" alt-text="The Send to OneNote button on the Home Ribbon.":::

The **Meeting Notes** button can be found on the Meeting and Appointment ribbons when you view Calendar items in Outlook 2013.

:::image type="content" source="./media/send-to-onenote-and-meeting-notes-buttons-not-working/meeting-notes-button.png" alt-text="The Meeting Notes button.":::

The **OneNote** button can be found on the Meeting and Appointment ribbons when you view Calendar items in Outlook 2010.

:::image type="content" source="./media/send-to-onenote-and-meeting-notes-buttons-not-working/onenote-button.png" alt-text="The OneNote button on a Calendar item in Outlook 2010.":::
