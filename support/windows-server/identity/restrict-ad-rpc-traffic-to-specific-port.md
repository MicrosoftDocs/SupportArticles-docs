---
title: Restrict Active Directory RPC traffic to a specific port
description: This article introduces how to configure Active Directory replication remote procedure calls traffic to a specific port.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.technology: windows-server-active-directory
---
# How to restrict Active Directory RPC traffic to a specific port  

This article describes how to restrict Active Directory (AD) replication remote procedure calls (RPC) traffic to a specific port in Windows Server.

_Applies to:_ &nbsp; all supported versions of Windows Server  
_Original KB number:_ &nbsp; 224196

## Summary

By default, Active Directory replication remote procedure calls (RPC) occur dynamically over an available port through the RPC Endpoint Mapper (RPCSS) by using port 135. An administrator can override this functionality and specify the port that all Active Directory RPC traffic passes through. This procedure locks down the port.

When you specify ports to use by using the registry entries in [More information](#more-information), both Active Directory server-side replication traffic and client RPC traffic are sent to these ports by the endpoint mapper. This configuration is possible because all RPC interfaces supported by Active Directory are running on all ports on which it's listening.

> [!NOTE]
> This article doesn't describe how to configure AD replication for a firewall. Additional ports must be opened to make replication work through a firewall. For example, ports may need to be opened for the Kerberos protocol. To obtain a complete list of the required ports for services across a firewall, see [Service overview and network port requirements for Windows](../networking/service-overview-and-network-port-requirements.md).  

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

When you connect to an RPC endpoint, the RPC runtime on the client contacts the RPCSS on the server at a well-known port (135). And it obtains the port to connect to for the service supporting desired RPC interface. It assumes that the client doesn't know the complete binding. It's the situation with all AD RPC services.

The service registers one or more endpoints when it starts, and has the choice of a dynamically assigned port or a specific port.

If you configure Active Directory and Netlogon to run at **port x** as in the following entry, it becomes the ports that are registered with the endpoint mapper in addition to the standard dynamic port.

Use Registry Editor to modify the following values on each domain controller where the restricted ports are to be used. Member servers aren't considered to be logon servers. So static port assignment for NTDS has no effect on member servers.

Member servers do have the Netlogon RPC Interface, but it's rarely used. Some examples may be remote configuration retrieval, such as `nltest /server:member.contoso.com /sc_query:contoso.com`.

### Registry key 1

> HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters  
> Registry value: TCP/IP Port  
> Value type: REG_DWORD  
> Value data: (available port)

Restart the computer for the new setting to become effective.

### Registry key 2

> HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters  
> Registry value: DCTcpipPort  
> Value type: REG_DWORD  
> Value data: (available port)

Restart the Netlogon service for the new setting to become effective.

> [!NOTE]
> When you use the `DCTcpipPort` registry entry, and you set it to the same port as the `TCP/IP Port` registry entry, you receive Netlogon error event 5809 under `NTDS\Parameters`. This indicates that the port configured is in use, and you should choose a different port.

You'll receive the same event when you have a unique port, and you restart the Netlogon service on the domain controller. This behavior is by design. It occurs because of the way the RPC runtime manages its server ports. The port will be used after the restart, and the event can be ignored.

Administrators should confirm that the communication over the specified port is enabled if any intermediate network devices or software is used to filter packets between the domain controllers.

Frequently, you must also manually set the File Replication Service (FRS) RPC port because AD and FRS replication replicate with the same Domain Controllers. The FRS RPC port should use a different port.

Don't assume that clients only use the Netlogon RPC services and thus only the setting `DCTcpipPort` is required. Clients are also using other RPC services such as SamRPC, LSARPC, and also the Directory Replication Services (DRS) interface. You should always configure both registry settings and open both ports on the firewall.

### Known issues

After you specify the ports, you may encounter the following issues:

- [Long logon time after you set a specific static port for NTDS and Netlogon in a Windows Server 2008 R2-based domain environment](https://support.microsoft.com/help/2827870)
- [AD replication fails with an RPC issue after you set a static port for NTDS in a Windows-based domain environment](https://support.microsoft.com/help/2912805)
- [Logon fails after you restrict client RPC to DC traffic in Windows Server 2012 R2 or Windows Server 2008 R2](https://support.microsoft.com/help/2987849)

To resolve the issues, install the updates mentioned in the articles.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
