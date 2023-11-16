---
title: Service may not start after patch installed
description: This article provides a resolution for the problem that occurs after the patch installer installs a patch and attempts to restart the system.
ms.date: 11/09/2020
ms.custom: sap:Installation, Patching and Upgrade
---
# SQL Server service may not start after patch installed

This article helps you resolve the problem that occurs after the patch installer installs a patch and attempts to restart the system.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 961301

## Symptom

You may receive a message that a SQL Server service has failed to start. The SQL Server fails to restart after the patch installer installs a patch and attempts to restart the system. The error message will be displayed on the screen or will appear in the *summary.txt* log.

## Cause

This may be caused by a SQL Service is running but the password has expired. When the patch installer tries to restart the SQL Service will fail on restart.

## Resolution

If you receive a message that a SQL Server service failed to start, to troubleshoot the issue check the following:

- Determine the error. A message would either be shown in the UI or in the *summary.txt* log located at *%programfiles%\Microsoft SQL Server\100\Setup Bootstrap\Log*.

- Verify if the type of startup service is automatic or manual.

- Verify that the account and password is valid and hasn't expired. A service could have been running previously with an invalid account or password.

- If the Database engine service will not start, after checking service credentials and startup, check the ERRORLOG. The ERRORLOG can be located at *C:\Program Files\Microsoft SQL Server\\\<Instance ID>\MSSQL\LOG*.
