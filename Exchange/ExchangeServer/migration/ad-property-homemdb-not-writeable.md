---
title: MigrationPermanentException Active Directory property homeMDB is not writeable on recipient
description: Fixes an issue in which you receive the Active Directory property homeMDB isn't writeable on recipient error when moving a mailbox to Microsoft 365.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Exchange Server 2010 
- Exchange Server 2013 
- Exchange Server 2016 
- Exchange Online
search.appverid: MET150
ms.reviewer: ninob, genli, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# "Active Directory property ‎'homeMDB‎' isn't writeable on recipient" error when moving a mailbox to Microsoft 365

## Symptoms

When you move an on-premises Exchange mailbox to Microsoft 365, you receive the following error message:

> Error: MigrationPermanentException: Active Directory property ‎'homeMDB‎' isn't writeable on recipient ‎`contoso.com/Users/mailbox`. --> Active Directory property ‎'homeMDB‎' is not writeable on recipient `‎contoso.com/Users/mailbox‎‎`.

## Cause

This issue occurs for either or both of the following reasons:

- The **Include Inheritable permission from this object's parent/Enable Inheritance** check box is not selected.
- The on-premises server that's running Microsoft Exchange Server that's used from proxy isn't a member of the **Exchange Servers** and **Exchange Trusted Sub Systems** role groups.

## Resolution

To resolve this problem, follow these steps:

1. Make sure that the **Include Inheritable permission from this object's parent/Enable Inheritance** check box is selected in the **\<User Account\> Properties** dialog box of Active Directory. To do this, follow these steps:

    1. Open **Active Directory Users and Computers**, select **View**, and then select the **Advanced Features** option.
    2. Open **Active Directory Users and Computers**, locate the affected user, select **\<User Account\> Properties,** select **Security**, and then select **Advanced**.
    3. Select the **Include Inheritable permission from this object's parent/Enable Inheritance** check box.

1. Make sure that all servers that are running Exchange Server in the organization are the members of the **Exchange Servers** and **Exchange Trusted Sub Systems** role groups. To check or add members, follow these steps:

    1. Open **Active Directory Users and Computers**.
    2. Select **Microsoft Exchange Security Groups**.
    3. Select **Exchange Servers/Exchange Trusted Sub Systems**, select **Properties**, and then select **Members**.
    4. Select **Add**.
