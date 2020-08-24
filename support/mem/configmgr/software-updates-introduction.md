---
title: Software updates introduction
description: Introduces software updates in Configuration Manager 2012 and 2012 R2.
ms.date: 06/04/2020
ms.prod-support-area-path:
ms.reviewer: jchornbe
---
# Software updates in Configuration Manager

This article introduces software updates in Configuration Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3092358

## Summary

Software updates in Configuration Manager provide a set of tools and resources that can help manage the complex task of tracking and applying software updates to client computers in the enterprise. An effective software update management process is necessary to maintain operational efficiency, overcome security issues, and maintain the stability of the network infrastructure.

## Software updates synchronization

Software updates synchronization in Configuration Manager uses Microsoft Update to retrieve software updates metadata. The top-level site synchronizes with Microsoft Update on a predetermined schedule or when you manually start synchronization from the Configuration Manager console. When Configuration Manager finishes software updates synchronization at the top-level site, software updates synchronization starts at child sites if they exist. When synchronization is complete at each primary site or secondary site, a site-wide policy is created that provides client computers with the location of the software update points.

After the client receives the policy, the client starts a scan for software updates compliance and writes the information to Windows Management Instrumentation (WMI). The compliance information is then sent to the management point. From there, the information is sent to the site server. For each software update, a state message is created that contains the compliance state for the update. The state messages are sent in bulk to the management point and then to the site server. There, the compliance state is inserted into the site database. The compliance state for software updates is displayed in the Configuration Manager console.

For more information about software updates synchronization process, see [Software updates synchronization](/mem/configmgr/sum/understand/software-updates-introduction#BKMK_Synchronization).

## Software update deployment packages

For more information, see [Software update deployment packages](/mem/configmgr/sum/understand/software-updates-introduction#BKMK_DeploymentPackages).

## Software update deployment process

For more information, see [Software update deployment process](/mem/configmgr/sum/understand/software-updates-introduction#BKMK_DeploymentProcess).

## References

For more information about understanding, maintaining, and troubleshooting the software update process, see the following resources:

- [Troubleshoot software update scan failures in Configuration Manager](troubleshoot-software-update-scan-failures.md)

- [Using log files to track the software update deployment process in Configuration Manager](track-software-update-deployment-process.md)

- [Troubleshoot software update deployments in Configuration Manager](troubleshoot-software-update-deployments.md)

- [Software updates maintenance in Configuration Manager](software-update-maintenance.md)
