---
title: Operations Manager can't monitor APS appliance
description: This article provides resolutions for the error where the SQL Server Analytics Platform System appliance isn't monitored in System Center Operations Manager.
ms.date: 08/05/2020
ms.custom: sap:Parallel Data Warehouse (APS)
ms.reviewer: krlange
---
# System Center Operations Manager can't monitor SQL Server Analytics Platform System appliance

This article helps you resolve the problem where System Center Operations Manager can't monitor SQL Server Analytics Platform System appliance.

_Original product version:_ &nbsp; SQL Server 2012 Parallel Data Warehouse, SQL Server 2008 R2 Parallel Data Warehouse  
_Original KB number:_ &nbsp; 4034603

## Symptoms

Consider the following scenario:

- You installed the Microsoft System Center Operations Manager Management Packs.
- You add a SQL Server Analytics Platform System (APS) appliance by running `new-apsappliance.ps1`.
- You set up the Watcher and Monitoring accounts.

In this scenario, the appliance isn't monitored, and you experience one of the following issues:

- **Issue A:** The appliance isn't discovered and isn't visible in Operations Manager.
- **Issue B:** The appliance is listed in Operations Manager but is in the **NOT MONITORED** state.

## Cause

This issue is caused by an error that occurs during discovery. To see the error information, check the Operations Manager event log on the watcher node. The following error scenarios can occur.

- **Scenario A:**

    Errors for the APS watcher account, such as an incorrect password.

- **Scenario B:**

    Error logged in the event log:

    ```console
    SQL2012APS MP.Appliance:<Fabric name>.Script:APSApplianceNodesDiscovery.vbs: Connection failed
    Error Number: 16389
    Description: [Microsoft][ODBC Driver Manager] Data source name not found and no default driver specified
    ```

    > [!NOTE]
    > This is an ambiguous error. APS no longer requires a DSN. The appliance information is added and used in the registry.

## Resolution

To fix this issue, follow these steps as appropriate for the error scenario.

- **For Scenario A:**

    Correct the password in Operations Manager.

- **For Scenario B:**

  - Verify that the appliance is added to the registry of the watcher node.

    > [!NOTE]
    > The IP that's specified must be for the APS Control Node IP. It should be located under the following registry subkey:
    > `HKLM\SOFTWARE\Microsoft\Analytics Platform System\Management Pack\Appliances`

  - Verify that SQL Server Native Client is installed.
