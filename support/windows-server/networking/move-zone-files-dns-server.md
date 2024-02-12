---
title: How to move Windows DNS zones to another Windows server
description: Describes how to move the zone files from one DNS server that is running Windows 2000 to another DNS server that is running Windows 2000.
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
# How to move Windows DNS zones to another Windows server  

This article describes how to move the zone files from one DNS server that is running Windows 2000 to another DNS server that is running Windows 2000.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016  
_Original KB number:_ &nbsp; 280061

## Move zone files

To move zone files from one server to another, follow these steps:

> [!NOTE]
> To use the following method, the Windows 2000 DNS Server service must be installed on a new Windows 2000-based server. The DNS Server service should not be configured yet.

1. On the DNS server that is currently hosting the DNS zone(s), change any Active Directory-integrated zones to standard primary. This action creates the zone files that are needed for the destination DNS server.
2. Stop the DNS Server service on both DNS servers.
3. Manually copy the entire contents (subfolders included) of the %SystemRoot%\System32\DNS folder from the source server to the destination server.
    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
    [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  
4. On the current DNS server, start Registry Editor (Regedit.exe).
5. Locate and click the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\DNS\Zones`
6. Export the Zones entry to a registry file.
7. Locate and click the following registry subkey:

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\DNS Server\Zones`
8. Export the Zones entry to a registry file.
9. On the destination DNS server, double-click each registry file to import the Zones subkeys into the registry.
10. Bring the current DNS server down and transfer its IP address to the destination DNS server.
11. On the destination DNS server, start the DNS Server service. To initiate the registration of the server's A and PTR resource records, run the following command at a command prompt:

    ```console
    ipconfig /registerdns
    ```

12. If this server is also a domain controller, stop and restart the Net Logon service to register the Service (SRV) records, or run the following command at a command prompt:

    ```console
    netdiag /fix
    ```

13. The standard zones that were previously Active Directory-integrated can be converted back to Active Directory-integrated on the replacement DNS server if it's a domain controller.
14. Verify that the SOA resource records on each zone contain the correct name for the primary server and that the NS resource records for the zone(s) are correct.

> [!NOTE]
> The steps outlined in this article don't migrate the following DNS server settings:
>
> - Interfaces
> - Forwarders
> - Advanced
> - Root Hints
> - Logging
> - Security
> - Any specific registry setting made under any keys other than the key that is specified in step 5 and step 7
