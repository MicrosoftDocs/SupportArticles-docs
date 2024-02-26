---
title: Use netsh advfirewall firewall context
description: This article describes how to use the netsh advfirewall firewall context instead of the netsh firewall context to control Windows Firewall behavior.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-firewall-with-advanced-security-wfas, csstroubleshoot
---
# Use netsh advfirewall firewall instead of netsh firewall to control Windows Firewall behavior

This article describes how to use the `netsh advfirewall` firewall context instead of the `netsh firewall` context to control Windows Firewall behavior.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 947709

## Summary

The `netsh advfirewall` firewall command-line context is available in Windows Server 2012 R2. This context provides the functionality for controlling Windows Firewall behavior that was provided by the `netsh firewall` firewall context.

This context also provides functionality for more precise control of firewall rules. These rules include the following per-profile settings:

- Domain
- Private
- Public

The `netsh firewall` command-line context might be deprecated in a future version of the Windows operating system. We recommend that you use the `netsh advfirewall` firewall context to control firewall behavior.

> [!IMPORTANT]
> If you are a member of the Administrators group, and User Account Control is enabled on your computer, run the commands from a command prompt with elevated permissions. To start a command prompt with elevated permissions, find the icon or Start menu entry that you use to start a command prompt session, right-click it, and then click **Run as administrator**.

Some examples of frequently used commands are provided in the following tables. You can use these examples to help you migrate from the older `netsh firewall` context to the new `netsh advfirewall` firewall context.

Additionally, the `netsh advfirewall` commands that you can use to obtain detailed inline help are provided.

## Command example 1: Enable a program

|Old command|New command|
|---|---|
|`netsh firewall add allowedprogram C:\MyApp\MyApp.exe "My Application" ENABLE`| `netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes`|
| `netsh firewall add allowedprogram program=C:\MyApp\MyApp.exe name="My Application" mode=ENABLE scope=CUSTOM addresses=157.60.0.1,172.16.0.0/16,LocalSubnet profile=Domain`| `netsh advfirewall firewall add rule name="My Application" dir=in action=allow program= "C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=domain` |
|`netsh firewall add allowedprogram program=C:\MyApp\MyApp.exe name="My Application" mode=ENABLE scope=CUSTOM addresses=157.60.0.1,172.16.0.0/16,LocalSubnet profile=ALL`|Run the following commands:<br/>`netsh advfirewall firewall add rule name="My Application" dir=in action=allow program= "C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=domain`<br/>`netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=private`|

For more information about how to add firewall rules, run the following command:

```console
netsh advfirewall firewall add rule ?
```

## Command example 2: Enable a port

|Old command|New command|
|---|---|
|`netsh firewall add portopening TCP 80 "Open Port 80"`|`netsh advfirewall firewall add rule name= "Open Port 80" dir=in action=allow protocol=TCP localport=80`|

For more information about how to add firewall rules, run the following command:

```console
netsh advfirewall firewall add rule ?
```

## Command example 3: Delete enabled programs or ports

|Old command|New command|
|---|---|
|`netsh firewall delete allowedprogram C:\MyApp\MyApp.exe`|`netsh advfirewall firewall delete rule name= rule name program="C:\MyApp\MyApp.exe"`|
|`delete portopening protocol=UDP port=500`|`netsh advfirewall firewall delete rule name= rule name protocol=udp localport=500`|

For more information about how to delete firewall rules, run the following command:

```console
netsh advfirewall firewall delete rule ?
```

## Command example 4: Configure ICMP settings

|Old command|New command|
|---|---|
|`netsh firewall set icmpsetting 8`| `netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow`|
| `netsh firewall set icmpsetting type=ALL mode=enable`| `netsh advfirewall firewall add rule name= "All ICMP V4" protocol=icmpv4:any,any dir=in action=allow`|
| `netsh firewall set icmpsetting 13 disable all`| `netsh advfirewall firewall add rule name="Block Type 13 ICMP V4" protocol=icmpv4:13,any dir=in action=block`|

For more information about how to configure ICMP settings, run the following command:

```console
netsh advfirewall firewall add rule ?
```

## Command example 5: Set logging

|Old command|New command|
|---|---|
| `netsh firewall set logging %systemroot%\system32\LogFiles\Firewall\pfirewall.log 4096 ENABLE ENABLE`|Run the following commands:<br/>`netsh advfirewall set currentprofile logging filename %systemroot%\system32\LogFiles\Firewall\pfirewall.log`<br/>`netsh advfirewall set currentprofile logging maxfilesize 4096`<br/>`netsh advfirewall set currentprofile logging droppedconnections enable`<br/>`netsh advfirewall set currentprofile logging allowedconnections enable` |

For more information, run the following command:

```console
netsh advfirewall set currentprofile ?
```

If you want to set logging for a particular profile, use one of the following options instead of the `currentprofile` option:

- `Domainprofile`
- `Privateprofile`
- `Publicprofile`

## Command example 6: Enable Windows firewall

|Old command|New command|
|---|---|
| `netsh firewall set opmode ENABLE`| `netsh advfirewall set currentprofile state on` |
| `netsh firewall set opmode mode=ENABLE exceptions=enable`|Run the following commands:<br/>`Netsh advfirewall set currentprofile state on`<br/>`netsh advfirewall set currentprofile firewallpolicy blockinboundalways,allowoutbound`|
| `netsh firewall set opmode mode=enable exceptions=disable profile=domain`|Run the following commands:<br/> `Netsh advfirewall set domainprofile state on`<br/>`netsh advfirewall set domainprofile firewallpolicy blockinbound,allowoutbound`|
| `netsh firewall set opmode mode=enable profile=ALL`|Run the following commands:<br/> `netsh advfirewall set domainprofile state on`<br/>`netsh advfirewall set privateprofile state on`|

For more information, run the following command:

```console
netsh advfirewall set currentprofile ?
```

If you want to set the firewall state for a particular profile, use one of the following options instead of the `currentprofile` option:

- `Domainprofile`
- `Privateprofile`
- `Publicprofile`

## Command example 7: Restore policy defaults

|Old command|New command|
|---|---|
|`netsh firewall reset`|`netsh advfirewall reset`|

For more information, run the following command:

```console
netsh advfirewall reset ?
```

## Command example 8: Enable specific services

|Old command|New command|
|---|---|
| `netsh firewall set service FileAndPrint`|`netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes`|
| `netsh firewall set service RemoteDesktop enable`|`netsh advfirewall firewall set rule group="remote desktop" new enable=Yes`|
| `netsh firewall set service RemoteDesktop enable profile=ALL`|Run the following commands:<br/><br/> `netsh advfirewall firewall set rule group="remote desktop" new enable=Yes profile=domain`<br/><br/>`netsh advfirewall firewall set rule group="remote desktop" new enable=Yes profile=private`|
