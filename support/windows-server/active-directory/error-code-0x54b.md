---
title: Domain Join Error Code 0x54b
description: Provides troubleshooting steps for resolving error code 0x54b when you join a workgroup computer to a domain.
ms.date: 04/23/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: eriw,dennhu,herbertm
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Domain join error code 0x54b

This article provides troubleshooting steps for resolving error code 0x54b when you join a workgroup computer to a domain.

## Symptoms

When you join a workgroup computer to a domain, you receive the following error message:

> **Error code 0x54b**
>
> Computer Name/Domain Changes
>
> An Active Directory Domain Controller (AD DC) for the domain "\<NetBIOS\\_name>" could not be contacted.
>
> Ensure that the domain name is typed correctly.
>
> If the name is correct, click Details for troubleshooting information.
>
> Note: This information is intended for a network administrator. If you are not your network's administrator, notify the administrator that you received this information, which has been recorded in the file C:\WINDOWS\debug\dcdiag.txt.
>
> The following error occurred when DNS was queried for the service location (SRV) resource record used to locate an Active Directory Domain Controller (AD DC) for domain "\<domain\_name>":
>
> The error was: "This operation returned because the timeout period expired." (error code 0x000005B4 ERROR\_TIMEOUT)
>
> The query was for the SRV record for \<srv\_record>
>
> The DNS servers used by this computer for name resolution are not responding. This computer is configured to use DNS servers with the following IP addresses:  
> \<ip\_address>
>
> Verify that this computer is connected to the network, that these are the correct DNS server IP addresses, and that at least one of the DNS servers is running.

Here's an example from the **netsetup.log** file:

```output
mm/dd/yyyy hh:mm:ss:ms NetpValidateName: checking to see if '<domain_name>' is valid as type 3 name
mm/dd/yyyy hh:mm:ss:ms NetpCheckDomainNameIsValid for <domain_name> returned 0x54b, last error is 0x0
mm/dd/yyyy hh:mm:ss:ms NetpCheckDomainNameIsValid [ Exists ] for '<domain_name>' returned 0x54b
```

## Cause

Error code 0x54b means "ERROR\_NO\_SUCH\_DOMAIN." This error code indicates the specified domain can't be contacted, pointing to issues locating domain controllers (DCs).

* Domain Name System (DNS) times out and resolution fails when attempting to reach DCs.
* Network connectivity to DCs is blocked on TCP port 135, 389, 445, or RPC dynamic ports.

## Troubleshooting steps

To resolve the 0x54b error, follow these steps:

### Step 1: Check the network connectivity between the client and the DC

| Server port     | Service             |
| --------------- | ------------------- |
| TCP 135         | RPC Endpoint Mapper |
| TCP 49152-65535 | RPC Dynamic Ports   |
| TCP 445         | SMB                 |
| UDP/TCP 389     | LDAP                |

* Refer to the list of required ports in [How to configure a firewall for Active Directory domains and trusts](config-firewall-for-ad-domains-and-trusts.md).

* Use the `Test-NetConnection` command to test the connection between DCs:

  ```powershell
  Test-NetConnection <IP\_address\_of\_the\_DC> -Port 389

  ComputerName: <computer_name>
  RemoteAddress: <remote_address>
  RemotePort: 389
  InterfaceAlias: Ethernet 2
  SourceAddress: <source_address>
  TcpTestSucceeded : True
  ```

  It indicates that the LDAP port TCP 389 is open between the client and the DC.

* [PortQry Command Line Port Scanner Version 2.0](https://www.microsoft.com/download/details.aspx?id=17148) can also be used to identify if a port (TCP/UDP) is blocked on DCs. Here's an example syntax:

  ```console
  portqry -n <problem_server> -e 135
  portqry -n <problem_server> -e 445
  portqry -n <problem_server> -e 389
  portqry -n <problem_server> -p UDP -e 389
  portqry -n <problem_server> -r 49152:65535
  ```

  Port query output examples:

  * When the connection to TCP port 135 on a DC is blocked, the following message is displayed:

    ```console
    portqry -n <dc_name> -e 135

    Querying target system called:

     <dc_name>

    Attempting to resolve name to IP address...

    Name resolved to <ip_address>

    querying...

    TCP port 135 (epmap service):FILTERED
    ```

  * When the connection to TCP port 389 on a DC is successful, the following message is displayed:

    ```console
    portqry -n <dc_name> -e 389

    Querying target system called:

     <dc_name>

    Attempting to resolve name to IP address...

    Name resolved to 192.168.1.2

    querying...

    TCP port 389 (ldap service): LISTENING
    ```

* Collect network monitor traces when reproducing the issue to confirm if there's any network connectivity issue, if necessary.

### Step 2: Verify if the preferred DNS server is the correct DNS server

### Step 3: Verify if the DC can be discovered

Run `nltest /dsgetdc` (DC Discovery) to verify if you can discover a DC. For example:

```console
nltest /dsgetdc:<domain_name> /force

           DC: \\<dc_address>
      Address: \\<dc_address>
     Dom Guid: <dom_guid>
     Dom Name: <dom_name>
  Forest Name: <foreast_name>
 Dc Site name: Default-First-site-Name
Our Site Name: Default-First-site-Name
        Flags: PDC GC DS LDAP KDC TIMESERV WRITABLE DNS_DC DNS_DOMAIN DNS_FOREST CLOSE_SITE FULL_SECRET WS DS_8 DS_9 DS_10 KEYLIST
The command completed successfully
```

### Step 4: Verify if SRV records are registered

Run `DCDiag /v` on the closest DC and verify if SRV records are registered. For example:

`_ldap._tcp.dc._msdcs.<domain_name>.com.`
