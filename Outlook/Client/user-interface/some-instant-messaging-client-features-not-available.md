---
title: Instant messaging client features not available
description: Describes a problem in which some instant messaging client features are not available in Outlook. Provides a resolution.
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
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Some instant messaging client features are not available in Outlook

_Original KB number:_ &nbsp; 2859256

## Symptoms

Some of the instant messaging features that are shared between your instant messaging (IM) client and Microsoft Outlook may be missing. For example, in Microsoft Outlook 2010, the **Quick Contacts** items from Microsoft Lync are not available in the Outlook To-Do bar; or presence information and contact photos do not appear in Outlook.

## Cause

This problem can occur when a wrong or incompatible IM client is listed as the value for `DefaultIMApp` in the registry.

In one case, Microsoft Support teams saw the problem that is described in the Symptoms section by noticing that the value of `DefaultIMApp` was set to **Cisco Jabber**. Cisco Jabber is manufactured by Cisco Systems.

## Resolution

> [ !IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve the problem, make sure that the `DefaultIMApp` string value is set to the appropriate value for your installed IM client. The following table lists the values to use for the different IM clients from Microsoft.

| Installed IM client| Value for DefaultIMApp |
|---|---|
|Microsoft Office Communicator| Communicator |
|Microsoft Lync 2010| Communicator |
|Microsoft Lync 2013 (Skype for Business)| Lync |
|Skype for Business 2016<br/>Skype (Consumer)| Lync<br/>Skype |
|Microsoft Teams| Teams |

To do this, follow these steps:

1. Exit Outlook and your IM client.
2. Start Registry Editor. To do this, use one of the following procedures, as appropriate for your version of Windows:

   - **Windows 10, Windows 8.1 and Windows 8:** Press Windows Key+R to open a **Run** dialog box. Type *regedit.exe*, and then select **OK**.
   - **Windows 7:** Select **Start**, type *regedit.exe* in the **Search** box, and then press Enter.

3. Locate and then select the following registry subkey:

   `HKEY_CURRENT_USER\SOFTWARE\IM Providers`

4. Select the `DefaultIMApp` string value.

   > [!NOTE]
   > If the `DefaultIMApp` value is not present under the IM Providers key, it must be created manually. To do this, follow these steps:

   1. Right-click **IM Providers**, point to **New**, and then select **String Value**.
   2. Right-click the new string value, and then select **Rename**.
   3. Change the string value name to **DefaultIMApp**, and then press Enter.

5. On the **Edit** menu, select **Modify**.
6. Type the name of your IM client, and then select **OK**.
7. Exit registry editor.
8. Start your IM client.
9. Start Outlook.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
