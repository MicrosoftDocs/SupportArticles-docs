---
title: A user can't create new rules in Outlook or Outlook on the web
description: Describes an issue in which a user cannot add new rules in Microsoft Outlook or in OWA in an environment that uses Microsoft Exchange.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Exchange Online
- Microsoft Exchange Online Dedicated
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
search.appverid: MET150
ms.reviewer: danabeck, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# A user cannot create new rules in Outlook or Outlook on the web

## Symptoms

A user cannot create new rules in Microsoft Outlook or in Outlook on the web (OWA). Additionally, the user receives the following error message:

> One or more rules cannot be uploaded to Microsoft Exchange and have been deactivated. This could be because some of the parameters are not supported, or there is insufficient space to store all of your rules.

## Cause

This issue occurs because, by default, the size limit of the rules in the mailbox is set at 64 kilobytes. If the size of the rules reaches this limit, the user receives an error message.

## Resolution

To resolve this issue, increase the size limit for rules in the mailbox. To do this, follow these steps:

1. To determine the size limit for rules in a mailbox, run the following command in the Exchange Management Shell:

    ```powershell
    get-mailbox -identity <mailbox> | fl *rulesquota*  
    ```

2. If the current size limit is less than 256 kilobytes, run the following command to increase the size limit to 256 kilobytes:

    ```powershell
    set-mailbox -identity <mailbox> -RulesQuota 256kb
    ```

> [!NOTE]
> This is an Active Directory cached attribute and changing it may take up to two hours to take effect.

## More Information

Tenant admins can also increase the size limit of the rules for their users in a Microsoft 365 environment. For more information, see [Ask the Microsoft Community](https://answers.microsoft.com/msoffice/forum).

If you are in a dedicated or an ITAR Microsoft 365 environment and experiencing this issue, members of the Limited Recipient Management self-service group can increase rules quota by using the commands in the Resolution section (12.3 version of the service and later versions).  You may also escalate to Microsoft Online Services Support.
