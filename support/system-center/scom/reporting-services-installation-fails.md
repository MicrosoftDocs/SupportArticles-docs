---
title: Can't install Reporting Services in System Center Operations Manager
description: Troubleshoot the "Data Reader account provided is not same" error when installing Reporting Services in System Center Operations Manager.
ms.reviewer: blakedrumm
ms.date: 09/26/2022
---
# "Data Reader account provided is not same" error when Reporting Services fails to install

_Applies to:_ &nbsp; System Center Operations Manager

## Symptoms

When you try to install Reporting Services in System Center Operations Manager, you receive the following error message:

> Data Reader account provided is not same as that in the management group.

## Cause

This issue occurs because of the profile misconfiguration, which causes problems with data warehouse workflows.

## Resolution

To fix the issue, reconfigure the profiles as follows:

1. Set the Data Warehouse Report Deployment account to be used for the following classes:

    - Collection Server
    - Data Warehouse Synchronization Server

    :::image type="content" source="media/reporting-services-installation-fails/data-warehouse-report-deployment-account-profile.png" alt-text="Screenshot shows the configuration of the Data Warehouse Report Deployment account.":::

1. Set the Data Warehouse Action account to be used for the following classes:

    - Collection Server
    - Data Warehouse Synchronization Server
    - Data Set
    - Operations Manager APM Data Transfer Service

    :::image type="content" source="media/reporting-services-installation-fails/data-warehouse-action-account-profile.png" alt-text="Screenshot shows the configuration of the Data Warehouse Action account.":::

After the reconfiguration, Reporting Services can be installed successfully with the Data Warehouse Report Deployment account.
