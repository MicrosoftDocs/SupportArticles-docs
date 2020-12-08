---
title: 10060 Connection timed out error with proxy server or ISA Server on slow link
description: Describes the 10060 Connection timed out error with proxy server or ISA Server on slow link.
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: carlc
---
# 10060 Connection timed out error with proxy server or ISA Server on slow link

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 191143

## Problem description

Winsock timeout errors may occur on slow, congested, or high latency Internet links with Microsoft Proxy Server or ISA Server. The following Winsock error Message appears on the client Web browser:

```

Proxy Reports:
 10060 Connection timed out

The Web server specified in your URL could not be contacted. Please
 check your URL or try your request again.

```

> [!NOTE]
> A timeout error may also occur when connecting to an Internet server that does not exist or if there is more than one default gateway on the Proxy Server computer.

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[161380](https://support.microsoft.com/help/161380) Only one default gateway allowed on proxy server  

To have us fix this problem for you, go to the "[Fix it for me](#fixitformealways)" section. To fix this problem yourself, go to the "[Let me fix it myself](#letmefixitmyselfalways)" section.

## Fix it for me

To fix this problem automatically, click the
 **Fix it** button or link. Click
 **Run** in the
 **File Download** dialog box, and then follow the steps in the Fix it wizard.

> [!NOTE]
> this wizard may be in English only; however, the automatic fix also works for other language versions of Windows.

> [!NOTE]
> If you are not on the computer that has the problem, you can save the automatic fix to a flash drive or to a CD, and then you can run it on the computer that has the problem.

Next, go to the "[Did this fix the problem?](#fixedalways)" section.

## Let me fix it myself

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  
Adjusting the following TCP/IP setting by adding a subkey in the registry should reduce the number of timeouts by allowing more time for the connection to complete. This setting is not present in the registry by default.


1. Start Registry Editor (Regedt32.exe) and go to the following subkey:

```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters
```

2. On the **Edit** menu, click **Add Value**, and then add the following information:

```

Value Name: TcpMaxDataRetransmissions
 Value Type: REG_DWORD - Number
 Valid Range: 0 - 0xFFFFFFFF
 Default Value: 5 Decimal
 New Value: 10 Decimal

```

3. Click **OK**, and then quit Registry Editor.

4. Reboot after registry change has been made.

## Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this article. If the problem is not fixed, you can [contact support](/contactus).

## More Information

The *TcpMaxDataRetransmissions* parameter controls the number of times TCP retransmits an individual data segment (non connect segment) before ending the connection. The retransmission timeout is doubled with each successive retransmission on a connection. It is reset when responses resume. The base timeout value is dynamically determined by the measured round-trip time on the connection.

The Default Value for this registry entry is 5; double this value to 10 (Decimal) (see step 2 above). If connection timeouts still occur, try doubling the value again to 20 (Decimal).

> [!NOTE]
> This registry entry may only reduce the number of connection timeout errors that occur. Changes to your Internet connection or router may have to be made to completely resolve the problem.
