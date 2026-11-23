---
title: Resolve Outlook delegate failures in Exchange hybrid
description: Resolve cross-premises Outlook delegate failures by checking hybrid delegation requirements or moving the mailbox owner and delegate to one environment.
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
  - New Outlook for Windows
  - Outlook for Mac
ms.date: 10/07/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Resolve Outlook delegate failures in Exchange hybrid

## Summary

Resolves Outlook delegate failures in an Exchange hybrid environment, including delegate setup failures, access to only free/busy information, and send on behalf issues when the mailbox owner and delegate are in different environments. To resolve the issue, verify the hybrid delegation requirements, or move both mailboxes to the same environment and re-create the delegate relationship.

## Symptoms

- Delegate setup fails when one mailbox is on-premises and the other mailbox is in Exchange Online.
- The delegate can open only free/busy information instead of full calendar details.
- Delegate access or send on behalf behavior changes after one mailbox moves to Exchange Online.

## Cause

Delegate and folder permissions have limitations when the mailbox owner and delegate are in different forests in an Exchange hybrid deployment.

## Resolution

1. Identify where the mailbox owner's mailbox and the delegate's mailbox are hosted.
1. Review the requirements and limitations in [Overview of delegation in a Microsoft 365 hybrid environment](/troubleshoot/exchange/send-emails/overview-delegation-office-365-hybrid).
1. Verify that the hybrid deployment is configured for delegated mailbox permissions and that the required directory attributes synchronize correctly.
1. If the required delegate scenario remains unsupported or unreliable across forests, move the mailbox owner and delegate to the same environment.
1. Remove and recreate the delegate relationship after both mailboxes are in the same environment.

### Verify the resolution

Have the delegate open the mailbox owner's calendar, create a test meeting, and send it on behalf of the owner. Confirm that the calendar details and meeting request behave as expected.

## More information

- [Fix a delegate settings save error](fix-delegate-settings-save-error.md)
- [Resolve Full Access and delegate conflicts](fix-full-access-delegate-conflicts.md)
