---
title: Transfers using BITS fail with errors
description: Fixes an issue in which error 12700, 2927, or 2912 occurs when you transfer content between the Virtual Machine Manager (VMM) server, the library server(s), and the virtualization hosts.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Transfers between VMM servers, library servers, and virtualization hosts fail with error 12700, 2927, or 2912

This article helps you fix an issue in which error 12700, 2927, or 2912 occurs when you transfer content between the Virtual Machine Manager (VMM) server, the library server(s), and the virtualization hosts.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2405062

## Symptoms

System Center Virtual Machine Manager uses Background Intelligent Transfer Service (BITS) to transfer content between the VMM server, the library server(s), and the virtualization hosts. If there is a service on one of the involved servers that's using the HTTPS port 443, the transfer may be slow or even fail with one of the following errors:

> Error (12700) \<path to vhd on destination host> 'The file or directory is corrupted and unreadable' (0x80070570)

> Error (2927)  
> A Hardware Management error has occurred trying to contact server servername.contoso.com. (Unknown error (0x8033811e))

> Error (2912)  
> An internal error has occurred trying to contact an agent on the servername.contoso.com server. (Unknown error (0x80072f06))

## Cause

This issue can occur if the port used by BITS to do file transfers is in use by another application or service. BITS uses a default port of 443 (decimal) which is commonly used by secure web sites (HTTPS).

## Resolution

To resolve this issue, configure VMM to use another port for BITS transfers between its library server(s) and the virtualization hosts.

> [!NOTE]
> You need to ensure that the newly selected port isn't blocked by a firewall between the involved hosts.

1. On your VMM server, open Registry Editor.

2. Browse to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft System Center Virtual Machine Manager Server\Settings`.  

3. Locate `BITSTcpPort` that should have a value of decimal **443**. Change it to some port unused in your environment (for example, 8500).

4. Restart Virtual Machine Manager service so that the change takes effect.
