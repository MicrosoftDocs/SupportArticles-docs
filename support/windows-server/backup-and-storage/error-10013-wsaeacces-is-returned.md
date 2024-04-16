---
title: Error 10013 when you bind excluded port again
description: Resolves an issue in which you cannot bind an excluded port again even though the SO_REUSEADDR option is set. This issue occurs in Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008 R2.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, makotkat
ms.custom: sap:Backup, Recovery, Disk, and Storage\File Server Resource Manager (FSRM) , csstroubleshoot
---
# Error 10013 (WSAEACCES) is returned when a second bind to an excluded port fails in Windows

This article provides help to solve an issue where you can't bind an excluded port again even though the SO_REUSEADDR option is set.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3039044

## Symptoms

Assume that you exclude a port by running the following command on a computer that is running Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2:

```console
netsh int ipv4 add excludedportrange protocol = tcp startport = Integer numberofports = 1
```

Additionally, assume that you bind the SO_REUSEADDR socket to a specific TCP port on the computer. In this situation, when you try to bind the SO_REUSEADDR socket to the TCP port again, the bind fails, and you receive the "WSAEACCES (10013)" error.

Therefore, if you use an application that calls the two binds in Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2, it cannot work correctly.

> [!Note]
>
> - By default, Windows Server 2008 R2 cannot use the `netsh` command to exclude ports. However, after you apply [hotfix 2665809](https://support.microsoft.com/help/2665809), the operating system supports this function.
> - This issue does not occur in Windows Server 2008 or Windows Server 2003.

## Cause

This issue occurs because of a problem in the tcpip.sys driver. Specifically, the REUSE flag was overwritten by the RESERVED flag when the tcpip.sys driver binds an excluded port.

## Workaround

To work around this issue, use one of the following methods:

- Use a port that is not included in the default dynamic port range (from 49,152 to 65,535), and do not specify the port as an excluded port by running the `netsh` command.
- Use the [CreatePersistentTcpPortReservation](/windows/win32/api/iphlpapi/nf-iphlpapi-createpersistenttcpportreservation) and [LookupPersistentTcpPortReservation](https://msdn.microsoft.com/library/windows/desktop/gg696072%28v=vs.85%29.aspx) functions to reserve a port.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

See the [setsockopt function](https://msdn.microsoft.com/library/windows/desktop/ms740476%28v=vs.85%29.aspx) to know more about the SO_REUSEADDR option.
