---
title: Use a Log Analysis Test Scenario to Troubleshoot Kerberos Authentication
description: Uses an example topology to demonstrate techniques for troubleshooting Kerberos issues.
ms.date: 06/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.custom:
- sap:windows security technologies\kerberos authentication
- pcy:WinComm Directory Services
ms.reviewer: kaushika, raviks, v-lianna, jobesanc
---
# Use a log analysis test scenario to troubleshoot Kerberos authentication

This article uses a hypothetical client and server deployment to demonstrate troubleshooting approaches for Kerberos authentication issues.

## Environment and configuration

- User "John" belongs to the `contoso.com` domain.

- All the domain's Domain Name System (DNS) servers are domain controllers.

- John is signed in to a client computer that's configured as follows:

  - Name and domain: `Client1.contoso.com`
  - Operating system: Windows 11
  - Browser: Microsoft Edge
  - Monitoring application: Network Monitor
    (Installed from [Microsoft Network Monitor](https://www.microsoft.com/download/details.aspx?id=4865))
  - Internet options configuration: all `contoso.com` sites belong to the local intranet zone

    :::image type="content" source="media/kerberos-authentication-log-analysis-test-scenario/internet-options-local-intranet-zone.png" alt-text="Screenshot of Internet Properties showing that all `contoso.com` websites are in the local intranet zone.":::

- On the client computer, John connects to a target server that's configured as follows:

  - Name and domain: `IISServer.contoso.com`
  - Operating system: Windows Server 2019
  - Target service: Web site that runs on Internet Information Services (IIS)
  - Target service account: the computer account (the service runs under the context of `IISServer.contoso.com`)
  - Target service port: TCP port 80
  - Authentication configuration (configured in Internet Information Services Manager):

    - **Windows Authentication** is **Enabled**.

      :::image type="content" source="media/kerberos-authentication-log-analysis-test-scenario/windows-authentication-enabled.png" alt-text="Screenshot of the Internet Information Services Manager window showing that Windows Authentication is enabled.":::

    - The list of enabled authentication providers includes Negotiate, as shown in the following screenshot:

      :::image type="content" source="media/kerberos-authentication-log-analysis-test-scenario/enabled-providers-negotiate.png" alt-text="Screenshot of the Providers window showing the Enabled Providers includes Negotiate.":::

  - Logon auditing configuration: Logon Success auditing and Logon Failure auditing are both enabled.

    > [!NOTE]  
    > By default, all Windows Server operating systems have Success and Failure logon auditing enabled. To verify this setting, open an administrative Command Prompt window, and then run the following command:
    >
    > ```console
    > auditpol /get /Subcategory:"logon"
    > ```
    >
    > If the setting is enabled, this command generates the following output:
    >
    > ```output
    > System audit policy
    > Category/Subcategory                    Setting
    > Logon/Logoff
    >   Logon                                 Success and Failure
    > ```
    >
    > If you don't see this result, run the following command to enable Success and Failure audit logging:
    >
    > ```console
    > auditpol /set /subcategory:"Logon" /Success:enable /Failure:enable
    > ```

## Expected authentication flow

The following diagram shows the sequence of Kerberos request and response messages and the paths of those messages in the environment that's described in the previous section.

:::image type="content" source="media/kerberos-authentication-log-analysis-test-scenario/authentication-flow.png" alt-text="Screenshot of an authentication flow.":::

The process starts when user John, who is signed in to the client computer `Client1.contoso.com`, opens a Microsoft Edge browser and connects to `IISServer.contoso.com`.

**Step 1** occurs on the client computer, and includes the following steps:

1. The DNS resolver service caches `IISServer.contoso.com` to check whether this information is already cached. The DNS resolver service checks the HOSTS file (*C:\\Windows\\System32\\drivers\\etc\\Hosts*) for any mapping of `IISServer.contoso.com`.
1. The DNS client service sends a DNS query to the preferred DNS server (as configured on the IP configuration settings).

**Step 2** occurs on the DNS server (domain controller), and includes the following steps:

1. The DNS server service checks its configured zones, locates the Host "A" record, and resolves `IISServer.contoso.com` to the IP address `192.168.2.104`.
1. The DNS server returns the IP address to the client computer.

**Step 3** occurs on the client computer, and includes the following steps:

1. The client computer performs a [TCP three-way handshake](../networking/three-way-handshake-via-tcpip.md) with `IISServer.contoso.com` by using TCP port 80.
1. The client computer sends an anonymous HTTP request to `IISServer.contoso.com`.

**Step 4** occurs on the target server, and includes the following steps:

1. The web service (running as `IISServer.contoso.com`) receives the request from `Client1.contoso.com`.
1. The web service sends a response message to `Client1.contoso.com` that contains an "HTTP 401" challenge response. the message specifies Negotiate as the preferred authentication provider and NTLM as the secondary authentication provider.

**Step 5** occurs on the client computer, and includes the following steps:

1. The client computer receives the challenge response message from `IISServer.contoso.com`.
1. The Microsoft Edge process verifies that `IISServer.contoso.com` belongs to the local intranet zone. Therefore, the authentication process should use Kerberos instead of NTLM.
1. The Microsoft Edge process calls *LSASS.exe* to look for a service ticket for `IISServer.contoso.com`.
1. In this case, the client computer doesn't have an appropriate service ticket. The Microsoft Edge process sends a request to the Kerberos Distribution Center (KDC) for a ticket.

**Step 6** occurs on the domain controller, and includes the following steps:

1. The domain controller (KDC service) receives the request from `Client1.contoso.com` and searches for the service that uses the SPN `HTTP\IISServer.contoso.com` (or `HOST\IISServer.contoso.com`).
1. The domain controller identifies the requested service as the web service that runs under the context of `IISServer.contoso.com`.
1. The domain controller sends a response to the client computer that includes a service ticket for the `IISServer.contoso.com` web service.

**Step 7** occurs on the domain controller, and includes the following steps:

1. The Microsoft Edge process creates a Kerberos Application Protocol (AP) message that includes the service ticket.
1. The Microsoft Edge process sends the AP message to `IISServer.contoso.com` in response to the "HTTP 401" challenge response message.

**Step 8** occurs on the web server, and includes the following steps:

1. The IIS process queries the local *LSASS.exe* process.
1. The *LSASS.exe* process decrypts the ticket, and then creates a token for the user that includes a SessionID and John's group memberships.
1. The *LSASS.exe* process returns a handle for the token to the IIS process.
1. The IIS process checks the group information in the token to make sure that John has permission to access the requested page.
1. The IIS process sends the requested page to the browser.

## Use Network Monitor to record an authentication test

Use the following steps to gather trace data on an environment that resembles the one that's described in the [Environment and configuration](#environment-and-configuration) section. During this test, the system components should interact in the manner that's described in the [Expected authentication flow](#expected-authentication-flow) section.

> [!NOTE]  
> To use the procedures in this section, you must belong to the local Administrators group:

1. On the client computer, open an administrative Command Prompt window, and then run `ipconfig /flushdns`.
1. Open Network Monitor, and start recording.
1. Open Microsoft Edge. In the address bar, enter `http://iisserver.contoso.com`.
1. When the Microsoft Edge operation finishes, stop recording in Network Monitor.

## Review the data that the authentication test generates

The authentication test generates the following information:

- Network Monitor trace data
- Ticket data
- Audit Success and Audit Failure event data for authentication events

The rest of this section provides more detail about what data the authentication flow produces.

### Review the trace data for significant events

In the trace data, look for information that resembles the following trace excerpts:

- DNS query to the domain controller for the Host "A" record for`IISServer.contoso.com`:

  ```output
  3005    00:59:30.0738430    Client1.contoso.com    DCA.contoso.com    DNS    DNS:QueryId = 0x666A, QUERY (Standard query), Query  for iisserver.contoso.com of type Host Addr on class Internet
  ```

- DNS response from the DNS service on the domain controller:

  ```output
  3006    00:59:30.0743438    DCA.contoso.com    Client1.contoso.com    DNS    DNS:QueryId = 0x666A, QUERY (Standard query), Response - Success, 192.168.2.104
  ```

- Anonymous request from the Microsoft Edge process on `Client1.contoso.com` to the `IISServer.contoso.com` IIS web server:

  ```output
  3027    00:59:30.1609409    Client1.contoso.com    iisserver.contoso.com    HTTP    HTTP:Request, GET /
  Host:  iisserver.contoso.com
  ```

- HTTP 401 challenge response message from `IISServer.contoso.com` to `Client1.contoso.com`:

  ```output
  3028    00:59:30.1633647    iisserver.contoso.com    Client1.contoso.com    HTTP    HTTP:Response, HTTP/1.1, Status: Unauthorized, URL: /favicon.ico Using Multiple Authetication Methods, see frame details
  
  WWWAuthenticate: Negotiate
  WWWAuthenticate: NTLM
  ```

- Service ticket request from `Client1.contoso.com` to the domain controller `DCA.contoso.com` for the service that uses `HTTP/iisserver.contoso.com` as its SPN (also known as the TGS request message):

  ```output
  3034    00:59:30.1834048    Client1.contoso.com    DCA.contoso.com    KerberosV5    KerberosV5:TGS Request Realm: CONTOSO.COM Sname: HTTP/iisserver.contoso.com
  ```

- Service ticket response from `DCA.contoso.com` that includes the service ticket for `IISServer.contoso.com` (also known as the TGS response message):
  ```output
  3036    00:59:30.1848687    DCA.contoso.com    Client1.contoso.com    KerberosV5    KerberosV5:TGS Response Cname: John 
  Ticket: Realm: CONTOSO.COM, Sname: HTTP/iisserver.contoso.com
  Sname: HTTP/iisserver.contoso.com
  ```

- Second request from the Microsoft Edge process on `Client1.contoso.com` to `IISServer.contoso.com`. This message includes the service ticket:

  ```output
  3040    00:59:30.1853262    Client1.contoso.com    iisserver.contoso.com    HTTP    HTTP:Request, GET /favicon.ico , Using GSS-API Authorization
  Authorization: Negotiate
  Authorization:  Negotiate YIIHGwYGKwYBBQUCoIIHDzCCBwugMDAuBgkqhkiC9xIBAgIGCSqGSIb3EgECAgYKKwYBBAGCNwICHgYKKwYBBAGCNwICCqKCBtUEggbRYIIGzQYJKoZIhvcSAQICAQBugga8MIIGuKADAgEFoQMCAQ6iBwMFACAAAACjggTvYYIE6zCCBOegAwIBBaENGwtDT05UT1NPLkNPTaIoMCagAwIBAqEfMB0bBEhUVFAbF
  SpnegoToken: 0x1
  NegTokenInit: 
  ApReq: KRB_AP_REQ (14)
  Ticket: Realm: CONTOSO.COM, Sname: HTTP/iisserver.contoso.com
  ```

- Message from the IIS server to `Client1.contoso.com`. This message indicates that the user is authenticated and authorized:

  ```output
  3044    00:59:30.1875763    iisserver.contoso.com    Client1.contoso.com    HTTP    HTTP:Response, HTTP/1.1, Status: Not found, URL: / , Using GSS-API Authentication
  WWWAuthenticate: Negotiate oYG2MIGzoAMKAQChCwYJKoZIgvcSAQICooGeBIGbYIGYBgkqhkiG9xIBAgICAG+BiDCBhaADAgEFoQMCAQ+ieTB3oAMCARKicARuIF62dHj2/qKDRV5XjGKmyFl2/z6b9OHTCTKigAatXS1vZTVC1dMvtNniSN8GpXJspqNvEfbETSinF0ee7KLaprxNgTYwTrMVMnd95SoqBkm/FuY7WbTAuPvyRmUuBY3EKZEy
  NegotiateAuthorization: 
  GssAPI: 0x1
  NegTokenResp: 
  ApRep: KRB_AP_REP (15)
  ```

### Review the ticket information on the client computer

At a command prompt on the client computer, run `klist tickets`. The output should resemble the following excerpt:

```output
Client: John @ CONTOSO.COM
Server: HTTP/iisserver.contoso.com @ CONTOSO.COM
KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96
Ticket Flags 0x40a10000 -> forwardable renewable pre_authent name_canonicalize
Start Time: 11/28/2022 0:59:30 (local)
End Time:   11/28/2022 10:58:56 (local)
Renew Time: 12/5/2022 0:58:56 (local)
Session Key Type: AES-256-CTS-HMAC-SHA1-96
Cache Flags: 0
Kdc Called: DCA.contoso.com
```

### Review audit events on the target server

In Event Viewer on `IISServer.contoso.com`, go to the **Windows Logs** > **Security** log to review sign-in (logon) events. Look for instances of event ID 4624 or 4625, and check the following fields:

- **Keywords**: **Audit Success** or **Audit Failure**
- **Logon type**: **3** (network logon)
- **Security ID** in **New Logon** field: **Contoso\John**
- **Source Network Address**: IP address of the client computer
- **Logon Process** and **Authentication Package**: **Kerberos**

The full text of the event record resembles the following excerpt:

```output
Log Name:      Security
Source:        Microsoft-Windows-Security-Auditing
Date:          11/28/2022 12:59:30 AM
Event ID:      4624
Task Category: Logon
Level:         Information
Keywords:      Audit Success
User:          N/A
Computer:      IISServer.contoso.com
Description:
An account was successfully logged on.

Subject:
    Security ID:        NULL SID
    Account Name:        -
    Account Domain:        -
    Logon ID:        0x0

Logon Information:
    Logon Type:        3
    Restricted Admin Mode:    -
    Virtual Account:        No
    Elevated Token:        No

Impersonation Level:        Impersonation

New Logon:
    Security ID:        CONTOSO\John
    Account Name:        John
    Account Domain:        CONTOSO.COM
    Logon ID:        0x1B64449
    Linked Logon ID:        0x0
    Network Account Name:    -
    Network Account Domain:    -
    Logon GUID:        {<GUID>}

Process Information:
    Process ID:        0x0
    Process Name:        -

Network Information:
    Workstation Name:    -
    Source Network Address:    192.168.2.101
    Source Port:        52655

Detailed Authentication Information:
    Logon Process:        Kerberos
    Authentication Package:    Kerberos
```

## Troubleshoot the authentication workflow

Review the network traces to observe which step fails so that you can narrow down the location in the process where the issue occurs. Use this information to determine which troubleshooting methods can help you fix the issue.

### Verify network connectivity

If there seems to be an issue in the DNS or TCP communications, check the following interactions:

- Verify that you can resolve the name of the target server (`IISServer.contoso.com`) from the client computer (`Client1.contoso.com`).
- Verify that the DNS server correctly resolves the target server IP address. To do this, open a PowerShell window, and then run the following cmdlet:

  ```powershell
  Resolve-DnsName -Name IISServer.contoso.com
  ```

  The output of this cmdlet should resemble the following excerpt:

  ```output
  Name                                       Type   TTL   Section    IPAddress
  ----                                       ----   ---   -------    ---------
  IISServer.contoso.com                      A      1200  Answer     192.168.2.104
  ```

- Verify that the required network ports are open between the client computer and the target server. To do this, run the following cmdlet:

  ```powershell
  Test-NetConnection -Port 80 IISServer.contoso.com 
  ```

  The output of this cmdlet should resemble the following excerpt:

  ```output
  ComputerName     : IISServer.contoso.com
  RemoteAddress    : 192.168.2.104
  RemotePort       : 80
  InterfaceAlias   : Ethernet 2
  SourceAddress    : 192.168.2.101
  TcpTestSucceeded : True
  ```

### Verify the ticket information on the client computer

1. Open a standard Command Prompt window (instead of an administrative Command Prompt window) in the context of the user who is trying to access the website.
1. Run the following commands, in the given order:

   ```console
   klist purge
   klist get http/iisserver.contoso.com
   ```

   The output of these commands should resemble the following excerpt:

   ```output
   Current LogonId is 0:0xa8a98b
   A ticket to http/iisserver.contoso.com has been retrieved successfully.
   
   Cached Tickets: (2)
   
   #0>     Client: John @ CONTOSO.COM
           Server: krbtgt/CONTOSO.COM @ CONTOSO.COM
           KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96
           Ticket Flags 0x40e10000 -> forwardable renewable initial pre_authent name_canonicalize
           Start Time: 11/28/2022 1:28:11 (local)
           End Time:   11/28/2022 11:28:11 (local)
           Renew Time: 12/5/2022 1:28:11 (local)
           Session Key Type: AES-256-CTS-HMAC-SHA1-96
           Cache Flags: 0x1 -> PRIMARY
           Kdc Called: DCA.contoso.com
   
   #1>     Client: John @ CONTOSO.COM
           Server: http/iisserver.contoso.com @ CONTOSO.COM
           KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96
           Ticket Flags 0x40a10000 -> forwardable renewable pre_authent name_canonicalize
           Start Time: 11/28/2022 1:28:11 (local)
           End Time:   11/28/2022 11:28:11 (local)
           Renew Time: 12/5/2022 1:28:11 (local)
           Session Key Type: AES-256-CTS-HMAC-SHA1-96
           Cache Flags: 0
           Kdc Called: DCA.contoso.com
   ```

   This excerpt indicates that the ticket was successfully retrieved. The details of the ticket are labeled "#1>" in the **Cached Tickets** section.

### Verify that the IIS web service is running on the IIS server by using the default credentials

Open a standard PowerShell Prompt window (instead of an administrative PowerShell Prompt window) in the context of the user who is trying to access the website:

```powershell
invoke-webrequest -Uri http://IIsserver.contoso.com -UseDefaultCredentials
```

The output of these commands should resemble the following excerpt:

```output
StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
                    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
                    <html xmlns="http://www.w3.org/1999/xhtml">
                    <head>
                    <meta http-equiv="Content-Type" cont...
RawContent        : HTTP/1.1 200 OK
                    Persistent-Auth: true
                    Accept-Ranges: bytes
                    Content-Length: 703
                    Content-Type: text/html
                    Date: Mon, 28 Nov 2022 09:31:40 GMT
                    ETag: "3275ea8a1d91:0"
                    Last-Modified: Fri, 25 Nov 2022...
```

### Review the Security event log on the target server

In Event Viewer on the target server, go to the **Windows Logs** > **Security** log. Look for instances of event ID 4624 (Audit Success) or 4625 (Audit Failure).

### Verify that other services function correctly

To verify that other services on the target server can process Kerberos authentication, follow these steps:

1. On the target server, create a file share or identify an existing file share to use for testing. Make sure that you (in the role of "John") have Read permission on the folder.
1. On the client computer, sign in as the user "John", and then open Windows Explorer.
1. In the address bar, enter *\\\IISServer.contoso.com \\Software$*.
1. On the target server, open Event Viewer, and then review the Security events. Verify that there are new event ID 4624 events, or event ID 4625 events.
1. On the client computer, run the `klist tickets` command at the command prompt. The command output should include a service ticket for `CIFS/IISServer.contoso.com`, as shown in the following excerpt:

   ```output
   #1>     Client: John @ CONTOSO.COM
           Server: cifs/iisserver.contoso.com @ CONTOSO.COM
           KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96
           Ticket Flags 0x40a10000 -> forwardable renewable pre_authent name_canonicalize
           Start Time: 11/28/2022 1:40:22 (local)
           End Time:   11/28/2022 11:28:11 (local)
           Renew Time: 12/5/2022 1:28:11 (local)
           Session Key Type: AES-256-CTS-HMAC-SHA1-96
           Cache Flags: 0
           Kdc Called: DCA.contoso.com
   ```
