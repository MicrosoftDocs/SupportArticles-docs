---
title: Event ID 5719, Error 1311, or Error 1355 - Domain controller or domain not found
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

Kerberos depends on domain controllers for authentication, authorization, and delegation functions. If a client computer or target server attempts to authenticate by using Kerberos and can't contact a domain controller, you see a message that resembles one of the following messages:

> The following error occurred attempting to join the domain "Contoso":
>
> The specified domain either does not exist or could not be contacted.
>
> The Domain Controller for the domain contoso.com could not be found.
>
> Could not contact Domain Controller 1355.

The error messages might differ from an application standpoint, but the meaning of the error is that the client or server is unable to discover a domain controller.

This type of error usually results from one of the following causes:

- Ports are blocked between the client and the domain controller.
- The client's Domain Name System (DNS) configuration isn't correct.
- The DNS server configuration on the domain controller isn't correct.

## Troubleshoot a domain or domain controller not found error

1. Check all firewalls (including Windows Firewall on each computer) between the client computer, the domain controller, and the target server. Make sure traffic is allowed on UDP port 389 (LDAP) and UDP port 53 (DNS). For more information, see [How to configure a firewall for Active Directory domains and trusts](../identity/config-firewall-for-ad-domains-and-trusts.md).

1. If you made changes, open an administrative Command Prompt window on the client computer, and then run the following command:

   ```console
   nltest /dsgetdc:<DomainName> /force /kdc
   ```

   > [!NOTE]  
   > In this command, \<DomainName> represents the name of the domain of the client computer.

   The `nltest` command retrieves a list of one or more available domain controllers. If the client or target server can't contact a domain controller, you see an error message.

   > [!NOTE]  
   > The list might not include all of the domain controllers that are available.

   If the domain controller still isn't available, continue to the next step.

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

1. In the command output, identify the network adapter in use. Check the following adapter settings:

   - Client IP address.
   - Subnet mask.
   - Default gateway.
   - DNS server IP addresses. Consider recording these addresses, and noting which DNS server is preferred and which is secondary. This information is useful for later troubleshooting.
   - Connection-specific DNS suffix.

1. If any of the network adapter settings are incorrect, fix them or contact your DNS administrator for assistance.

1. If you made any changes, run `nslookup <TargetName>` again.

   If `nslookup` still doesn't correctly resolve the name, there might be a larger DNS problem. Contact your DNS administrator, or to troubleshoot this issue further yourself, see [Troubleshooting DNS servers](/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server).

1. If `nslookup` now resolves the name correctly, run `nltest` again. Depending on the result, do one of the following:

   - If `nltest` returns the name of at least one domain controller, check to see if your original Kerberos issue has been resolved.

   - If `nltest` still doesn't identify at least one domain controller, you might have a deeper network or Active Directory issue. Contact your network administrator.
