---
title: CU doesn't apply to your installation
description: This article provides a resolution for the problem that occurs when you use WSUS, Microsoft Update, or Microsoft System Center Configuration Manager Software Updates to apply updates to Microsoft SQL Server.
ms.date: 01/11/2021
ms.custom: sap:Database Engine
ms.reviewer: troymoen 
---
# Non-applicable SQL Server CUs are listed in WSUS, MU, or ConfMgr

This article helps you resolve the problem that occurs when you use WSUS, Microsoft Update (MU), or Microsoft System Center Configuration Manager software updates to apply updates to Microsoft SQL Server.

_Original product version:_ &nbsp; SQL Server 2016, SQL Server 2014, SQL Server 2012 Enterprise, SQL Server 2012, SQL Server 2017 on Windows (all editions), SQL Server 2014  
_Original KB number:_ &nbsp; 4047327

> [!NOTE]
> The Microsoft Update detection logic is updated for newer cumulative update (CU) releases and GDR releases going forward. This article is valid for the following servicing releases:
>
>- SQL Server releases through SQL Server 2014: All CU releases
>- SQL Server 2016: All CU releases for RTM and SP1 baselines. SP2 baseline CU releases through CU13
>- SQL Server 2017: RTM baseline CU releases through CU18
>- SQL Server 2019: None
>- All security releases through 2020

For information about the updates to the detection logic for newer CU releases and future security releases, see [Updates to the Microsoft Update detection logic for SQL Server servicing](../windows/new-mu-servicing-model.md).

## Symptoms

When you use WSUS, MU, or System Center Configuration Manager Software Updates to apply updates to SQL Server, you notice that some of the listed cumulative updates (CU) don't apply to your SQL Server installation.

## Cause

SQL Server updates are published to the Update service. Distribution channels such as the Windows built-in automatic update service and System Configuration Manager Software Updates Management can scan Update for SQL Server updates.  

Each SQL Server update that is listed in Update has a list of applicability rules that are evaluated in order to determine whether an update is applicable.  

For a CU to be displayed as applicable to a SQL Server installation, at least one CU has to be installed on that updates baseline.  

> [!NOTE]
> Baseline in this context refers to an RTM or Service Pack release.

For example, consider a scenario in which the latest CU for SQL Server 2014 Service Pack 2 (SP2) is Cumulative Update 6 (CU6). Currently, the latest update that is installed on the system is SQL Server 2014 SP2. You run an Update scan of the system, and you notice that no CUs are listed as applicable. You manually download and install SQL Server 2014 SP2 Cumulative Update 1. You run the Update scan again, and now you notice that SQL Server 2014 SP2 Cumulative Update 6 is listed as applicable.

## Resolution

To fix this issue, manually download and install any SQL Server Cumulative Update that applies to the baseline build. After this is performed, the latest cumulative update that is released to Update will be listed as applicable.

## More information

This behavior is by design. The system administrator can install a CU to determine the servicing branch that SQL Server should follow.  

Each servicing baseline (RTM or a service pack) includes two servicing branches:

- A General Distribution Release (GDR) branch that contains only Security and other Critical fixes.

- A CU branch that contains Security and other Critical fixes plus all other fixes for the baseline.

Currently, the MU detection logic is constructed so that instances on a servicing baseline or along the GDR branch are offered the GDR branch.

Users have to proactively install at least one CU to align the instance to the CU branch. However, after this is done, you cannot return to the GDR branch until the instance baseline is either reset by moving up to the next Service Pack or all CUs for the baseline are manually uninstalled. If all CUs are uninstalled, this moves the instance back to the GDR branch or servicing baseline.

This logic helps to minimize the default number of changes that are required in the event of a Security or other Critical update. Instances that are on the CU branch must necessarily accept all updates in the event that a required Security or other Critical release is provided for the baseline. This includes all cumulative nonsecurity changes for the baseline up to the point of the required Security update.

## Applies to

- SQL Server 2017 on Windows (all editions)
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Standard
- SQL Server 2016 Web
- SQL Server 2016 Business Intelligence
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Standard
- SQL Server 2014 Web
- SQL Server 2014 Business Intelligence
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Business Intelligence
