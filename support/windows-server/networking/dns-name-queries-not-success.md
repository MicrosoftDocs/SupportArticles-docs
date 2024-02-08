---
title: Some DNS name queries are unsuccessful
description: Describes an issue that occurs because of the Extension Mechanisms for DNS (EDNS0) functionality that is supported in Windows Server DNS. Provides a resolution and workaround.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# Some DNS name queries are unsuccessful after you deploy a Windows-based DNS server

This article describes an issue where DNS queries to some domains may not be resolved successfully after you deploy a Windows-based DNS server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 832223

## Symptoms

After you deploy a Windows-based DNS server, DNS queries to some domains may not be resolved successfully.

## Cause

This issue occurs because of the Extension Mechanisms for DNS (EDNS0) functionality that is supported in Windows Server DNS.

EDNS0 allows larger User Datagram Protocol (UDP) packet sizes. However, some firewall programs may not allow UDP packets that are larger than 512 bytes. Therefore, these DNS packets may be blocked by the firewall.

## Resolution

To resolve this issue, update the firewall program to recognize and allow UDP packets that are larger than 512 bytes. For more information about how to do this, contact the manufacturer of your firewall program.

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.  

## Workaround

To work around this issue, turn off the EDNS0 feature on Windows-based DNS servers. To do this, take the following action:

At a command prompt, type the following command, and then press Enter:

```console
dnscmd /config /enableednsprobes 0
```

> [!NOTE]
> Type a 0 (zero) and not the letter "O" after "enableednsprobes" in this command.

 The following information appears:

> Registry property enableednsprobes successfully reset.  
    Command completed successfully.

> [!NOTE]
> Dnscmd.exe is installed on all Windows-based DNS servers except servers that are running Windows Server 2003 or Windows Server 2003 R2. You can install Dnscmd.exe from the Windows Server 2003 Support Tools. To download the Windows Server 2003 Support Tools, click the following Microsoft Download Center link: [Setspn](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731241(v=ws.11))

## More information

Some firewalls contain features to check certain parameters of the DNS packet. These firewall features may make sure that the DNS response is smaller than 512 bytes. If you capture the network traffic for an unsuccessful DNS lookup, you may notice that DNS requests EDNS0. Frames that resemble the following don't receive a reply:

> Additional records  
 \<Root>: type OPT, class unknown  
 Name: \<Root>  
 Type: EDNS0 option  
 UDP payload size: 1280  

In this scenario, the firewall may drop all EDNS0-extended UDP frames.
