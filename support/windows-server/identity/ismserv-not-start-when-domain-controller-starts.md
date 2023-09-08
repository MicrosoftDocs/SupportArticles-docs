---
title: ISMServ.exe fails to start when a domain controller starts
description: Describes a condition under which the Intersite Messaging Service does not start correctly when a domain controller starts. Provides a workaround.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, oweindl
ms.custom: sap:active-directory-database-issues-and-domain-controller-boot-failures, csstroubleshoot
ms.technology: windows-server-active-directory
---
# ISMServ.exe does not start when a domain controller starts

This article provides a workaround for an issue where the IsmServ service doesn't start correctly when a domain controller starts.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4530043

## Symptoms

When you start a Windows Server domain controller (DC), it does not start correctly. When you check the System log in Event Viewer, you find the following entry for Event ID 7023:

> Log Name:      System  
Source:        Service Control Manager​  
Event ID:      7023​  
Level:         Error​  
Description:​  
The IsmServ service terminated with the following error:  
The specified server cannot perform the requested operation.​  
Event Xml:​  
\<Event xmlns="`http://schemas.microsoft.com/win/2004/08/events/event`"\>  
\...​  
  \<EventData\>​  
    \<Data Name="param1"\>IsmServ\</Data\>​  
    \<Data Name="param2"\>%%58\</Data\>​  
  \</EventData\>​  
\</Event\>​

This event includes the following data parameters:

- The **param1** parameter value, **IsmServ**: This represents the Intersite Messaging service (ISMserv.exe).
- The **param2** parameter value, **58**: This maps to the ERROR_BAD_NET_RESP message ("The specified server cannot perform the requested​ operation").

To collect more information about this problem, you can configure LDAP Event Tracing for Windows (ETW) to run at system startup. (For details about how to do this, see [More information](#more-information).) After you restart the DC, you should see the following lines in the log:

> [Microsoft-Windows-LDAP-Client/Debug] Message=LDAP connection 0xec4b08a8 successfully resolved 'localhost' using GetHostByName.  
...  
[Microsoft-Windows-LDAP-Client/Debug] Message=gethostbyname collected 2 records for '`dc1.contoso.com`'**[Microsoft-Windows-LDAP-Client/Debug] Message=LdapParallelConnect called for connection 0xec4b08a8 with timeout 45 sec 0 usec.  Total count is 2.**  
**[Microsoft-Windows-LDAP-Client/Debug] Message=No response yet...**  
[Microsoft-Windows-LDAP-Client/Debug] Message=LdapParallelConnect finished for connection 0xec4b08a8.  Time taken was 1 sec.  Original timeout specified was 45 sec 0 usec.  
...  
[Microsoft-Windows-LDAP-Client/Debug] Message=LdapConnect failed to open connection 0xec4b08a8, error = 0x5b.  
[Microsoft-Windows-LDAP-Client/Debug] Message=LdapConnect thread 0xce0 has connection 0xec4b08a8 as down.

In this event, the value of the **error** parameter (**0x5b** or **91**) maps to the LDAP_CONNECT_ERROR message.

## Cause

ISMServ depends on Active Directory Domain Services (AD DS). However, during system startup, ISMServ may try to create an LDAP connection to AD DS before AD DS finishes coming online. When this happens, the LDAP port (TCP port 389) is not available when ISMServ tries to connect. Because the port is not listening, ISMServ determines that the connection has failed without waiting for the connection time-out period (45 seconds). Therefore, ISMServ does not start.

## Workaround

To immediately work around this problem, manually restart ISMServ.

To avoid this problem in the future, use the Services and Applications MMC snap-in to change the **Startup Type** of ISMServ from **Automatic** to **Automatic (Delayed Start)**.

## More information

To configure LDAP ETW, follow these steps:

1. Use Registry Editor to create the following registry subkey:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ldap\Tracing\ISMSERV.EXE`

2. Open an elevated Command Prompt window, and run the following commands:

    ```console
    logman create trace "autosession\g_os" -ow -o c:\boot-ldap.etl -p "Microsoft-Windows-LDAP-Client" 0xffffffffffffffff 0xff -nb 16 16 -bs 1024 -mode Circular -f bincirc -max 4096 -ets reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\g_os /v FileMax /t REG_DWORD /d 2 /F
    ```

3. Restart the computer.

4. After the computer starts, run the following command at an elevated command prompt:

    ```console
    logman stop "g_os" -ets
    ```

5. When you finish collecting data, run the following command at an elevated command prompt to stop tracing:

    ```console
    logman delete "autosession\g_os" -et
    ```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

## References

[How to turn on debug logging of the LDAP client (Wldap32.dll)](https://support.microsoft.com/help/325616)
