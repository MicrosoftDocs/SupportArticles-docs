---
title: ConfigMgr clients are automatically upgraded
description: Configuration Manager clients are automatically upgraded to the Service Pack 1 client version after an upgrade to Configuration Manager 2012 R2 SP1 CU1. Provides a workaround.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Client Installation, Registration and Assignment\Client Upgrade
---
# Clients are automatically upgraded after you update to System Center 2012 R2 Configuration Manager SP1 CU1

This article provides a workaround to an issue in which clients are automatically upgraded after you update to System Center 2012 R2 Configuration Manager Service Pack 1 (SP1) CU1.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3123029

## Symptom

After an upgrade to System Center 2012 R2 Configuration Manager SP1 CU1, Configuration Manager clients are automatically upgraded to the SP1 client version.

## Cause

This is a known issue in which the Configuration Manager Client Retry Task is created under Microsoft\Microsoft\Configuration Manager in **Task Scheduler**. After it's installed, the Configuration Manager client cannot delete the scheduled task that was created in this location. Therefore, the client is scheduled to be reinstalled every 5 hours.

## Workaround

To work around this issue, delete the scheduled task that is created under Microsoft\Microsoft\Configuration Manager in **Task Scheduler**.
