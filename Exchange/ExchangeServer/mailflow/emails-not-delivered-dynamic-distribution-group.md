---
title: Emails aren't delivered to all recipients
description: Describes an issue in which email messages that are sent to a Dynamic Distribution Group aren't delivered to all recipients. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: arindamt, v-six
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
ms.date: 01/24/2024
---
# Email messages sent to a Dynamic Distribution Group aren't delivered to all recipients

_Original KB number:_ &nbsp; 4090655

## Symptoms

Email messages that are sent to a Dynamic Distribution Group aren't delivered to all the recipients.

## Cause

By default, when you create a Dynamic Distribution Group, the `RecipientContainer` parameter is set to the organizational unit (OU) in which the Dynamic Distribution Group is created, if it isn't selected explicitly.

The categorizer searches only under the OU that is mentioned in the `RecipientContainer` parameter. It uses the `RecipientFilter` parameter to select the members of the Dynamic Distribution Group to deliver email messages to.

Users who are part of another OU don't receive email messages that are sent to the Dynamic Distribution Group. This is expected behavior.

## Resolution

To fix this issue, specify the correct `RecipientContainer` parameter when you create the Dynamic Distribution Group.

For example, the following command creates a Dynamic Distribution Group that is named *Marketing Group*. It contains all users in the OU that are named *North America* who have a **Department** field that equals the **Marketing** or **Sales** strings.

```console
New-DynamicDistributionGroup -Name "Marketing Group" -IncludedRecipients "MailboxUsers,MailContacts" -ConditionalDepartment "Marketing","Sales" -RecipientContainer "North America"
```  

Additionally, you can use the following command to view members of a Dynamic Distribution Group that will receive the email messages:

```console
$marketing = Get-DynamicDistributionGroup "Marketing group" Get-Recipient -RecipientPreviewFilter $marketing.RecipientFilter -OrganizationalUnit $marketing.RecipientContainer
```
