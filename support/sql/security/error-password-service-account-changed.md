---
title: Error when password for service account is changed
description: This article provides a resolution for the problem that occurs when the password for the SQL Server service account is changed.
ms.date: 10/29/2020
ms.prod-support-area-path: Security Issues
ms.prod: sql
---
# SQL Server service does not start successfully because of a logon failure

This article helps you resolve the problem that occurs when the password for the SQL Server service account is changed.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 282254

## Symptoms

When you restart Microsoft SQL Server or SQL Server Agent, the service may fail to start with the following error message:

> Error 1069: The service did not start due to a logon failure.

## Cause

This problem occurs because the password for the SQL Server startup service account or the SQL Server Agent startup service account is not correct. This problem can occur when the password for the account is changed but the password information was not updated for the SQL Server service or the SQL Server Agent service.

## Resolution

To solve this problem, type the correct password in the SQL Server service account on the SQL Server host computer. To do this, follow the procedures documented in [SCM Services - Change the Password of the Accounts Used](/sql/database-engine/configure-windows/scm-services-change-the-password-of-the-accounts-used).
