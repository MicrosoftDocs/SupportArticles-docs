---
title: Configure ISA Server computer for authentication requests
description: Describes how to improve authentication throughput on a computer that is running Microsoft Internet Security and Acceleration (ISA) Server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, STEFANG
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# How to configure an ISA Server computer for a large number of authentication requests

This step-by-step article describes how to improve authentication throughput on a computer that is running Microsoft Internet Security and Acceleration (ISA) Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 326040

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base: [256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows registry  

## Summary

If the computer uses NTLM or Basic authentication for many Web clients, you may experience poor performance. This problem does not occur when authentication is turned off.

You can improve the authentication throughput by increasing the number of concurrent authentication calls that are in progress at one time between the ISA Server computer and the domain controller.

Windows member servers only issue up to two concurrent NTLM authentication requests by default. Windows Domain Controllers only support one concurrent authentication request per session with a remote (user) domain controller.

### Add a registry key

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

Follow these steps to increase the number of concurrent authentication calls in progress at one time between the ISA Server computer and the domain controller.

1. Start **Registry Editor**. To do this, click **Start** , click **Run**, type *Regedt32.exe*, and then click **OK**.
2. Locate the following registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  

3. On the **Edit** menu, click **Add Value**, and then add the following registry information:

    - Value Name: MaxConcurrentApi
    - Data Type: REG_DWORD
    - Value: between 0 and 10.

    Windows 2008 R2 maximum value is 150.
4. Restart the NETLOGON service. To use the higher values, you need to install an update:
 [975363](https://support.microsoft.com/help/975363) A time-out error occurs when many NTLM authentication requests are sent from a Domain Member for users from remote Domains in a high latency network.

> [!NOTE]
> When you increase the value of the MaxConcurrentApi entry to a value that is greater than 5, make sure that you monitor the number of requests that are sent to the domain controller.

If you have a computer that is running Microsoft Windows 2000 Advanced Server, you can use the Network Load Balancing component (previously known as WLBS) of Windows 2000 Advanced Server to distribute incoming access requests among multiple IAS servers. This helps the server perform better when network traffic is high.

To load balance the Web requests and authentication and to increase performance, you can also use more ISA Server computers in an array.

You should set the value on the resource server and all intermediate DCs handling the NTLM authentication request on the path to the user domain. In a multi-level Active Directory Forest contoso.com with domains users.contoso.com with the users and servers.contoso.com with the resource servers, this means that you have to set this on the resource servers and DCs in server.contoso.com and DCs in contoso.com.

Another way to improve performance may be to authenticate the client computer by using Kerberos, but this is not supported with Internet Explorer 6 and earlier versions. earlier.

## References

Information about the update for Windows Server 2008 R2 that increases the limit documented above:

975363 A time-out error occurs when many NTLM authentication requests are sent from a computer that is running Windows Server 2008 R2 or Windows 7 in a high latency network

[You are intermittently prompted for credentials or experience time-outs when you connect to Authenticated Services](https://support.microsoft.com/help/975363)
