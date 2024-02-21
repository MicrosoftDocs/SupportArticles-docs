---
title: An Internet Explorer or Edge window opens when your computer connects to a corporate network or a public network
description: When you connect a computer that's running Windows 8 or later to a network under certain conditions, you may see a sign-in page or the MSN Portal page.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tea, v-jesits, dantes, arrenc
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# An Internet Explorer or Edge window opens when your computer connects to a corporate network or a public network

This article provides some information about the issue where an Internet Explorer or Edge window opens when your computer connects to a corporate network or a public network.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 4494446

## Symptoms

You connect a computer that's running Windows 8 (or a later version) to a network in either of the following conditions:

- You connect your computer to a public network that requires Hotspot Sign in information (for example a hotel, airport, and so forth).
- You connect your computer to a corporate network that uses a proxy server to connect to the internet.

You notice the following behavior:

- The default browser (for example, **Internet Explorer** or **Edge**) opens, and shows a web page such as a sign-in page for the network or the MSN portal page.
- The network icon on the Task Bar shows an alert symbol (for example,:::image type="icon" source="media/internet-explorer-edge-open-connect-corporate-public-network/network-status-alert.png" border="false":::). If you hover over the icon, you see a message such as "No connectivity" or "Limited Internet access."

After you sign in to the network, you can use the network in the usual manner. After you use the network for a few seconds, the network alert on the Task Bar disappears.

## Cause

This behavior is by design.

## More information

Windows uses the Network Location Awareness (NLA) service to detect the properties of a network and determine how to manage connections to that network. NLA uses a component that is named the Network Connectivity Status Indicator (NCSI) to determine whether the computer has successfully connected to the network, and whether the network has intranet or internet connectivity.

NCSI uses both active and passive probes. These probes are triggered by changes in any of the network interfaces. When you connect your computer to a network as described in the [Symptoms](#symptoms)  section, NCSI begins a process that includes one or more of the following:

- [NCSI active probes and the network status alert](#ncsi-active-probes-and-the-network-status-alert)
- [Authentication and the automatic sign-in page](#authentication-and-the-automatic-sign-in-page)
- [NCSI passive monitoring and the network status alert](#ncsi-passive-monitoring-the-msn-portal-page-and-the-network-status-alert)

### NCSI active probes and the network status alert

The active probe process consists of the following steps:

- Windows 10 or later versions:
   1. NCSI sends a DNS request to resolve the address of the `www.msftconnecttest.com` FQDN.
   2. If NCSI receives a valid response from a DNS server, NCSI sends a plain HTTP GET request to `http://www.msftconnecttest.com/connecttest.txt`.
   3. If NCSI successfully downloads the text file, it makes sure that the file contains Microsoft Connect Test.
   4. NCSI sends another DNS request to resolve the address of the `dns.msftncsi.com` FQDN.

      - If any of these requests fails, the network alert appears in the Task Bar (as described in Symptoms). If you hover over the icon, you see a message such as "No connectivity" or "Limited Internet access" (depending on which requests failed).
      - If all of these requests succeed, the Task Bar shows the usual network icon. If you hover over the icon, you see a message such as "Internet access."

- Windows 8.1 or earlier versions:
  1. NCSI sends a DNS request to resolve the address of the `www.msftncsi.com` FQDN.
  2. If NCSI receives a valid response from a DNS server, NCSI sends a plain HTTP GET request to `http://www.msftncsi.com/ncsi.txt`.
  3. If NCSI successfully downloads the text file, it makes sure that the file contains Microsoft NCSI.
  4. NCSI sends another DNS request to resolve the address of the `dns.msftncsi.com` FQDN.

     - If any of these requests fails, the network alert appears in the Task Bar (as described in Symptoms). If you hover over the icon, you see a message such as "No connectivity" or "Limited Internet access" (depending on which requests failed).
     - If all of these requests succeed, the Task Bar shows the usual network icon. If you hover over the icon, you see a message such as "Internet access."

NCSI and the NLA service combine these responses with other information to build a profile of the network connection, or identify its existing profile. The network connection profile provides the information that Windows needs to configure the appropriate Windows Firewall profile:

- For Active Directory-authenticated networks: Firewall domain profile.
- For networks that the user has marked as "private": Firewall private profile.
- For networks that the user has marked as "public": Public firewall profile.

> [!Note]
> You can use Group Policy to restrict the active probe process, and you can substitute a different website as a target (although this substitution is not a recommended solution). For more information, see the following resources:
>
> - [Manage connections from Windows operating system components to Microsoft services: 14. Network Connectivity Status Indicator](/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services#14-network-connection-status-indicator)
> - [Policy CSP - Connectivity: Connectivity/DisallowNetworkConnectivityActiveTests](/windows/client-management/mdm/policy-csp-connectivity#connectivity-disallownetworkconnectivityactivetests)

### Authentication and the automatic sign-in page

If the network requires credentials, Windows opens the default browser (such as Internet Explorer or Edge). If the network has a sign-in page, that page appears in the browser.

This behavior was introduced to improve the Windows user experience. In earlier versions of Windows, when you connect to a network that requires you to authenticate, the browser window does not open automatically. You may see a message that states that you must take further action in order to connect fully to the network. To complete the connection, you must click the message to open a browser window (or manually open a browser window) and enter a user name and password.

Because the network does not allow internet access without credentials, the network alert appears in the Task Bar.

### NCSI passive monitoring, the MSN Portal page, and the network status alert

In addition to the active probes that this article describes, NCSI monitors the network activity of other applications on the computer. This passive monitoring process continues even if the active probe process fails. NCSI adjusts its network status determination based on whether other applications can make successful TCP connections. If a network alert appears because of a failed active probe, it disappears when a passive probe succeeds.

> [!Note]
> The NCSI passive monitoring process does not transfer any information to or from your computer, and does not read any of the information that other applications transfer.

In some cases, such as when you connect to a network that uses a proxy server to connect to the internet or when network restrictions prevent NCSI from completing its active probe process, Windows opens the MSN Portal page in the default browser. If you analyze a network trace on the computer, it shows an HTTP connection to `http://www.msftconnecttest.com/redirect` that is followed by a connection to the MSN Portal. Windows opens this page for the benefit of the passive probe process. If the page loads, NCSI concludes that the computer has internet access. As the different probes fail and then succeed, the network status alert appears and then disappears.

> [!Note]
> To prevent the browser window from opening when the computer connects to a network that has a proxy server, you have to configure the network firewall to allow access to the following URLs on port 80:
>
> - \*.msftncsi.com
> - \*.msftconnecttest.com
>
>For more information, see [KB 2778122, Using authenticated proxy servers together with Windows 8](use-authenticated-proxy-servers.md)

## Workaround

You can disable the NCSI active or passive probes by using the registry or Group Policy Objects (GPOs).

> [!Caution]
> Microsoft does not recommend disabling the NCSI probes. Several operating system components and applications rely on NCSI. For example, if NCSI does not function correctly, Microsoft Outlook may not be able to connect to a mail server, or Windows may not be able to download updates even if the computer is connected to the internet.

To use the registry to disable NCSI active probes, configure one of the following registry keys.

> [!Important]
Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\EnableActiveProbing`
  - Key Type: DWORD
  - Value: Decimal 0 (False)
- `HKLM\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator\NoActiveProbe`
  - Key Type: DWORD
  - Value: Decimal 1 (True)
    > [!Note]
    > In the default registry configuration, this registry entry does not exist. You must create it.

To use the registry to disable NCSI passive probes, create the following registry key.

- `HKLM\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator\DisablePassivePolling`
  - Key Type: DWORD
  - Value: Decimal 1 (True)
    > [!Note]
    > In the default registry configuration, this registry entry does not exist. You must create it.

To use Group Policy to disable NCSI active probes, configure the following GPO:

- **Computer Configuration**\\**Administrative Templates**\\**System**\\**Internet Communication Management**\\**Internet Communication settings**\\**Turn off Windows Network Connectivity Status Indicator active tests**  
  - Value: Enabled

To use Group Policy to disable NCSI passive probes, configure the following GPO:

- **Computer Configuration**\\**Administrative Templates**\\**Network**\\**Network Connectivity Status Indicator**\\**Specify passive polling**.  
  - Value: Enabled
