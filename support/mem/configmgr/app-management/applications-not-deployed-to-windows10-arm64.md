---
title: Applications aren't deployed to Windows 10 ARM64 devices
description: Describes an issue in which applications that are deployed to Windows 10 devices in an earlier version of Configuration Manager aren't deployed to Windows 10 ARM64 devices.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Application Management\Application Deployment (Devices)
---
# Applications aren't deployed to Windows 10 ARM64 devices in Configuration Manager

This article helps you resolve an issue in which applications deployed to Windows 10 devices in an earlier version of Configuration Manager aren't deployed to Windows 10 ARM64 devices.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4338726

## Symptoms

Consider the following scenario:

- You have Configuration Manager current branch version 1710 or a later version that's installed in a hybrid mobile device management (MDM) environment.
- You have Windows 10 ARM64 devices that are enrolled in this environment.
- An application was deployed to Windows 10 devices in an earlier version of Configuration Manager.

In this scenario, the application isn't automatically deployed to the Windows 10 ARM64 devices.

## Cause

This issue occurs because Windows 10 ARM64 isn't automatically added to the list of supported operating systems for the application.

## Resolution

To fix this issue, manually update the deployment type of the application, and then redeploy the application. To do this, follow these steps:

1. In the Configuration Manager console, go to **Software Library** > **Application Management** > **Applications**.
2. In the **Applications** list, right-click the application that you want to deploy to Windows 10 ARM64 devices, and then select **Properties**.
3. Select the **Deployment Types** tab, select the deployment type, and then select **Edit**.
4. Select the **Requirements** tab, select the operating system requirement, and then select **Edit**.
5. Under **Windows 10**, select **All Windows 10 (ARM64)**, and then select **OK** three times to close all dialog boxes.
6. Select the **Deployments** tab, and then note the existing deployments.
7. Delete deployments to the following collections:

   - Device collections that include Windows 10 ARM64 devices.
   - User collections that include users who have Windows 10 ARM64 devices enrolled.

8. Re-create the deleted deployments.
