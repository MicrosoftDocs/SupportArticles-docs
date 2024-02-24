---
title: 10060 Connection timed out error with proxy server or ISA Server on slow link
description: Describes the 10060 Connection timed out error with proxy server or ISA Server on slow link.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, carlc
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# 10060 Connection timed out error with proxy server or ISA Server on slow link

This article provides help to fix Winsock timeout errors that occur on slow, congested, or high latency Internet links with Microsoft Proxy Server or ISA Server.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 191143

## Symptoms

Winsock timeout errors may occur on slow, congested, or high latency Internet links with Microsoft Proxy Server or ISA Server. The following Winsock error Message appears on the client Web browser:

> Proxy Reports:  
10060 Connection timed out
>
> The Web server specified in your URL could not be contacted. Please check your URL or try your request again.

> [!NOTE]
> A timeout error may also occur when connecting to an Internet server that does not exist or if there is more than one default gateway on the Proxy Server computer.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Adjusting the following TCP/IP setting by adding a subkey in the registry should reduce the number of timeouts by allowing more time for the connection to complete. This setting is not present in the registry by default.

1. Start Registry Editor (Regedt32.exe) and go to the following subkey:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`

2. On the **Edit** menu, click **Add Value**, and then add the following information:

    - Value name: TcpMaxDataRetransmissions
    - Value type: REG_DWORD - Number
    - Valid range: 0 - 0xFFFFFFFF
    - Default value: 5 Decimal
    - New value: 10 Decimal

3. Click **OK**, and then quit Registry Editor.
4. Reboot after registry change has been made.

## More information

The TcpMaxDataRetransmissions parameter controls the number of times TCP retransmits an individual data segment (non-connect segment) before ending the connection. The retransmission timeout is doubled with each successive retransmission on a connection. It is reset when responses resume. The base timeout value is dynamically determined by the measured round-trip time on the connection.

The default value for this registry entry is 5; double this value to 10 (Decimal) (see step 2 above). If connection timeouts still occur, try doubling the value again to 20 (Decimal).

> [!NOTE]
> This registry entry may only reduce the number of connection timeout errors that occur. Changes to your Internet connection or router may have to be made to completely resolve the problem.
