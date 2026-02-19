---
title: Microsoft Deployment Toolkit support lifecycle
description: Discusses the support lifecycle for Microsoft Deployment Toolkits.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, scottmca, v-jesits
ms.custom:
- sap:windows setup,upgrade and deployment\installing or upgrading windows
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Microsoft Deployment Toolkit support lifecycle

This article discusses the support lifecycle for Microsoft Deployment Toolkits.

_Original KB number:_ &nbsp; 2872000

##  Microsoft Deployment Toolkit (MDT) is now retired

> [!IMPORTANT]
> **Microsoft Deployment Toolkit (MDT) is retired.** MDT integration with Configuration Manager and MDT Standalone are **no longer supported**. To prevent task sequence corruption and modification failures, **remove all MDT task sequence steps**, and then **remove MDT integration**. Consider moving to modern provisioning solutions such as Windows Autopilot to obtain cloud‑driven, zero‑touch provisioning for Windows devices. [Learn more about Autopilot](/windows/deployment/windows-autopilot/windows-autopilot). For customers who have on-premises infrastructure and existing Configuration Manager environments, OSD remains a fully supported option.
>
>For full details about this retirement, see the [Removed and Deprecated Features](/intune/configmgr/core/plan-design/changes/deprecated/removed-and-deprecated-cmfeatures) page.

## More information

Microsoft Deployment Toolkits use the following support lifecycle:

- MDT releases will support only scenarios that use underpinning technologies that are still under their mainstream support policy.
- MDT releases will be supported for one (1) year after the next version is released, whichever date is last.
Currently supported version: [Microsoft Deployment Toolkit (latest released build)](https://www.microsoft.com/download/details.aspx?id=54259)
These earlier product versions are not available for download and are no longer supported:
- Microsoft Deployment Toolkit 2013  (8443)
- Microsoft Deployment Toolkit 2013 Update 2
- Microsoft Deployment Toolkit (MDT) 2013 Update 1
- Microsoft Deployment Toolkit (MDT) 2012 Update 1
- Microsoft Deployment Toolkit (MDT) 2013
- Microsoft Deployment Toolkit 2010 Update 1, September 2010 release
- Microsoft Deployment Toolkit 2010 (RTW), September 2009 release
- Microsoft Deployment Toolkit 2008 Update 1, September 2008 release
- Microsoft Deployment Toolkit 2008, March 2008 release
- Microsoft Deployment, November 2007 release
- Business Desktop Deployment 2007 Update 2, March 2008 release
- Business Desktop Deployment 2007 Update 1, May 2007 release
- Business Desktop Deployment 2007, January 2007 release
- Business Desktop Deployment 2.5, August 2005 release
Microsoft Deployment Toolkit is supported only during local business hours.

## Additional "Applies to" products

Microsoft Deployment Toolkit 2013 Update 1
Microsoft Deployment
Business Desktop Deployment 2007 Update 1
Business Desktop Deployment 2007
Business Desktop Deployment 2.5

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
