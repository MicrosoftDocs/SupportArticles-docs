---
title: Troubleshoot domain controller location issues in Windows
description: Helps troubleshoot domain controller location issues in Windows.
ms.date: 03/18/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, roharwoo, herbertm
ms.custom:
- sap:windows security\netlogon,secure channel,dc locator
- pcy:WinComm Directory Services
---
# Troubleshoot domain controller location issues in Windows

This article helps troubleshoot domain controller location issues in Windows.

Domain controller (DC) location, also known as *DC Locator*, refers to the algorithm the client machine uses to find a suitable domain controller. DC Locator is a critical baseline functionality in all enterprise environments. For more information about how domain controllers are located in Windows, see [Locating domain controllers in Windows and Windows Server](/windows-server/identity/ad-ds/manage/dc-locator).

If DC Locator doesn't work as expected in Active Directory domains, troubleshoot issues by using the following steps:

> [!NOTE]
> Authentication is the first step in almost all functional scenarios in an Active Directory enterprise environment. However, authentication occurs after the client communicates with an Active Directory domain controller.

1. Check the system logs (for example, the event source is **NETLOGON**) on both the client and the server. Also check the Directory Service logs (for example, the event source is **NTDS KCC**) on the server and Domain Name System (DNS) logs on the DNS server.
2. Open an elevated command prompt, and check the IP configuration by running the following command:

    ```console
    ipconfig /all
    ```

3. Use the Ping utility to verify network connectivity and the name resolution. Ping the IP address, the server name, and the domain name.
4. Use the [PortQryUI](https://www.microsoft.com/en-us/download/details.aspx?id=24009&msockid=010f589c35de634f3bee4ca4341562b2) tool to probe for availability of important domain controller services. When you start the tool, specify the domain controller fully qualified domain name (FQDN), and query the **Domains and Trusts** set of services as follows:

    :::image type="content" source="media/troubleshoot-domain-controller-location-issues/port-query-udp-389.png" alt-text="Screenshot of the Port Query tool window showing the query result with UDP port 389.":::

    The screenshot shows one important port for DC discovery which is UDP/389, and in this case, it is successful.

    > [!NOTE]
    > UDP/389: This port is required to discover AD services.

5. Use the `nslookup` tool to verify that DNS entries are correctly registered in DNS. Verify that the server host records and the globally unique identifier (GUID) SRV records can be resolved.

    For example, to verify record registrations, run the following commands:

    ```console
    nslookup servername.childofrootdomain.rootdomain.com
    ```

    ```console
    nslookup guid._msdcs.rootdomain.com
    ```

    If either of these commands doesn't succeed, use one of the following methods to reregister records with DNS:

    - To force the host record registration, use the `ipconfig /registerdns` command.
    - To force the domain controller service registration, stop and restart the Netlogon service.
    - To detect domain controller issues, run the DCdiag utility from a command prompt. The utility runs many tests to verify that a domain controller is running correctly. Use the `dcdiag /v >dcdiag.txt` command to send the results to a text file.

6. Use the *Ldp.exe* tool to connect and bind to the domain controller to verify appropriate Lightweight Directory Access Protocol (LDAP) connectivity.
7. If you suspect that a particular domain controller has issues, turn on Netlogon debug logging. Use the Nltest tool by running the `nltest /dbflag:0x2000ffff` command. The information is then logged in the *Netlogon.log* file under the *%windir%\\Debug* folder.
8. If you still haven't isolated the issue, use network monitor tools like Wireshark to capture and analyze network traffic between the client and the domain controller.
