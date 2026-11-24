---
title: External shared calendar availability or details aren't available
description: Describes how to troubleshoot issues such as missing calendar availability, missing event details, and delayed changes for external users by checking sharing policies, organization relationships, and federation configuration.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
search.appverid:
  - MET150
appliesto:
  - Exchange Online
ms.date: 11/24/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# External shared calendar availability or details aren't available

## Summary

This article explains why external users might not see calendar availability, shared event details, or recent changes. It describes the configuration checks that apply to each symptom.

## Symptoms

- An external user can't see availability in Scheduling Assistant.
- A shared calendar shows only free/busy information instead of the expected event details.
- Changes to a shared calendar aren't immediately visible across organizations.

## Cause

- If availability isn't visible in Scheduling Assistant, the issue might be caused by a missing or incorrectly configured organization relationship, disabled free/busy access, or incorrect federation configuration that can prevent external users from viewing availability. This workflow is separate from calendar access through an individual sharing invitation.
- If the expected event details aren't visible, the cause might be the owner's assigned sharing policy that restricts individual external sharing to free/busy information instead of the expected event details. For a published calendar, the permitted detail level depends on the policy's `Anonymous` entry and the calendar's publishing configuration, not a federated-domain entry.
- If calendar changes aren't visible immediately, it is because external sharing uses periodic synchronization rather than internal instant synchronization. A delay doesn't indicate a configuration failure though.

## Resolution

1. Identify the owner, the receiver, and the hosting environment of each. Sharing between Exchange Online and on-premises Exchange crosses an organization boundary, even when the email domains look similar.
1. In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following commands to identify the owner's sharing policy and the organization relationships:

   ```powershell
   Get-Mailbox -Identity "owner@contoso.com" | Format-List SharingPolicy
   Get-SharingPolicy | Format-List Name,Enabled,Domains
   Get-OrganizationRelationship | Format-List Name,DomainNames,FreeBusyAccessEnabled,FreeBusyAccessLevel,TargetApplicationUri
   ```

   For more information, see [Get-Mailbox](/powershell/module/exchangepowershell/get-mailbox), [Get-SharingPolicy](/powershell/module/exchangepowershell/get-sharingpolicy), and [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship).

1. Review the policy that's assigned to the owner. A domain-specific entry takes precedence over the wildcard entry. Don't change calendar folder permissions to bypass an external policy restriction.
1. If availability doesn't appear in Scheduling Assistant, ask the administrators of both organizations to verify the organization relationship and federation configuration for the direction and hosting environment involved.
1. If a non-federated Internet Calendar subscription doesn't show the expected calendar information, review the `Anonymous` policy entry and the calendar's publishing configuration. A domain-specific federated entry doesn't replace anonymous publishing. Don't change this policy to fix a synchronization delay.
1. Make only the configuration changes that your organization approves. For more information, see [Sharing policies in Exchange Online](/exchange/sharing/sharing-policies/sharing-policies) and [Organization relationships in Exchange Online](/exchange/sharing/organization-relationships/organization-relationships).
1. Test the affected workflow again. Test availability and shared calendar access separately, and confirm that the receiver sees only the approved detail level. External changes can take approximately three to four hours to synchronize, so don't expect the instant synchronization that internal sharing provides.

If the symptom is still unresolved, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide information about the affected users, the failure time and time zone, the exact symptom, and the configuration output with the support request.
