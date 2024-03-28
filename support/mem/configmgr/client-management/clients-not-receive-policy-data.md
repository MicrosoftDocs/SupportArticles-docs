---
title: ConfigMgr clients don't receive policy data
description: Fixes an issue that occurs if a recovery that's made from a central administration site doesn't reset session IDs in SQL Server.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Client Operations\Client Policy
---
# Configuration Manager clients don't receive policy data after you recover a primary site from a CAS

This article helps you fix an issue in which the Configuration Manager clients don't receive policy data after you recover a primary site from a central administration site (CAS).

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4095539

## Symptoms

Consider the following scenario:

- You're running Configuration Manager (current branch, version 1810, or a later version) in your hierarchy.
- The instance of Microsoft SQL Server that's hosting the database for the primary site is lost.
- You recover a primary site from a CAS on a newly installed SQL Server instance (for the primary site).

In this scenario, Configuration Manager clients don't receive policy data, and the **Configurations** tab in client properties is blank (that is, baselines aren't visible). Additionally, applications and software update deployments that were created before the recovery may not work.

## Cause

This problem occurs because the **Last Row Version** registry entry for the Object Replication Manager and Policy Provider has a higher value than that of the `rowversion` entry in the site database.

## Resolution

To fix this issue, follow these steps:

1. Stop the **SMS_Executive** and **SiteComp** services on the primary site server.
2. Run the following query on the recovered primary database to obtain the current value for `rowversion`:

    ```sql
    select min(rowversion) from CI_CIAssignments
    ```

3. Update the **Last Row Version** value at the following location to match the value that's returned from the SQL query:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_OBJECT_REPLICATION_MANAGER\CI Assignment\Last Row Version`

4. Start the **SiteComp** service on the primary site server. This will start the **SMS_executive** service.
