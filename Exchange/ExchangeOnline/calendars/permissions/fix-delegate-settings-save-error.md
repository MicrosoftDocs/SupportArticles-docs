---
title: The Delegate settings were not saved correctly error in Outlook in an Exchange hybrid environment
description: Resolve the Outlook error that says delegate settings weren't saved because send on behalf permissions couldn't be activated in a hybrid environment.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom: 
  - sap:Calendaring\Calendar Permission
  - Exchange Online
  - Exchange Hybrid
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
  - Outlook for Mac
ms.date: 10/07/2026
ms.service: exchange-online
---

# Fix a delegate settings save error in Outlook

## Summary

Fixes the Outlook error "The Delegates settings were not saved correctly. Unable to activate send on behalf list. You do not have sufficient permission to perform this operation on this object." This error happens when a user adds or removes a delegate in a hybrid environment. Verify the user's Active Directory permissions and confirm that Outlook connects to a global catalog in the user's domain.

## Symptoms

This issue happens in hybrid environments where Outlook must update the on-premises `publicDelegates` attribute when a user adds or removes a delegate. Outlook shows this error when the mailbox owner adds or removes a delegate:

> The Delegates settings were not saved correctly. Unable to activate send on behalf list. You do not have sufficient permission to perform this operation on this object.

## Cause

This error happens when Outlook connects to a global catalog outside the user's domain or when the user's SELF security principal can't write personal information to its Active Directory object. For Microsoft's documented causes and a registry-based alternative resolution, see [The Delegates settings were not saved correctly error in Outlook](https://support.microsoft.com/outlook/the-delegates-settings-were-not-saved-correctly-error-when-you-try-to-add-a-delegate-in-outlook).

## Resolution

1. Confirm that the affected mailbox is in a hybrid environment with an on-premises Active Directory user object.
1. Have an Active Directory administrator verify that the user's SELF security principal has the `Write personal information` permission on the user object.
1. Confirm that Outlook connects to a global catalog in the user's domain.
1. Restart Outlook, remove the delegate, and add the delegate again.

### Verify the resolution

Open the Outlook delegate settings. Confirm that the delegate is listed, close the dialog, reopen it, and verify that the delegate remains listed. Send a meeting request on behalf of the mailbox owner to confirm delegate calendar access.

## More information

- [Reset corrupt Outlook delegate permissions](fix-corrupt-delegate-permissions.md)
- [Resolve hybrid delegate failures](fix-hybrid-delegate-failures.md)
