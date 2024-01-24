---
title: Enable Schannel event logging in Windows
description: This article describes how to enable schannel event logging in Windows and Windows Server.
ms.date: 12/11/2020
ms.custom: sap:Health, Diagnostic, and Performance Features
ms.topic: how-to
ms.technology: health-diagnostic-performance
---
# Enable Schannel event logging in Windows and Windows Server

This article introduces how to enable schannel event logging in Windows and Windows Server.

_Original product version:_ &nbsp; Windows 7, Windows 8, Windows 10, Windows Server 2008 R2, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 260729

## Summary

When you enable **Schannel event logging** on a machine that is running any version of Windows listed in the [Applies to](#applies-to) section of this article, detailed information from `Schannel` events can be written to the Event Viewer logs, in particular the System event log. This article describes how to enable and configure **Schannel event logging**.

## Enable logging

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

This registry key is present already in Windows and Windows Server.

1. Start Registry Editor. To do this, click **Start**, click **Run**, type `regedit`, and then click **OK**.
2. Locate the following key in the registry:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurityProviders\SCHANNEL`

3. Double-click the EventLogging key or right-click it and select Modify.

    - Value Name: `EventLogging`
    - Data Type: `REG_DWORD`
    - Value: `See "Logging options" table below`

4. Exit Registry Editor.
5. Reboot the machine (Logging does not take effect until after you restart the computer).

## Logging options

The default value for Schannel event logging is _0x00000001_ in Windows, which means that error messages are logged. Additionally, you can log multiple events by specifying the hexadecimal value that equates to the logging options that you want. This is a combination DWORD, which combines individual values for the desired result. For example, to log **error messages** (0x00000001) and **warnings** (0x00000002), set the value to _0x00000003_.

|Value|Description|
|---|---|
|0x0000|Do not log|
|0x0001|Log error messages|
|0x0002|Log warnings|
|0x0003|Log warnings and error messages|
|0x0004|Log informational and success events|
|0x0005|Log informational, success events and error messages|
|0x0006|Log informational, success events and warnings|
|0x0007|Log informational, success events, warnings, and error messages (all log levels)|
  
## More information

Schannel event logging is different from schannel logging. Use schannel logging to enable Windows products to log debug information using the checked version of Schannel.dll.

## Applies to

- Windows 7
- Windows 8
- Windows 8.1
- Windows 10
- Windows Server 2008 R2
- Windows Server 2012 R2
- Windows Server 2016
- Windows Server 2019
