---
title: Disk space exhaustion causes SSAS crash
description: This article describes a Microsoft SQL Server Analysis Services (SSAS) crash error that occurs when disk space is exhausted.
ms.date: 08/03/2020
ms.custom: sap:Analysis Services
ms.reviewer: jburchel, daleche
ms.prod: sql
---
# Disk space exhaustion during the rollback of a failed processing job causes SSAS to crash

This article describes a Microsoft SQL Server Analysis Services (SSAS) crash error that occurs when disk space is exhausted on the system hosting the SSAS instance.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4088924

## Symptoms

Any release of SSAS crashes when it experiences an I/O error during the rollback of a failed processing job. When this problem occurs, the following error message may be logged in the Application log:

> File system error: The following error occurred while writing to the file 'LazyWriter Stream': There is not enough space on the disk. .  
File system error: The background thread running lazy writer encountered an I/O error.

## More information

This problem may occur if the available disk space is exhausted. This problem can cause an emergency shutdown of the service. The shutdown resembles a crash, although it is internally initiated.

During the rollback operation, some I/O is required to wrap up the transaction. Disk exhaustion can cause I/O failure. This makes it impossible to roll back the transaction deterministically to a consistent state. The server should not continue serving any data while it is in an inconsistent state. In this situation, the only way to recover is to shut down the server and then force it to restart.

When the server restarts, a cleanup operation occurs before any data is made available for querying. This operation can safely enumerate through all the files in the data directory. The cleanup removes any files that are not confirmed as valid and part of the expected data.

## Applies to

- SQL Server 2017 on Windows (all editions)
- SQL Server 2017 on Linux (all editions)
- SQL Server 2016 Enterprise
- SQL Server 2014 Enterprise
- SQL Server 2012 Enterprise
