---
title: DP installations or upgrades take longer than expected
description: Describes a performance issue when installing or upgrading DPs on Configuration Manager sites that have many standard or pull distribution points.
ms.date: 12/05/2023
ms.reviewer: kaushika, brianhun, DAVSTEW, mikecure
---
# Distribution point installations or upgrades take longer than expected in System Center 2012 Configuration Manager

This article describes a performance issue when installing or upgrading distribution points (DPs) on Configuration Manager sites that have many standard or pull DPs.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, System Center Configuration Manager 2012 R2  
_Original KB number:_ &nbsp; 3025353

## Summary

On System Center 2012 Configuration Manager sites that have many standard or pull distribution points, installing or upgrading all distribution points may take longer than expected. This can occur if the Distribution Manager component cannot create additional threads for the installation or upgrade process.

Additionally, you will receive messages that resemble the following in the Distmgr.log file:

> DP upgrade processing thread: No more available threads left to process any more upgrade distribution point notification. Will wait for existing distribution point upgrades.

If you receive this message repeatedly, you can reduce the overall time that is required to complete the process by increasing the number of processing threads.

## DP upgrade thread limit

By default, Distribution Manager allocates up to five threads to install or upgrade distribution points. Each thread has a single distribution point. The default setting is recorded in the Distmgr.log file as **DP upgrade thread limit**.

**DP upgrade thread limit** is a Site Control File property that's represented as `DPUpgradeThreadLimit` in Windows Management Instrumentation (WMI). By default, this property is not present. However, when you add this property, you can override the predefined limit of five threads.

To increase the default limit, create `DPUpgradeThreadLimit` as an embedded property of the `SMS_DISTRIBUTION_MANAGER` component. This is an instance of the `SMS_SCI_Component` class in the site namespace.

To make sure that the changes take effect, restart the SMS_Executive service on the site server after you change this property.

> [!NOTE]
> Increasing the thread limit beyond the default will put additional load on the site server. Careful planning and testing should be completed to prevent the introduction of performance bottlenecks on the site server during the upgrade process. A maximum of fifty threads should be sufficient for most environments.

## References

- [How to Read and Write to the Configuration Manager Site Control File by Using WMI](/previous-versions/system-center/developer/jj885701(v=cmsdk.12)?redirectedfrom=MSDN)

- [How to Write a Configuration Manager Site Control File Embedded Property](/previous-versions/jj902804(v=msdn.10)?redirectedfrom=MSDN)

- [Planning a Content Deployment Migration Strategy in System Center 2012 Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg712275(v=technet.10)?redirectedfrom=MSDN)
