---
title: Which ConfigMgr version to deploy a particular Windows version
description: Provides an overview of the versions of Configuration Manager that correspond to particular versions of Windows in a Windows installation scenario.
ms.date: 12/05/2023
ms.reviewer: kaushika, kimmar
ms.custom: sap:Operating Systems Deployment (OSD)\Other
---
# Which version of Configuration Manager to deploy a particular version of Windows

This article provides an overview of the versions of Configuration Manager that are required to deploy particular versions of Windows.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 2909893

## Summary

You can use Operating System Deployment (OSD) to deploy the Windows operating system and to upgrade to a newer version. However, depending on the version of Windows that you want to deploy, you may have to first upgrade the Configuration Manager version that you're using.

## Required Configuration Manager version to deploy a particular Windows version

The following table provides details about which version of Configuration Manager you need in order to deploy a particular version of Windows.

|Version of Windows being deployed| Version of Configuration Manager required |
|---|---|
|Windows 8|System Center 2012 SP1 Configuration Manager or later|
|Windows 8.1|System Center 2012 R2 Configuration Manager or System Center 2012 SP1 CU3 Configuration Manager*|
  
\* CU3 (Cumulative Update 3) requires additional configuration considerations. For information about CU3 considerations, see [How to customize Windows PE boot images to use in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/dn387582(v=technet.10)?redirectedfrom=MSDN).

For more information about operating system deployment prerequisites, see [Prerequisites for deploying operating systems in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg682187(v=technet.10)?redirectedfrom=MSDN).

## References

- [Deploy Windows 10 in a test lab using Microsoft Endpoint Configuration Manager](/windows/deployment/windows-10-poc-sc-config-mgr)
- [Windows PowerShell Requirements for System Center 2012 R2](/previous-versions/system-center/system-center-2012-R2/dn281932(v=sc.12)?redirectedfrom=MSDN)
