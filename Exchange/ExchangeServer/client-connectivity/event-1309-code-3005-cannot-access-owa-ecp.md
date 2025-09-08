---
title: Event ID 1309 and you can't access OWA and ECP after you install Exchange Server 2016 or Exchange Server 2013
description: Resolves an issue that prevents you from accessing OWA and ECP and generates Event ID 1309 after you successfully install Exchange Server 2016 or Exchange Server 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Need help in configuring EAC
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, excontent, batre, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Event ID 1309 and you can't access OWA and ECP after you install Exchange Server 2016 or Exchange Server 2013

_Original KB number:_ &nbsp;3099532

## Symptoms

You successfully installed Microsoft Exchange Server 2016 or Exchange Server 2013. The installation process may have failed or been interrupted at some stage and then resumed and finally completed successfully. However, when you try to access Exchange Control Panel (ECP) or Outlook Web App (OWA), you receive the following error message:

> something went wrong
>
> Sorry, we can't get that information right now. Please try again later. If the problem continues, contact your helpdesk.

:::image type="content" source="media/event-1309-code-3005-cannot-access-owa-ecp/something-went-wrong-error.png" alt-text="Screenshot of the error message - we can't get that information right now.":::

Additionally, the following event may be logged in the Application log:

```console
Log Name:  Application
Source:  ASP.NET 4.0.30319.0
Event ID:  1309
Task Category:  Web Event
Level:  Warning
Keywords:  Classic
User:  N/A
Computer:  Exch2.contoso.com
Description:

Event code: 3005
Event message: An unhandled exception has occurred.

Event ID: f23d9d455f3145068c57286262ac517f
Event sequence: 1
Event occurrence: 1
Event detail code: 0

Application information:
  Application domain: /LM/W3SVC/2/ROOT/owa-5-130879214460462920
  Trust level: Full
  Application Virtual Path: /owa
  Application Path: C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess\owa\
  Machine name: EXCH2

Process information:
  Process ID: 4348
  Process name: w3wp.exe
  Account name: NT AUTHORITY\SYSTEM

Exception information:
  Exception type: TargetInvocationException
  Exception message: Exception has been thrown by the target of an invocation.
  at System.RuntimeTypeHandle.CreateInstance(RuntimeType type, Boolean publicOnly, Boolean noCheck,
  Boolean&canBeCached, RuntimeMethodHandleInternal&ctor, Boolean&bNeedSecurityCheck)

    * SharedWebConfig.config is missing from either of these locations:
      C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy
      C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess
```

## Cause

This issue occurs if SharedWebConfig.config is missing from either of the following locations:

- C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy
- C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess

## Resolution

To resolve this issue, follow these steps:

1. On the server that's facing the problem, identify the location that the file is missing from.
1. Generate the missing file:

    1. Run `cd %ExchangeInstallPath%\bin` to change the current directory to the bin folder that's under the Exchange installation path.
    1. Use the DependentAssemblyGenerator.exe tool to generate the file:

        - If the file is missing from *C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess*, run the following command:

        ```console
        DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\ClientAccess" -configFile "%ExchangeInstallPath%\ClientAccess\SharedWebConfig.config"
        ```

        - If the file is missing from *C:\Program Files\Microsoft\Exchange Server\V15\FrontEnd\HttpProxy*, run the following command:

        ```console
        DependentAssemblyGenerator.exe -exchangePath "%ExchangeInstallPath%\bin" -exchangePath "%ExchangeInstallPath%\FrontEnd\HttpProxy" -configFile "%ExchangeInstallPath%\FrontEnd\HttpProxy\SharedWebConfig.config"
        ```

1. Run IISRESET, or restart the server.

## More information

The *SharedWebConfig.config* file generates during the post-installation phase of Setup. If Setup resumes after an interruption, it doesn't do the post-installation steps for the roles that were successfully installed before the interruption.
