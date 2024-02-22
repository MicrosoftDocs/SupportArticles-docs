---
title: Event ID 9519 when you mount a database
description: Describes a problem that triggers a 0x80004005 error when you try to mount a mailbox database or a public folder database, and provides resolutions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: mattrich, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
ms.date: 01/24/2024
---
# Event ID 9519 and error 0x80004005 when you try to mount a database in Exchange Server

_Original KB number:_ &nbsp; 925825

> [!NOTE]
> This article is not intended for end-users. Instead, it targets an IT Professional audience.

## Symptoms

In an Exchange Server 2016, Exchange Server 2013, Exchange Server 2010, or Exchange Server 2007 environment, you experience the following symptoms:

- If you try to mount a mailbox database or a public folder database, you experience the following:
  - You receive an error message that resembles the following:

    > Failed to mount database 'Mailbox Database'
    >
    > Mailbox Database  
    > Error:  
    > Exchange is unable to mount the database that you specified. Specified database: d1cdba46-6f79-46f2-ba14-3ae2fa8aad43; Error code: MapiExceptionCallFailed: Unable to mount database. (hr=0x80004005,ec=-2147467259).

  - The following events are logged in the Application log:

    > Event ID 9519 Event ID 9518

- When you try to log on to the computer, Windows stops responding (hangs) at the **Applying computer settings** stage of the logon process.

## Cause

This problem may occur if the *DomainName*\Exchange Servers group isn't assigned the **Manage auditing and security log** user right.

To resolve this problem, use one of the following methods:

## Resolution 1: Run Setup /PrepareAD

Run the `Setup /PrepareAD`  command from the Exchange Server CD to prepare the Active Directory directory service for Exchange Server 2010 or Exchange Server 2007. This command restores the Exchange Server configuration in Active Directory. For more information about how to prepare Active Directory, see the How to Prepare Active Directory and Domains topic in Exchange Server Help. To view this help topic, follow these steps for the appropriate program.

- Exchange Server 2010
    1. Start Exchange Server 2010 Help.
    2. Click the **Contents** tab, expand **Deployment**, expand **New Installation**, expand **Preparing to Deploy Exchange 2010**, and then click **How to Prepare Active Directory and Domains**.
- Exchange Server 2007
    1. Start Exchange Server 2007 Help.
    1. Click the **Contents** tab, expand **Deployment**, expand **New Installation**, expand **Preparing to Deploy Exchange 2007**, and then click **How to Prepare Active Directory and Domains**.

## Resolution 2: Add the Exchange Servers group to the Manage auditing and security log policy

To add the Exchange Servers group to the **Manage auditing and security log** policy, follow these steps:

1. Log on to a domain controller by using an account that has administrative rights.
2. Click **Start**, point to **Administrative Tools**, and then click **Domain Controller Security Policy**.
3. In the Default Domain Controller Security Settings Microsoft Management Console (MMC) snap-in, expand **Local Policies**, and then click **User Rights Assignment**.
4. In the right pane, double-click **Manage auditing and security log**.
5. In the **Manage auditing and security log Properties** dialog box, click **Add User or Group**.
6. In the **User and group names** box, type *\<DomainName>\Exchange Servers*, and then click **OK** two times.
7. Exit the Default Domain Controller Security Settings MMC snap-in, and then wait for this security setting to propagate across the domain controllers in the domain.
8. Restart the Exchange Information Store service.
