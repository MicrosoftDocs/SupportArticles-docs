---
title: How to enable LDAP signing
description: Describes how to enable LDAP signing in Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, and Windows 10.
ms.date: 02/22/2024
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, hjerez, jarrettr, herbertm, wincicadsec
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# How to enable LDAP signing in Windows Server

This article describes how to enable LDAP signing in Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10, and Windows 11.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 11 - all editions, Windows 10 - all editions  
_Original KB number:_ &nbsp; 935834

## Summary

You can significantly improve the security of a directory server by configuring the server to reject Simple Authentication and Security Layer (SASL) LDAP binds that do not request signing (integrity verification), or to reject LDAP simple binds that are performed on a clear text (non-SSL/TLS-encrypted) connection. SASL binds may include protocols such as Negotiate, Kerberos, NTLM, and Digest.

Unsigned network traffic is susceptible to replay attacks. In such attacks, an intruder intercepts the authentication attempt and the issuance of a ticket. The intruder can reuse the ticket to impersonate the legitimate user. Additionally, unsigned network traffic is susceptible to man-in-the-middle (MIM) attacks in which an intruder captures packets between the client and the server, changes the packets, and then forwards them to the server. If this occurs on an LDAP server, an attacker can cause a server to make decisions that are based on forged requests from the LDAP client.

## How to discover clients that do not use the Require signing option

After you make this configuration change, clients that rely on unsigned SASL (Negotiate, Kerberos, NTLM, or Digest) LDAP binds or on LDAP simple binds over a non-SSL/TLS connection stop working. To help identify these clients, the directory server of Active Directory Domain Services (AD DS) or Lightweight Directory Server (LDS) logs a summary Event ID 2887 one time every 24 hours to indicate how many such binds occurred. We recommend that you configure these clients not to use such binds. After no such events are observed for an extended period, we recommend that you configure the server to reject such binds.

If you must have more information to identify such clients, you can configure the directory server to provide more detailed logs. This additional logging will log an Event ID 2889 when a client tries to make an unsigned LDAP bind. The log entry displays the IP address of the client and the identity that the client tried to use to authenticate. You can enable this additional logging by setting the **16 LDAP Interface Events** diagnostic setting to **2 (Basic)**. For more information about how to change the diagnostic settings, see [How to configure Active Directory and LDS diagnostic event logging](https://support.microsoft.com/help/314980).

If the directory server is configured to reject unsigned SASL LDAP binds or LDAP simple binds over a non-SSL/TLS connection, the directory server logs a summary Event ID 2888 one time every 24 hours when such bind attempts occur.

## How to configure the directory to require LDAP server signing for AD DS

For information about possible affects of changing security settings, see [Client, service, and program issues can occur if you change security settings and user rights assignments](https://support.microsoft.com/help/823659).

### Using Group Policy

#### How to set the server LDAP signing requirement

1. Select **Start** > **Run**, type *mmc.exe*, and then select **OK**.
2. Select **File** > **Add/Remove Snap-in**, select **Group Policy Management Editor**, and then select **Add**.
3. Select **Group Policy Object** > **Browse**.
4. In the **Browse for a Group Policy Object** dialog box, select **Default Domain Controller Policy** under the **Domains, OUs, and linked Group Policy Objects** area, and then select **OK**.
5. Select **Finish**.
6. Select **OK**.
7. Select **Default Domain Controller Policy** > **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies**, and then select **Security Options**.
8. Right-click **Domain controller: LDAP server signing requirements**, and then select **Properties**.
9. In the **Domain controller: LDAP server signing requirements Properties** dialog box, enable **Define this policy setting**, select **Require signing** in the **Define this policy setting** list, and then select **OK**.
10. In the **Confirm Setting Change** dialog box, select **Yes**.

#### How to set the client LDAP signing requirement by using local computer policy

1. Select **Start** > **Run**, type *mmc.exe*, and then select **OK**.
2. Select **File** > **Add/Remove Snap-in**.
3. In the **Add or Remove Snap-ins** dialog box, select **Group Policy Object Editor**, and then select **Add**.
4. Select **Finish**.
5. Select **OK**.
6. Select **Local Computer Policy** > **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies**, and then select **Security Options**.
7. Right-click **Network security: LDAP client signing requirements**, and then select **Properties**.
8. In the **Network security: LDAP client signing requirements Properties** dialog box, select **Require signing** in the list, and then select **OK**.
9. In the **Confirm Setting Change** dialog box, select **Yes**.

#### How to set the client LDAP signing requirement by using a domain Group Policy Object

1. Select **Start** > **Run**, type **mmc.exe**, and then select **OK**.
2. Select **File** > **Add/Remove Snap-in**.
3. In the **Add or Remove Snap-ins** dialog box, select **Group Policy Object Editor**, and then select **Add**.
4. Select **Browse**, and then select **Default Domain Policy** (or the Group Policy Object for which you want to enable client LDAP signing).
5. Select **OK**.
6. Select **Finish**.
7. Select **Close**.
8. Select **OK**.
9. Select **Default Domain Policy** > **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies**, and then select **Security Options**.
10. In the **Network security: LDAP client signing requirements Properties** dialog box, select **Require signing** in the list, and then select **OK**.
11. In the **Confirm Setting Change** dialog box, select **Yes**.

#### How to set the client LDAP signing requirement by using registry keys

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

By default, for Active Directory Lightweight Directory Services (AD LDS), the registry key is not available. Therefore, you must create a `LDAPServerIntegrity` registry entry of the REG_DWORD type under the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\<InstanceName>\Parameters`

> [!NOTE]
> The placeholder `<InstanceName>` represents the name of the AD LDS instance that you want to change.

The registry entry has the following possible values:

- **0**: Signing is disabled.
- **2**: Signing is enabled.

When you change this value, the new value takes effect immediately. You don't have to restart the computer.

#### How to verify configuration changes

1. Sign in to a computer that has the AD DS Admin Tools installed.
2. Select **Start** > **Run**, type *ldp.exe*, and then select **OK**.
3. Select **Connection** > **Connect**.
4. In **Server** and in **Port**, type the server name and the non-SSL/TLS port of your directory server, and then select **OK**.

    > [!NOTE]
    > For an Active Directory Domain Controller, the applicable port is 389.

5. After a connection is established, select **Connection** > **Bind**.
6. Under **Bind type**, select **Simple bind**.
7. Type the user name and password, and then select **OK**.

    If you receive the following error message, you have successfully configured your directory server:

    > Ldap_simple_bind_s() failed: Strong Authentication Required

## Event reference for LDAP signing requirements

### Event ID 2886

After starting DS services, Event ID 2886 is logged to remind administrators to enable signing requirements:

```output
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      2886
Task Category: LDAP Interface
Level:         Warning
Keywords:      Classic
Description:
The security of this directory server can be significantly enhanced by configuring the server to reject SASL (Negotiate, Kerberos, NTLM, or Digest) LDAP binds that do not request signing (integrity verification) and LDAP simple binds that are performed on a clear text (non-SSL/TLS-encrypted) connection. Even if no clients are using such binds, configuring the server to reject them will improve the security of this server. 
 
Some clients may currently be relying on unsigned SASL binds or LDAP simple binds over a non-SSL/TLS connection, and will stop working if this configuration change is made. To assist in identifying these clients, if such binds occur this directory server will log a summary event once every 24 hours indicating how many such binds occurred. You are encouraged to configure those clients to not use such binds. Once no such events are observed for an extended period, it is recommended that you configure the server to reject such binds. 
 
For more details and information on how to make this configuration change to the server, please see http://go.microsoft.com/fwlink/?LinkID=87923. 
 
You can enable additional logging to log an event each time a client makes such a bind, including information on which client made the bind. To do so, please raise the setting for the "LDAP Interface Events" event logging category to level 2 or higher.
```

### Event ID 2887

When a problem client is detected but permitted, a summary event (Event ID 2887) of the past 24 hours is logged:

```output
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      2887
Task Category: LDAP Interface
Level:         Warning
Keywords:      Classic
Description:
During the previous 24 hour period, some clients attempted to perform LDAP binds that were either:
(1) A SASL (Negotiate, Kerberos, NTLM, or Digest) LDAP bind that did not request signing (integrity validation), or
(2) A LDAP simple bind that was performed on a clear text (non-SSL/TLS-encrypted) connection

This directory server is not currently configured to reject such binds. The security of this directory server can be significantly enhanced by configuring the server to reject such binds. For more details and information on how to make this configuration change to the server, please see http://go.microsoft.com/fwlink/?LinkID=87923.

Summary information on the number of these binds received within the past 24 hours is below.

You can enable additional logging to log an event each time a client makes such a bind, including information on which client made the bind. To do so, please raise the setting for the "LDAP Interface Events" event logging category to level 2 or higher.

Number of simple binds performed without SSL/TLS: <count of binds>
Number of Negotiate/Kerberos/NTLM/Digest binds performed without signing: <count of binds>
```

### Event ID 2888

When a problem client is rejected, a summary event (Event ID 2888) of the past 24 hours is logged:

```output
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      2888
Task Category: LDAP Interface
Level:         Information
Keywords:      Classic
Description:
During the previous 24 hour period, some clients attempted to perform LDAP binds that were either:
(1) A SASL (Negotiate, Kerberos, NTLM, or Digest) LDAP bind that did not request signing (integrity validation), or
(2) A LDAP simple bind that was performed on a clear text (non-SSL/TLS-encrypted) connection

This directory server is configured to reject such binds.  This is the recommended configuration setting, and significantly enhances the security of this server. For more details, please see http://go.microsoft.com/fwlink/?LinkID=87923.

Summary information on the number of such binds received within the past 24 hours is below.

You can enable additional logging to log an event each time a client makes such a bind, including information on which client made the bind. To do so, please raise the setting for the "LDAP Interface Events" event logging category to level 2 or higher.

Number of simple binds rejected because they were performed without SSL/TLS: <count of binds>
Number of Negotiate/Kerberos/NTLM/Digest binds rejected because they were performed without signing: <count of binds>
```

### Event ID 2889

When a problem client tries to connect, Event ID 2889 is logged:

```output
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      2889
Task Category: LDAP Interface
Level:         Information
Keywords:      Classic
Description:
The following client performed a SASL (Negotiate/Kerberos/NTLM/Digest) LDAP bind without requesting signing (integrity verification), or performed a simple bind over a clear text (non-SSL/TLS-encrypted) LDAP connection. 
 
Client IP address:
<IP address>:<TCP port>
Identity the client attempted to authenticate as:
contoso\<username>
Binding Type:
0 – Simple Bind that does not support signing
1 – SASL Bind that does not use signing
```

## References

- [ADV190023: Microsoft Guidance for Enabling LDAP Channel Binding and LDAP Signing](https://portal.msrc.microsoft.com/security-guidance/advisory/ADV190023)
- [2020 LDAP channel binding and LDAP signing requirement for Windows](https://support.microsoft.com/help/4520412)
- [2020, 2023, and 2024 LDAP channel binding and LDAP signing requirements for Windows (KB4520412)](https://support.microsoft.com/topic/2020-2023-and-2024-ldap-channel-binding-and-ldap-signing-requirements-for-windows-kb4520412-ef185fb8-00f7-167d-744c-f299a66fc00a)
- [How to configure Active Directory and LDS diagnostic event logging](configure-ad-and-lds-event-logging.md)
