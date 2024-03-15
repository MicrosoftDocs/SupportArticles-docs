---
title: Service Manager workflows display Needing attention
description: Fixes an issue where new service requests don't change status, workflows don't execute, and list item changes aren't saved in System Center 2012 Service Manager.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# Service Manager workflows don't execute and list item changes aren't saved

This article helps you fix an issue where new service requests don't change status, workflows don't execute, and list item changes aren't saved in Microsoft System Center 2012 Service Manager.

_Original product version:_ &nbsp; System Center 2012 Service Manager, System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 3029574

## Symptoms

When new service requests (SRs) are submitted in System Center 2012 Service Manager, the status of the SRs doesn't change from **New**. Additionally, corresponding workflows don't execute for other work items, and the workflows display **Needing attention** in the console under **Administration** > **Workflows** > **Status**.

Also, after you change a list item in the console, close the console, and then reopen the console, the change is no longer present in the list.

The list item behavior can also be observed for any secondary management server. In some cases, you may not see any issues on the primary workflow server. Even though the primary workflow server appears to be functioning correctly, you won't see any updates made from the primary server on the secondary server.

## Cause

This issue can occur if Microsoft SQL Server Service Broker isn't enabled on the Service Manager database. When the Service Manager database is created, Service Broker is enabled. However, if a disaster-recovery scenario is met and the database has to be restored, Service Broker will be disabled when the restoration is finished, and Service Broker must be enabled manually.

## Resolution

To resolve this issue, enable SQL Server Service Broker. To do this, follow these steps:

> [!NOTE]
> Do this at a time when the Management Server services can be stopped.

1. On the management server or servers, open the `Services.msc` in Microsoft Management Console (MMC) snap-in.
2. Take one of the following actions, depending on your version of Service Manager:

    - For System Center 2012 Service Manager and System Center 2012 Service Manager Service Pack 1 (SP1), stop the following services:

        - System Center Management Configuration Service
        - System Center Management Service
        - System Center Data Access Service

    - For System Center 2012 R2 Service Manager, stop the following services:

        - System Center Management Configuration Service
        - System Center Data Access Service
        - Microsoft Monitoring Agent Service

3. Start Microsoft SQL Server Management Studio on the Service Manager database server or on a computer that has the SQL Server tools installed and that can connect to the Service Manager database server.

4. Select **New Query**.
5. In the navigation pane, expand **Databases**, and then select **ServiceManager**.
6. In the **details** pane, type the following command, and then select **Execute**:

    ```sql
    SELECT is_broker_enabled FROM sys.databases WHERE name = 'ServiceManager'
    ```

7. In the results that are displayed, verify the value that's displayed in the **is_broker_enabled** field. SQL Server Service Broker is disabled if this value is **0** (zero).

8. In the **details** pane, type the following command, and then select **Execute**:

    ```sql
    ALTER DATABASE ServiceManager SET ENABLE_BROKER
    ```

9. Verify that the command succeeded. If it did, SQL Server Service Broker is now enabled.

10. On the management server or servers, take one of the following actions, depending on your version of Service Manager:

    - For System Center 2012 Service Manager and System Center 2012 Service Manager Service Pack 1, start the following services:

        - System Center Management Configuration Service
        - System Center Management Service
        - System Center Data Access Service

    - For System Center 2012 R2 Service Manager, start the following services:

        - System Center Management Configuration Service
        - System Center Data Access Service
        - Microsoft Monitoring Agent Service

11. Close all open windows and dialog boxes.
12. Test the workflows by restarting any workflow that needs attention.
13. Submit a new service request, and verify that it moves to the **In Progress** state.
