---
title: Troubleshoot DNS name resolution on the Internet
description: Describes how to troubleshoot DNS name resolution on the Internet in Microsoft Windows Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
ms.technology: networking
---
# Troubleshoot DNS name resolution on the Internet in Windows Server

This article provides methods to troubleshoot Domain Name System (DNS) name resolution on the Internet in Microsoft Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 816567

## Summary

This article describes methods that you can use to configure DNS if queries that are directed to the Internet are not resolved correctly, but local intranet name resolution functions correctly.

The Cache.dns file that stores root hints on your Windows Server computer may be missing or damaged. You can manually add root hints by using the DNS snap-in, replace the Cache.dns file on your hard disk with the backup Cache.dns file or replace it with the original version of the Cache.dns file.

### To update root hints by using the DNS snap-in

To update root hints:

#### On a non-domain controller

To manually add root hints on a Windows Server DNS server that is not configured as a domain controller:

1. Click **Start**, point to **Administrative Tools**, and then click **DNS**.
2. In the right pane, right-click **ServerName**, where **ServerName** is the name of the server, and then click **Properties**.  
3. Click the **Root Hints** tab, and then click **Add**.
4. Specify the fully qualified domain name (FQDN) and the IP address of the root server that you want to add, and then click **OK**.  

#### On a domain controller

To update root hints on a Windows Server DNS server that is configured as a domain controller:

1. Click **Start**, point to **Administrative Tools**, and then click **DNS**.
2. In the right pane, right-click **ServerName**, where **ServerName** is the name of the server, and then click **Properties**.  
3. Click the **Root Hints** tab.
4. Do one of the following:
   - Add a root server to the list. To do so, click **Add**, specify the FQDN and the IP address of the root server that you want to add, and then click **OK**.
   - Copy the root hints from another DNS server. To do so, click **Copy from Server**, specify the IP address of the DNS server where you want to copy the root hints from, and then click **OK**.
5. Click **OK**.

> [!NOTE]
> The following is a list root servers as specified by Network Solutions:  
>
> `a.root-servers.net. 198.41.0.4`
>
> `b.root-servers.net. 199.9.14.201`
>
> `c.root-servers.net. 192.33.4.12`
>
> `d.root-servers.net. 199.7.91.13`
>
> `e.root-servers.net. 192.203.230.10`
>
> `f.root-servers.net. 192.5.5.241`
>
> `g.root-servers.net. 192.112.36.4`
>
> `h.root-servers.net. 198.97.190.53`
>
> `i.root-servers.net. 192.36.148.17`
>
> `j.root-servers.net. 192.58.128.30`
>
> `k.root-servers.net. 193.0.14.129`
>
> `l.root-servers.net. 199.7.83.42`
>
> `m.root-servers.net. 202.12.27.33`

### To copy and use the backup Cache.dns file

To rename and replace the Cache.dns file in the %SystemRoot%\System32\Dns folder with the backup Cache.dns file:

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type *cmd*, and then click **OK**.
3. Stop the DNS service. To do so, at the command prompt, type `net stop dns`, and then press ENTER.
4. Rename the Cache.dns file in the %SystemRoot%\\System32\\Dns folder to Cache.old. To do so, at the command prompt, type the following lines. Press ENTER after each line:

    ```console  
    cd %systemroot%\Sytem32\Dns  
    ren cache.dns cache.old  
    copy backup\cache.dns
    ```  

5. Start the DNS service. To do so, at the command prompt, type net start dns, and then press ENTER.

## References

For additional information about how to configure DNS for Internet access in Windows Server, click the following article number to view the article in the Microsoft Knowledge Base:  
[323380](https://support.microsoft.com/help/323380) Troubleshooting DNS servers  
For additional information about how to install and configure DNS in Windows Server, click the following article number to view the article in the Microsoft Knowledge Base:  
[814591](https://support.microsoft.com/help/814591) Troubleshooting Domain Name System (DNS) issues  
