---
title: Slow performance occurs when you copy data to a TCP server by using a Windows Sockets API program
description: Provides workarounds for the issue slow performance occurs when you copy data to a TCP server by using a Windows Sockets API program.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, tdetzner
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.technology: networking
---
# Slow performance occurs when you copy data to a TCP server by using a Windows Sockets API program

This article provides workarounds for the issue where slow performance occurs when you copy data to a TCP server by using a Windows Sockets API program.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 823764

## Symptoms

When you run a program that uses the Windows Sockets API, you may experience slow performance when you copy data to a TCP server.

If you make a network trace with a network sniffer such as Microsoft Network Monitor, the TCP server sends a TCP ACK segment to the last TCP segment in a TCP data stream in the delayed acknowledgment timer (also known as the delayed ACK timer). By default, for Windows operating systems, the value for this timer is 200 milliseconds (ms). A typical data flow for sending 64 kilobytes (KB) of data looks similar to the following sequence:

> Client->Server 1460 bytes  
Client->Server 1460 bytes  
Server->Client ACK  
Client->Server 1460 bytes  
Client->Server 1460 bytes  
Server->Client ACK  
....  
Client->Server 1460 bytes  
Client->Server 1460 bytes  
Server->Client ACK-PUSH  
Client->Server 1296 bytes  
-> delayed ACK 200 ms  

## Cause

This problem occurs because of the architectural behavior of the Windows Sockets API and afd.sys. This problem occurs if all the following conditions are true:

- The Windows Sockets program uses non-blocking sockets.
- A single send call or WSASend call fills the whole underlying socket send buffer.

    For example, the program uses the Windows Sockets `setsockopt` function to change the default socket send buffer to 32 KB during its socket initialization routines:

    ```c
    setsockopt( sock, SOL_SOCKET, 32768, (char *) &val, sizeof( int ));
    ```

    Later, when the program sends data, it issues a send call or a WSASend call and sends 64 KB of data during each send:

    ```c
    send(socket, pWrBuffer, 65536, 0);
    ```

    In this scenario, each time the program issues a send call of 64 KB of data, the program returns a SOCKET_ERROR error code if the underlying 32-KB socket buffer is filled. After it calls the WSAGetLastError function, the program receives the WSAEWOULDBLOCK error code. Most programs use the Windows Sockets select function to check the status of the socket. In this scenario, the select function does not report the socket as writable until the client receives the outstanding TCP ACK segment. By default in a Windows environment, this may take as long as 200 ms because of the delayed acknowledgment algorithm.

- The remote TCP server acknowledges all the TCP segments before the client sends the last TCP segment with the push bit set.

## Workaround

To work around this problem, use any of the following methods.

### Method 1: Use blocking sockets

This problem only occurs with non-blocking sockets. When you use a blocking socket, this problem does not occur because afd.sys handles the socket buffer differently. For more information about blocking and non-blocking socket programming, see the Microsoft Platform SDK documentation.

### Method 2: Make the socket send buffer size larger than the program send buffer size

To modify the socket send buffer, use the Windows Sockets `getsockopt` function to determine the current socket send buffer size (SO_SNDBUF), and then use the `setsockopt` function to set the socket send buffer size. When you are finished, the SO_SNDBUF value must be at least 1 byte larger than the program send buffer size.

Modify the send call or the WSASend call to specify a buffer size at least 1 byte smaller than the SO_SNDBUF value. In the earlier example in the "Cause" section of this article, you could modify the setsockopt call to the following value,

```c
setsockopt( sock, SOL_SOCKET, 65537, (char *) &val, sizeof( int ));
```

or you could modify the send call to the following value:

```c
send(socket, pWrBuffer, 32767, 0);
```

You could also use any combination of these values.

### Method 3: Modify the TCP/IP settings on the TCP server

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

Modify the TCP/IP settings on the TCP server to immediately acknowledge incoming TCP segments. This workaround works best in an environment that has a large client installation base and where you cannot change the program's behavior. For scenarios where the remote TCP server runs on a Windows-based server, you must modify the registry of the remote server. For other operating systems, see the operating system's documentation for information about how to change the delayed acknowledgment timer.

On a server that runs Windows 2000, follow these steps:

1. Start **Registry Editor** (Regedit.exe).
2. Locate and then click the following registry subkey:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\<Interface GUID>`  
3. On the **Edit** menu, click **Add Value**, and then create the following registry value:  
    **Value name**: TcpDelAckTicks  
    **Data type**: REG_DWORD  
    **Value data**: 0  
4. Quit **Registry Editor**.
5. Restart Windows for this change to take effect.

On a server that runs Windows XP or Windows Server 2003, follow these steps:

1. Start **Registry Editor**.
2. Locate and then click the following registry subkey:
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\<Interface GUID>`  
3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Name the new value *TcpAckFrequency*, and assign it a value of 1.
5. Quit **Registry Editor**.
6. Restart Windows for this change to take effect.

### Method 4: Modify the buffering behavior in afd.sys for non-blocking sockets

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

> [!NOTE]
> This registry key is only available for Windows Server 2003 with Service Pack 1 and subsequent service packs.

1. Click **Start**, type *regedit.exe*, and then click **OK**.
2. Locate and then click the following registry subkey:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters`  
3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Name the new value *NonBlockingSendSpecialBuffering*, and assign it a value of 1.
5. Exit **Registry Editor**.
6. Restart Windows for this change to take effect.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

[328890](https://support.microsoft.com/help/328890) New registry entry for controlling the TCP Acknowledgment (ACK) behavior in Windows XP and in Windows Server 2003
