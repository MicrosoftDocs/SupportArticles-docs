---
title: Domain join error code 0x0000232A
description: Provides troubleshooting steps for resolving error code 0x0000232A when you join a workgroup computer to a domain.
ms.date: 04/25/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: eriw,dennhu,herbertm
ms.custom:
- sap:active directory\on-premises active directory domain join
- pcy:WinComm Directory Services
---
# Domain join error code 0x0000232A

This article provides troubleshooting steps for resolving error code 0x0000232A when you join a workgroup computer to a domain.

## Symptoms

When you join a workgroup computer to a domain, you receive the following error message:

> **Error code 0x0000232A**
>
> Computer Name/Domain Changes
>
> An Active Directory Domain Controller (AD DC) for the domain "\<NetBIOS\_name>" could not be contacted.
>
> Ensure that the domain name is typed correctly.
>
> If the name is correct, click Details for troubleshooting information.
>
> Note: This information is intended for a network administrator. If you are not your network's administrator, notify the administrator that you received this information, which has been recorded in the file C:\WINDOWS\debug\dcdiag.txt.
>
> The domain name "\<NetBIOS\_name>" might be a NetBIOS domain name. If this is the case, verify that the domain name is properly registered with WINS.
>
> If you are certain that the name is not a NetBIOS domain name, then the following information can help you troubleshoot your DNS configuration.
>
> The following error occurred when DNS was queried for the service location (SRV) resource record used to locate an Active Directory Domain Controller (AD DC) for domain "\<NetBIOS\_name>":  
> The error was: "DNS server failure." (error code 0x0000232A RCODE\_SERVER\_FAILURE)
>
> The query was for the SRV record for \_ldap.\_tcp.dc.\_msdcs.<NetBIOS\_name>
>
> Common causes of this error include the following:
>
> * The DNS servers used by this computer contain incorrect root hints. This computer is configured to use DNS servers with the following IP addresses:  
>   \<ip\_address\>
> * One or more of the following zones contains incorrect delegation:
 <NetBIOS\_name> . (the root zone)

Here's an example from the **netsetup.log** file:

```output
NetpValidateName: checking to see if '<NetBIOS_name>' is valid as type 3 name
NetpCheckDomainNameIsValid for <NetBIOS_name> returned 0x54b, last error is 0x0
NetpCheckDomainNameIsValid [ Exists ] for '<NetBIOS_name>' returned 0x54b
```

## Cause

Error 0x0000232A indicates that the Domain Name System (DNS) name can't be resolved. The error code can appear with error codes such as RCODE\_NAME\_ERROR and RCODE\_SERVER\_FAILURE, which indicate potential misconfigurations in the DNS settings or root hints. Error 0x0000232A might also occur if the client computer lacks NetBIOS name resolution to the domain.

## Troubleshooting steps

1. When you enter the domain name, ensure that you enter the DNS domain name rather than the NetBIOS name. For example, if the DNS name of the domain is `contoso.com`, make sure you enter that name instead of `contoso`.
2. Verify the DNS server settings on the client to ensure they point to the correct DNS server.
3. In the DNS management console, confirm that the SRV records are correctly registered in DNS for the Active Directory domain controller (DC).
4. Conduct tests to ensure that DNS queries from the client to the Active Directory Domain Services (AD DS) server are successful after adjustments are made:

   ```console
   nltest /dsgetdc:
   ```

   The expected output should have the DC name as follows:

   ```output
   nltest /dsgetdc:
              DC: \\DC.contoso.com
         Address: \\<ip_address>
        Dom Guid: <Dom_Guid>
        Dom Name: contoso.com
     Forest Name: contoso.com
    Dc Site Name: Default-First-Site-Name
   Our Site Name: Default-First-Site-Name
           Flags: PDC GC DS LDAP KDC TIMESERV WRITABLE DNS_DC DNS_DOMAIN DNS_FOREST CLOSE_SITE FULL_SECRET WS DS_8 DS_9
   The command completed successfully
   ```
