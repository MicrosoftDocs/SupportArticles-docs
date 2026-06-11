---
title: MigrationPermanentException Active Directory property homeMDB isn't writeable on recipient
description: Fixes an issue in which you receive the Active Directory property homeMDB isn't writeable on recipient error when you move a mailbox to Microsoft 365.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:From or To Exchange Online
  - CSSTroubleshoot
appliesto: 
- Exchange Server SE 
- Exchange Server 2019 
- Exchange Server 2016 
- Exchange Online
search.appverid: MET150
ms.reviewer: ninob, jarrettr, v-six, v-kccross
author: cloud-writer
ms.author: meerak
ms.date: 06/05/2026
---

# "Active Directory property homeMDB isn't writeable on recipient" error if you move a mailbox to Microsoft 365

## Summary

You receive the "Active Directory property homeMDB isn't writeable on recipient" error when you move a mailbox to Microsoft 365. This error occurs because Microsoft Exchange Server doesn’t have permission to update the mailbox in Active Directory. This issue occurs if permission inheritance is disabled on the user account or if the Exchange Server-based server that's used for the move isn’t in the required role groups (Exchange Servers and Exchange Trusted Subsystems).

## Symptoms

If you move an on-premises Exchange mailbox to Microsoft 365, you receive the following error message:

```console
   Error: MigrationPermanentException: Active Directory property homeMDB isn't writeable on recipient contoso.com/Users/mailbox. --> Active Directory property homeMDB is not writeable on recipient contoso.com/Users/mailbox.
```

## Cause

This issue occurs for either or both of the following reasons:

- The **Include Inheritable permission from this object's parent/Enable Inheritance** checkbox isn't selected.
- The on-premises Exchange server that's used for proxy isn't a member of the **Exchange Servers** and **Exchange Trusted Sub Systems** role groups.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that the **Include Inheritable permission from this object's parent** or **Enable Inheritance** checkbox is selected in the **\<User Account\> Properties** dialog box of Active Directory. Follow these steps:

    1. Open **Active Directory Users and Computers**, select **View**, and then select the **Advanced Features** option.
    1. Open **Active Directory Users and Computers**, locate the affected user, select **\<User Account\> Properties,** select **Security**, and then select **Advanced**.
    1. Select the **Include Inheritable permission from this object's parent** or **Enable Inheritance** check box (depending on the UI version).

1. Make sure that all servers that are running Exchange Server in the organization are the members of the **Exchange Servers** and **Exchange Trusted Sub Systems** role groups. To check or add members, follow these steps:

    1. Open **Active Directory Users and Computers**.
    1. Select **Microsoft Exchange Security Groups**.
    1. Select **Exchange Servers/Exchange Trusted Sub Systems**, select **Properties**, and then select **Members**.
    1. Select **Add**.
