---
title: TCP settings may impact BizTalk Server
description: Describes TCP settings that can impact BizTalk Server.
ms.date: 03/18/2020
ms.prod-support-area-path:
---
# TCP settings may impact BizTalk Server

This article describes TCP settings that can impact BizTalk Server.

_Original product version:_ &nbsp; BizTalk Server 2010, 2009  
_Original KB number:_ &nbsp; 970406

## Symptoms

On a BizTalk server, you may notice the following symptoms:

- The following events may be logged in the Application Event logs:

   > Event ID: 6913  
   > Description: SQL Server, BizTalkMsgBoxDb, [DBNETLIB][ConnectionWrite (send()).] General network error. Check your network documentation.

   > Event ID: 5410  
   > Description: [DBNETLIB][ConnectionWrite (send()).]General network error. Check your network documentation.

   > Event ID: 6912  
   > Description: DBNETLIB][ConnectionRead (recv()).]General network error. Check your network documentation.

- The BizTalk Server fails to restart or shut down. When rebooting the computer, it may just hang and the mouse may not move. These symptoms may occur for an extended period of time and the computer may not shut down. There are no errors in the event log.

## Cause

These issues can occur because of TCP/IP changes in Windows Server 2003 and later.

## Resolution

There are several items to implement to stop the errors from occurring:

1. On the SQL server running on Windows Server 2003, set the `SynAttackProtect` registry key to 0. If you have incoming TCP/IP traffic (HTTP, WCF, WSE, or other adapters are using TCP/IP), you may have to set it on the BizTalk servers as well.

    > [!NOTE]
    > The `SynAttackProtect` registry key is not applicable on Windows Server 2008, Windows Vista, and later Windows versions.

2. On all the BizTalk and SQL servers running on Windows Server 2008, disable Receive Side Scaling (RSS) and the `TCP Chimney Offload` features of the Scalable Networking Pack (SNP).

    > [!NOTE]
    > You may also have to disable the Receive Side Scaling (RSS) and the TCP Chimney Offload features in the network adapter advanced properties as the network adapter drivers may override Windows settings that set earlier in this section in some cases.

3. On all BizTalk servers running on Windows Server 2003, increase the ephemeral ports and reduce the TCP reuse timeout setting by modifying the `MaxUserPort` and `TCPTimedWaitDelay` registry keys documented in [BizTalk Server Database Optimization](https://www.microsoft.com/download/details.aspx?id=56495).

    You can modify these settings at the `HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters` registry key. The table below lists the recommended values:

    |Value name|Value|Comment|
    |---|---|---|
    |MaxUserPort|0xFFFE (65534)|Prevents port exhaustion|
    |TcpTimedWaitDelay|0x1E (30)|Release unused ports as quickly as possible|
    ||||

4. On all BizTalk servers running on Windows Server 2008, there are 16383 ports (port 49152 to port 65535) and it around four times more ports than the default ports number in Windows Server 2003, we recommend that you only increase the ephemeral ports if the default range is not enough.

    > [!NOTE]
    > You can use the netstat `- an` command to see all TCP/IP ports. If you determine that additional dynamic ports are needed, refer to [The default dynamic port range for TCP/IP has changed in Windows Vista and in Windows Server 2008](https://support.microsoft.com/help/929851).

    The TCP reuse timeout setting can also be reduced by modifying the `TCPTimedWaitDelay` registry key.

    > [!NOTE]
    > It is recommend referring earlier in this section to increase the number of ports first before changing the setting.

5. On all the BizTalk and SQL servers running on Windows Server 2003, disable Privilege Attribute Certificate (PAC) verification. On all BizTalk and SQL servers running on Windows Server 2008, refer to [906736](https://support.microsoft.com/help/906736) for more information on Privilege Attribute Certificate (PAC) verification.

6. When you have many or complex group policies set on the user accounts and computer accounts that are used in BizTalk and SQL Server environment, the domain controllers may be too overloaded to respond to incoming authentication traffic. In this situation, you may have to optimize or exclude BizTalk and SQL Server servers from group policies and make sure that you have domain controllers that can handle such load. BizTalk uses multiple host instances and many threads that are continuously authenticated by the domain controllers. We also recommend that you use Kerberos authentication instead of NT LAN Manager (NTLM) authentication as it has certain cache. You can also handle double-hop scenarios, for example in multi-server environments.

7. When BizTalk servers are communicating with the computers that are running SQL Server on Windows Server 2008 with full encryption enabled mode, you may experience network timeouts issue intermittently. This issue occurs because the SQL Server servers are handling the Advanced Encryption Standard (AES) and Transport Layer Security (TLS) variable length encryption packets. To work around this issue, you have to disable full encryption or move the SQL Server instances to Windows Server 2003 or Windows Server 2008 R2. If you are using full encryption mode, it may reduce the performance significantly. It may be better to protect servers through other methods. For example: encrypted data, IP Security (IPsec), network segmentation, firewalls, or limited access.

### Restart requirement

You should restart your computer after implementing the changes above.

## More information

TCP/IP settings can also be configured using the Network shell (netsh) command-line utility at a Windows command prompt with administrator-level permissions. Refer to [Netsh Technical Reference](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc725935(v=ws.10)) for more information.

The [Description of TCP/IP settings that you may have to adjust when SQL Server connection pooling is disabled](https://support.microsoft.com/help/328476) also reference general network errors.

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability, or accuracy of the information contained in the documents and related graphics published on this website (the **materials**) for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by Applicable Law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied, or statutory. And it includes but is not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.
