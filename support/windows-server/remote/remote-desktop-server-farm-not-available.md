---
title: Remote Desktop Server farm is unavailable over DirectAccess
description: Fixes an issue makes a Remote Desktop Server (RDS) farm unavailable in a Windows Server 2008 environment.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Remote Desktop Services and Terminal Services\Connection Broker and load balancing, csstroubleshoot
---
# Remote Desktop Server farm is unavailable over DirectAccess (single/multisite)

This article helps fix an issue that makes a Remote Desktop Server (RDS) farm unavailable in a Windows Server 2008 environment.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3123137

## Symptoms

Consider the following scenario:

- You have a DirectAccess environment (two network adapters on Edge, two network adapters behind Edge, or a single network adapter behind Edge), including Force Tunnel.
- You have users who connect to a Remote Desktop Services deployment from an external network through the DirectAccess tunnel.
- Session redirection is enabled on the RDS farm through the Connection Broker role.

In this scenario, all redirected RDS connections fail.

## Cause

The issue occurs because the Remote Desktop Services roles and services aren't IPv6-aware. When the client tries to connect to the RDS deployment, the Connection Broker returns a redirection packet, and this contains the IP address of the endpoint RDSH that the client will be redirected to. If the RDSH servers have only an IPv4 address assigned, the connection broker returns only this IPv4 address. Therefore, clients try to connect to the IPv4 address over the DA tunnel, and this fails.  

## Resolution

### Prerequisites

Windows 7 and Windows 8.1 clients must have the following update installed to connect to RDP over a DA connection. This update fixes an issue in which the client doesn't try to connect to the IPv6 address if a connection to the IPv4 address fails:

[Windows 8.1 or Windows 7 cannot connect over DirectAccess to a Remote Desktop Session Host server farm](https://support.microsoft.com/help/2964833).

To resolve the issue, IPv6 IP addresses must be enabled and applied, and the internal network must be capable of IPv6 routing. To enable this functionality, use one of the following methods:

- Enable and use an ISATAP adapter on the Remote Desktop Session Host servers. Be aware that this method is supported only with a single site DA deployment. The use of an ISATAP adapter in environments that contain a multi-site DA deployment isn't recommended nor supported.
- Apply the method that's described in the "Workaround" section.

## More information

For more DA-related fixes, see [Recommended hotfixes and updates for Windows Server 2012 DirectAccess and Windows Server 2012 R2 DirectAccess](https://support.microsoft.com/help/2883952)  

## Workaround

To work around this issue, follow these steps:  

1. At an administrative PowerShell prompt on the DA server, run the following command:

    ```powershell
    Get-NetNatTransitionConfiguration
    ```

    > [!NOTE]
    > Make a note of the prefix (it usually has :7777:: embedded in it).

2. Inject the prefix into the following script, as appropriate for your version of Windows Server. For multiple DA deployments, add each suffix separated by a comma (,). Also, the quotation marks ("") are required.

    **For Windows Server 2012 and later versions**  

    ```powershell
    $prefix = ""
    $add = Get-NetIPAddress -AddressFamily IPv4 -Type Unicast -PrefixOrigin Manual
    foreach ($a in $add)
    {


    $n = ($a.IPAddress).Split(".")
    Clear-Variable c -ErrorAction SilentlyContinue
    $c;
    foreach($num in $n)
    {if ($c.Length -eq 4)
    {$c = $c + ":"
    }
    $c = $c + ("{0:X2}" -f [int]$num)
    }
    $ip = $prefix + $c;
    New-NetIPAddress -IPAddress $ip -InterfaceAlias $a.InterfaceAlias -AddressFamily IPv6 -PrefixLength 64 -Type Unicast
    }
    ```

    **For Windows Server 2008 R2**  

    ```powershell
    $prefix = ""
    $addresses = get-wmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { ($_.IPEnabled -eq $true) } | Select-object IPAddress,InterfaceIndex

    Write-Host "Prefix: $prefix" -ForegroundColor Yellow

    foreach ($address in $addresses)
    {

    $a = $address.IPAddress[0];
    $idx = $address.InterfaceIndex;

    $n = $a.ToString().Split(".")
    foreach($num in $n)
    {
    if ($c.Length -eq 4)
    {
    $c = $c + ":"
    }
    $c = $c + ("{0:X2}" -f [int]$num)
    }
    $ip = $prefix + $c;
    Clear-Variable c;
    Write-Host "Adding DNS64 IP : $a == $ip " -ForegroundColor Green
    netsh int ipv6 add address $idx $ip
    }
    ```

3. Run this script on all the RDS servers. The script picks up the static IP from the network adapter, generates an NAT64'd IPv6 address, and assigns the address to the network adapter.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#remote-desktop-session).
