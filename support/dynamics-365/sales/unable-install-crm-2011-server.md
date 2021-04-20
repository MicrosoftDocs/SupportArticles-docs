---
title: Unable to install CRM 2011 server
description: Provides a solution to an error that occurs during installation of Microsoft Dynamics CRM server on Windows Server 2012 using the Volume Licensing ISO.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Unable to install Microsoft Dynamics CRM 2011 server on Windows Server 2012 from Volume Licensing

This article provides a solution to an error that occurs during the installation of Microsoft Dynamics CRM server on Windows Server 2012 using the Volume Licensing ISO.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2868216

## Symptoms

Error occurs during the installation of Microsoft Dynamics CRM server on Windows Server 2012 by using the Volume Licensing ISO to install bits.

Error message:

> Setup cannot proceed because an error occurred while copying installer files to the local system: The upgrade cannot be installed by the Windows Installer service because the program to be upgraded may be missing, or the upgrade may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct upgrade. (setup.cpp:CCrmSetup::CopyInstallerFiles:488)

## Cause

It's because Volume Licensing ISO contains RTM bits (version: 5.0.9688.583)  
To install Microsoft Dynamics CRM on Windows Server 2012, we need CRM server version: 5.0.9690.1992 (Slip stream version with Update rollup 6)

## Resolution

Install bits from [Microsoft Dynamics CRM Server 2011](https://www.microsoft.com/download/details.aspx?id=27822), and provide the Volume Licensing Service Center product key during installation. The license Key should be located in installation files contained on the media for the `\server\amd64\license.txt` file.
