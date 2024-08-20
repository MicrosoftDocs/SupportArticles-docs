---
title: Installation of Edge Transport role fails
description: This article fixes an issue that causes the installation of the Exchange Edge Transport role to fail.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: arindamt, v-six
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
---
# Error when installation of Exchange Edge Transport role fails: Process execution failed with exit code 3

_Original KB number:_ &nbsp; 4495264

## Symptoms

When you install Exchange Server 2019, 2016, or 2013 Edge Transport server roles by using the Setup wizard, the installation fails and returns an error message that resembles the following:

> The following error was generated when "$error.Clear(); $dllFile = join-path $RoleInstallPath "bin\ExSMIME.dll"; $regsvr = join-path (join-path $env:SystemRoot system32) regsvr32.exe; start-SetupProcess -Name:"$regsvr" -Args:"/s `"$dllFile`"" -Timeout:120000; " was run: "Microsoft.Exchange.Configuration.Tasks.TaskException: Process execution failed with exit code 3.  
> at Microsoft.Exchange.Management.Tasks.RunProcessBase.InternalProcessRecord()  
> at Microsoft.Exchange.Configuration.Tasks.Task.b__91_1() at Microsoft.Exchange.Configuration.Tasks.Task.InvokeRetryableFunc(String funcName, Action func, Boolean terminatePipelineIfFailed)".

## Cause

This issue occurs because Visual C++ 2012 isn't installed on the server. Visual C++ 2012 is required in order to include the Active Template Library (ATL).

## Resolution

To fix this issue, install Visual C++ 2012, and run the Setup wizard again.

The following article lists the download links for the latest versions of Visual C++:  
[The latest supported Visual C++ downloads](https://support.microsoft.com/help/2977003/the-latest-supported-visual-c-downloads)
