---
title: Not a valid SMTP address in a cutover migration
description: Fixes an issue that triggers an error when you try to migrate mailboxes from an on-premises Exchange organization to Exchange Online in a cutover migration.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Not a valid SMTP address when you migrate mailboxes to Exchange Online in a cutover migration
  
_Original KB number:_ &nbsp; 2965789

## Problem

You're performing a cutover migration to migrate all mailboxes from your on-premises Exchange organization to Exchange Online. The source server for the migration is running Microsoft Exchange Server 2016, Exchange Server 2013, Exchange Server 2010, or Exchange Server 2007. However, the migration attempt fails, and you receive the following error message:

> "/o=NT5/ou=###xx##x#x##x###x##xxxx/cn=###xx##x#x##x###x##xxxx" is not a valid SMTP address"

## Cause

This issue occurs if the migration batch includes invalid or stale global address list (GAL) entries.

## Solution

To resolve this issue, follow these steps:

1. Open Exchange Management Shell on the on-premises Exchange server.
2. Run the following command:

    ```powershell
    Update-GlobalAddressList -Identity "Default Global Address List" -DomainController "NameOfDomainController"
    ```

3. Delete and then re-create the cutover migration batch in Exchange Online.

## More information

Exchange Server 2003 uses the Recipient Update Service, and this creates and maintains Active Directory attribute values. This service is not included in Exchange 2007 and later versions. Therefore, stale or invalid entries can exist on objects in Active Directory Domain Services (AD DS) in Exchange Server 2016, Exchange Server 2013, Exchange Server 2010, and Exchange Server 2007. These entries don't present an issue until you try to migrate and create new cloud objects.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
