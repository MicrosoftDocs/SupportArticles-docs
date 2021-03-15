---
title: Error 0x00000709 when you use CNAME record
description: An issue occurs when clients try to connect to printers by using a CNAME record in the UNC path.
ms.data: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: 'Management and Configuration: General issues'
ms.technology: windows-client-printing
---
# Error 0x00000709 when you use a CNAME record for a print server in Windows Server 2008 R2: Operation could not be completed

This article helps fix the error 0x00000709 (Operation could not be completed). The error occurs when you use a CNAME record for a print server.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2546625

## Symptoms

Consider the following scenario:

- You have printers that are hosted on a system that is running Windows Server 2008 R2.
- You must provide an alternative UNC path for the print server. And you decide to do so by using a CNAME (alias) resource record in DNS.
- Clients try to connect to the printers by using the CNAME record in the UNC path.

In this scenario, clients can't connect to the printers if they use the CNAME record in the UNC path. Besides, attempts to connect to the shared printers fail with the following error:

> Operation could not be completed (error 0x00000709). Double check the printer name and make sure that the printer is connected to the network.

> [!NOTE]
>
> - Attempts to connect to the printers succeed as long as you use the actual host name instead of the CNAME record.
> - After you implement the DnsOnWire registry value that is described in the following article in the Microsoft Knowledge Base, the problem persists:  
> [Error message when you try to connect to a printer by using an alias (CNAME) resource record: "Windows couldn't connect to the printer"](https://support.microsoft.com/help/979602)

## Cause

This issue may occur if certain non-Microsoft DNS solutions are providing name resolution for the network.

## Resolution

To work around this issue, follow these steps on the print server, and then restart the Print Spooler service:

1. Implement the `DnsOnWire` registry value that's described in the following article:

   [Error message when you try to connect to a printer by using an alias (CNAME) resource record: "Windows couldn't connect to the printer"](https://support.microsoft.com/help/979602).

2. Edit the local Hosts file to include the CNAME record for the server.

    > [!NOTE]
    > The Hosts file entry must be entered as a NetBIOS name instead of as an FQDN.

The following example is for illustration only. You must use names and IP addresses that are valid for your network.

Use NetBIOS name: 192.168.0.10 CNAME

Don't use FQDN: 192.168.0.10 `CNAME.CONTOSO.COM`

## More information

The issue that is described in the [Symptoms](#symptoms) section may occur if the non-Microsoft DNS solution provides `QRecord` responses of type ALL.
