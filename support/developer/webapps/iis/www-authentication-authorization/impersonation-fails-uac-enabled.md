---
title: Impersonation fails when UAC is enabled
description: This article provides resolutions for the problem where an impersonation fails with IIS Express when UAC is enabled.
ms.date: 04/03/2020
ms.custom: sap:WWW authentication and authorization
ms.reviewer: robmcm
ms.technology: www-authentication-authorization
---
# Impersonation fails with IIS Express when User Account Control (UAC) is enabled

This article helps you resolve the problem where an impersonation fails with Microsoft Internet Information Services (IIS) Express when User Account Control (UAC) is enabled.

_Original product version:_ &nbsp; Internet Information Services Express  
_Original KB number:_ &nbsp; 2701070

## Symptoms

Consider the following scenario:

You're running a web application in IIS Express with Visual Studio. The application is configured for Anonymous authentication, and uses impersonation of a service account to access a backend SQL database. When browsing to the web application with a web browser, an error message similar to the following example is displayed:

> Server Error in /my_app Application.  
> Configuration Error  
> Description: An error occurred during the processing of a configuration file required to service this request. Please review the specific error details below and modify your configuration file appropriately.  
> Parser Error Message: An error occurred loading a configuration file: Failed to start monitoring changes to C:\mysite\web\my_app\default.aspx.  
> Source Error:  
> [No relevant source lines]  
> Source File: C:\mysite\web\my_app\default.aspx\web.config Line: 0  
> Version Information: Microsoft .NET Framework Version:4.0.30319; ASP.NET Version:4.0.30319.17379  

This problem occurs when the impersonation account is running as non-elevated (UAC).

## Cause

For impersonation to work, the user must have the `SeImpersonatePrivilege` privilege. However, with UAC enabled the `SeImpersonatePrivilege` privilege is stripped from the impersonation token, so impersonation fails.

## Resolution

To resolve this problem, run IIS Express as an administrator if you need to use impersonation in the web application.

## More information

- [IIS Express Overview](/iis/extensions/introduction-to-iis-express/iis-express-overview)
- [User Account Control Step-by-Step](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc709691(v=ws.10))
