---
title: Fail to create a DFS Namespace
description: Provides solutions to the error - The namespace cannot be queried. The RPC server is unavailable when you access, modify, or create a DFS Namespace.
ms.date: 09/24/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, randt, warrenw, albugn
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error when you attempt to create a DFS Namespace: The namespace cannot be queried. The RPC server is unavailable

This article provides solutions to the error "The namespace cannot be queried. The RPC server is unavailable" that occurs when you access, modify, or create a Distributed File System (DFS) namespace.

_Original KB number:_ &nbsp; 2021914

When you access, modify, or create a DFS Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message:

> The namespace cannot be queried. The RPC server is unavailable.

## Cause 1: The DFS Namespace service is stopped or in an undefined state

You use the DFS Management console locally and receive this error on the DFS Namespace server. It might indicate that the DFS Namespace service on the DFS Namespace server is stopped or in an undefined state but not "Running."

## Resolution for cause 1: Start the DFS Namespace service

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

To resolve the issue, start the DFS Namespace service.

Run the following PowerShell cmdlet to check if the DFS Namespace service is running:

```powershell
Get-Service -Name Dfs
```

If the DFS Namespace service isn't started, run the following PowerShell cmdlet to start the DFS Namespace service:

```powershell
Start-Service -Name Dfs
```

> [!NOTE]
> If you can't start the DFS Namespace service, it indicates a registry corruption or a service dependency issue. Ensure the dependency services of the DFS Namespace service are running properly, or import the registry settings from a backup. Then, start the DFS Namespace service again. For more information, see [Resolution for cause 4: Import the registry key from a valid registry backup](#resolution-for-cause-4-import-the-registry-key-from-a-valid-registry-backup).

## Cause 2: The DFS Namespace service is stopped or the DFS Namespace server can't be reached

If you use the DFS Management console from a domain-joined member server (not a DFSN server) or a domain client with RSAT File Services tools installed, this error might occur when:

- Scenario 1

  The DFS Namespace service on the DFS Namespace server is stopped or in an undefined state but not "Running."

- Scenario 2

  The domain-joined member server (not a DFS Namespace) or the Windows client with RSAT File Services tools installed, where you run the DFS Management console, can't reach the DFS Namespace server over TCP port 445 (used by  Server Message Block (SMB)).

### Wireshark trace

- Scenario 1

    ```output
    192.168.0.45    192.168.0.42    SMB2    190    Create Request File: netdfs
    192.168.0.42    192.168.0.45    SMB2    130    Create Response, Error: STATUS_OBJECT_NAME_NOT_FOUND
    ```

- Scenario 2

    The Domain Name System (DNS) queries for A records of the DFS Namespace servers.
    
    ```output
    192.168.0.45    192.168.0.1    DNS    79    Standard query 0x429a A SRV2022.contoso.com
    192.168.0.1    192.168.0.45    DNS    95    Standard query response 0x429a A SRV2022.contoso.com A 192.168.0.42
    ```
    
    However, establishing a TCP connection to the DFS Namespace server on TCP port 445 (used by SMB) fails.
    
    ```output
    192.168.0.45    192.168.0.42    TCP    66    60345 → 445 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
    192.168.0.45    192.168.0.42    TCP    66    [TCP Retransmission] 60345 → 445 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
    192.168.0.45    192.168.0.42    TCP    66    [TCP Retransmission] 60345 → 445 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
    192.168.0.45    192.168.0.42    TCP    66    [TCP Retransmission] 60345 → 445 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
    192.168.0.45    192.168.0.42    TCP    66    [TCP Retransmission] 60345 → 445 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
    ```

## Resolution for cause 2: Start the DFS Namespace service or allow TCP port 445

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

To resolve the issue:

- Scenario 1

    Start the DFS Namespace service.

    Run the following PowerShell cmdlet to check if the DFS Namespace service is running:

    ```powershell
    Get-Service -Name Dfs
    ```

    If the DFS Namespace service isn't started, run the following PowerShell cmdlet to start the DFS Namespace service:

    ```powershell
    Start-Service -Name Dfs
    ```

- Scenario 2

    Make sure that TCP port 445 (used by SMB) to the DFS Namespace server is allowed and that the server service (LanmanServer) is started.

## Cause 3: No DomainDNSName records are registered for the domain

This error is typically seen in an environment using a third-party DNS server. It can occur when no DomainDNSName records are registered for the domain. These records are updated by the Netlogon service on domain controllers. These are the "same as parent" A records in the domain's forward lookup zone.

The following documentation indicates these records aren't a requirement and are only used for DNS clients that don't understand SRV records:  

[How DNS Support for Active Directory Works](/previous-versions/windows/it-pro/windows-server-2003/cc759550(v=ws.10))

|Host (A) resource record  |Description  |
|---------|---------|
|DnsDomainName     |Enables a non-SRV-aware client to locate any domain controller in the domain by looking up an A record. A name in this form is returned to the LDAP client through an LDAP referral. A non-SRV-aware client looks up the name; an SRV-aware client looks up the appropriate SRV resource record.         |

In a network trace, you'll see a DNS lookup for the DomainDNSname A record and the DNS server will respond with the SOA record if these A records don't exist.

DNS lookup query:

> Dns: QueryId = 0x887C, QUERY (Standard query), Query for contoso.com of type Host Addr on class Internet  
QRecord: contoso.com of type Host Addr on class Internet

Response with the SOA record:

> Dns: QueryId = 0x887C, QUERY (Standard query), Response - Success  
QRecord: contoso.com of type Host Addr on class Internet  
AuthorityRecord: contoso.com of type SOA on class Internet: PrimaryNameServer: SRVPdc.contoso.com, AuthoritativeMailbox: hostmaster.contoso.com

## Resolution for cause 3: Update the A records on the DNS server or create a HOSTS file

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

Update the "same as parent" A records on the third-party DNS servers.

> [!NOTE]
> Restarting the Netlogon service on Windows domain controllers repopulates all the missing SRV records under the `_msdcs.contoso.com` zone. Make sure that AD replication is possible or runs successfully so that the changes about the SRV records are replicated correctly troughout your domain.

As an exceptional workaround for exceptional situations:

If the preceding solution doesn't show positive results within 30 minutes after applying, you can implement the following method as a temporary workaround. Only use this workaround until you've updated the "same as parent" A records on the third-party DNS servers.

On the computer you'll use the DFS Management console, create a HOSTS file that includes the fully qualified name and the IP addresses of the domain controllers.

Sample for the HOSTS file entry:

- contoso.com 192.168.0.1
- contoso.com 192.168.0.2
- contoso.com 192.168.0.3

## Cause 4: Registry values for stand-alone DFS Namespaces are missing

One or both of the registry values `ID` and `Svc` with the `REG_BINARY` type under the DFS root registry path `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\<YourDfsStandaloneNamespace>`, are missing.

In this case, the DFS Namespace service can crash, stop responding or even fail to start, resulting in this error.

## Resolution for cause 4: Import the registry key from a valid registry backup

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

Importing the registry key for the DFS Namespace root, from a valid registry backup (if available), of the same registry key, can resolve the issue.

If no backup is present, and since you have only a single DFS root server for your namespace in a DFS stand-alone namespace configuration, the only option is to delete the DFS Namespace, perform a DFS Namespace cleanup on the DFS root server, and re-create the DFS Namespace.

> [!NOTE]
> Restart the DFS server or the DFS server service so that the changes in the registries are loaded into memory again. Not restarting the DFS server or the DFS server service might result in the same error.
