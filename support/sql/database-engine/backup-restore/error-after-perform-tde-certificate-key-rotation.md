---
title: Error after you perform TDE certificate or key rotation
description: This article provides a resolution for the problem that occurs after you perform a Transparent Data Encryption (TDE) certificate or key rotation, drop the original certification, and then conduct a log backup using COMPRESSION+MAXTRANSFERSIZE.
ms.date: 01/15/2021
ms.custom: sap:Administration and Management
ms.reviewer: liweiyin, ramand 
---
# Msg 33111 error after SQL Server TDE certificate or key rotation

This article helps you resolve the problem that occurs after you perform a Transparent Data Encryption (TDE) certificate or key rotation, drop the original certification, and then conduct a log backup using COMPRESSION+MAXTRANSFERSIZE.

_Applies to:_ &nbsp; SQL Server 2019, SQL Server 2016, SQL Server 2014, SQL Server 2012  
_Original KB number:_ &nbsp; 4534430

## Symptoms

After you perform a Transparent Data Encryption (TDE) certificate or key rotation, drop the original certification, and then conduct a log backup using COMPRESSION+MAXTRANSFERSIZE, you receive the following error:

> Msg 33111, Level 16, State 3, Line LineNumber  
Cannot find server certificate with thumbprint '%'.  
Msg 3013, Level 16, State 1, LineLineNumber  
BACKUP LOG is terminating abnormally.

## Cause

When changing the certificate or keys, the current active Virtual Log File (VLF)-which is encrypted by the previous key-will be closed. The next available VLF (or newly created VLF) will be used and encrypted by the new certification.

At this stage, the transaction log file retains log records encrypted by the previous certificate as well as log records encrypted by new certificate.

When you conduct a log backup with COMPRESSION+MAXTRANSFERSIZE parameters, the log records that have been encrypted by the previous certificate will be decrypted and then encrypted by the new certificate, and then saved to the backup file.

Because of this, the previous certification is needed for decryption. The log backup will fail if the previous certificate does not exist.

## Resolution

Restore the previous certification and try the backup again.

> [!NOTE]
> We recommend keeping certification backups in case the issue occurs in the future.

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available.

## References

Learn about the [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
