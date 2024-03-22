---
title: Reports Dictionary must be upgraded
description: Provides a solution to an error that occurs when you try to sign in to Microsoft Dynamics GP after you copy the reports.dic file to a shared location.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# "Reports Dictionary must be upgraded" Error message when you try to sign in to Microsoft Dynamics GP after you copy the reports.dic file to a shared location

This article provides a solution to an error that occurs when you try to sign in to Microsoft Dynamics GP after you copy the reports.dic file to a shared location.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857506

## Symptoms

When you try to sign in to Microsoft Dynamics GP or to Microsoft Business Solutions - Great Plains 8.0 after you copy the reports.dic file to a shared location, you receive the following error message:

> Reports Dictionary must be upgraded

## Cause

This problem occurs because of a synchronization problem between the new client and the reports.dic file.

## Resolution

To resolve this problem, follow the steps below:

> [!NOTE]
> Try to sign in to Microsoft Dynamics GP after you complete each step. If you continue to receive the error message, go to the next step.

1. Make sure that all client computers use the same version and service pack of Microsoft Dynamics GP. Additionally, they must use the same version of Dexterity. To make sure that the client computers use the same version, use the appropriate step:
   - In Microsoft Dynamics GP, select **Help**, and then select **About Microsoft Dynamics GP**.
   - In Microsoft Business Solutions - Great Plains 8.0, select **Help**, and then select **About Microsoft Business Solutions - Great Plains**.

2. Synchronize the modified forms and reports by using Great Plains Utilities. To do it, follow these steps:

    1. Start Great Plains Utilities. To do it, follow the appropriate step:

        - In Microsoft Dynamics GP 10.0 and higher versions, select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 10.0** (or appropriate version), and then select **Utilities**.
        - In Microsoft Dynamics GP 9.0, select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, point to **GP 9.0**, and then select **Utilities**.
        - In Microsoft Business Solutions - Great Plains 8.0, select **Start**, point to **All Programs**, point to **Microsoft Business Solutions**, point to **Great Plains**, and then select **Great Plains Utilities**.

    2. In the **Additional Tasks** window, select **Synchronize forms and reports dictionaries**, and then select **Process**.
    3. Locate the Dynamics.set file on the client computer, and then select **Next**.

3. On the client computer that is working correctly, copy the Dynamics.dic file to the client computers that aren't working correctly.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
