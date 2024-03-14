---
title: Software updates introduction
description: Introduces software updates in Configuration Manager 2012 and 2012 R2.
ms.date: 12/05/2023
ms.reviewer: kaushika, jchornbe
ms.custom: sap:Application Management\Software Center
---
# Software updates in Configuration Manager

_Original product version:_ &nbsp; Configuration Manager (current branch), Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 3092358

Software updates in Configuration Manager provide a set of tools and resources that can help manage the complex task of tracking and applying software updates to client computers in the enterprise. An effective software update management process is necessary to maintain operational efficiency, overcome security issues, and maintain the stability of the network infrastructure. Because of the changing nature of technology and the continual appearance of new security threats, effective software update management requires consistent and continual attention.

## Summary

[Software updates synchronization](/mem/configmgr/sum/understand/software-updates-introduction#BKMK_Synchronization) in Configuration Manager uses Microsoft Update to retrieve software updates metadata. The top-level site synchronizes with Microsoft Update on a predetermined schedule or when you manually start synchronization from the Configuration Manager console. When Configuration Manager finishes software updates synchronization at the top-level site, software updates synchronization starts at child sites if they exist. When synchronization is complete at each primary site or secondary site, a site-wide policy is created that provides client computers with the location of the software update points.

After the client receives the policy, the client starts a scan for software updates compliance and writes the information to Windows Management Instrumentation (WMI). The compliance information is then sent to the management point. From there, the information is sent to the site server. For each software update, a state message is created that contains the compliance state for the update. The state messages are sent in bulk to the management point and then to the site server. There, the compliance state is inserted into the site database. The compliance state for software updates is displayed in the Configuration Manager console. For more information about compliance assessment, see [Software updates compliance assessment](/mem/configmgr/sum/understand/software-updates-introduction#BKMK_SUMCompliance).

When you deploy software updates or when an automatic deployment rule runs and deploys software updates, a deployment assignment policy is added to the machine policy for the site. The software updates are downloaded from the download location, the Internet, or network shared folder, to the package source. The software updates are copied from the package source to the content library on the site server, and then copied to the content library on the distribution point. For more information about software update deployment, see [Software update deployment process](/mem/configmgr/sum/understand/software-updates-introduction#BKMK_DeploymentProcess).

## References

For more information about understanding, maintaining, and troubleshooting the software update process, see the following resources:

- [Track software update synchronization](track-software-update-synchronization.md)
- [Track software update compliance assessment](track-software-update-compliance-assessment.md)
- [Track the software update deployment process](track-software-update-deployment-process.md)
- [Troubleshoot software update synchronization](troubleshoot-software-update-synchronization.md)
- [Troubleshoot software update scan failures](troubleshoot-software-update-scan-failures.md)
- [Troubleshoot software update deployments](troubleshoot-software-update-deployments.md)
