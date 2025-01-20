---
title: The application or service crashing behavior troubleshooting guidance
description: Provides guidance on how to troubleshoot application or service crashing behaviors.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, vjulio, holgerh, v-lianna
ms.custom: sap:System Performance\App, Process, Service Performance (slow, unresponsive), csstroubleshoot
---
# The application or service crashing behavior troubleshooting guidance

This article provides guidance on how to troubleshoot application or service crashing behaviors.

_Applies to:_ &nbsp; All supported versions of Windows Server and Windows Client

When you see Event ID 1001 and Event ID 1000 repeatedly in the application log, it indicates an application crashing behavior. It occurs together with first- or third-party processes and points to a possible faulting module.

This article details the process of checking the event, understanding the information in the event, and handling the event based on whether it's a first- or third-party application. [Debugging Tools for Windows](/windows-hardware/drivers/debugger/debugger-download-tools) are used in this process.

## Before you begin

Considerations:

- Verify that you're running the latest updates for the installed operating system version.
- Verify that the impacted application is up to date.
- If antivirus software is installed, verify that it's running on the latest version and that necessary exclusions are in place.

The Event ID 1001 `level` information shows if Windows Error Reporting (WER) is enabled in the system. However, you need to change this service to collect the `level` information required for the investigation. The system doesn't log this information by default to avoid a slight performance overhead.

The Event ID 1000 with the `Error` level is the actual application crashing event. It shows the following information as an example:

```output
Log Name:      Application
Source:        Application Error
Date:          <Date Time>
Event ID:      1000
Task Category: Application Crashing Events
Level:         Error
Keywords:      
User:          SYSTEM
Computer:      demo.contoso.com
Description:
Faulting application name: netsh.exe, version: 10.0.22621.1, time stamp: 0x13af0815
Faulting module name: netsh.exe, version: 10.0.22621.1, time stamp: 0x13af0815
Exception code: 0xc0000005
Fault offset: 0x0000000000005399
Faulting process id: 0x0xFEE4
Faulting application start time: 0x0x1DAB66BB5BE07D4
Faulting application path: C:\WINDOWS\system32\netsh.exe
Faulting module path: C:\WINDOWS\system32\netsh.exe
Report Id: <Report ID>
Faulting package full name: 
Faulting package-relative application ID:
```

It often presents a Microsoft module as the faulting module, for example, *ntdll.dll*, *kernel32.dll*, and *kernelbase.dll*. These modules are heavily used while processes are running and transitioning between user mode and kernel mode. In the process, they're caught as victims of other types of corruption previously performed by misbehaving modules.

Common exceptions:

- `0xc0000022`

    `STATUS_ACCESS_DENIED`
- `0xc0000005`

    `STATUS_ACCESS_VIOLATION`
- `0xc0000374`

    `STATUS_HEAP_CORRUPTION`

When an exception occurs, you can enable additional verbose logging for the process and collect a full process dump by using [Windows Error Reporting](/windows/win32/wer/windows-error-reporting) (WER) and [GFlags](/windows-hardware/drivers/debugger/gflags) (*gflags.exe*).

Install the [Debugging Tools for Windows](/windows-hardware/drivers/debugger/debugger-download-tools) to get *gflags.exe*, as it's included in the tools. However, you only need to copy the file without installing the tools on the machine that needs troubleshooting.

## Gather data

For the preceding example of a *netsh.exe* crash, set up the machine to collect dumps for more information on what caused the crash. Replace *netsh.exe* with the executable file identified in Event ID 1000 on your device.

1. Set up WER to collect full process dumps of the exception by running the following commands from an elevated command prompt:

    ```console
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\netsh.exe"
    
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\netsh.exe"/v DumpFolder /t REG_EXPAND_SZ /d "C:\WER" /f
    
    md C:\WER
    
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\netsh.exe" /v DumpCount /t REG_DWORD /d 10 /f
    
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\netsh.exe" /v DumpType /t REG_DWORD /d 2 /f
    
    reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\Windows Error Reporting\LocalDumps\netsh.exe"
    
    reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\Windows Error Reporting\LocalDumps\netsh.exe" /v DumpFolder /t REG_EXPAND_SZ /d "C:\WER" /f
    
    reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\Windows Error Reporting\LocalDumps\netsh.exe" /v DumpCount /t REG_DWORD /d 10 /f
    
    reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\Windows Error Reporting\LocalDumps\netsh.exe" /v DumpType /t REG_DWORD /d 2 /f
    ```

    These commands allow up to 10 full process dumps of the *netsh.exe* process to be collected and stored in the *C:\\WER* folder.

    > [!NOTE]
    > The Windows on Windows 64 (WOW64) registry location is added, which allows 32-bit applications to run on 64-bit systems.

2. Set up GFlags to monitor heap allocations to trace the corruption.

    Navigate to the directory where the tool is located, and run the following commands from an elevated command prompt.

    To turn on the [Enable page heap](/windows-hardware/drivers/debugger/enable-page-heap) (hpa) flag:

    ```console
    Gflags.exe /i netsh.exe +hpa
    ```

    To turn off the **Enable page heap** flag:

    ```console
    Gflags.exe /i netsh.exe -hpa
    ```

    Restart the process for the setting to take effect.

3. Monitor the *C:\\WER* folder and check for any created dumps.

## Analyze data

Once you have the process dumps, you can:

- Share the relevant dumps with the third party for investigation if the process is a third-party process.
- Contact Microsoft Support to analyze the data if the process is a first-party process.
- Use the debugger (*windbg.exe*) installed using [Debugging Tools for Windows](/windows-hardware/drivers/debugger/debugger-download-tools) and try to determine the faulting module by using [the !analyze extension](/windows-hardware/drivers/debugger/using-the--analyze-extension).

After collecting the data and completing the investigation, delete the registry key (the one with the process name) and turn off the **Enable page heap** flag for GFlags.
