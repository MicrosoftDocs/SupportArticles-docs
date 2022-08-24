---
title: Can't upgrade to System Center 2012 R2 Service Manager
description: Fixes an issue in which an upgrade from System Center 2012 Service Manager SP1 to System Center 2012 Service Manager R2 fails and returns a ReportLibrary.mpb error.
ms.date: 08/04/2020
ms.reviewer: adoyle
---
# Upgrade to System Center 2012 R2 Service Manager fails and returns a ReportLibrary.mpb error

This article helps you fix an issue in which an upgrade from Microsoft System Center 2012 Service Manager Service Pack 1 (SP1) to Microsoft System Center 2012 R2 Service Manager fails and returns a ReportLibrary.mpb error.

_Original product version:_ &nbsp; System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 2909838

## Symptoms

When you try to upgrade from System Center 2012 Service Manager SP1 to System Center 2012 R2 Service Manager, the installation fails, and the following error is logged in the Setup log:

> ImportMsiPackage: Loading management pack C:\Program Files\Microsoft System Center 2012\Service Manager\ReportLibrary.mpb.
>
> ImportBundle: We are using the Client API to load the MP.
>
> ImportBundle: Created the package reader.
>
> ImportBundle: Read the msi package.
>
> ImportBundle: Error: Unable to load management pack C:\Program Files\Microsoft System Center 2012\Service Manager\ReportLibrary.mpb
>
> : Verification failed with 1 errors:
>
> \-------------------------------------------------------
>
> Error 1:
>
> Found error in 2|ServiceManager.ConfigurationManagement.Report.Library|7.5.3079.0|ServiceManager.ConfigurationManagement.Report.Library|| with message:
>
> Could not load management pack \<ID=Microsoft.SystemCenter.ConfigurationManager.Datawarehouse, KeyToken=31bf3856ad364e35, Version=7.5.3079.0>. The management pack was not found in the store.
>
> : Version mismatch. The management pack (\<Microsoft.SystemCenter.ConfigurationManager.Datawarehouse, 31bf3856ad364e35, 7.5.2905.0>) requested from the database was version 7.5.3079.0 but the actual version available is 7.5.2905.0.

## Cause

This problem occurs if the Sccmdw.mpb file is not imported during the installation process. The file isn't imported if the value of its **Date Modified** property is greater than the value of its **Date Created** property. When the .msi installer tries to replace the Sccmdw.mpb file, it determines by the date properties that the file has been modified. Therefore, it doesn't overwrite the file.

## Resolution

To resolve this problem, follow these steps:

1. On the Service Manager data warehouse server, navigate to the Service Manager installation folder.
2. In the installation folder, examine the **Date Created** and **Date Modified** properties of the Sccmdw.mpb file.
3. If the property values differ, delete or rename the Sccmdw.mpb file.
4. Try again to upgrade to System Center 2012 R2 Service Manager.
