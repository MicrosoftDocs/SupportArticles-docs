---
title: Meeting shows an incorrect time zone for an attendee
description: Provides a resolution for a calendar issue in which Outlook on the web and the new Outlook for Windows show an incorrect time zone for a meeting attendee.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 185863
ms.reviewer: moabozei, tylewis, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Meeting shows an incorrect time zone for an attendee

## Symptoms

Both the organizer and attendee of a meeting [work](https://support.microsoft.com/office/learn-more-about-work-hours-in-outlook-af2fddf9-249e-4710-9c95-5911edfd76f6) in the same time zone. However, the organizer sees the following message when scheduling the meeting in Outlook on the web or the new Microsoft Outlook for Windows:

> \<Attendee\> is in a different time zone. Use the Scheduling Assistant to select times across time zones.

In the Scheduling Assistant, the organizer sees an incorrect time zone for the attendee.

> [!NOTE]
> As an admin, you can verify that the mailbox settings for both the organizer and attendee show the same time zone by running the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):
>
> ```PowerShell
> Get-MailboxCalendarConfiguration -Identity <user> | FL WorkingHoursTimeZone
> ```

## Cause

The work hours of the attendee in Outlook on the web and the new Outlook for Windows are based on an incorrect time zone because of corrupted calendar settings.

## Resolution

To fix the issue, use the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) tool to reset the work hours of the attendee. Follow these steps.

>[!NOTE]
> To use the following procedure, you must have full access permissions to the attendee's mailbox or be the attendee. Run the procedure on a Microsoft Windows-based computer that has the Outlook desktop client installed and an Outlook profile for the attendee's mailbox.

1. Select **File** \> **Office account** \> **About Outlook** to determine whether the Outlook installation on the attendee's mailbox is the [32-bit or 64-bit](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c) version.

2. Download and extract the latest 32-bit or 64-bit version of [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) to match the Outlook installation.

   [!INCLUDE [Important MFCMAPI alert](../../../includes/mfcmapi-important-alert.md)]

3. Close Outlook and Outlook on the web, and then run MFCMapi.exe. If the MFCMAPI startup screen appears, close it.

4. Select **Tools** \> **Options** to open the **Options** window.

5. Select both the following options, and then select **OK**:

   - Use the MDB_ONLINE flag when calling OpenMsgStore

   - Use the MAPI_NO_CACHE flag when calling OpenEntry

6. Select **Session** \> **Logon** to open the **Choose Profile** window.

7. Select the Outlook profile for the attendee, and then select **OK**.

8. Double-click the attendee's mailbox in the **Display Name** column to open it.

9. In the left pane, navigate to **Root Container** \> **Top of Information Store** \> **Calendar**.

10. Right-click **Calendar**, and then select **Open associated contents table**.

11. Delete all entries that have `IPM.FlexibleWorkingHours` in the **Message Class** column.

12. Close all MFCMAPI windows to exit the application.

13. Open Outlook on the web or the new Outlook for Windows, and then [set work hours for the attendee](https://support.microsoft.com/office/learn-more-about-work-hours-in-outlook-af2fddf9-249e-4710-9c95-5911edfd76f6#ID0EDL).
