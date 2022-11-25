---
title: Kerberos authentication troubleshooting guidance
description: Provides guidance to troubleshoot Kerberos authentication issues.
ms.date: 11/25/2022
author: v-lianna
ms.author: v-lianna
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
ms.technology: windows-server-security
ms.custom:sap: kerberos-authentication, csstroubleshoot
localization_priority: medium
ms.reviewer: kaushika, raviks
---
# Kerberos authentication troubleshooting guidance

This guide provides you with the fundamental concepts used when troubleshooting Kerberos authentication issues.

## Troubleshooting checklist

- A Kerberos-related error is a symptom of another service failing. The Kerberos protocol relies on many services that must be available and functioning properly for any authentication to take place.
- To determine whether a problem is occurring with Kerberos authentication, check the System event log for errors from any services such as Kerberos, kdc, LsaSrv, or Netlogon on the client, target server or domain controller that provide authentication. If any such errors exist, there might be errors associated with the Kerberos protocol as well.
- Failure audits on the target server's Security event log might show that the Kerberos protocol was being used when a logon failure occurred.
- Before you inspect the Kerberos protocol, make sure that the following services or conditions are functioning properly:

  - The network infrastructure is functioning properly and that all computers and services can communicate.
  - The domain controller is accessible. You can run the command `nltest /dsgetdc:<Domain Name> /force /kdc` (for example, `nltest /dsgetdc:contoso.com /force /kdc`) on the client or target server.
  - Domain Name System (DNS) is configured properly and resolving host names and services appropriately.
  - The clocks are synchronized across the domain.
  - All critical updates and security updates for Windows Server are installed.
  - All software, including non-Microsoft software, is updated.
  - The computer is restarted if you're running a server operating system.
  - The required services and server are available. The Kerberos authentication protocol requires a functioning domain controller, DNS infrastructure, and network to work properly. Verify that you can access these resources before you begin troubleshooting the Kerberos protocol.

If you've examined all these conditions and are still having authentication problems or Kerberos errors, you need to look further for the solution. The problems can be caused by the way the Kerberos protocol is configured or by the way other technologies that work with the Kerberos protocol are configured.

## Common issues and solutions

### Kerberos delegation issues

In a typical scenario, the impersonating account would be a service account assigned to a web application or the computer account of a web server. The impersonated account would be a user account requiring access to resources via a web application.

There are three types of delegation using Kerberos:

- Full delegation (unconstrained delegation)  
  Full delegation should be avoided as much as possible. The user, front-end and back-end user can be located in different domains and also in different forests.
- Constrained delegation (Kerberos only and protocol transition)  
  The user can be from any domain or forest, but the front-end and the back-end services should be running in the same domain.
- Resource based constrained delegation (RBCD)  
  The user can be from any domain, front-end and back-end resources can be from any domain or forest.

### Most common Kerberos delegation troubleshooting

- Service principal name missing or duplicated
- Name resolution failures or incorrect responses (wrong IP addresses given for a server)
- Large Kerberos tickets (MaxTokenSize) and environment not set up properly
- Ports being blocked by firewalls or routers
- Service account not given appropriate privileges (User Rights Assignment)
- Front-end or back-end services not in the same domain and constrained delegation set up

For more information, see:

- [Constrained delegation for CIFS fails with ACCESS_DENIED error](constrained-delegation-access-denied.md)
- [Configure constrained delegation for a custom service account](../identity/configure-kerberos-constrained-delegation.md#scenario-1-configure-constrained-delegation-for-a-custom-service-account)
- [Configure constrained delegation on the NetworkService account](../identity/configure-kerberos-constrained-delegation.md#scenario-2-configure-constrained-delegation-on-the-networkservice-account)

### Single sign-on (SSO) broken and prompting for authentication once

Consider the following scenarios:

- A client and server application like Microsoft Edge and Internet Information Services (IIS) server. The IIS server is configured with Windows Authentication (Negotiate).
- A client and server application like SMB client and SMB server. By default, SMB server is configured with Negotiate Security Support Provider Interface (SSPI).

A User opens Microsoft Edge and browses an internal website `http://webserver.contoso.com`. The website is configured with Negotiate and this website prompts for authentication. After the user manually enters the username and password, the user gets authentication and the website works as expected.

> [!NOTE]
> This scenario is an example of client and server. The troubleshooting technique is the same for any client and server configured with Integrated Windows authentication.

Integrated Windows authentication is broken on the user level or the machine level.

#### Troubleshooting methods

- Review the client configuration for an integrated authentication setting, which can be enabled either at an application level or machine level. For example, all HTTP based applications would look for the site to be in Trusted zone when trying to perform integrated authentication.  

  Open *inetcpl.cpl* (**Internet Options**) which all HTTP based applications use for Internet Explorer configurations and review if the website is configured as **Local intranet**.
- Applications also have a configuration to perform Integrated Windows authentication.

  Microsoft Edge or Internet Explorer has a setting **Enable Integrated Windows Authentication** to be enabled.
- Review the application configuration, and the client computer can obtain a Kerberos ticket for a given service principal name (SPN). In this example, the SPN is `http/webserver.contoso.com`.
  - Success message when you can find the SPN:

    ```console
    C:>klist get http/webserver.contoso.com
    Current LogonId is 0:0x9bd1f
    A ticket to http/webserver.contoso.com has been retrieved successfully.
    ```

  - Error message when you can't find the SPN:
  
    ```console
    C:>klist get http/webserver.contoso.com
    klist failed with 0xc000018b/-1073741429: The SAM database on the Windows Server does not have a computer account for this workstation trust relationship.
    ```

  Identify and add the respective SPNs to the appropriate user, service or machine accounts.

- If you've identified that the SPNs can be retrieved, you can verify if they're registered on the correct account by using the following command:

    ```console
    setspn -F -Q */webserver.contoso.com
    ```

### Authentication DC discovery issues

Application servers configured with Integrated Windows authentication need domain controllers (DCs) to authenticate the user/computer and service.

Inability for contacting a domain controller during the authentication process would lead to an error 1355:

> The specified domain either does not exist or could not be contacted

#### Unable to access a resource configured with Integrated Windows authentication with an error 1355

> [!NOTE]
> Error messages may differ from an application standpoint, but the meaning of the error is that the client or server is unable to discover a domain controller.

Here are examples of such error messages:

- > The following error occurred attempting to join the domain "Contoso":  
    The specified domain either does not exist or could not be contacted.
- > The Domain Controller for the domain contoso.com  could not be found
- > Could not contact domain Controller 1355

#### Top causes of the issue

- DNS misconfiguration on the client

  You can run the `ipconfig /all` command and review DNS servers list.
- DNS misconfiguration on the domain controllers in a trusted domain or forest
- Network ports blocked between the client and domain controllers

  DC Discovery ports: UDP 389 (UDP LDAP) and UDP 53 (DNS)

#### Troubleshooting steps

1. Run the `nslookup` command to identify any DNS misconfigurations.
2. Open required ports between the client and the domain controller. For more information, see [How to configure a firewall for Active Directory domains and trusts](../identity/config-firewall-for-ad-domains-and-trusts.md).
