---
title: Can't distribute packages to a remote DP
description: Describes an issue in which distributing packages to a remote DP fails because the Site System Installation Account for the remote DP is used to connect to the remote content library.
ms.date: 12/05/2023
ms.custom: sap:Boot images
ms.reviewer: kaushika
---
# Package distribution to a remote distribution point fails because of a logon failure

This article helps you work around an issue in which you can't distribute packages to a remote distribution point (DP).

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4508653

## Symptoms

Consider the following scenario:

- You configure a remote content library for the site server on another server in the same domain, _CONTOSO.COM_.
- You have a remote site system server as a DP that's in an untrusted domain, _FABRIKAM.COM_.
- You select the **Use another account for installing this site system** option for the remote site system, and you specify an account that has local administrative rights on that server.

In this scenario, distributing packages to the remote DP fails, and you receive the following error messages in the PkgXferMgr.log file on the site server:

> Date Time    SMS_PACKAGE_TRANSFER_MANAGER    7280 (0x1c70)    Found send request with ID: 26, Package: DAL0000C, Version:1, Priority: 2, Destination: DP.FABRIKAM.COM, DPPriority: 200  
> Date Time    SMS_PACKAGE_TRANSFER_MANAGER    4892 (0x131c)    Sending thread starting for Job: 26, package: DAL0000C, Version: 1, Priority: 2, server: DP.FABRIKAM.COM, DPPriority: 200  
> Date Time    SMS_PACKAGE_TRANSFER_MANAGER    4892 (0x131c)    ~"FABRIKAM\\\<AccountName>" user will be used to connect to the remote DP machine "DP.FABRIKAM.COM"  
> Date Time    SMS_PACKAGE_TRANSFER_MANAGER    4892 (0x131c)    Sending legacy content DAL0000C.1 for package DAL0000C  
> Date Time    SMS_PACKAGE_TRANSFER_MANAGER    4892 (0x131c)    CContentDefinition::TotalFileSizes failed; 0x8007052e  
> Date Time    SMS_PACKAGE_TRANSFER_MANAGER    4892 (0x131c)    CSendFileAction::SendFiles failed; 0x8007052e  
> Date Time    SMS_PACKAGE_TRANSFER_MANAGER    4892 (0x131c)    CSendFileAction::SendContent failed; 0x8007052e

Additionally, event 4625 is logged on the server that hosts the content library:

> Log Name: &nbsp; &nbsp; Security  
> Source: &nbsp; &nbsp; &nbsp; &nbsp;Microsoft-Windows-Security-Auditing  
> Event ID: &nbsp; &nbsp; &nbsp;4625  
> Task Category: Logon  
> Level: &nbsp; &nbsp; &nbsp; &nbsp; Information  
> Keywords: &nbsp; &nbsp; Audit Failure  
> User: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;N/A  
> Computer: &nbsp; &nbsp; &nbsp;STORAGE.CONTOSO.COM  
> Description:  
> An account failed to log on.
>
> Account For Which Logon Failed:  
> Security ID:  NULL SID  
> Account Name:  \<AccountName>  
> Account Domain:  FABRIKAM

> [!NOTE]
> FABRIKAM\\\<AccountName> represents the **Site System Installation Account** for the remote DP.

## Cause

This issue occurs because Configuration Manager incorrectly uses the **Site System Installation Account** for the remote site system to connect to the remote content library.

## Workaround

To work around this issue, follow these steps:

1. Create a local account on the server that hosts the content library.
2. Assign the new account the same name as the **Site System Installation Account** that is configured for the remote site system.
3. Grant the new account access to the content library folder.

This action enables pass-through authentication to work around the distribution failure that occurs because Configuration Manager incorrectly uses the **Site System Installation Account**.

If you notice error entries for Microsoft SQL Server authentication in the DistMgr.log file, follow the steps in [Site system installation account is incorrectly used for a remote site system to connect to SQL Server database](../setup-migrate-backup-recovery/site-system-installation-account-used-for-db-connection.md) to work around the issue.
