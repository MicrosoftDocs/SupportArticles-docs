---
title: Kerberos authentication troubleshooting guidance
description: Provides guidance to troubleshoot Kerberos authentication issues.
ms.date: 06/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom:
- sap:windows security technologies\kerberos authentication
- pcy:WinComm Directory Services
ms.reviewer: kaushika, raviks, v-lianna, jobesanc
---
# Kerberos authentication troubleshooting guidance

This guide provides you with the fundamental concepts used when troubleshooting Kerberos authentication issues.

> [IMPORTANT!]  
> This article provides general guidance. You might have to adapt the procedures and examples here to work with your specific configuration.

## Troubleshooting checklist

The Kerberos protocol relies on a number of infrastructure components and services. If any of these components or services aren't available or not functioning, you might see authentication issues.

### 1. Check events and logs

Check the event logs for indications of an issue. Use Event Viewer to review the Security and System logs on the systems that are involved in the authentication operation:

- The authenticating client.
- The target server or service.
- The domain controller.

In particular, look for any events from sources that might relate to Kerberos authentication or the services that it relies on. These sources include the following:

- Kerberos.
- Key Distribution Center (KDC).
- LSA (LsaSrv).
- Netlogon.

On the target server, check the Security log for failure audits. Such failures might show that the Kerberos protocol was being used when an authentication failure occurred.

Some events or errors indicate specific issues. If any of the computers recorded one of the following events or errors, select the link for more detailed troubleshooting information.

| Event or error | Troubleshooting information |
| - | - |
| Event ID 4, Error KERB_AP_ERR_MODIFIED | The client couldn't decrypt the service ticket. More than one issue can cause this error, so check for other events that might be related. For example, this string might mean that the client and target server clocks are out of sync, or that the SPN isn't unique. In a multi-domain environment, the service account name might not be unique in the forest (or other trusted forests).<br/>For more information, see [The kerberos client received a KRB_AP_ERR_MODIFIED error from the server](kerberos-client-krb-ap-err-modified-error.md). If that article doesn't help, see [Kerberos generates KDC_ERR_S_PRINCIPAL_UNKNOWN or KDC_ERR_PRINCIPAL_NOT_UNIQUE error](kerberos-error-kdc-err-s-principal-unknown-or-not-unique.md). |
| Event ID 4, Error KERB_AP_ERR_SKEW | [Make sure that the computer clocks are synchronized](#g-make-sure-that-the-computer-clocks-are-synchronized) |
| Event ID 14 | ["Unsupported etype" error when accessing a resource in a trusted domain](unsupported-etype-error-accessing-trusted-domain.md) |
| Event ID 16 or Event ID 27 | [KDC event ID 16 or 27 is logged if DES for Kerberos is disabled](kdc-event-16-27-des-encryption-disabled.md)<br/>[Event ID 27 KDC Errors on Windows Server 2003 Domain Controllers](event-id-27-kdc-errors.md) |
| Error 1069 | [Service Logons Fail Due to Incorrectly Set SPNs](/previous-versions/windows/it-pro/windows-server-2003/cc772897(v=ws.10)) |
| Event ID 5719, Error 1311, or Error 1355 | [Event ID 5719, Error 1311, or Error 1355 - Domain controller or domain not found](troubleshoot-kerberos-dc-domain-not-found-event-id-5719.md) |

If you identify an issue that you know how to fix, fix that issue and then try to authenticate again before you continue.

### 2. Check infrastructure

#### a. Are the client application and the target service installed on the same computer?

When the client and the target service are installed on a single computer, Kerberos is disabled by default. If you can't install the client application and the target service on separate computers, you have to change specific security-related settings in Windows, and you might have to change a registry key. For more information about the issues that are related to this scenario and the specific settings that affect it, see [Error message when you try to access a server locally](../networking/accessing-server-locally-with-fqdn-cname-alias-denied.md).

If you made any changes, try to authenticate again before you continue.

#### b. Are the client, the target server, and any resource servers joined to appropriate domains?

If needed, join the client computer or target server to an appropriate domain. Then try to authenticate again.

> [NOTE!]  
> In this context, "appropriate domains" are domains within a single forest or within a set of forests that have trust relationships.

#### c. Check the health of the target server and its supporting services

Make sure that application or front-end services (such as web services) and back-end services (such as SQL Server service) are running.

> [NOTE!]  
> If you see a message that resembles "A service has generated Error 1069: The service did not start due to a logon failure," see [Service Logons Fail Due to Incorrectly Set SPNs](/previous-versions/windows/it-pro/windows-server-2003/cc772897(v=ws.10)).

#### d. Make sure that the correct ports are available

Check all firewalls (including Windows Firewall on each computer) between the client computer, the domain controller, and the target server. Make sure traffic is allowed on the following ports:  

  > [NOTE!]  
  > The list uses the _**server**_**:** _**client port**_**,** _**server port**_ format.

- **DHCP:** 67 (UDP), 67 (UDP)
- **DNS:** 49152 -65535 (TCP, UDP), 53 (TCP, UDP)
- **HTTPS, including certificate-based authentication:** 443 (TCP), 443 (TCP)
- **Kerberos:** 49152 -65535 (TCP, UDP), 88 (TCP, UDP)
- **Kerberos password change:** 49152 -65535 (TCP), 464 (TCP, UDP)
- **LDAP, including DC Locator:** 49152 -65535 (TCP, UDP), 389 (TCP, UDP)
- **LDAP SSL:** 49152 -65535 (TCP), 636 (TCP)
- **SMB:** 49152 -65535 (TCP, UDP), 445 (TCP)
- **RPC endpoint mapper:** 49152 -65535 (TCP), 135 (TCP)
- **RPC for LSA, SAM, NetLogon:** 49152 -65535 (TCP), 49152-65535 (TCP)
- **W32Time:** 49152 -65535 (UDP), 123 (UDP)

If you make changes to any firewall settings, try to authenticate again.

#### e. Check that domain controllers are available

When the client tries to contact a service or application (referred to as the "target server"), both the client and the target server require a domain controller to facilitate authentication, authorization, and delegation.

On the client computer, open an elevated Command Prompt window, and then run the following command:

```console
nltest /dsgetdc:<DomainName> /force /kdc
```

> [NOTE!]  
>
> - In this command, \<DomainName> represents the name of the domain of the computer that you are querying from.

The `nltest` command retrieves a list of available domain controllers (although the list might not include all of the domain controllers that are available). Note or record the fully qualified domain names and IP addresses of these domain controllers for use in later procedures.

If the client or target server can't contact a domain controller, you see a message that resembles the following (sometimes labeled "error 1355"):

> The specified domain either does not exist or could not be contacted.

If you see this message, see [Event ID 5719, Error 1311, or Error 1355 - Domain controller or domain not found](troubleshoot-kerberos-dc-domain-not-found-event-id-5719.md) for more troubleshooting information. Otherwise, continue through this checklist.

#### f. Check that DNS is working between the client and the target server

On the client computer, open an administrative Command Prompt window and then run the following command:

```console
nslookup <TargetName>
```

> [NOTE!]  
> In this command, \<TargetName> represents the NetBIOS name of the target server.

If the `nslookup` command correctly resolves the target server name, the DNS configuration is correct. If the command doesn't resolve the target server name, follow these steps to check the client computer's network adapter configuration:

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

   If any of these settings are incorrect, fix them or contact your DNS administrator for assistance. If you made any changes, run `nslookup <TargetName>` again.

If DNS still doesn't work correctly, follow these steps:

1. Run the following command on the client computer:

   ```console
   nslookup <ClientName> <DNSIPAddress>
   ```

   > [NOTE!]  
   > In this command, \<ClientName> represents the NetBIOS name of the client computer, and \<DNSIPAddress> represents the IP address of one the DNS servers that the client is configured to use. First, use the IP address of the preferred DNS server that you recorded in the previous procedure. If the command doesn't work, try again using the IP address of the client's secondary DNS server.

   For example, if the client computer's name is "client1" and the IP address of the client's preferred DNS server is 10.0.0.1, run the following command:

   ```console
   nslookup client1 10.0.0.1
   ```

1. Run the same command from the target server. The command resembles the following:

   ```console
   nslookup <TargetName> <DNSIPAddress>
   ```

   > [NOTE!]  
   > In this command, \<TargetName> represents the NetBIOS name of the target server, and \<DNSIPAddress> represents the IP address of one the DNS servers that the target server is configured to use. First, use the IP address of the preferred DNS server that you recorded in the previous procedure. If the command doesn't work the first time that you run it, try again using the IP address of the target server's secondary DNS server.

   For example, if the target server's name is "WebServer1" and the IP address of the target server's preferred DNS server is 10.0.0.1, run the following command:

   ```console
   nslookup WebServer1 10.0.0.1
   ```

   The following table summarizes the results that these `nslookup` queries might produce, the implications of those results.

   | | Target query<br/>succeeds | Target query<br/>fails |
   | - | - | - |
   | **Client query**<br/>**succeeds** | No DNS issue | Issue with the target or at least one DNS server |
   | **Client query**<br/>**fails** | Issue with the client or at least one DNS server | Issue with one or more DNS servers |

If the query results indicate that you have a DNS issue, see the following articles for more assistance:

- [Troubleshooting Domain Name System (DNS) issues](../networking/troubleshoot/troubleshoot-dns-data-collection)
- [Troubleshooting DNS clients](../networking/troubleshoot/troubleshoot-dns-client.md)
- [Troubleshooting DNS servers](../networking/troubleshoot/troubleshoot-dns-server.md)

If you resolve the DNS issue but the Kerberos issue remains, continue troubleshooting the Kerberos issue from the next section of this article.

#### g. Make sure that the computer clocks are synchronized

The client computer or the target server can cache tickets for future use, but each ticket has timestamps that determine its time to live (TTL). The Kerberos Key Distribution Center service, which runs on the domain controllers, sets the timestamps.

The difference in time between the domain controller and the client computer or the target server must be less than five minutes. Typically, if the clocks aren't synchronized, Windows can resynchronize them automatically. There are two cases where you might have to take action:

- The clocks are out of sync by more than 48 hours.
- The out-of-sync clock doesn't use a domain controller in its domain as a time server, or doesn't use the same time server as those domain controllers.

To resolve this issue, the affected computer has to recheck the network for time servers and then resynchronize its own clock. To do this, open an administrative Command Prompt window and then run the following command:

```console
w32tm /resync /computer:<Target> /rediscover
```

> [NOTE!]  
> In this command, \<Target> represents the computer that you are configuring. The `/rediscover` option instructs the computer to check the network for new or updated time sources.

For more information about the options that are available for the `w32tm` command, see [Windows Time service tools and settings: Command-line parameters for W32Time](/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings#command-line-parameters-for-w32time).

If you resynchronize clocks, try to authenticate again.

#### h. Check Windows Update status

Make sure that all domain controllers, the client computer, and the target server have all relevant Windows updates.

If you installed any updates, restart the affected computers and then try to authenticate again.

#### i. Check application update status

Make sure that the client and server applications are up to date on the client computer and the target server. If you install any updates, restart the affected computers and then try to authenticate again.

#### j. Restart the computers

If you haven't already restarted the client computer, target server, or domain controller, restart them now. After the computers restart, try to authenticate again.

If your infrastructure is OK and you still have an issue, continue to the more advanced troubleshooting procedures.

### 3. Collect trace and ticket data

The following procedures use the free [Network Monitor](https://www.microsoft.com/download/details.aspx?id=4865) tool. Download and install the tool on both the client computer and the target server. For an example of how to use Network Monitor to collect trace data and identify Kerberos messages, see [Kerberos errors in network captures](https://techcommunity.microsoft.com/blog/askds/kerberos-errors-in-network-captures/400066).

#### a. Collect simultaneous network traces

On the client computer, follow these steps:

1. Do one of the following:
   - Restart the client computer.
   - Sign out the account that you're using to troubleshoot, and then sign in again.
   - Close the client application, and then reopen it.

1. Start tracing. To do this, follow these steps:
   1. Select **Start**, and then type **netmon**.
   1. In the search results, right-click **Microsoft Network Monitor 3.4**, and then select **Run as administrator** (select **Yes** in the User Account Control window).
   1. In Network Monitor, select **Start**.

1. Open an administrative Command Prompt window, and then run the following commands, in sequence:

   ```console
   ipconfig /flushdns
   nbtstat -RR
   klist purge
   klist -li 0x3e7 purge
   ```

On the target server, follow these steps:

1. Open Network Monitor as an Administrator, and then select **Start**.
1. Open an administrative Command Prompt window, and then run the following commands, in sequence:

   ```console
   ipconfig /flushdns
   nbtstat -RR
   klist purge
   klist -li 0x3e7 purge
   ```

Try to reproduce your issue, and then stop and save the traces on both the client computer and the target server. To do this, in Network Monitor, select **Stop**, and then select **Save As**.

#### b. Record ticket information

After you reproduce your issue and stop tracing, check the Kerberos tickets that were generated while you were recording trace data. At the command prompt on the client computer and on the target server, run the following command:

```console
klist tickets
```

This command generates a list of tickets. You can copy this information to another application (such as Notepad) so that you can use it in later troubleshooting procedures.

### 4. Check the trace data for Kerberos messages

You can use Network Monitor to review, filter, and search data in capture files. In particular, look for events that are labeled with "KerberosV5." In addition to status information, such events can list the names or IP addresses of domain controllers that were contacted and the service principal name (SPN) of the service that the client tried  to reach.

Event descriptions that contain strings that resemble the following are part of typical Kerberos functions:

- KerberosV5:KRB_Error -KDC_ERR_PREAUTH_REQUIRED
- KerberosV5:AS Request
- KerberosV5:AS Response
- KerberosV5:TGS Request
- KerberosV5:TGS Response
- KerberosV5:AP Request
- KerberosV5:AP Response

> [NOTE!]  
> You can also use Network Monitor to check the trace data for ticket information in HTTP GET requests. If the ticket information is missing in the GET request, there was a problem in using Kerberos authentication.

Event descriptions that contain strings that resemble the following mean that there's a problem. The following list includes some of the most common errors. If you see one of these strings, note any server names, IP addresses, and SPNs for later use.

- **KDC_ERR_PRINCIPAL_NOT_UNIQUE or KDC_ERR_S_PRINCIPAL_UNKNOWN**. The requested SPN is associated with more than one account, or isn't associated with any account. For help resolving either of these issues, see [Kerberos generates KDC_ERR_S_PRINCIPAL_UNKNOWN or KDC_ERR_PRINCIPAL_NOT_UNIQUE error](kerberos-error-kdc-err-s-principal-unknown-or-not-unique.md).

- **KRB_AP_ERR_MODIFIED**. The client couldn't decrypt the service ticket. More than one issue can cause this error. Review the trace data for other errors that accompany KRB_AP_ERR_MODIFIED. Check the event logs for Event ID 4 and other related events, as described in [1. Check events and logs](#1-check-events-and-logs).

- **ERB_AP_ERR_SKEW**. The client and target server clocks are out of sync. For more information, see [Make sure that the computer clocks are synchronized](#g-make-sure-that-the-computer-clocks-are-synchronized).

- **KDC_ERR_ETYPE_NOTSUPP**. One or more of the components involved in authentication uses an encryption type that is disabled for other components. Check the event logs for more information about which components and which encryption types are involved, as described in [1. Check events and logs](#1-check-events-and-logs).

## Common issues and solutions

### HTTP 400 - Bad Request (Request Header too long) issue

If a user belongs to a large number of groups (for example, more than 1,000 groups), Kerberos might deny the user access because it doesn't correctly process the request. For more information about this issue, see the following articles:

- [Problems with Kerberos authentication when a user belongs to many groups](kerberos-authentication-problems-if-user-belongs-to-groups.md).

- [Logging on a user account that is a member of more than 1,010 groups may fail on a Windows Server-based computer](logging-on-user-account-fails.md).

### Service issues

Service issues typically involve the SPN and the service account. For example, the SPN might be incorrect, missing, configured on the incorrect account, or configured on more than one account. The troubleshooting checklist in this article  [a. Collect simultaneous network traces](#a-collect-simultaneous-network-traces) earlier in this article. If you have already identified a common SPN issue, see the following articles:

- [Kerberos generates KDC_ERR_S_PRINCIPAL_UNKNOWN or KDC_ERR_PRINCIPAL_NOT_UNIQUE error](kerberos-error-kdc-err-s-principal-unknown-or-not-unique.md).

- [Service Logons Fail Due to Incorrectly Set SPNs](/previous-versions/windows/it-pro/windows-server-2003/cc772897(v=ws.10)).

- [The kerberos client received a KRB_AP_ERR_MODIFIED error from the server](kerberos-client-krb-ap-err-modified-error.md).

### Single sign-on (SSO) issues

Single sign-on is an authentication method that allows users to sign in using one set of credentials to multiple systems or applications within a single intranet. To work correctly, both the target service (or the front-end component of the target service) and the client must have the correct settings. For information about how to troubleshoot these settings, see [Troubleshooting Kerberos single sign-on issues](kerberos-sso-issues.md).

### Delegation issues

When your target service has separate front-end and back-end components, Kerberos can delegate client credentials (including access permissions) to a service account. In simple terms, the client accesses the front-end service, and then the front-end service accesses the back-end service on the client's behalf.

Kerberos supports three types of delegation:

- **Unconstrained delegation**. After the client accesses the front-end service, the front-end service can access any other service on the client's behalf. This configuration is the easiest to implement, but is the least secure. Unconstrained delegation isn't recommended because it doesn't restrict which services the authenticated account can interact with.
- **Constrained delegation**. The front-end service maintains a list of services that it can access on behalf of a client.
- **Resource-based constrained delegation (RBCD)**. The back-end service maintains a list of front-end services that can access it on behalf of a client.

> [NOTE!]  
> If you have an issue using constrained delegation with CIFS, see [Constrained delegation for CIFS fails with ACCESS_DENIED error](constrained-delegation-access-denied.md).

> [IMPORTANT!]  
>
> - Don't configure constrained delegation and RBCD on the same set of front-end and back-end servers.
>
>   Constrained delegation and RBCD are different configurations, and they are mutually exclusive. When a front-end service requests a ticket to a back-end service, the KDC first checks the front-end service for constrained delegation. If constrained delegation is not configured for the front-end service, the KDC checks the back-end service for resource-based constrained delegation. Because of this sequence, constrained delegation takes precedence over resource-based delegation.
>
> - By default, Microsoft Edge does not support unconstrained delegation. If you're using unconstrained delegation, see [Kerberos unconstrained double-hop authentication with Microsoft Edge (Chromium)](/troubleshoot/developer/webapps/iis/www-authentication-authorization/kerberos-double-hop-authentication-edge-chromium) for more information about the configuration you need.
>
> - Unconstrained delegation is not recommended because it doesn't restrict which services the authenticated account can interact with.

#### Supported topology types

The different delegation types place different requirements on your topology. The following table lists three common types of topology, and which types of delegation (if any) are supported for each type.

| Topology type | Unconstrained delegation | Constrained delegation | RBCD |
| - | - | - | - |
| All services reside in a single domain | Supported (not recommended) | Supported | Supported |
| Front-end and back-end services reside in different domains | Supported (not recommended) | Not supported | Supported |
| Front-end and back-end services reside in different (trusted) forests | Supported<sup>*</sup> (not recommended) | Not supported | Supported<sup>*</sup> |

<sup>*</sup> Make sure that the service account of the front-end service can authenticate across the trust with the trusted domain controller.

#### Troubleshooting specific delegation types

The configuration details for delegation differ depending on the type of delegation that you're using and on the type of account that the front-end service uses. To troubleshoot delegation issues further, see one of the following articles as appropriate:

- [Troubleshooting Kerberos constrained delegation when using a built-in service account](troubleshoot-kerberos-constrained-delegation-issues.md#troubleshooting-kerberos-constrained-delegation-when-using-a-built-in-service-account).
- [Troubleshooting Kerberos RBCD when using a built-in service account](troubleshoot-kerberos-rbcd-issues.md#troubleshooting-kerberos-rbcd-when-using-a-built-in-service-account).
- [Troubleshooting Kerberos constrained delegation when using a custom service account](troubleshoot-kerberos-constrained-delegation-issues.md#troubleshooting-kerberos-constrained-delegation-when-using-a-custom-service-account).
- [Troubleshooting Kerberos RBCD when using a custom service account](troubleshoot-kerberos-rbcd-issues.md#troubleshooting-kerberos-rbcd-when-using-a-custom-service-account).

## Using a log analysis test scenario to troubleshoot Kerberos authentication

For advanced Kerberos testing and troubleshooting, see [Use a log analysis test scenario to troubleshoot Kerberos authentication](kerberos-auth-log-analysis-test-scenario.md).
