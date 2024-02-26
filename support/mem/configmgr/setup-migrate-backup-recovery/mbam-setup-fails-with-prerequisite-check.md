---
title: MBAM 2.0 Setup prerequisite checker fails
description: Error retrieving Configuration Manager server role settings for Reporting Services Point role. This error occurs when running BitLocker Administration and Monitoring prerequisite checker in System Center 2012 Configuration Manager.
ms.date: 12/05/2023
ms.reviewer: kaushika, manojse, lacranda, kaushika
---
# MBAM 2.0 Setup fails with Error retrieving Configuration Manager Server role settings

This article provides a solution for the issue that Microsoft BitLocker Administration and Monitoring (MBAM) prerequisite checker fails when you run the MBAM 2.0 Setup in System Center 2012 Configuration Manager.

_Original product version:_ &nbsp; BitLocker Administration and Monitoring 2.0, Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2870847

## Symptoms

If you run MBAM 2.0 Setup on a System Center 2012 Configuration Manager (ConfigMgr) server, the MBAM prerequisite checker fails with this error message:

> Error retrieving Configuration Manager server role settings for 'Reporting Services Point' role

## Cause

If you have a Configuration Manager topology that includes the Central Administration Site (CAS) role, the Primary Site role or the Secondary Site role, MBAM 2.0 requires that the Reporting Service Point role be installed on the Configuration Manager server that has the CAS role installed.

## Resolution

To resolve this issue, perform the following steps:

1. Install the Reporting Service Point role on the Configuration Manager server that has the CAS role.

    For more information, see the following articles:

    - [Supported Configurations for Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg682077(v=technet.10))
    - [Install Sites and Create a Hierarchy for Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg712320(v=technet.10))

2. Make sure that the account used to execute MBAM 2.0 setup on the Configuration Manager server has the correct permissions on the server. For more information, see [Planning to Deploy MBAM with Configuration Manager](/microsoft-desktop-optimization-pack/mbam-v2/planning-to-deploy-mbam-with-configuration-manager-2).

## More information

When MBAM 2.0 is installed in Configuration Manager Integration topology, MBAM 2.0 prerequisites perform the following checks:

- Check ConfigMgr connectivity
- Check ConfigMgr version
- Check ConfigMgr user permissions
- Check that the ConfigMgr server is considered a primary site system
- Check that the ConfigMgr server has the Desired Configuration Management (DCM) agent enabled
- Check that the ConfigMgr server has the Hardware Inventory agent enabled
- Check that ConfigMgr has SQL Server Reporting Services (SSRS) integration enabled
- Check SSRS user permissions
- Checking if any ConfigMgr objects are already installed.

For more information, see [Using MBAM with Configuration Manager](/microsoft-desktop-optimization-pack/mbam-v2/using-mbam-with-configuration-manager).
