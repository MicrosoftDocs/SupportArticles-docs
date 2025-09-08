---
title: Can't update a meeting in large distribution group
description: Describes an issue that triggers a non-delivery report when you send an update to a meeting, and provides resolutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Recipients\Issues with Mailbox, DG, MEU/MEC Management
  - Exchange Server
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Enterprise
  - Outlook 2013
  - Outlook 2010
ms.date: 01/24/2024
---
# Error (too many recipients) when you update a meeting in a large Outlook distribution group

_Original KB number:_ &nbsp; 3024804

## Symptoms

You send a meeting request to a distribution group that has a large membership. You later try to send an update to the meeting, but you receive a non-delivery report (NDR) that resembles the following:

> This message wasn't delivered to anyone because there are too many recipients. The limit is 500. This message has \<number of> recipients.

For each listed recipient, you see the following error message:

> This message has too many recipients. Please try to resend with fewer recipients.

Under the diagnostic information for administrators, the following error is generated for each listed recipient:

> #550 5.5.3 RESOLVER.ADR.RecipLimit; too many recipients ##

When you open the meeting on the calendar, the **To** field contains a number of the recipients in the distribution group membership, in addition to the distribution group itself.

## Cause

This issue may occur if the number of recipients who responded to the earlier meeting request exceeds the recipient limit for messages. Each recipient who sends a response to the meeting request is added to the **To**  field in the updates to the meeting request, in addition to the distribution group. For a large distribution group, the resulting **To**  field may exceed the number of allowed recipients. This triggers the NDR.

Use one of the following methods to prevent meeting updates from being sent with additional recipients on the **To** line.

## Resolution 1: Disable responses for the meeting request

When you send a meeting request to a large distribution group whose membership exceeds the established recipient limit for your organization, turn off responses from recipients:

1. In the new meeting window, select Response Options  on the ribbon.
2. Clear the Request Responses check box.

This prevents responding recipients from being added to the **To** field on subsequent updates to the meeting. This also prevents the tracking of meeting responses on the meeting's Tracking page.

> [!NOTE]
> In some cases, clearing the **Request Responses** check box may not completely eliminate recipient responses from being returned to the organizer. This behavior may still occur if the recipient accepts the meeting invitation from a device or a non-Outlook client that does not honor the disabled **Request Responses** setting. This behavior is known to occur with certain third-party implementations of Exchange ActiveSync (EAS).

## Resolution 2: Manually delete additional responses before you send the update

When you reopen the meeting to send an update, delete the additional recipient entries from the **To** field before you click **Send Update**.

> [!NOTE]
> When you use this method, removed recipients may receive a cancellation notice for the original meeting, and the update may be applied as a new meeting on the recipient's calendar.

## More information

The `MaxRecipientEnvelopeLimit` value in Exchange is where the organization limit for recipients is stored. The default setting in Exchange 2010 and Exchange 2013 is 5000 recipients per message. However, this setting can be configured by your Exchange administrator.

Exchange Online and Microsoft 365 have an organization limit of 500 recipients per message, and this setting can't be modified. Where applicable, this value is configured through the following PowerShell command:

```powershell
Set-TransportConfig -maxrecipientenvelopelimit: value
```

The `MaxRecipientEnvelopeLimit` parameter specifies the maximum number of recipients for a message. The default value is 5000. The valid input range for this parameter runs from 0 through 2147483647. If you enter a value of **Unlimited**, no limit is imposed on the number of recipients for a message. Exchange treats an unexpanded distribution group as one recipient. This parameter is available only in on-premises installations of Exchange 2013.

For more information, see [Set-TransportConfig](/powershell/module/exchange/set-transportconfig).
