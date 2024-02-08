---
title: Network access validation algorithms and examples for Windows
description: Describes network access validation algorithms and examples.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: tinab, kaushika
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
---
# Network access validation algorithms and examples for Windows Server 2003, Windows XP, and Windows 2000

This article explains how Windows account validation is observed to function during network access using the NTLM protocol.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 103390

## Summary

The following is a simplified algorithm that explains how Windows account validation is observed to function during network access using the NTLM protocol. It's using access through the server message block (SMB) protocol as the example, but it applies to all other server applications that support NTLM authentication. This discussion doesn't cover the internal workings of this process. With this information, you can predict Windows network logon behavior under deterministic conditions.

When Kerberos is used to authenticate the user and obtain access to server resources, the process is different from what NTLM does.

Remember that the local database is the domain database and the only database on the domain controllers. But on other servers and all computers, the local database differs from the domain controller.

## Background information

When two Windows Server 2003-based, Windows XP-based, or Windows 2000-based computers communicate over a network, they use a high-level protocol called server message block (SMB). SMB commands are embedded in the transport protocols, such as NetBIOS Enhanced User Interface (NetBEUI) or TCP/IP. For example, when a client computer performs a `NET USE` command, an "SMB Session Setup and X" frame is sent out.

In Windows, the "Session Setup" SMB includes the user account, a hash function of the encrypted password and logon domain. A domain controller will examine all this information to determine whether the client has permissions to complete the NET USE command.

## Algorithms

A Windows client computer sends the following command to a server:

```console
NET USE x: \\server\share
```

The Windows client computer sends a "Session Setup" SMB that contains its login domain, user account, and password.

The server examines the domain name or computer name that was specified by the SMB. If the name is the server's own name, the following algorithm is run:

```vb
    It checks its own domain database or computer database for
        a matching account.
    If it finds a matching account then
        The SMB password is compared to the domain database password or the computer database password.
        If  the password matches then
            The command completed successfully.
        If  the password does NOT match then
            The user is prompted for a password.
                The password is retested as above.
            System error 1326 has occurred. Logon failure: unknown
            user name or bad password.
        End
    If  it does NOT find the account in the domain Security Accounts Manager (SAM) database or computer SAM database then
        Guest permissions are tested.
        If  the guest account is enabled
            The command completed successfully.
        If  the guest account is disabled
            (* See Note a).
            The user is prompted for a password.
            System error 1326 has occurred. Logon failure:
                unknown user name or bad password.
        End
```

If the domain specified in the SMB is one that the server trusts, the following algorithm is run:

```vb
    The server will do pass-through authentication. The
        network logon request will be sent to a server that has a domain controller role in the
        specified trusted domain.
```

If a secure channel is not set up, the following algorithm is run:

```vb
The trusted domain controller checks its own domain database
        for a matching account.
    If the trusted domain controller finds a matching account, then
       NOT for Windows 2000 and later versions:
    It determines whether the account is a local or global account.
       If the account is local, then
           Guest permissions on the original server are tested.
           If the guest account is enabled
               The command completed successfully.
           If the guest account is disabled
               (* See Note 1) The user is prompted for a password.
               System error 1326 has occurred. Logon failure:
               unknown user name or bad password.
        End
        If the account is global (the only option for Active Directory)
           The SMB password is compared to the domain database
               password.
           If  the password matches, then
               The command completed successfully.
               (* See Note 2)
           If  the password does NOT match, then
               The user is prompted for a password.
                   The password is retested as above.
               System error 1326 has occurred. Logon failure:
               unknown user name or bad password.
       End
    If the trusted domain controller does NOT find the account in the trusted domain controller
           database, then
       Guest permissions are tested on the original server, not the trusted domain.  (* See Note 3)
       If  the guest account is enabled
           The user will have original server guest access.
           The command completed successfully.
       If  the guest account is disabled
           (* See Note 1) The user is prompted for a password.
           System error 1326 has occurred. Logon failure:
           unknown user name or bad password.
    End
```

> [!IMPORTANT]
> The following cases discuss scenarios where the client uses a different user domain from that which the server has or knows of. There is a problem with this mismatch when the NTLMv2 authentication protocol is negotiated. NTLM at v2 uses a password salt, and the user domain is used in this salt by the client.

When the server obtains the information and finds the user in the local database, the server uses the name of the LOCAL database to compute the salt and the hash. Therefore, if the "source domain" as sent by the client is empty or is an unknown domain, the salt and therefore the password hash will not match. In these cases, the authentication attempt will fail with an "unknown user name or bad password" (STATUS_LOGON_FAILURE) error. The audit event for the attempt will report "incorrect password," symbol STATUS_WRONG_PASSWORD.

A sample event:

> Log Name: Security  
Source: Microsoft-Windows-Security-Auditing  
Event ID: 4625  
Task Category: Logon  
Level: Information  
Keywords: Audit Failure  
Computer: server-computer1  
Description:  
An account failed to log on.  
>
> Subject:
>
> Security ID: NULL SID  
Account Name: -  
Account Domain: -  
Logon ID: 0x0  
>
> Logon type: 3
>
> Account for which logon failed:
>
> Security ID: NULL SID  
Account Name: ntadmin  
Account Domain: client-computer1  
>
> Failure information:
>
> Failure Reason: Unknown user name or bad password.  
Status: 0xc000006d  
Sub Status: 0xc000006a  
...
>
> Detailed authentication information:

> Logon Process: NtLmSsp  
Authentication Package: NTLM  
Transited Services: -  
Package Name (NTLM only): -  
Key Length: 0

To avoid this scenario, you have to include the correct domain name explicitly on the client. For a drive-mapping on a workgroup scenario, that would be the following:  
`Net use x: \\server-computer1\data /u:server-computer1\ntadmin *`

If the domain that's specified in the SMB is unknown by the server-for example, if a domain was specified but was not recognized by the server as a trusted domain or its domain controller-the following algorithm is run:

```vb
    It  will check its own account database for
        a matching account
    If  the server finds a matching account, then
        The SMB password is compared to the domain database password or the computer database password.
        If  the password matches, then
            The command completed successfully.
        If  the password does NOT match, then
            The user is prompted for a password.
                The password is retested as above.
            System error 1326 has occurred. Logon failure: unknown
            user name or bad password.
    End
    If  it does NOT find the account in the domain database then
        guest permissions are tested.
        If  the guest account is enabled
            The command completed successfully.
        If  the guest account is disabled
            System error 1326 has occurred. Logon failure:
            unknown user name or bad password.
    End
```

If the domain that is specified in the SMB is NULL, that is, no domain is specified, the following algorithm is run:

```vb
    The server will treat this as a local network logon. The server
        will test for a matching account in its own database.
    If  it finds a matching account, then
        The SMB password is compared to the SAM database password.
        If  the password matches, then
            The command completed successfully.
        If  the password does NOT match, then
            The user is prompted for a password.
                The password is retested as above.
            System error 1326 has occurred. Logon failure: unknown
            user name or bad password.
    End
    If  it does NOT find the account in the local SAM database AND
      LsaLookupRestrictIsolatedNameLevel=0 AND NeverPing=0, then (* See Note 4)
        The server will simultaneously ask each domain that it trusts whether it has account that
            matches the SMB account.
        The first trusted domain to reply is sent a request to
            perform pass-through authentication of the client
            information.
        The trusted domain will look in its own database.
        If  an account that matches the SMB account is found, then
            The trusted domain determines whether the account is a local or global
                account.
           Not for Windows 2000 and later versions:
            If  the account is local then
                Guest permissions on the original server are tested.
                If  the guest account is enabled
                    The command completed successfully.
                If  the guest account is disabled
                The user will be prompted for a password.
                Regardless of what password is entered, the user will receive
                    "Error 5: Access has been denied."
            End
            If  the account is global (the only option for Active Directory)
                The password that was specified in the SMB is compared
                    to the SAM database password.
                If  the password matches, then
                    The command completed successfully.
                If  the password does NOT match, then
                    The user is prompted for a password.
                        The password is retested as above.
                    System error 1326 has occurred. Logon failure:
                    unknown user name or bad password.
            End
    If  no trusted domains respond to the request to identify the
        account, then
        Guest permissions are tested on the original server,
            not the trusted server.
        If  the guest account is enabled
            The command completed successfully.
        If  the guest account is disabled
            System error 1326 has occurred. Logon failure:
            unknown user name or bad password.
    End
```

### Notes

1. If the guest account is disabled and the user does not have an account, the server will still request a password. Although no password will meet its requirements, the server will still request a password as a security measure. This security measure insures that an unauthorized user cannot tell the difference between a case where an account exists and when the account does not exist. The user will always be prompted for a password regardless of whether the account exists.

2. At this point, the following information is returned from the trusted domain in the response: Domain SID, User ID, Global Groups Memberships, Logon Time, Logoff Time, KickOffTime, Full Name, Password LastSet, Password Can Change Flag, Password Must Change Flag, User Script, Profile Path, Home Directory, and Bad Password Count.

3. If no account is found on the trusted domain, the operating system must use the local guest account to guarantee consistent behavior for authentication against the server.

4. For more information about how to restrict the lookup and logon of isolated names in trusted domains by using the LsaLookupRestrictIsolatedNameLevel and NeverPing registry entries, see [The Lsass.exe process may stop responding if you have many external trusts on an Active Directory domain controller](https://support.microsoft.com/help/923241).

    - Guest accounts on trusted domains will never be available.
    - The actual, internal process is more complex than the algorithms that are described here.
    - These algorithms do not discuss the actual mechanics of pass-through authentication. For more information, see [NTLM user authentication in Windows](ntlm-user-authentication.md)

    - These algorithms do not discuss the password encryption process that is used in Windows Server 2003, Windows XP, and Windows 2000. A binary large object (BLOB) derived from a one-way password hash is sent as part of the authentication request. The content of this BLOB will depend on the authentication protocol chosen for the logon.
    - This article does not discuss the internal workings of the Microsoft Authentication Module.
    - These algorithms assume that the guest account, when enabled, has no password. By default, the guest account does not have a password in Windows Server 2003, Windows XP, and Windows 2000. If a guest account password is specified, the user password that is sent in the SMB must match that guest account password.

## Examples

The following are examples of these algorithms in action.

### Example 1

You are logged on to the computer by using the same account name and password that is in the SCRATCH-DOMAIN domain account database. When you run the `NET USE \\SCRATCH` command for the domain controller for the SCRATCH-DOMAIN domain, the command is completed successfully. When you run the `NET USE \\NET` command for the domain controller that trusts the SCRATCH-DOMAIN domain, you receive the following error message:

> System error 1326 has occurred. Logon failure: unknown user name or bad password.

The \\SCRATCH-DOMAIN\\USER1 account has permissions on \\\\NET.

> [!NOTE]
> This example assumes the following configurations.

Configurations

Computer that has a local security authority:

-Login account: USER1  
-Password: PSW1  
-Login Domain: LOCAL1

Active Directory domain controller:

  -Server Name: NET\</WWITEM>  
  -Domain:      NET-DOMAIN\</WWITEM>  
  -Trust:       NET-DOMAIN Trust SCRATCH-DOMAIN (Therefore,  
                accounts on SCRATCH-DOMAIN can be granted permissions  
                in the NET- DOMAIN).

The NET-DOMAIN domain:

- The domain account database for the NET-DOMAIN domain does not contain an account for USER1.
- The guest account is disabled.

Windows Server 2003:

-Server Name: SCRATCH  
-Domain: SCRATCH-DOMAIN  
-Domain Database contains account: USER1  
-Domain Database contains password: PSW1

In this example, the computer is logged on to its local domain, not the SCRATCH-DOMAIN domain where the computer's domain account resides.

### Example 2

When you run the `NET USE x: \\NET\share` command, the following steps occur:

1. The computer sends out the following in the "Session Setup" SMB:

    - account = "USER1"
    - password = "PSW1"
    - domain = "LOCAL1"

2. The \\\\NET server receives the SMB and looked at the account name.
3. The server examines its local domain account database and does not find a match.
4. The server then examines the SMB domain name.
5. The server does not trust "LOCAL1," so the server does not check its trusted domains.
6. The server then checks its guest account.
7. The guest account is disabled so the "System error 1326 has occurred. Logon failure: unknown user name or bad password." error message is generated.

### Example 3

When you run the `NET USE x: \\SCRATCH\share` command, the following steps occur:

1. The computer sends out the following in the "Session Setup" SMB:

    - account = "USER1"
    - password = "PSW1"
    - domain = "LOCAL1"

2. The \\\\SCRATCH server receives the SMB and examines the account name.
3. The server examines its local domain account database and finds a match.
4. The server then compares the SMB password to the domain account password.
5. The passwords match.

Therefore, the "Command Completes Successfully" message is generated. In Example 2 and Example 3, the trust relationship is unavailable. If the computer had been logged on to the SCRATCH-DOMAIN domain, the `NET USE x: \\NET\share` command would have been successful.

The ideal solution is to have all computers log on to a domain. In order to log on, the user must specify the domain, account, and password. After you do this, all NET USE -type commands will pass the correct domain, account, and password information. Administrators should try to avoid duplicate accounts on both computers and multiple domains. Windows Server 2003-based, Windows XP-based, and Windows 2000-based computers help avoid this configuration by using trusts between domains and by using members that can use domain databases.

## Workaround

There is one workaround that can be used in these cases. From the computer, you could run the following command:

```console
NET USE X: \\NET\SHARE /USER:SCRATCH-DOMAIN\USER1 PSW1
```

In this command, the follow is true:

- \\\\NET = The computer name of the domain controller being accessed.
- \\SHARE = The share name.
- /USER: command line parameter that lets you specify the domain,
account and password that should be specified in the "Session Setup"
SMB.
- SCRATCH-DOMAIN = Domain name of the domain where the user
account resides.
- \\USER1 = account to be validated against.
- PSW1 = password that matches account on the domain.

For more information about this command, type the following at the command prompt:

```console
NET USE /?  
```

## NULL domain names

The Microsoft SMB client that is included in Windows Server 2003, Windows XP, and Windows 2000 sends NULL domain names in the "Session Setup SMB [x73]" SMB. The Microsoft SMB client handles the domain name by specifying the logon domain name and by sending a NULL character if the domain name is not specified in the NET USE command. The Microsoft SMB client will also exhibit the behavior described in Example 1.

> [!NOTE]
>
> - The default domain name is specified in the LANMAN.INI file on the "DOMAIN =" line. This can be overridden by the `/DOMAIN:` switch with the `NET LOGON` command.
> - There are typically two representations for "NULL" in the SMB: A zero-length domain name and a one-byte domain name that consists of the question mark character (?). The SMB server catches the question mark and translates it to NULL before passing it to the local security authority (LSA).

## Troubleshooting

A good tip for troubleshooting network access problems is to enable auditing by doing the following.

### Windows 2000 and later versions of Windows 2000-based domain controllers

1. From the Administrative Tools on a domain controller, start Active Directory Users and Computers.
2. Right-click **Domain Controllers OU**, and then click **Properties**.
3. On the **Group Policy** tab, double-click **Default Domain Controller Policy**.
4. In the Policy Editor, click **Computer Settings**, click **Windows Settings**, click **Security Settings**, click **Local Policies**, and then click **Audit Policy**.
5. Select the **Logon and Account Logon Success** option and the **Failure** option.

### Domain settings for Windows 2000 servers and members

1. From the Administrative Tools on a domain controller, start Active Directory Users and Computers.
2. Right-click the domain name, and then click **Properties**.
3. On the **Group Policy** tab, double-click **Default Domain Policy**.
4. In the Policy Editor, click **Computer Settings**, click **Windows Settings,** click **Security Settings**, click **Local Policies**, and then click **Audit Policy**.
5. Select the **Logon and Account Logon Success** option and the **Failure** option.

### Local settings for Windows 2000 servers and members

1. From the Administrative Tools, start Local Security Policy.
2. Open Audit Policy.
3. Select the **Logon and Account Logon Success** option and the **Failure** option. Now, anytime that a network user accesses this server remotely, an audit trail will be logged in Event Viewer. To see these events in Event Viewer, click **Security** in the **Log** menu.

For more information about trust relationships, pass-through authentication, user permissions, and domain logins, see the "Technical Overview of Windows Server 2003 Security Services."

## More information

Basically, the same network access validation algorithms are applied to Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2.

These OS has several new features in SMB.

Windows Server 2008

- [What's New in SMB](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff625695(v=ws.10))

- [File Services for Windows Server 2008](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc770740(v=ws.10))

Windows Server 2012

- [Server Message Block Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831795(v=ws.11))
