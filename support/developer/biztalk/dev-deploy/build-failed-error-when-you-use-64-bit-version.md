---
title: Build process fails with an error
description: This article provides a workaround for the problem where the builds of BizTalk Server projects fail.
ms.date: 09/27/2020
ms.custom: sap:Development and Deployment
ms.reviewer: zoltank
---
# Error when you use a 64-bit version of MSBuild to build a BizTalk project

This article helps you resolve the problem where the builds of BizTalk Server projects fail.

_Original product version:_ &nbsp; BizTalk Server  
_Original KB number:_ &nbsp; 3030830

## Symptoms

When you use a 64-bit version of MSBuild (for example, `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe`) to build a BizTalk project, the build process fails with an error that resembles the following:

> Build FAILED.  
"C:\Users\superuser\Documents\Visual Studio 2010\Projects\BizTalk1\BizTalk1.sln" (default target) (1) ->  
"C:\Users\superuser\Documents\Visual Studio 2010\Projects\BizTalk1\BizTalk1\BizTalk1.btproj" (default target) (2) ->(CoreCompile target) ->  
CSC : error CS2001: Source file 'C:\Users\superuser\Documents\Visual Studio 2010\Projects\BizTalk1\BizTalk1\Schema1.xsd.cs' could not be found [C:\Users\superuser\Documents\Visual Studio 2010\Projects\BizTalk1\BizTalk1\BizTalk1.btproj]  
0 Warning(s)  
1 Error(s)

When you use a 32-bit version of MSBuild (for example, `C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe`), the build process works as expected.

## Cause

This problem is caused by a limitation in the current versions of BizTalk 2013 and BizTalk 2010.

## Workaround

To work around this problem, use a 32-bit version of MSBuild.

## Applies to

- BizTalk Server 2013 Branch
- BizTalk Server 2013 Developer
- BizTalk Server 2013 Enterprise
- BizTalk Server 2013 Standard
- BizTalk Server Branch 2010
- BizTalk Server Developer 2010
- BizTalk Server Enterprise 2010
- BizTalk Server Standard 2010
