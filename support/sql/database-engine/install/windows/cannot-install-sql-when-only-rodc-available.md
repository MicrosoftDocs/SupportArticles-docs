---
title: Can't install SQL Server when only an RODC is reachable
description: This article discusses an issue in which you can't install SQL Server when only a read-only domain controller (RODC) is available.
ms.date: 11/08/2022
ms.reviewer: ramakoni1, v-jayaramanp
ms.custom: sap:Database Engine
---

# You can't install SQL Server by using a service account when only an RODC is reachable

This article discusses an issue in which you can't install SQL Server when only a read-only domain controller (RODC) is available.

_Original product version:_ &nbsp; SQL Server  \
_Original KB number:_ &nbsp; 2962968

## Symptoms

Consider the following scenario:
- You have a perimeter network (also known as a demilitarized zone (DMZ), and a screened subnet) that only has an RODC available.
- You have a member server in the perimeter network.
You try to install SQL Server on the member server and use an Active Directory service account for the SQL Server service.

In this scenario, the installation wizard fails when the installation program validates your account.

## Cause

When you log on to a computer for the first time and try to encrypt data, the operating system creates a preferred Data Protection Application Programming Interface (DPAPI) MasterKey, which is based on your current password. During the creation of the DPAPI MasterKey, an attempt is made to back up this master key by contacting a Read Write Domain Controller (RWDC). If the backup fails, the MasterKey can't be created, and this results in failure.

## Workaround

To work around this issue, perform the following:

1. Use the built-in account to install SQL Server.
1. Change the account that is used for the services to an Active Directory service account.

For other resolutions and additional information, see [DPAPI MasterKey backup failures](../../../../windows-server/identity/dpapi-masterkey-backup-failures.md).

## References

[Installing SQL Server on a domain controller](/sql/sql-server/install/security-considerations-for-a-sql-server-installation)
