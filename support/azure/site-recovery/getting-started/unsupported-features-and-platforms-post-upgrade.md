---
title: Unsupported Features and Platforms post upgrade to Azure Recovery Services Scout 8.0.1
description: Describes the information about Unsupported Features and Platforms post upgrade to Azure Recovery Services Scout 8.0.1.
author: genlin
ms.author: genli
ms.service: azure-site-recovery
ms.date: 04/15/2024
ms.reviewer: mabisth
ms.custom: sap:I need help getting started with Site Recovery
---
# Unsupported Features and Platforms post upgrade to Azure Recovery Services Scout 8.0.1

[!INCLUDE [CentOS End Of Life](../../../includes/centos-end-of-life-note.md)]

_Original product version:_ &nbsp; Azure Site Recovery  
_Original KB number:_ &nbsp; 3120174

Azure Recovery Services Scout 8.0.1 removed support for all Application Protection, P2P, Backup Solutions, virtual snapshot, Unix platforms. However the same is not removed from the product. Any continued usage of the same will not be covered under the Microsoft support agreement. For a more detailed list of unsupported features and configurations, refer to the EOL Support Depreciation list below.

The Azure Recovery Services Scout 8.0.1 feature set is equivalent of the InMage vContinuum feature set. For a complete list of the Azure Recovery Services Scout 8.0.1 feature set, see the [compatibility matrix](https://download.microsoft.com/download/c/d/a/cda1221b-74e4-4ccf-8f77-f785e71423c0/inmage_scout_standard_compatibility_matrix.pdf).
Microsoft has stopped distributing all versions of ScoutOS ISOs. Users need to download the required CentOS ISO from the internet and install required packages before installing RX.

EOL of Support from previous releases:

### Deprecated Solutions (Not Supported)

* Any Application aware features (MSSQL, File Server, MS Exchange, Oracle, Oracle RAC, DB2, MySQL, SharePoint, BES) protection/failover/failback

* Backup features (Virtual Snapshot, backup validation, volpack, long-term retention, Scout Mail Recovery)

* Fx and any Fx based solutions

### Deprecated Deployment and Configuration (Not Supported)

* 1 to many replications

* CX HA

* Standby CX

### Deprecated Platforms (Not Supported)

* Linux CX (Configuration Server and Process Server)

* Ubuntu

* RHEL4

* Debian

* AIX

* Solaris

### Deprecated Hypervisors (Not Supported)

* All virtual to virtual scenarios are deprecated (except VMware 5.1 and 5.5)

* For Physical to Virtual, target has to be VMware 5.1 or 5.5. For source details, refer to the Azure Recovery Services Scout 8.0.1 compatibility matrix

Maximum supported retention size is up to 15 days  

Appliances using InMage Scout products are no longer supported

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
