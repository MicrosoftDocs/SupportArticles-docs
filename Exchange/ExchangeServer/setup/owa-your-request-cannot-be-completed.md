---
title: Your request cannot be completed right now error in Outlook on the web after updating Exchange Server
description: Solves an issue where you receive a (Request cannot be completed right now) error when you open, reply to, or forward items in Outlook on the web, or sign in to Outlook on the web or select different folders.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with OWA
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 9949
ms.reviewer: v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 07/28/2026
---

# Your request cannot be completed right now error in Outlook on the web after an Exchange Server upgrade

_Original KB number:_ &nbsp;3191636

## Summary

This article discusses error messages that occur when using Outlook on the web after a cumulative update to Exchange Server. Conflicting files from previous cumulative updates can cause this problem. Administrators can resolve the problem by moving files and updating the `SharedWebConfig.config` files to point to the correct location.

## Symptoms

In an upgraded Microsoft Exchange Server environment, when you open, reply to, or forward items in Outlook for the web, or when you sign in or select folders, you receive a message that states, “Request cannot be completed right now. Please try again later.”

Additionally, the following event is logged repeatedly in the Windows Application log:

```console
Time:     7/05/2016 2:20:24 PM
ID:       4999
Level:    Error
Source: MSExchange Common
Machine:  MBX1.contoso.com
Message:  Watson report about to be sent for process id: 10472, with parameters: E12IIS, c-RTL-AMD64, 15.00.1178.004, w3wp#MSExchangeOWAAppPool, m.exchange.services, M.E.S.C.T.IdConverter.ConvertId, System.MissingMethodException, a16f, 15.00.1104.003.
ErrorReportingEnabled: False
```

## Cause

When you apply a cumulative update, the Exchange installation folder's `bin` subfolder still contains the setup files for previous cumulative updates. By default, this location is in `C:\Program Files\Microsoft\Exchange Server\V15\Bin\Setup`.

When you run the setup process in the `\bin\setup` folder from PowerShell, it uses the wrong configuration. The `SharedWebConfig.config` file that's located in `C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess` (mailbox role) or `C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy` (client access role) points to `C:\Program Files\Microsoft\Exchange Server\V15\Bin\Setup`. In this scenario, the setup process doesn't update these files. Instead, you need to launch setup from the correct cumulative update installation source.

## Resolution

To resolve the issue, follow these steps to remove the files from *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Setup* and update the `SharedWebConfig.config` files to point to the correct locations:

1. At an elevated command prompt, run the following command to stop IIS services and allow access to the files:

    ```console
    iisreset /stop
    ```

1. Move the *C:\Program Files\Microsoft\Exchange Server\V15\Bin\Setup* folder to another location outside of the Exchange installation path. For example, move it to *C:\TEMP\Setup*.

1. Make a backup copy of the `SharedWebConfig.config` file in both *C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess* and *C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy* in an alternative location.

1. At an elevated command prompt, run `cd %ExchangeInstallPath%\bin` to change to the correct folder. Then, run the following command to rebuild the `SharedWebConfig.config` file in *C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess*:

    ```console
    DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\ClientAccess" -configFile "%ExchangeInstallPath%\ClientAccess\SharedWebConfig.config"
    ```

1. At an elevated command prompt, run the following command to rebuild the `SharedWebConfig.config` file in *C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy*:

    ```console
    DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\FrontEnd\HttpProxy" -configFile "%ExchangeInstallPath%\FrontEnd\HttpProxy\SharedWebConfig.config"
    ```

1. At an elevated command prompt, run the following command to restart IIS services:

    ```console
    iisreset /start
    ```
