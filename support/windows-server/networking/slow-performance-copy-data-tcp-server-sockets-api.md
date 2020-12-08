---
title: Slow performance occurs when you copy data to a TCP server by using a Windows Sockets API program
description: 
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: tdetzner
---
# Slow performance occurs when you copy data to a TCP server by using a Windows Sockets API program

_Original product version:_ &nbsp; Microsoft Windows Server 2003 Enterprise Edition (32-bit x86), Microsoft Windows Server 2003 Standard Edition (32-bit x86), Microsoft Windows Server 2003 Web Edition, Microsoft Windows XP Home Edition, Microsoft Windows XP Professional, Windows Server 2008 Datacenter without Hyper-V, Windows Server 2008 Enterprise without Hyper-V, Windows Server 2008 for Itanium-Based Systems, Windows Server 2008 Standard without Hyper-V, Windows Server 2008 Datacenter, Windows Server 2008 Enterprise, Windows Server 2008 Standard, Windows Server 2008 Web Edition, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Enterprise, Windows Server 2008 R2 Datacenter, Windows Server 2012 Datacenter, Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2012 Standard, Windows 8 Enterprise, Windows 8 Pro, Windows 7 Professional, Windows 7 Enterprise, Windows 7 Home Basic, Windows 7 Home Premium  
_Original KB number:_ &nbsp; 823764

## Symptoms

When you run a program that uses the Windows Sockets API, you may experience slow performance when you copy data to a TCP server.

If you make a network trace with a network sniffer such as Microsoft Network Monitor, the TCP server sends a TCP ACK segment to the last TCP segment in a TCP data stream in the delayed acknowledgement timer (also known as the delayed ACK timer). By default, for Windows operating systems, the value for this timer is 200 milliseconds (ms). A typical data flow for sending 64 kilobytes (KB) of data looks similar to the following sequence:
```
Client->Server 1460 bytes
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

```

## Cause

This problem occurs because of the architectural behavior of the Windows Sockets API and Afd.sys. This problem occurs if all the following conditions are true:


- The Windows Sockets program uses non-blocking sockets.
- A single send call or WSASend call fills the whole underlying socket send buffer.

For example, the program uses the Windows Sockets setsockopt function to change the default socket send buffer to 32 KB during its socket initialization routines:
```
setsockopt( sock, SOL_SOCKET, 32768, (char *) &val, sizeof( int ));
```

Later, when the program sends data, it issues a send call or a WSASend call and sends 64 KB of data during each send:
```
send(socket, pWrBuffer, 65536, 0);
```

In this scenario, each time the program issues a send call of 64 KB of data, the program returns a SOCKET_ERROR error code if the underlying 32-KB socket buffer is completely filled. After it calls the WSAGetLastError function, the program receives the WSAEWOULDBLOCK error code. Most programs use the Windows Sockets select function to check the status of the socket. In this scenario, the select function does not report the socket as writable until the client receives the outstanding TCP ACK segment. By default in a Windows environment, this may take as long as 200 ms because of the delayed acknowledgement algorithm.
- The remote TCP server acknowledges all the TCP segments before the client sends the last TCP segment with the push bit set.

## Workaround

To work around this problem, use any of the following methods.

### Method 1: Use Blocking Sockets

This problem only occurs with non-blocking sockets. When you use a blocking socket, this problem does not occur because Afd.sys handles the socket buffer differently. For more information about blocking and non-blocking socket programming, see the Microsoft Platform SDK documentation.

### Method 2: Make the Socket Send Buffer Size Larger Than the Program Send Buffer Size

To modify the socket send buffer, use the Windows Sockets getsockopt function to determine the current socket send buffer size (SO_SNDBUF), and then use the setsockopt function to set the socket send buffer size. When you are finished, the SO_SNDBUF value must be at least 1 byte larger than the program send buffer size.

Modify the send call or the WSASend call to specify a buffer size at least 1 byte smaller than the SO_SNDBUF value. In the earlier example in the "Cause" section of this article, you could modify the setsockopt call to the following value,
```
setsockopt( sock, SOL_SOCKET, 65537, (char *) &val, sizeof( int ));
```

or you could modify the send call to the following value:
```
send(socket, pWrBuffer, 32767, 0);
```

You could also use any combination of these values.

### Method 3: Modify the TCP/IP Settings on the TCP Server

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

Modify the TCP/IP settings on the TCP server to immediately acknowledge incoming TCP segments. This workaround works best in an environment that has a large client installation base and where you cannot change the program's behavior. For scenarios where the remote TCP server runs on a Windows-based server, you must modify the registry of the remote server. For other operating systems, see the operating system's documentation for information about how to change the delayed acknowledgement timer.

On a server that runs Windows 2000, follow these steps:
1. Start Registry Editor (Regedit.exe).
2. Locate and then click the following registry subkey:
 **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\<Interface GUID>**  

3. On the **Edit** menu, click **Add Value**, and then create the following registry value:

**Value name** : TcpDelAckTicks 
 **Data type** : **REG_DWORD**  
 **Value data** : 0 
4. Quit Registry Editor.
5. Restart Windows for this change to take effect.On a server that runs Windows XP or Windows Server 2003, follow these steps:
1. Start Registry Editor.
2. Locate and then click the following registry subkey:
 **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\<Interface GUID>**  

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Name the new value TcpAckFrequency , and assign it a value of 1.
5. Quit Registry Editor.
6. Restart Windows for this change to take effect.

### Method 4: Modify the buffering behavior in Afd.sys for non-blocking sockets

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

> [!NOTE]
> This registry key is only available for Windows Server 2003 with Service Pack 1 and subsequent service packs.
1. Click **Start**, type regedit.exe , and then click **OK**.
2. Locate and then click the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters` 

3. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
4. Name the new value NonBlockingSendSpecialBuffering , and assign it a value of 1.
5. Exit Registry Editor.
6. Restart Windows for this change to take effect.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. 

## References

[328890](https://support.microsoft.com/help/328890) New registry entry for controlling the TCP Acknowledgment (ACK) behavior in Windows XP and in Windows Server 2003
