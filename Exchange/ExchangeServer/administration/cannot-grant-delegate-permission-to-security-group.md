---
title: Sharing invitation couldn't be sent
description: Error is triggered when a user in an Exchange Server 2013 environment tries to grant Delegate permissions to a security group through their Calendar. Workarounds are provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Error in Outlook Web App when Exchange Server 2013 users try to grant Delegate permissions to a security group: Sharing invitation couldn't be sent

_Original KB number:_ &nbsp; 3188800

## Symptoms

An Exchange Server 2013 user tries to grant Delegate permissions through Calendar sharing to a security group by using Outlook Web App. However, the user receives the following error message:

> The sharing invitation couldn't be sent to the following recipients:Groupalias@contoso.com. Please try again later.

## Cause

The behavior is by design in Exchange Server 2013.

## Workaround

To work around this issue, use one of the following methods:

- Use an Outlook client to grant delegate permissions to the security group. For more information, see [Allow someone else to manage your mail and calendar](https://support.microsoft.com/office/allow-someone-else-to-manage-your-mail-and-calendar-41c40c04-3bd1-4d22-963a-28eafec25926).
- Install Exchange Server 2016.
