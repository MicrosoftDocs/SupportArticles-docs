---
title: NDR error 550 5.6.0 APPROVAL.InvalidExpiry
description: If a retention policy tag with IsDefaultModeratedRecipientsPolicyTag isn't set for a moderated distribution group, you can't send messages to the group.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
ms.reviewer: scottlan, v-six
appliesto: 
  - Exchange Online Protection
search.appverid: MET150
ms.date: 01/24/2024
---
# "550 5.6.0 APPROVAL.InvalidExpiry" when sending messages to a moderated recipient

## Symptoms

You have configured message moderation for a distribution group or a dynamic distribution group so that each message that's sent to the group must be approved by a moderator.

When an email message is sent to the group, the sender receives a non-deliver report that includes following error message:

> OrgExtensionProperties0_LONG_GUID@contoso.onmicrosoft.com  
Remote Server returned '550 5.6.0 APPROVAL.InvalidExpiry; Cannot read expiry policy. [Stage: OnCreatedEvent][Agent: Approval Processing Agent]"

## Cause

The message approval agent requires that the retention policy has a retention policy tag with the `IsDefaultModeratedRecipientsPolicyTag` property is set on it.

## Resolution

For moderated distribution groups in your Exchange organization, you must create a retention policy tag that has the `IsDefaultModeratedRecipientsPolicyTag` property set.

To set the retention policy tag, do the following:

1. From a PowerShell prompt, open Exchange Online PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

1. Run the following cmdlets:

    ```powershell
    Enable-OrganizationCustomization
    New-RetentionPolicyTag -IsDefaultModeratedRecipientsPolicyTag -Name TagforModeration -AgeLimitForRetention 2
    ```

This creates *Personal* retention tag on the retention policy. For more information on retention tag types, see [Retention tags and retention policies in Exchange Server](/Exchange/policy-and-compliance/mrm/retention-tags-and-retention-policies).
