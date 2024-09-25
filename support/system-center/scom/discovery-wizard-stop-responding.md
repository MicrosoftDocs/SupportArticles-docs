---
title: The Discovery Wizard stops responding
description: Fixes an issue in which the Discovery Wizard in Microsoft System Center Operations Manager stops responding (hangs) during the discovery process.
ms.date: 04/15/2024
ms.reviewer: v-jomcc
---
# The Discovery Wizard may stop responding during the discovery process in Operations Manager

This article helps you fix an issue in which the Discovery Wizard in Microsoft System Center Operations Manager stops responding (hangs) during the discovery process.

_Applies to:_ &nbsp; Microsoft System Center Operations Manager  
_Original KB number:_ &nbsp; 941409

## Symptoms

When you run the Discovery Wizard in System Center Operations Manager, the wizard may stop responding (hang). This behavior typically occurs in the **Discovery Progress** section of the wizard.

## Cause

This issue may occur if Microsoft SQL Server Service Broker is not running on the Operations Manager SQL database.

## Resolution

To resolve this issue, you will need to enable SQL Server Service Broker. To do this, follow these steps at a time when the management server services can be stopped:

1. On the management server(s) in your management group, run `Services.msc` (Microsoft Management Console (MMC) snap-in), and stop the following services:

   - **System Center Management Configuration (cshost)**
   - **Microsoft Monitoring Agent (HealthService)**
   - **System Center Data Access Service (OMSDK)**

2. Start Microsoft SQL Server Management Studio on the Operations Manager database server or on a computer that has the SQL Server tools installed and that can connect to the Operations Manager database server.
3. Select **New Query**.
4. In the navigation pane, expand **Databases**, and then select `OperationsManager`.
5. In the **Details** pane, type the following command, and then select **Execute**:

   ```sql
   SELECT is_broker_enabled FROM sys.databases WHERE name = 'OperationsManager'
   ```

6. In the results that are displayed, verify the value that's displayed in the `is_broker_enabled` field. SQL Server Service Broker is disabled if this value is **0** (zero).
7. In the **Details** pane, type the following command, and then select **Execute**:

   ```sql
   ALTER DATABASE OperationsManager SET ENABLE_BROKER
   ```

   Check for successful completion of the TSQL command. SQL Server Service Broker is now enabled.

8. On the management server(s) in your management group, start the following services:

   - **System Center Data Access Service (OMSDK)**
   - **Microsoft Monitoring Agent (HealthService)**
   - **System Center Management Configuration (cshost)**

9. Close all open windows and dialog boxes.
10. Test the Discovery Wizard in System Center Operations Manager.

## More information

System Center Operations Manager depends on SQL Server Service Broker to implement all task operations. If SQL Server Service Broker is disabled, all task operations will be affected. The resulting behavior may vary according to the task that has been initiated. Therefore, it's important to check the state of SQL Server Service Broker whenever unexpected behavior is observed around a task in System Center Operations Manager.
