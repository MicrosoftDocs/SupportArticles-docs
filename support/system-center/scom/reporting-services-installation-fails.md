---
title: Can't install Reporting Services in System Center Operations Manager
description: Troubleshoot the "Data Reader account provided is not same" error when installing Reporting Services in System Center Operations Manager.
ms.reviewer: blakedrumm, luisferreira, alexkre, jarrettr, msadoff
ms.date: 09/26/2022
---
# "Data Reader account provided is not same" error when installing Reporting Services

_Applies to:_ &nbsp; System Center Operations Manager

## Symptoms

When you try to install Reporting Services in System Center Operations Manager, you receive the following error message:

> Data Reader account provided is not same as that in the management group.

## Cause

This issue occurs because there is misconfiguration of the **Data Warehouse Report Deployment Account** and **Data Warehouse Account** Run As profiles, which causes problems with data warehouse workflows. Data Warehouse Maintenance and running of reports will fail if the default action account doesn’t have necessary SQL permissions.

## Resolution

To fix the issue, reconfigure the profiles as follows:

### Step 1: Data Warehouse Report Deployment Account profile

1. Set the Data Warehouse Report Deployment account to be used for the following classes:

    - Collection Server
    - Data Warehouse Synchronization Server

    :::image type="content" source="media/reporting-services-installation-fails/data-warehouse-report-deployment-account-profile.png" alt-text="Screenshot shows the configuration of the Data Warehouse Report Deployment account.":::

### Step 2: Data Warehouse Account profile

1. Set the Data Warehouse Action account to be used for the following classes:

    - Collection Server
    - Data Warehouse Synchronization Server
    - Data Set
    - Operations Manager APM Data Transfer Service

    :::image type="content" source="media/reporting-services-installation-fails/data-warehouse-action-account-profile.png" alt-text="Screenshot shows the configuration of the Data Warehouse Action account.":::

After the reconfiguration, you can install Reporting Services successfully by using the Data Warehouse Report Deployment account.

> [!NOTE]
> If you are still having issues verify the System Center Operations Manager database (*OperationsManager* and *OperationsManagerDW*) permissions are set correctly.
