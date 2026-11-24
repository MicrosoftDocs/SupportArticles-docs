---
title: External calendar sharing invitation returns InvalidSharingDataException or token-validation errors
description: Troubleshoot external calendar invitation acceptance failures caused by invalid sharing data, incorrect federation information, or an expired invitation token.
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

# External calendar sharing invitation returns InvalidSharingDataException or token-validation errors

## Summary

This article describes how to troubleshoot a calendar sharing invitation that a receiver in another organization can't accept. It covers the invitation's age, message integrity, and federation configuration.

## Symptoms

A receiver in another organization can't accept a calendar sharing invitation, or the accepted calendar isn't usable. Diagnostic evidence might contain one of the following errors:

```text
Microsoft.Exchange.Data.Storage.InvalidSharingDataException:
The sharing message metadata has the following invalid field: SharedFolderData=.
```

```text
TokenValidationResult(Result=InvalidUnknownEncryption)
TokenValidationResult(Result=InvalidTokenFailedValidation)
```

## Cause

External sharing uses encrypted sharing data. Acceptance fails if the invitation was modified, the encryption target doesn't match the receiving environment, or the invitation token has expired. A token has a limited lifetime, so an old invitation might no longer be accepted.

In hybrid environments, cloud and on-premises federation metadata can differ. An on-premises target URI isn't interchangeable with a cloud target URI.

## Resolution

1. Ask the owner to send a new invitation. Don't forward or reuse the old invitation.
1. Ask the receiver to accept the new invitation promptly, and then confirm that the intended calendar opens.

If acceptance succeeds, stop troubleshooting the acceptance failure. Check later calendar changes separately, because successful acceptance doesn't show that synchronization is healthy.

For availability and detail-level problems after acceptance, see [External shared calendar availability or details aren't available in Exchange Online](external-calendar-details-unavailable.md).

### If the invitation still fails

1. Check whether message processing modified the invitation. For more information, see [Calendar sharing invitation has no Accept button or returns WrongObjectTypeException](sharing-invitation-modified.md).
1. Ask the administrators of both organizations to review the federation information and organization relationships:

   ```powershell
   Get-FederationInformation -DomainName "fabrikam.com"
   Get-OrganizationRelationship | Format-List Name,DomainNames,TargetApplicationUri
   ```

   For more information, see [Get-FederationInformation](/powershell/module/exchangepowershell/get-federationinformation) and [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship). Replace `fabrikam.com` with the receiver's domain. Verify that the metadata describes the actual receiving environment. Don't replace a URI because it differs from an example.

1. If configuration or token errors persist, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide the two mailbox addresses, their hosting locations, the invitation time, the message identifiers, the exact error, and the relevant configuration output with the support request.
