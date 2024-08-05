---
title: ApplicationPoolIdentity not working with App_Data
description: This article provides resolutions for access denied error that occurs when a web application writes data to the ASP.NET App_Data folder in IIS 7.5 and later versions.
ms.date: 04/15/2020
ms.custom: sap:Security
ms.reviewer: danma
---
# ApplicationPoolIdentity doesn't have write permission to ASP.NET App_Data folder

This article helps you resolve the problem that an error (access denied) occurs when a web application writes data to the ASP.NET *App_Data* folder.

_Original product version:_ &nbsp; Internet Information Services 7.5 and later versions  
_Original KB number:_ &nbsp; 2005172

## Symptoms

A web application is created using Microsoft Visual Studio and then published to Internet Information Services (IIS) 7.5 or a later version. As part of the application's request processing, it needs to write data to the *App_Data* folder on the server. For example, the application uses a `SQLDataSource` or `XMLDataSource`. When it attempts to do so, an error message similar to the following is displayed:

> Exception Details: System.UnauthorizedAccessException: Access to the path [path to App_Data folder] is denied.

## Cause

Beginning in IIS 7.5 and later versions, the default identity for an application pool is ApplicationPoolIdentity. When a web application is created using Visual Studio, the *App_Data* folder is not automatically configured to allow write access for ApplicationPoolIdentity. Therefore the attempt to write to the *App_Data* folder will fail.

## Resolution

To work around this behavior, grant both read and write ACL permissions to the ApplicationPoolIdentity (IIS APPPOOL\ApplicationPool) on the *App_Data* folder.

## More information

ApplicationPoolIdentity is a managed service account, which is a new concept introduced in Windows Server 2008 R2. For more information on managed service accounts, see [What's New in Service Accounts](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd367859(v=ws.10))
