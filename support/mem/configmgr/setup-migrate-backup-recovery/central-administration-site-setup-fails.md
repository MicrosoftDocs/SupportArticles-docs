---
title: Can't expand a stand-alone primary site
description: Describes an issue in which a central administration site setup fails when you expand a stand-alone primary site. This issue occurs when the two-factor authentication is enabled in hierarchy settings.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Attaching a central administration site to a stand-alone primary site fails when two-factor authentication is enabled

This article helps you fix an issue in which a central administration site setup fails when you expand a stand-alone primary site.

_Original product version:_ &nbsp; Configuration Manager (current branch - version 1810)  
_Original KB number:_ &nbsp; 4494361

## Symptom

You have a Configuration Manager current branch version 1810 stand-alone primary site. Two-factor authentication is enabled in the hierarchy settings.

When you try to expand the stand-alone primary site by installing a central administration site, the central administration site setup fails. The following errors are logged in the ConfigMgrSetup.log file:

> Configuration Manager Setup    INFO: Updating primary site's site control file in CAS's database.  
> Configuration Manager Setup    \*** insert into vSMS_SC_GlobalProperty (SiteNumber, PropertyName, Value1, Value2, Value3) values (1, N'{3B1F3900-A186-11d0-BDA9-00A0C909FDD7} Authentication', N'', N'', 0)~;select convert(BIGINT, SCOPE_IDENTITY())  
> Configuration Manager Setup    *** [42000][50000][Microsoft][SQL Server Native Client 11.0][SQL Server]Cannot insert Authentication property vSMS_SC_GlobalProperty in this context : tr_vSMS_SC_GlobalProperty_ins

## Cause

This issue occurs because the **Authentication** global property can only be replicated by using the Data Replication Service (DRS). If the global property is updated directly without using DRS, the `tr_vSMS_SC_GlobalProperty_ins` trigger raises the error.

## Resolution

To fix this issue, update the stand-alone primary site to [Update Rollup 2 for Configuration Manager version 1810](https://support.microsoft.com/help/4488598) or [Configuration Manager version 1902](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1902), and then reattach the central administration site.

## Workaround

To work around this issue in Configuration Manager current branch version 1810:

1. Change the authentication level to disable two-factor authentication:

   1. In the Configuration Manager console, go to the **Administration** workspace, expand **Site Configuration**, and select the **Sites** node.
   2. Select **Hierarchy Settings** in the ribbon.
   3. Switch to the **Authentication** tab.
   4. Select an authentication level other than **Windows Hello for Business authentication**, and then select **OK**.

1. To delete the Authentication property, run the following SQL query on the primary site database:

    ```sql
    DELETE p
    FROM SC_GlobalProperty p
    INNER JOIN SC_GlobalProperty_Property gp ON p.ID = gp.GlobalPropertyID AND gp.Name=N'{3B1F3900-A186-11d0-BDA9-00A0C909FDD7} Authentication'
    ```

1. Reattach the central administration site.
