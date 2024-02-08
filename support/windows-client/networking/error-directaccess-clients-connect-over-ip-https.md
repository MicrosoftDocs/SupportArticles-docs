---
title: DirectAccess clients can connect over Teredo but not through IP-HTTPS
description: Describes an issue that prevents DirectAccess clients from connecting by using IP-HTTPS even though they can connect over Teredo. A resolution is provided.
ms.date: 09/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: ajayps, kaushika
ms.custom: sap:remote-access, csstroubleshoot
---
# DirectAccess clients can connect over Teredo but not through IP-HTTPS

This article describes an issue that prevents DirectAccess clients from connecting by using IP-HTTPS even though they can connect over Teredo.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 – all editions  
_Original KB number:_ &nbsp; 2980660

## Symptoms

DirectAccess clients can connect over Teredo, but may be unable to connect by using IP-HTTPS.

When you run the netsh interface http show interface command, the output is as follows:

> Error: 0x643  
Translates to: Fatal error during installation.
>
> Error: 0x34  
Translates to: Interface creation failure.

## Cause

> Error: 0x643  
 Translates to: Fatal error during installation.
>
> 0x643 translates to:  
ERROR_INSTALL_FAILURE  
\#Fatal error during installation.
>
> Error: 0x34  
 Translates to : Interface creation failure.  
>
>0x34 translates to:  
ERROR_DUP_NAME  
\# You were not connected because a duplicate name exists on  
\# the network. If joining a domain, go to System in Control  
\# Panel to change the computer name and try again. If joining  
\# a workgroup, choose another workgroup name.  

The reasons for these error codes are the same. Both error codes indicate a pre-existing setting or interface that conflicts with the currently applied IP-HTTPS configuration.

Possible causes for this issue include the following:

- Duplicate or corrupted IP-HTTPS interface in device manger.
- Corrupted or invalid ACL for IP-HTTPS binding (this is server-side issue).
- IPv6 Transition Adapters are disabled, or all IPv6 is disabled.

    > [!NOTE]
    > If IPv6 isn't selected on the NIC, but the DisabledComponents registry key has not been set, then you can ignore this possible cause.

## Resolution

### If there are corrupted or duplicate IP-HTTPS interfaces

- Clear all stale IP-HTTPS interfaces from Device Manager:
  1. Make sure that you're looking at the hidden and ghost devices.
     - Set devmgr_show_nonpresent_devices=1.
     - Open devmgmt.msc.
     - Select show hidden devices.  

      > [!Note]  
      >
      > - In Windows 8, the IP-HTTPS interface will appear under Network Adapters.
      > - In Windows 8.1, there will also be a "Microsoft IPv4 IPv6 Transition Adapter Bus" under Software Devices that might need to be reinstalled.
      > - *Do not* remove the Transition adapter on a DirectAccess server, because this all DirectAccess traffic to cease.  

  2. Reset the IP-HTTPS interface on the machine, and then reapply the configuration (GPO).
- Clear the stale or duplicate entries from the registry:
  1. Delete the following subkeys:

        `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Tcpip\v6Transition\IPHTTPS`  
  
        `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Tcpip\v6Transition\IPHTTPSProfiles`  

  2. Restart the IPHLPSVC, and then restart the computer while connected to the corporate LAN to apply Group Policy settings again.
- A hotfix has been released to address this issue.  

    [2966807](https://support.microsoft.com/help/2966087) Randomly you cannot connect to the DirectAccess server by using the IP-HTTPS adapter in Windows 8.1 and Windows Server 2012 R2

### If there's server-side IP-HTTPS creation failure

- Back up and then delete the following registry key:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HTTP\Parameters\UrlAclInfo`  
- Delete the following keys:
  - `https://+:443/C574AC30-5794-4AEE-B1BB-6651C5315029/`  
  - `https://+:443/sra_{BA195980-CD49-458b-9E23-C84EE0ADCD75}/`  

    > [!NOTE]
    > Be aware that this is a *server-side* fix.

### If IPv6 or only IPv6 Transition Adapters are disabled

If IPv6 is disabled make sure to enable it back.

If the DisabledComponents registry key is set under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6`, then delete it, or make sure that transition adapters aren't being disabled.

For more information about this, go to the following article at the Microsoft Knowledge Base:

[929852](https://support.microsoft.com/help/929852) How to disable IPv6 or its components in Windows

## More information

DirectAccess connectivity methods  

DirectAccess clients use multiple methods to connect to the DirectAccess server, which enables access to internal resources. Clients can use either Teredo, 6to4, or IP-HTTPS to connect to DirectAccess. This also depends on how the DirectAccess server is configured.

When the DirectAccess client has a public IPv4 address, it will try to connect by using the 6to4 interface. However, some ISPs give the illusion of a public IP Address. What they provide to end users is a pseudo public IP address. This means that the IP address received by the DirectAccess client (a data card or SIM connection) might be an IP from the public address space but that it's actually located behind one or more NATs.

When the client is behind a NAT device, it will try to use Teredo. Many businesses such as hotels, airports, and coffee shops don't allow Teredo traffic to traverse their firewall. In such scenarios, the client will fail over to IP-HTTPS. IP-HTTPS is built over an SSL (TLS) TCP 443-based connection. SSL outbound traffic will most likely be allowed on all networks.

Having this in mind, IP-HTTPS was built to provide a backup connection that is reliable and always reachable. A DirectAccess client will make use of this when other methods (such as Teredo or 6to4) fail.

More information about transition technologies can be found at [IPv6 transition technologies](/previous-versions//bb726951(v=technet.10)).
