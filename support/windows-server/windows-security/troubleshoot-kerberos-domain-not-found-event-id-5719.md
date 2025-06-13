---
title: Event ID 5719, Error 1311, or Error 1355 - Domain Controller or Domain Not Found
description: Provides guidance to troubleshoot "DC or domain not found" issues that occur during Kerberos authentication.
ms.date: 06/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom:
- sap:windows security technologies\kerberos authentication
- pcy:WinComm Directory Services
ms.reviewer: kaushika, raviks, v-lianna, jobesanc
---
# Event ID 5719, Error 1311, or Error 1355 - Domain controller or domain not found

Kerberos depends on domain controllers for authentication, authorization, and delegation functions. If a client computer or target server tries to authenticate by using Kerberos and can't contact a domain controller, you receive a message that resembles one of the following messages:

> The following error occurred attempting to join the domain "Contoso":
>
> The specified domain either does not exist or could not be contacted.
>
> The Domain Controller for the domain contoso.com could not be found.
>
> Could not contact Domain Controller 1355.

Although these messages differ from an application standpoint, the meaning of the error is that the client or server can't discover a domain controller.

This kind of error usually has one of the following causes:

- Ports are blocked between the client and the domain controller.
- The client's Domain Name System (DNS) configuration isn't correct.
- The DNS server configuration on the domain controller isn't correct.

## Troubleshoot a domain or domain controller not found error

1. Check all firewalls (including Windows Firewall on each computer) between the client computer, the domain controller, and the target server. Make sure that traffic is allowed on UDP port 389 (LDAP) and UDP port 53 (DNS). For more information, see [How to configure a firewall for Active Directory domains and trusts](../identity/config-firewall-for-ad-domains-and-trusts.md).

1. If you made changes, open an administrative Command Prompt window on the client computer, and then run the following command:

   ```console
   nltest /dsgetdc:<DomainName> /force /kdc
   ```

   > [!NOTE]  
   > In this command, \<DomainName> represents the name of the domain of the client computer.

   The `nltest` command retrieves a list of one or more available domain controllers. If the client or target server can't contact a domain controller, you receive an error message.

   > [!NOTE]  
   > The list might not include all the available domain controllers.

   If the domain controller still isn't available, go to the next step.

1. At the command prompt on the client computer, run the following command:

   ```console
   nslookup <TargetName>
   ```

   > [!NOTE]  
   > In this command, \<TargetName> represents the NetBIOS name of the target server.

   If the `nslookup` command correctly resolves the target server name, the DNS configuration is correct.

   If the command doesn't resolve the target server name, follow these steps to check the client computer's network adapter configuration:

1. On the client computer, run the following command:

   ```console
   ipconfig /all
   ```

1. In the command output, determine the network adapter that's in use. Check the following adapter settings:

   - Client IP address
   - Subnet mask
   - Default gateway
   - Connection-specific DNS suffix
   - DNS server IP addresses

     Record the IP addresses, and note which DNS server is preferred and which is secondary. This information is useful for later troubleshooting.

1. If any of the network adapter settings are incorrect, fix them or contact your DNS administrator for assistance.

1. If you made any changes, run `nslookup <TargetName>` again.

   If `nslookup` still doesn't correctly resolve the name, you might have a larger DNS issue. Contact your DNS administrator or troubleshoot this issue further yourself. For more troubleshooting guidance, see [Troubleshooting DNS servers](/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server).

1. If `nslookup` now resolves the name correctly, run `nltest` again. Depending on the result, do one of the following actions:

   - If `nltest` returns the name of at least one domain controller, check to see whether your original Kerberos issue is resolved.

   - If `nltest` still doesn't identify at least one domain controller, you might have a larger network or Active Directory issue. Contact your network administrator.
