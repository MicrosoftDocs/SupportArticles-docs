---
title: An I/O error when you use Backup to URL
description: This article provides a resolution for the nonrecoverable I/O error that occurs when you use the Backup Database to URL command in SQL Server.
ms.date: 09/15/2020
ms.custom: sap:Administration and Management
ms.prod: sql
---
# Backup to URL fails with nonrecoverable I/O error 3271 in SQL Server

This article helps you resolve the `nonrecoverable I/O` error that occurs when you use the Backup Database to URL command in SQL Server.

_Original product version:_ &nbsp; SQL Server 2012 Enterprise, SQL Server 2014 Enterprise, SQL Server 2014 Enterprise  
_Original KB number:_ &nbsp; 3177997

## Symptoms

You try to back up a database on your Azure-based SQL Server virtual machine (IaaS) by using the Backup Database to URL command. However, the attempt fails with the following error:

> Msg 3271, Level 16, State 1, Line 7  
A nonrecoverable I/O error occurred on file "https://sqlbakurl.blob.core.windows.net/backupcontainer/demodb.bak:" Backup to URL received an exception
from the remote endpoint.  
Exception Message: The remote server returned an error: (400) Bad Request.  
Msg 3013, Level 16, State 1, Line 7  
BACKUP DATABASE is terminating abnormally.

## Cause

This issue occurs if the storage account that you're trying to back up to was created with the **Account Kind** setting set to **Blob**. The **Account Kind** setting should be **General Purpose**.

:::image type="content" source="media/nonrecoverable-io-error-backup-url/general-purpose-storage-account.png" alt-text="Screenshot of the drop-down menu of the Account kind setting in the Create storage account dialog box." border="false":::

## Resolution

To resolve this issue, create a new storage account, and specify **General Purpose** for the **Account Kind** setting. Also, designate a container in this storage account for backup to URL.

## More information

When the account kind is set to **General Purpose**, this provides support for page blob files. SQL Server backup uses page blobs as the Blob type. For more information, see [SQL Server backup and restore with Windows Azure Blob Storage Service](/previous-versions/sql/sql-server-2012/jj919148(v=sql.110)).
