---
title: Enable logging in WDS
description: Explains how to modify the registry to enable tracing and logging in WDS. You can use the information to help troubleshoot issues that you may experience in WDS.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Setup, Upgrade and Deployment\Installing or upgrading Windows, csstroubleshoot
---
# How to enable logging in WDS in Windows

This article describes how to enable logging in Windows Deployment Services (WDS) in Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 936625

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

## Introduction

This article discusses how to enable logging in WDS in Windows Server. Additionally, this article describes how to gather data in WDS.

You can use this information to help troubleshoot issues that you may experience in WDS.

## Overview

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Each WDS component has a mechanism that you can enable for logging and for tracing. You can then analyze the results for troubleshooting. Use the information in the following sections to enable logging and tracing for WDS components.

## General WDS server health

Type the following command to generate general server health information:

```console
WDSUTIL /get-server /show:all /detailed
```

This command causes general server health information to be logged in the Application log and in the System log.

## WDS server component

Type the following command to generate health information about the WDS server component:

```console
WDSUTIL /get-server /show:all /detailed
```

This command causes WDS information to be logged in the Application log and in the System log.

## Obtain trace logs for Windows Server

To obtain trace information for Windows Server, do the following:

1. Open **Event Viewer** (eventvwr).
2. Browse to **Windows Logs**\\**Applications and Services Logs**\\**Microsoft**\\**Windows**\\**Deployment-Services-Diagnostics**.
3. Right-click the channel and choose **Enable Log**.

Then, configure the components that you want to be logged by setting one or more of the following registry keys to a 0 value.

- WDS Multicasting

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\WDSServer\Providers\WDSMC\TraceDisabled`

- WDS PXE

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\WDSServer\Providers\WDSPXE\TraceDisabled`

- WDS TFTP

     `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\WDSServer\Providers\WDSTFTP\TraceDisabled`

WDS servers also support the following additional tracing:

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\WDSServer\Providers\WDSTFTP\TraceFlags`
- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\WDSServer\Providers\WDSMC\TraceFlags`

You can set these registry keys to the following values to control what is included:

- 7F0000: This value includes packet tracing and protocol tracing.
- 3F0000: This value excludes packet tracing.
- 3E0000: This value excludes packet tracing and protocol tracing. By default, this value is used.

> [!NOTE]
> A tracing process may affect performance. Therefore, we recommend that you disable the tracing functionality when you do not have to generate a log.

After you set this registry entry, trace information for the WDS server component is logged in the following file:%windir%\\Tracing\\wdsserver.log

## WDS management components

Type the following command to generate management component health information:

```console
WDSUTIL /get-server /show:all /detailed
```

This command causes WDS component health information to be logged in the Application log and in the System log.

## Enable tracing

To obtain trace information, you must enable tracing in the WDS management component and in the WDS Microsoft Management Console (MMC) component. To do this, set the following registry entries:

### For the management component

- Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\WDSMGMT`
- Name: EnableFileTracing
- Value type: REG_DWORD
- Value data: 1

### For the MMC component

- Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\WDSMMC`
- Name: EnableFileTracing
- Value type: REG_DWORD
- Value data: 1

After you set these registry entries, trace information for the WDS management component is logged in the %windir%\\Tracing\\wdsmgmt.log file.

Additionally, trace information for the WDS MMC component is logged in the %windir%\\Tracing\\wdsmmc.log file.

> [!NOTE]
> Although the WDS MMC component and the WDSUTIL component share the same API layer, MMC sometimes adds processing and functionality. If an error occurs, it is frequently worthwhile to use WDSUTIL to try to reproduce the failure. WDSUTIL may help you determine whether the error is local to MMC or whether the error is a general management API failure. Frequently, the WDSUTIL component provides more detailed error output when tracing is not enabled. Where applicable, use the following options to obtain extra information:
>
> - /detailed
> - /verbose
> - /progress

## WDS legacy components

If you perform legacy management functions, set the following registry entry to enable tracing in the RISetup component:

- Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\RISetup`
- Name: EnableFileTracing
- Value type: REG_DWORD
- Value data: 1

To obtain the trace log in the WDSCapture operation, follow these steps:

1. Start the Capture Windows PE boot image.
2. When the Capture Wizard starts, press SHIFT+F10 to open a command prompt.
3. Enable tracing in the WDSCapture component. To do this, follow these steps:
    1. Start Registry Editor.
    2. Set the following registry entry to enable tracing in the WDSCapture component:

    - Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\WDSCapture`
    - Name: EnableFileTracing
    - Value type: REG_DWORD
    - Value data: 1

4. Start a second instance of the WDSCapture component. Then, reproduce the problem by using the second instance of WDSCapture.

> [!NOTE]
> Don't close the original instance of WDSCapture. If you close the original instance of WDSCapture, Windows PE restarts. Instead, press ALT+TAB to switch between the instances of WDSCapture.The following trace log file is generated: X:\\Windows\\Tracing\\WDSCapture.log.

## WDS client components

To turn on the client logging functionality, run the following command on the WDS server:

```console
WDSUTIL /Set-Server /WDSClientLogging /Enabled:Yes
```

Then, run the following command on the WDS server to change which events are logged:

```console
WDSUTIL /Set-Server /WDSClientLogging /LoggingLevel:{None|Errors|Warnings|Info}
```

> [!NOTE]
> Each category includes all the events from the previous categories.

The following are the definitions of the logging levels:

- The **NONE** logging level disables the logging functionality. By default, this logging level is used.
- The **ERRORS** logging level logs only errors.
- The **WARNINGS** logging level logs warnings and errors.
- The **INFO** logging level logs errors, warnings, and informational events. This logging level is the highest logging level.

To view the event logs, follow these steps:

1. Open Server Manager, and then click **Diagnostics**.
2. Click **Event Viewer**.
3. Click **Applications and Services Logs**.
4. Click **Microsoft**, click **Windows**, and then click **Deployment-Services-Diagnostics**.

In the tree structure of event logs, the **Admin** log contains all the errors, and the **Operational** log contains the information messages. The following are the definitions of the architectures that are listed for some errors in these logs:

- The **Architecture 0** is the x86 processor architecture.
- The **Architecture 6** is the IA-64 processor architecture.
- The **Architecture 9** is the x64 processor architecture.

## Setup logs from the client computer

The location of the setup logs depends on when the failure occurs.

If the failure occurs in Windows PE before the disk configuration page of the WDS client is completed, you can find the logs at the **X:\\Windows\\Panther** folder. Use Shift+F10 to open a command prompt, and then change the directory to the location.

If the failure occurs in Windows PE after the disk configuration page of the WDS client is completed, you can find the logs on the local disk volume at the **$Windows.~BT\\Sources\\Panther** folder. The local disk volume is usually the drive **C**. Use Shift+F10 to open a command prompt, and then change the directory to the location.

If the failure occurs on the first boot after the image is applied, you can find the logs in the **\\Windows\\Panther** folder of the local disk volume. The local disk volume is usually the drive **C**.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
