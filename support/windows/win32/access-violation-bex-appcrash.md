---
title: Access Violation of BEX or APPCRASH occurs
description: This article provides resolutions for the Access Violation of BEX or APPCRASH on Windows Server 2008 R2 with Terminal Service.
ms.date: 09/24/2020
ms.custom: sap:System Services Development
ms.reviewer: koichm, skuzin, govm
ms.technology: windows-dev-apps-system-services-dev
---
# Access Violation of BEX or APPCRASH occurs on Windows Server 2008 R2 with Terminal Service.

This article helps you resolve the Access Violation of BEX or APPCRASH on Windows Server 2008 R2 with Terminal Service.

_Original product version:_ &nbsp; Winsock  
_Original KB number:_ &nbsp; 2279689

## Symptoms

You may experience an Access Violation when your application:

- Uses Winsock API or crypto API, and may frequently load/unload a DLL dynamically.
- Is a multithreaded application.

When the Access Violation occurs, the following error message is generated. You may receive APPCRASH or BEX Event Error.

> Sample.exe Application has stopped working.  
>  
>Problem signature :  
Problem event name : APPCRASH  
Application name : Sample.exe  
Application version : 0.0.0.0  
Application Timestamp : 4afa1ed3  
Fault Module name : MSVCR80.dll  
Fault Module Version : 8.0.50727.4927  
Fault Module Timestamp: 4a2752ff  
Exception Code : 40000015  
Exception Offset : 000046b4  
OS Version : 6.1.7600.2.0.0.16.7  
Locale ID: 1041  
>
> Problem signature :  
Problem event name : BEX  
Application name : Sample.exe  
Application version : 0.0.0.0  
Application Timestamp : 4afa1ed3  
Fault Module name : mswsock.dll  
Fault Module Version : 6.1.7600.16385  
Fault Module Timestamp: 4a5bda77  
Exception Offset: 000016bf  
Exception Code : c0000005  
Exception Data: 00000008  
OS Version : 6.1.7600.2.0.0.16.7  
Locale ID: 1041  

## Cause

The root cause of this problem is a change made in Windows Server 2008 R2 to the time when the tsappcmp.dll module (Remote Desktop Services Application Compatibility DLL) gets initialized, which consequently causes your application to call DLL functions before it establishes a link to functions within the DLL.

## Resolution

To resolve this problem, do either of the following four options:

1. Exclude the application that has the error occurring from Data Execution Prevention (DEP).

2. Add the **/TSAWARE linker** option to build your application.

3. Add the **/TSAWARE** option with editbin.exe tool.

   - Run Command prompt of Visual Studio.
   - Type following command.

        ```console
        editbin.exe /TSAWARE <Program file name>
        ```

   - You can confirm that the program is aware of terminal service by following command.

        ```console
        editbin.exe /headers <Program file name>
         :
         8540 DLL characteristics
         Dynamic base
         NX compatible
         No structured exception handler
         Terminal Server Aware
        ```

For more information about TSAware flag, see [Change in the TSAware flag behavior in .NET Framework 3.5 SP1](/troubleshoot/dotnet/framework/change-tsaware)
