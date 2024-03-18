---
title: Could not load file or assembly error when browsing EWS or Autodiscover sites
description: Provides a resolution to solve the error that occurs when you open the Exchange EWS or Autodiscover sites.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# Could not load file or assembly error occurs when browsing the Exchange EWS or Autodiscover sites

## Symptoms

You may receive the following error while browsing `https://servername/autodiscover/Autodiscover.xml` or `https://servername/ews/exchange.asmx`.

> Could not load file or assembly 'Microsoft.Exchange.Diagnostics, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified.  
> Description: An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.
>
> Exception Details: System.IO.FileNotFoundException: Could not load file or assembly 'Microsoft.Exchange.Diagnostics, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified.
>
> Source Error:
>
> An unhandled exception was generated during the execution of the current web request. Information regarding the origin and location of the exception can be identified using the exception stack trace below.
>
> Assembly Load Trace: The following information can be helpful to determine why the assembly 'Microsoft.Exchange.Diagnostics, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' could not be loaded.
>
> WRN: Assembly binding logging is turned OFF.  
> To enable assembly bind failure logging, set the registry value [HKLM\Software\Microsoft\Fusion!EnableLog] (DWORD) to 1.  
> Note: There is some performance penalty associated with assembly bind failure logging.  
> To turn this feature off, remove the registry value [HKLM\Software\Microsoft\Fusion!EnableLog].
>
> Stack Trace:
>
> [FileNotFoundException: Could not load file or assembly 'Microsoft.Exchange.Diagnostics, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified.]  
Microsoft.Exchange.Services.AuthorizationModule.Init(HttpApplication context) +0  
System.Web.HttpApplication.InitModulesCommon() +135  
System.Web.HttpApplication.InitInternal(HttpContext context, HttpApplicationState state, MethodInfo[] handlers) +2601588  
System.Web.HttpApplicationFactory.GetNormalApplicationInstance(HttpContext context) +347  
System.Web.HttpApplicationFactory.GetApplicationInstance(HttpContext context) +139  
System.Web.HttpRuntime.ProcessRequestInternal(HttpWorkerRequest wr) +196
>
> --------------------------------------------------------------------------------  
> Version Information: Microsoft .NET Framework Version:2.0.50727.1434; ASP.NET Version:2.0.50727.1434

## Cause

It could not load the assembly `Microsoft.Exchange.Diagnostics` due to incorrect entry in the application web.config file.

## Resolution

- If the problem is occurring with `https://servername/autodiscover/autodiscover.xml`:

  Take a backup of web.config in _C:\Program Files\Microsoft\Exchange Server\ClientAccess\Autodiscover_.

  - Open web.config from _C:\Program Files\Microsoft\Exchange Server\ClientAccess\Autodiscover_ in notepad.
  - Replace all _file:///%ExchangeInstallDir%_ with *file:///C:\Program Files\Microsoft\Exchange Server\\* where Cis the drive where Exchange is installed.
  - Save the file.
  - Open an Administrator command prompt and run `IISreset /noforce`.
  - Test browsing `https://servername/autodiscover/autodiscover.xml`.

- If the problem is occurring with `https://servername/ews/exchange.asmx`:

  Take a backup of web.config in _C:\Program Files\Microsoft\Exchange Server\ClientAccess\exchweb\ews_.

  - Open web.config from _C:\Program Files\Microsoft\Exchange Server\ClientAccess\exchweb\ews_ in notepad.
  - Replace all _file:///%ExchangeInstallDir%_ with *file:///C:\Program Files\Microsoft\Exchange Server\\* where Cis the drive where Exchange is installed.
  - Save the file.
  - Open an Administrator command prompt and run `IISreset /noforce`.
  - Test browsing `https://servername/ews/exchange.asmx`.
