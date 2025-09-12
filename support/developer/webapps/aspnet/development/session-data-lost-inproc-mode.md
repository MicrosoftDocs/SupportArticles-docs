---
title: Session data is lost if you use InProc
description: This article provides workarounds for the problem that session data is lost when you use ASP.NET InProc session state mode.
ms.date: 04/15/2020
ms.custom: sap:General Development
ms.reviewer: josborne
---
# Session data is lost when you use ASP.NET InProc session state mode

This article helps you resolve the problem that session data is lost when you use ASP.NET InProc session state mode.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 324772

## Symptoms

Session data for ASP.NET Web applications appears to be lost at random intervals for the InProc session state mode.

## Cause

Session state data is lost if the `AppDomain` class or the Aspnet_wp.exe process (or the W3wp.exe process, for applications that run on IIS 7.0 or a later version) is recycled. Generally, the `AppDomain` is restarted based on several factors:

- Various attributes (for example, the `memoryLimit` attribute) have particular settings in the `<processModel>` section of the configuration file.
- The *Global.asax* or the *Web.config* file was modified.
- The `Bin` directory of the Web application was modified.
- Virus scanning software touched some *.config* files.

InProc session mode indicates that session state is stored locally. This means that with InProc session state mode is stored as life objects in the `AppDomain` of the Web application. This is why the session state is lost when Aspnet_wp.exe (or W3wp.exe, for applications that run on IIS) or the `AppDomain` restarts.

## Resolution

To work around this problem, you can use StateServer or SqlServer session state mode. ASP.NET provides these other approaches for storing session state data. In the StateServer and SqlServer modes, your session state is not stored in the `AppDomain` of the Web application.

> [!NOTE]
> It is important to understand the behavior and the issues that are associated with each session state mode when you decide which mode is appropriate for your requirements.

## Status

This behavior is by design.

## References

For more information about ASP.NET session state management and other related information, see [Session State](/previous-versions/dotnet/netframework-1.1/87069683(v=vs.71)).
