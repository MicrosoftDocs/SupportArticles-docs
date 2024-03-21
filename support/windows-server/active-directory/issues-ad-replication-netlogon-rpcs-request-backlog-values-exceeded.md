---
title: Issues when AD replication and Netlogon RPCs request backlog values are exceeded
description: Describes how to configure Active Directory (AD) replication and Netlogon remote procedure calls (RPCs) request backlog values in Windows Server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, clfish, tcolla
ms.custom: sap:Active Directory\LDAP configuration and interoperability, csstroubleshoot
---
# Issues when AD replication and Netlogon RPCs request backlog values are exceeded

This article describes how to configure Active Directory (AD) replication and Netlogon remote procedure calls (RPCs) request backlog values in Windows Server.

You encounter one of the following issues:

- Transmission Control Protocol (TCP) resets occur frequently, but a network trace analysis doesn't provide the root cause.  
- Microsoft Exchange servers receive 401 errors intermittently when authenticating to domain controllers.
- Exchange servers fail to connect to domain controllers and report "The server is unavailable."
- Microsoft Outlook repeatedly prompts for user credentials when authenticating to a domain controller.
- You receive this error message when you sign in:
    > "The trust relationship between this workstation and the primary domain failed."

You might also see the following events in Windows Server:

- Event ID 3210

    ```output
    Event Log: System
    Event Type: Error
    Event Source: Netlogon
    Event ID: 3210
    Event Text: 
    This computer could not authenticate with [file://%3cDomain]\\<Domain Controller Name>.<Domain Name>, a Windows domain controller for domain <Domain Name>, and therefore this computer might deny logon requests.
 
    This inability to authenticate might be caused by another computer on the same network using the same name or the password for this computer account is not recognized. If this message appears again, contact your system administrator.
    ```

- Event ID 5719

    ```output
    Event Log: System
    Event Type: Error
    Event Source: Netlogon
    Event ID: 5719
    Event Text:
    This computer was not able to set up a secure session with a domain controller in domain <Domain Name> due to the following:

    The remote procedure call failed and did not execute.
    
    This may lead to authentication problems. Make sure that this computer is connected to the network. If the problem persists, please contact your domain administrator.
    ```

- Event ID 7

    ```output
    Event Log: System
    Event Type: Error
    Event Source: Microsoft-Windows-Security-Kerberos
    Event ID: 7
    Event Text:
    The digitally signed Privilege Attribute Certificate (PAC) that contains the authorization information for client <Hostname>$ in realm <Domain Name> could not be validated.
    ```

## Events after installing Windows preview updates June 2022

Windows Server 2019 [June 23, 2022—KB5014669 (OS Build 17763.3113) Preview](https://support.microsoft.com/topic/june-23-2022-kb5014669-os-build-17763-3113-preview-e9aae102-e21c-4f6d-89e0-ed0a82a793dc) update and Windows Server 2022 [June 23, 2022—KB5014665 (OS Build 20348.803) Preview](https://support.microsoft.com/topic/june-23-2022-kb5014665-os-build-20348-803-preview-feebab2b-1851-4119-a531-89ca80300b10) update report the problem and adjust settings for the RPC request backlog. After installing these updates, you might receive the following events.  

- The Netlogon service starts successfully with the given RPC backlog size.

    ```output
    Event Log: System
    Event Type: Info
    Event Source: Netlogon
    Event ID: 5836
    Event Text:
    The Netlogon service was able to bind to a TCP/IP port with the configured backlog size of <Configured Backlog Size>
    ```

- The Netlogon service related backlog size failure.

    ```output
    Event Log: System
    Event Type: Warning
    Event Source: Netlogon
    Event ID: 5837
    Event Text:
    The Netlogon service tried to bind to a TCP/IP port with the configured backlog size of <Configured RPC Backlog Size> but failed.

    More information can be found in the following log file '%SystemRoot%\debug\netlogon.log' and, potentially, in the log file '%SystemRoot%\debug\netlogon.bak' created if the former log becomes full. For steps in enabling the log, please visit https://go.microsoft.com/fwlink/?linkid=2163327.
    ```

- Active Directory replication related backlog limit failure.

    ```output
    Event Log: Active Directory Domain Services
    Event Type: Warning
    Event Source: ActiveDirectory_DomainService
    Event ID: 3042
    Event Text:
    Active Directory Domain Services could not configure the TCP port with the backlog limit as specified in registry.

    Additional Data
    
    TCP Port:
    
    <Configured Port>

    Configured backlog limit:

    <Backlog Limit Configured on Port>

    Registry backlog limit:

    <Backlog Limit Specified in Registry>

    User Action:

    Make sure the same TCP port is not being used by other services such as Netlogon and the Active Directory Domain Controller has been rebooted after configuring the backlog limit value in registry.
    ```

## Backlog limit value is exceeded  
  
The Transmission Control Protocol/Internet Protocol (TCP/IP) ports registered for AD replication and RPCs for the Netlogon service are configured with a backlog limit value. The default value is 10. This value represents the maximum number of requests that can be queued on the registered TCP/IP port. When the backlog limit value is exceeded, the TCP SYN packets are immediately reset by the RPC layer on the server. This behavior will affect authentication on the systems.  
  
## Increase RPC backlog limit value for DRSUAPI and Netlogon

> [!IMPORTANT]
> This section contains instructions to modify the registry. Serious problems might occur if the registry is modified incorrectly. As a precaution, back up the registry before you modify it. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).
  
You can use Registry Editor to increase the RPC backlog limit values for DRSUAPI and the Netlogon service as follows:  

> [!NOTE]
> We recommend that administrators configure proper values in the registry keys. Large values on your Windows servers can cause large amounts of non-paged pool memory usage. Administrators should balance memory footprint versus scalability requirements.  

- Registry key for DRSUAPI  
  
    Registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`  
    Registry value: **TCP/IP Backlog Limit**  
    Value type: **REG_DWORD**  
    Value data: Any value between 10 and 100  
  
    Restart the system for the setting to take effect.  

- Registry key for Netlogon  
  
    Registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`  
    Registry value: **DcTcpipBacklogLimit**  
    Value type: **REG_DWORD**  
    Value data: Any value between 10 and 100  

    Restart the Netlogon service for the setting to take effect. You may also need to restart the domain controller.  
