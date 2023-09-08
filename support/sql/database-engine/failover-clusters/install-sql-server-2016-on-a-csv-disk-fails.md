---
title: Installation of SQL Server on a CSV disk fails
description: Provides a workaround for permissions problem that occurs when you install SQL Server 2016 on a CSV disk.
ms.date: 07/22/2020
ms.custom: sap:High Availability and Disaster Recovery features
ms.reviewer: Mnilson, cmathews
---
# Error occurs when you install SQL Server 2016 on a Cluster Shared Volume disk

This article helps you work around the permissions problem that occurs when you install SQL Server 2016 on a Cluster Shared Volume (CSV) disk.

_Original product version:_ &nbsp; SQL Server 2016 Standard, SQL Server 2016 Enterprise  
_Original KB number:_ &nbsp; 4082888

## Symptoms

Assume that you try to install an instance of Microsoft SQL Server 2016 on a CSV disk, you may receive an error that resembles the following:

> TITLE: Microsoft SQL Server 2016 Setup
>
> The following error has occurred:  
>
> Updating permission setting for folder 'C:\ClusterStorage\volume1\Data1\' failed. The folder permission setting were supposed to be set to 'D:P(A;OICI;FA;;;BA)(A;OICI;FA;;;SY)(A;OICI;FA;;;CO)(A;OICI;FA;;)'.
>
> Click 'Retry' to retry the failed action, or click 'Cancel' to cancel this action and continue setup.

## Cause

The folder that has been chosen for the database locations has **Inheritable Permissions** button enabled.

## Workaround

The workaround for this issue is as follows:

Assume that we are using the folder `C:\ClusterStorage\Volume1\Data1\` as an example.

1. Navigate to `C:\ClusterStorage\Volume1\`.
2. Right-click the **Data1** folder, and then select the **Properties** button.
3. Select the **Security** tab, and then select the **Advanced** button at the bottom.
4. Select the **Disable Inheritance** button, and then choose the **Convert inherited permissions into explicit permissions on this object** option.
5. Retry the install again.
