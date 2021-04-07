---
title: Support for Microsoft Dynamics CRM with SQL Server 2012
description: This article describes support for running Microsoft Dynamics CRM 2011 with Microsoft SQL Server 2012.
ms.reviewer: chanson
ms.topic: article
ms.date: 
---
# Support for Microsoft Dynamics CRM with Microsoft SQL Server 2012

Microsoft Dynamics CRM 2011 (Update Rollup 6) are compatible with Microsoft SQL Server 2012.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2686619

> [!NOTE]
> Microsoft Dynamics CRM 2011 support installing and running Dynamics CRM on Microsoft SQL Server 2012. Microsoft SQL 2012 has a new feature called Always On, which has been tested and is supported with Microsoft Dynamics CRM 2011. For more information, see [Set configuration and organization databases for SQL Server AlwaysOn failover](/previous-versions/dynamicscrm-2016/deployment-administrators-guide/jj822357(v=crm.8)).

## Issues that may occur when using Microsoft Dynamics CRM 2011 with Microsoft SQL Server 2012

- After upgrading to Microsoft SQL Server 2012, you will need to reinstall the Microsoft Dynamics CRM Reporting Extensions. The custom binaries do not get brought over during the upgrade so the Microsoft Dynamics CRM Reporting Extensions need to be reinstalled.
- When using Microsoft SQL Server 2012 Express with the Microsoft Dynamics CRM Client for Microsoft Office Outlook, you get the following error:

  > CrmSqlStartupSvc:SqlShutdownEvent cannot stop service of SQL Express with as "SQL Express service could not be stopped".

  This issue has been fixed in [Microsoft Dynamics CRM 2011 Update Rollup 8](https://support.microsoft.com/help/2600644).
