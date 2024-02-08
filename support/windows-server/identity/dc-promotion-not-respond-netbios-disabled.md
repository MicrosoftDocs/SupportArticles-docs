---
title: DC promotion stops responding
description: Describes an issue in which domain controller promotion fails. This issue occurs when short credentials are used in an environment that has NetBIOS over TCPIP disabled.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Domain controller promotion stops responding when NetBIOS over TCPIP is disabled in Windows Server 2012 R2

This article provides a solution to an issue where domain controller promotion stops responding when short credentials are used in an environment that has NetBIOS over TCPIP disabled.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2948052

## Symptoms

When you use Active Directory Domain Services Configuration Wizard to promote a computer to domain controller in Windows Server 2012 R2, the wizard stops responding. When the issue occurs, Active Directory Domain Services Configuration Wizard indicates the promotion is in process and displays the following text:  
> Windows Server 2012 R2 domain controllers have a default for the security setting named "Allow cryptography algorithms compatible with Windows NT 4.0" that prevents weaker cryptography algorithms when establishing security channel sessions.

When the issue occurs, the Dcpromo.log file correctly indicates that the promotion operation has stopped:
> [INFO] DnsDomainName chilld contoso.local  
[INFO] FlatDomainName child  
[INFO] SiteName Default-First-Site-Name  
[INFO] SystemVolumeRootPath C:\Windows\SYSVOL  
INFO] DsDatabasePath C:\Windows\NTDS, DsLogPath C:\Windows\NTDS  
[INFO] ParentDnsDomainName contoso.local  
[INFO] ParentServer \<helper DC>.contoso.local  
[INFO] Account contoso\administrator  
[INFO] Options 5243072  
[INFO] Validate supplied paths  
....  
[INFO] EVENTLOG (Error): NTDS Replication / DS RPC Client : 1963  
Internal event: The following local directory service received an exception from a remote procedure call (RPC) connection. Extensive RPC information was requested. This is intermediate information and might not contain a possible cause  
>
> [INFO] EVENTLOG (Error): NTDS Replication / DS RPC Client : 1962  
Internal event: The local directory service received an exception from a remote procedure call (RPC) connection. Extended error information is not available.  
....
Error value:  
A security package specific error occurred. 1825directory service:  
\<hostname>
Additional Data  
>
> Error value:  
Could not find the domain controller for this domain. (1908)  
>
> [INFO] EVENTLOG (Error): NTDS Replication / Setup : 1125  
The Active Directory Domain Services Installation Wizard (Dcpromo) was unable to establish connection with the following domain controller.  
Domain controller: \<DC name>.\<DNS domain name>.\<top level domain name>  
Additional Data  
Error value:  
1908 Could not find the domain controller for this domain.  

This issue occurs when the following conditions are true:  

- NetBIOS over TCP/IP is disabled. This occurs in the following situations:  
 **Disable NetBIOS over TCP/IP** option is not selected in Networks panel, the WINS tab in the Advanced TCP/IP Settings of IPv4 properties.  
NetBIOS over TCP/IP is disabled on the DHCP Server.  
The computers are using IPv6 configuration only.  
- "Short" credential names are used in the Credential UI or in the domain controller promotion answer file.  
The `Dcpromo.log` earlier in this section indicates an ERROR_DOMAIN_CONTROLLER_NOT_FOUND error is returned from the DRS bind call when the promotion process is setting up to replicate the first naming context.  

    In this case, Kerberos cannot locate a domain controller to authenticate with by using the specified credentials. For example, the specified credentials are "wolf\administrator" instead of a "long" DNS credentials like wolf.com\administrator. In the credential, "wolf" is the NetBIOS name of the domain hosting the administrator account.  

> [!NOTE]
> If the issue occurs when you promote a new domain controller in a new child domain. The following issues also occurs:  
>
> - The computer consider it is joined to the domain.
> - You will have the option to log on to the child domain but the logon will fails.
> - If you log on to the computer locally, the ADDS and AWDS services is disabled. The Netlogon.exe process is not started and the startup value is set to manual identical, such as the default setting for a member workstation.

## Cause

When you run Active Directory Domain Services Configuration Wizard in a NetBIOS-less\WINS-less environment, it introduces some DC-locator limitations to be aware of short domain names. This is especially true on a non-domain-joined computer. DC-locator tries to map short domain names to fully qualified domain names (FQDNs) by using the trusted-domain-list, which involves DNS to be used most of the time. If DNS cannot be used, locator has to use WINS\NetBIOS. However, WINS\NetBIOS is not available when NetBIOS over TCP/IP is disabled. This issue can be partly worked around by the DNS-suffix feature that is added to DC-locator in Windows Server 2012 R2 and Windows 8.1 but that is not always a 100% reliable solution.

## Resolution

To resolve the issue, follow these steps:  

1. End the Server Manager process in Task Manager.

    > [!NOTE]
    > This step closes the Active Directory Domain Services Configuration Wizard. When the issue occurs, the cancel button in the UI does not work. Additionally, ending the Active Directory Domain Services Configuration Wizard in Task Manager also does not work.  

2. When you promote the computer as a domain controller again, use one of the following workarounds:
   - Specific "long" credentials, for example, **\<domain>**\administrator, in the promotion wizard or the promotion answer files.
   - On Windows 8.1 and Windows Server 2012 R2 computers, configure the DNS search suffixes, so that when the DNS search suffixes are concatenated with the provided NetBIOS domain name, they can be resolved to the fully qualified DNS name of the Active Directory domain that hosts the user account being used to perform the authenticated operation.  

        > [!NOTE]
        > This assumes that the NetBIOS name that is specified in credential "UI" matches the left-most part of the target accounts DNS domain name.
   - Join the computer being prompted as a member computer in the target domain, and then retry the promotion.
   - Temporarily enable NetBIOS over TCP/IP in order to complete the promotion.
