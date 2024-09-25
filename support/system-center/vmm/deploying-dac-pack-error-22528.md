---
title: Error 22528 when deploying a DAC pack
description: Fixes an issue in which you receive error 22528 when deploying a data-tier application pack in System Center 2012 Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# Deploying a DAC pack in System Center 2012 Virtual Machine Manager fails if using a named SQL instance

This article fixes an issue in which you receive error 22528 when deploying a data-tier application pack in System Center 2012 Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2679704

## Symptoms

When deploying a SQL data-tier application (DAC) pack using System Center 2012 Virtual Machine Manager, if the name of the SQL instance in the DAC pack is blank then the service template will fail with the following error:

> Error (22528)  
> The connection to SQL Server on the virtual machine (*VMName*) failed for the SQL Server data-tier application (*Application Name*).  
> DetailedErrorMessage: Failed to connect to server (local).  
>
> Recommended Action  
> Verify the specified SQL Server connection information for the SQL Server data-tier application.

## Cause

When deploying a DAC pack or creating a SQL server using a service template, the SQL instance must match the instance name specified when you created the generalized VHD (Syspreped). Otherwise the service template will fail with **Instance Not Found**.

## Resolution

Edit the DAC pack to specify the correct instance name or edit the service template to match the instance name of the original VHD.
