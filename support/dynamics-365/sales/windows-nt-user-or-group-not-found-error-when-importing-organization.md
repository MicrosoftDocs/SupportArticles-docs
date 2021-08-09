---
title: Import Organization failed with 0x80131904 error code
description: You may receive a Windows NT user or group not found error when importing a Microsoft Dynamics CRM 2011 organization. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Windows NT user or group not found error when trying to import a Microsoft Dynamics CRM 2011 organization

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2564514

## Symptoms

When you try to import a Microsoft Dynamics CRM organization database into an environment that previously had Dynamics CRM 2011 uninstalled and a reinstall was performed, the following error may occur.

Error message in the log file shows:

> Error| Import Organization (Name=\<ORGNAME>, Id=*ID*) failed with Exception:
>
> System.Data.SqlClient.SqlException (0x80131904): Windows NT user or group '\<DOMAINNAME>\SQLAccessGroup {*ID*}' not found. Check the name again.

## Cause

This can be caused due to the Microsoft Dynamics CRM privilege groups being left in the SQL Server Security folder when Microsoft Dynamics CRM is uninstalled.

## Resolution

To resolve this issue, remove the old Microsoft Dynamics CRM privilege groups from within the SQL Server Security Logins folder on the database server:

1. On the SQL Server, open SQL Server Management Server.

    1. Select **Start**.
    2. Select **All Programs**.
    3. Select Microsoft SQL Server 2008 or Microsoft SQL Server 2008 R2.
    4. Select **SQL Server Management Studio**.

2. Sign in to SQL Server Management Studio.

3. Expand the Security folder.

    1. Select to expand Security folder.
    2. Select to expand Logins folder.

4. Locate the CRM security groups.

    \<DOMAINNAME>\PrivReportingGroup {GUID VALUE}  
    \<DOMAINNAME>\ReportingGroup {GUID VALUE}  
    \<DOMAINNAME>\SQLAccessGroup {GUID VALUE}

5. Remove each of the security groups.

    1. Right-click on the name.
    2. Select **Delete**.
    3. Select **OK**.

6. Reattempt the organization import.
