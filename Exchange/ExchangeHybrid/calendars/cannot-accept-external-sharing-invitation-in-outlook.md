---
title: Can't accept external sharing invitation
description: Users in a hybrid environment can't accept cross-organization sharing and cross-premises sharing.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: kellybos, aruiz, kerbo, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Unable to accept an external sharing invitation by using Outlook in a hybrid environment

_Original KB number:_ &nbsp; 4337974

## Symptoms

You experience one of the following symptoms in a Microsoft Exchange hybrid environment when you share calendars with users:

- Microsoft 365 users in other organizations can't accept your shared invitations.
- Microsoft 365 users in your same organization who are hosted in Exchange on-premises can't accept your shared invitations.

## Cause

A recent update enables delegated mailbox permissions in hybrid environments. This feature enables **send on behalf** permissions in hybrid environments. However, it also interferes with the Calendar Sharing feature.

## Status

Microsoft is currently developing a fix to be released in the following phases.

### Phase 1 - Fix released in March 2019

Calendars work again for cross-organization sharing and for cross-premises sharing. However, be aware of the following caveats:

- You must share a calendar from an updated version of Microsoft Outlook. You can find an updated version of Outlook under the **Share a calendar** section of [Calendar sharing in Microsoft 365](https://support.microsoft.com/office/calendar-sharing-in-microsoft-365-b576ecc3-0945-4d75-85f1-5efafb8a37b4) this article.
- If a calendar is shared cross-premises, the calendar must be accepted from Outlook for Windows. (There is no minimum build requirement.) Users can't accept a cross-premises sharing invitation from any other version of Outlook.

> [!NOTE]
>
> - Calendars that are shared across organizations are supported in all Outlook applications: Outlook for Windows, Outlook on the web, Outlook for Mac, Outlook for iOS, and Outlook for Android. You can share and accept calendars from any of these clients if they are updated clients (minimum versions, as described in [Calendar sharing in Microsoft 365](https://support.microsoft.com/office/calendar-sharing-in-microsoft-365-b576ecc3-0945-4d75-85f1-5efafb8a37b4).
> - Calendars that are shared cross-premises are now supported only in Outlook for Windows. If you try to view a cross-premises shared calendar by using any other Outlook application, you can't sync or view events on the calendar.

### Phase 2 - Fix released in August 2019

After this fix is released, Outlook clients that can't accept cross-premises sharing invitations will no longer offer an **Accept** button to users. The cross-premises invitations can be accepted on legacy and modern Outlook Desktop clients only. This fix does not change any functionality. Instead, it improves the user experience so that users are not offered an option that is not supported.

#### State after the server fix (August 2019)

|Client| Owner: On-Premises <br>Recipient: Microsoft 365|Owner: Microsoft 365<br> Recipient: On-Premises|
|---|---|---|
| Desktop MSI| ✔ Accept button shown & working| ✔ Accept button shown & working |
| Desktop C2R Semi-annual| ✔ Accept button shown & working| ✔ Accept button shown & working |
| Desktop C2R Monthly| ✖ Accept button shown but does not work| ✔ Accept button shown & working |
| Outlook for Web| ✔ No accept button shown (can't accept)| ✔ Accept button shown & working |
| Outlook for Mac, iOS, Android| ✔ No accept button shown (can't accept)| ✔ No accept button shown (can't accept) |

#### State after the Windows client fix (no ETA yet)

|Client|Owner: On-Premises <br>Recipient: Microsoft 365|Owner: Microsoft 365 <br>Recipient: On-Premises |
|---|---|---|
| Desktop MSI| ✔ Accept button shown & working| ✔ Accept button shown & working |
| Desktop C2R Semi-annual| ✔ Accept button shown & working| ✔ Accept button shown & working |
| Desktop C2R Monthly| ✔ Accept button shown & working| ✔ Accept button shown & working |
| Outlook for Web| ✔ No accept button shown (can't accept)| ✔ Accept button shown & working |
| Outlook for Mac, iOS, Android| ✔ No accept button shown (can't accept)| ✔ No accept button shown (can't accept) |

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
