---
title: Error 2901 adding a Citrix XenServer as a host
description: Fixes an issue in which you get error 2901 when you add a Citrix XenServer to Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# Adding a Citrix XenServer to Virtual Machine Manager fails with error 2901

This article helps you fix an issue in which you get error 2901 when you add a Citrix XenServer to Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2679668

## Symptoms

Adding a Citrix XenServer 6.0 computer as a host in System Center 2012 Virtual Machine Manager fails with the following error:

> Error (2901)  
> The operation did not complete successfully because of a parameter or call sequence that is not valid.
>
> Recommended Action  
> Ensure that the parameters are valid, and then try the operation again.

## Cause

This can occur in either of the following situations:

- The certificate name doesn't match the name you're using in the wizard.
- You need to disable automatic creation of logical networks and virtual networks.

## Resolution

If the certificate name matches the name you are using in the wizard, turn off the automatic creation of local network and virtual networks in the Virtual Machine Manager console. To do this, navigate to **Settings**, select **General**, double-click **Network Settings**, and then uncheck the following boxes:

- **Create logical networks automatically**  
- **Create virtual networks automatically**
