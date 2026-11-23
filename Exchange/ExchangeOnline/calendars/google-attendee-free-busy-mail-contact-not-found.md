---
title: Google attendee availability isn't displayed when the mail contact is missing
description: Restore Google Workspace attendee availability in Exchange Online Calendar Interop by checking the attendee's mail contact and address resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: meshel,shanefe
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
search.appverid: MET150
ms.date: 11/09/2026
ai-usage: ai-assisted
---
# Google attendee availability isn't displayed when the mail contact is missing

## Summary

This article addresses Exchange Online users who can't retrieve a Google Workspace user's availability through Google Calendar Interop because the required mail contact is missing or isn't selected. It doesn't address shared calendar subscriptions or requests that originate in Google Workspace.

## Symptoms

In Outlook Scheduling Assistant, you add a Google Workspace attendee, but the attendee's availability isn't displayed. In an organization that uses Calendar Interop, the attendee doesn't resolve to the expected mail contact in the global address list.

## Cause

Calendar Interop requires a mail contact in Exchange for the Google Workspace user. The contact supplies the address used to route the availability lookup. An absent contact, an incorrect contact address, or selection of a different recipient prevents the lookup from following the configured Google availability route.

## Resolution

Work with the Google Workspace administrator to confirm that Calendar Interop is configured for the affected Google user.

1. In Exchange Online PowerShell, use [Get-MailContact](/powershell/module/exchangepowershell/get-mailcontact) to check the affected recipient. Replace the example address with the Google user's address.

   ```powershell
   Get-MailContact -Identity "googleuser@fabrikam.com" |
       Format-List DisplayName,PrimarySmtpAddress,ExternalEmailAddress,HiddenFromAddressListsEnabled
   ```

1. If no contact exists, create the required contact by following [Manage mail contacts in Exchange Online](/exchange/recipients-in-exchange-online/manage-mail-contacts). Confirm the Google user's destination address before creating it. Don't create a duplicate recipient or change mail routing solely to test availability.
1. Confirm that the contact is visible in the global address list and that mail sent to the contact reaches the intended Google Workspace account.
1. If Calendar Interop uses a Google user alias domain, check that the contact's primary address uses that alias domain and that its other address is configured as described in [Google's Calendar availability sharing instructions](https://knowledge.workspace.google.com/admin/sync/allow-exchange-users-to-see-calendar-availability-data). Don't substitute an unrelated domain.
1. In a new meeting, select the intended contact from the address list instead of reusing an unresolved or previously selected attendee.

### Verify the resolution

Query the same Google attendee in Scheduling Assistant for the same time range. Confirm that the selected recipient is the intended mail contact and that availability is returned. If the resolution succeeds but availability is still unavailable, investigate the configured Calendar Interop connection separately.

## More information

- [Google Calendar Interop configuration](https://knowledge.workspace.google.com/admin/sync/allow-exchange-users-to-see-calendar-availability-data)
- [Verify the Calendar Interop setup](https://knowledge.workspace.google.com/admin/sync/verify-the-user-availability-setup)
