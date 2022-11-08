---
title: Can't install SQL Server when only an RODC is reachable
description: This article discusses an issue in which you can't install SQL Server when only a read-only domain controller (RODC) is available.
ms.date: 11/8/2022
author: ramakoni1
ms.author: v-shwetasohu
ms.prod: sql
ms.custom: sap:Database Engine
---

# You can't install SQL Server by using a service account when only an RODC is reachable

This article discusses an issue in which you can't install SQL Server when only a read-only domain controller (RODC) is available.

## Symptoms

Consider the following scenario:
- You have a perimeter network (also known as a DMZ, demilitarized zone, and a screened subnet) that only has an RODC available.
- You have a member server in the perimeter network.
You try to install  SQL Server on the member server and use an Active Directory service account for the SQL Server service.

In this scenario, the installation wizard fails when the installation program validates your account.

## Cause

When you log on to a computer for the first time and try to encrypt data , the operating system creates a preferred Data Protection Application Programming Interface (DPAPI) MasterKey, which is based on your current password. During the creation of the DPAPI MasterKey, an attempt is made to back up this master key by contacting an RWDC. If the backup fails, the MasterKey cannot be created, and this results in failure.

## Workaround

To work around this issue, use the built-in account to install SQL Server. Then, change the account that is used for the services to an Active Directory service account. For other resolutions and additional information, see [DPAPI MasterKey backup failures](../../windows-server/identity/dpapi-masterkey-backup-failures.md).

## References

[Installing SQL Server on a domain controller](/sql/sql-server/install/security-considerations-for-a-sql-server-installation?view=sql-server-ver15&preserve-view=true)