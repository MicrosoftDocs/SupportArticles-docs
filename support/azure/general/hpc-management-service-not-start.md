---
title: HPC Management Service fails to initialize
description: Provides a solution for an issue where HPC Management Service fails to start after you restore a corrupted database
ms.date: 09/14/2022
ms.service: azure-common-issues-support
ms.author: v-weizhu
author: AmandaAZ
ms.reviewer: hclvteam 
---
# HPC Management Service fails to start after restoring database

This article provides a solution for an issue where HPC Management Service fails to start after you restore a corrupted database.

## Symptoms

After you restore a corrupted HPC management database, HPC management service fails to initialize. When you reboot the computer multiple times, all other services are in running status. However, HPC Management Service still doesn't start.

The following error is shown in HPC Management event logs.

> Level Date and Time Source Event ID Task Category Error 7/13/2020 14:06 Microsoft-HPC-Management 6106 Initialization The HPC Management Service failed to initialize correctly: The instance collection of ids cannot be resolved in the current instance view.

## Cause

Check HPC Management event logs:

:::image type="content" source="media/hpc-management-service-not-start/instancecacheloadexception.png" alt-text="Screenshot that shows HPC Management event logs.":::

HPC Management Service crashed with "InstanceCacheLoadException". The instances are sql instances. Many instances are in wrong state. For each instance, there's only one version in "Current" state (for example, 2), but in your HPCManagement  database, there are tens of instances with 2 or 3 version in "Current" state.

## Resolution

To resolve the issue, run the PowerShell script [FixInstanceErrorState.ps1](https://microsoft-my.sharepoint.com/:t:/p/zanawab/ERUPyvekYd1BhWCjAZt-8r0BBvLxbDYDjvCeTJUMjllgaw?e=hpo1Lc). To do this, follow these steps:

1. Run PowerShell as an Administrator.

2. Run the following command:

    ```powershell
    .\FixInstanceErrorState.ps1 -ServerInstance SQLserver -Database HpcManagement
    ```

3. Restart the HPC SDM and HPC Management service.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]