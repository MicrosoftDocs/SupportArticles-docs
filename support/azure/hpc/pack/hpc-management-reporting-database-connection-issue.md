---
title: Resolve HPC reporting database connection problem
description: Resolve a high-performance computing (HPC) reporting database connection problem in the HPC Cluster Manager.
ms.date: 10/17/2022
editor: v-jsitser
ms.reviewer: cargonz, v-leedennis
ms.service: hpcpack
#Customer intent: As a Microsoft HPC Pack user, I want to resolve a reporting database connection problem in the HPC Cluster Manager so that I can successfully use a high-performance computing (HPC) management database.
---
# Resolve an HPC reporting database connection problem

Resolve a high-performance computing (HPC) reporting database connection problem in the Microsoft HPC Cluster Manager.

## Symptoms

In the HPC Cluster Manager, after you select another reporting database in the **Charts and Reports** pane, the Cluster Manager can no longer connect to the database, and you receive an error message that resembles the following text:

> The HPC Cluster Manager cannot connect to the reporting database. Please check connection string 'Data Source=\<data-source-name>;Initial Catalog=TCHPCReporting;Integrated Security=True;' and make sure you have access.
>
> Cannot open database 'TCHPCReporting' requested by the login. The login failed.  
> Login failed for user \<user-name>.

For example, this symptom might occur if you switch between the **Cluster Utilization** and **Node Availability** reports, or to any other [HPC Pack built-in report](/powershell/high-performance-computing/using-the-reports) or custom report.

## Cause

You're using Microsoft HPC Pack 2016 Update 1. In this version of HPC Pack, the connection problem that is described in the "Symptoms" section is a known issue.

## Solution 1: Upgrade to HPC Pack 2019

Download and install [HPC Pack 2019](https://www.microsoft.com/download/details.aspx?id=101360).

## Solution 2: Use HPC Pack 2016 Update 3 and install extra fixes

To move to HPC Pack 2016 Update 3 and install some extra required fixes, follow these steps:

1. In the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\HPC\Security\ReportingDbConnectionString** registry subkey, make sure that the **connectionstring** entry is configured correctly.

1. Download and install [HPC Pack 2016 Update 3](https://www.microsoft.com/download/details.aspx?id=58506).

1. Download and install [HPC Pack 2016 Update 3 fixes](https://www.microsoft.com/download/details.aspx?id=100918).

## Solution 3: Fix the connection string

If you don't want to upgrade your installed version of HPC Pack, you can run the following SQL script manually to fix the database connection string. In the script, replace the placeholder with the exact connection string for the reporting database. To find that connection string, locate the **connectionstring** entry value in the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\HPC\Security\ReportingDbConnectionString** registry subkey.

```sql
Update [dbo].[SettingValues] set value = '<new-connection-string>' where memberId = 1886096935
```

If the error still occurs after you run the script, restart the HPC management service, and then try again to select that reporting database in HPC Cluster Manager.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
