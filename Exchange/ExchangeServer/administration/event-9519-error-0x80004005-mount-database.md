---
title: Event ID 9519 when you mount a database
description: Resolves a problem that causes a 0x80004005 error when you mount a mailbox database or a public folder database.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Unable to Mount Database
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11999
ms.reviewer: mattrich, v-six, v-kccross
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 06/05/2026
---

# Event ID 9519 and error 0x80004005 when you try to mount a database in Microsoft Exchange Server

_Original KB number:_ &nbsp; 925825

## Summary

You encounter Event ID 9519, Event ID 9518, and error 0x80004005 when you mount a mailbox or public folder database. The server might also stop responding during startup. This issue occurs because the Exchange Servers group doesn’t have the **Manage auditing and security log** user right on domain controllers. Without this permission, Microsoft Exchange Server can’t access required security log operations. Therefore, the database can't mount.
To resolve the issue, use Group Policy to add the Exchange Servers group to the **Manage auditing and security log** policy, and then restart the Exchange Information Store service.

## Symptoms

If you mount a mailbox database or a public folder database, you experience the following symptoms:

- You receive an error message that resembles the following message:

    > Failed to mount database 'Mailbox Database'
    >
    > Mailbox Database  
    > Error:  
    > Exchange is unable to mount the database that you specified. Specified database: d1cdba46-6f79-46f2-ba14-3ae2fa8aad43; Error code: MapiExceptionCallFailed: Unable to mount database. (hr=0x80004005,ec=-2147467259).

- The Application log records the following events:

    > Event ID 9519 Event ID 9518

If you sign on to the computer, Windows stops responding at the **Applying computer settings** stage of the process.

## Cause

This problem might occur if the *DomainName*\Exchange Servers group isn't assigned the [Manage auditing and security log](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/manage-auditing-and-security-log) user right.

## Resolution

Add the Exchange Servers group to the Manage auditing and security log policy.

To add the Exchange Servers group to the **Manage auditing and security log** policy, follow these steps:

1. Use an account that has sufficient administrative permissions to sign in to a domain controller.

1. Open Group Policy Management.

1. In the console tree, expand **Forest** > **Domains** > ***DomainName***, and then select **Domain Controllers**.

1. Right-click **Default Domain Controllers Policy**, and then select **Edit**.

1. In the **Group Policy Management Editor**, navigate to:

**Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **User Rights Assignment**

1. In the right pane, double-click **Manage auditing and security log**.

1. Select **Add User or Group**, enter ***DomainName*\Exchange Servers**, and then select **OK**.

1. Select **OK** to close the dialog box.

1. Close the **Group Policy Management Editor**, and wait for the policy to replicate to domain controllers, or run `gpupdate /force` to apply the changes.

1. Restart the Microsoft Exchange Information Store service.
