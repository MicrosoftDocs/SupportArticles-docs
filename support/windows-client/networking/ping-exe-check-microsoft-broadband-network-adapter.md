---
title: Check Microsoft Broadband Network Adapter
description: Provides some information about checking your Microsoft Broadband Network Adapter with Ping.exe.
ms.date: 09/27/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.subservice: networking
---
# How to use Ping.exe to check your Microsoft Broadband Network Adapter  

This article provides some information about checking your Microsoft Broadband Network Adapter with Ping.exe.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 814155

## Summary

This article describes how to use the Microsoft Windows Ping.exe utility to determine if your network adapter is working.

## More information

To use ping effectively, you need the following information:

- The IP address of the network adapter that you are checking.
- The IP address of your default gateway. It may be your base station, modem, or router, depending on how your network is configured.  

To find this information:

1. Click **Start**, click **Run**, type cmd, and then click **OK**.
2. At the command prompt, type
 ipconfig, and then press ENTER.
3. Note the following information:

   - The IP address of the network adapter that you want to check.
   - The IP address of your default gateway.

### Use Ping.exe to Check Your Hardware

To do this checking:

1. At the command prompt, type ping loopback /localhost 127.0.0.1, and then press ENTER. The result should be similar as:  

    ```console
    Reply from 127.0.0.1: bytes=127 time<1ms TTL=128  
    Reply from 127.0.0.1: bytes=127 time<1ms TTL=128  
    Reply from 127.0.0.1: bytes=127 time<1ms TTL=128  
    Reply from 127.0.0.1: bytes=127 time<1ms TTL=128  
    ```  

   Ping statistics for 127.0.0.1: Packets: Sent = 4, Received = 4, Lost = 0 (0% loss), Approximate round-trip times in milliseconds: Minimum = 0ms, Maximum = 0ms, Average = 0ms  
If it does not work, there may be a problem with TCP/IP on your computer. You may have to reinstall TCP/IP, and you cannot complete the following steps until you can successfully complete this step.
2. At the command prompt, type ping  
 **network_adapter_IP_address**, and then press ENTER. For example, if your network adapter's IP address is 192.168.2.9, type ping 192.168.2.9, and then press ENTER. The result should be similar to the as:  

    ```console
    Reply from 192.168.2.9: bytes=32 time<1ms TTL=128  
    Reply from 192.168.2.9: bytes=32 time<1ms TTL=128  
    Reply from 192.168.2.9: bytes=32 time<1ms TTL=128  
    Reply from 192.168.2.9: bytes=32 time<1ms TTL=128  
    ```

   Ping statistics for 192.168.2.9: Packets: Sent = 4, Received = 4, Lost = 0 (0% loss), Approximate round-trip times in milliseconds: Minimum = 0ms, Maximum = 0ms, Average = 0ms  
 If it does not work, there may be a problem with your network adapter.
3. At the command prompt, type ping  
 **gateway_IP_address**, and then press ENTER. For example, if the IP address of your base station is 192.168.2.1, type
 ping 192.168.2.1, and then press ENTER. The result should be similar to the as:  

    ```console
    Reply from 192.168.2.1: bytes=32 time=5ms TTL=64  
    Reply from 192.168.2.1: bytes=32 time=4ms TTL=64  
    Reply from 192.168.2.1: bytes=32 time=4ms TTL=64  
    Reply from 192.168.2.1: bytes=32 time=4ms TTL=64  
    ```

   Ping statistics for 192.168.2.1: Packets: Sent = 4, Received = 4, Lost = 0 (0% loss), Approximate round-trip times in milliseconds: Minimum = 4 ms, Maximum = 5 ms, Average = 4 ms  
If it does not work, there may be a problem with your base station, modem, router, or network cable.

## References

For additional information about how to troubleshoot TCP/IP in Microsoft Windows, click the following article numbers to view the articles in the Microsoft Knowledge Base:  

   [314067](https://support.microsoft.com/help/314067) How to troubleshoot TCP/IP connectivity with Windows XP  
   [169790](https://support.microsoft.com/help/169790) How to troubleshoot basic TCP/IP problems
