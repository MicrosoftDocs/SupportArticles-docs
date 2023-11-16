---
title: How to enable LDAP signing
description: Describes how to enable LDAP signing in Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, and Windows 10.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, hjerez, jarrettr, herbertm, wincicadsec
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
ms.technology: windows-server-active-directory
---
# How to enable LDAP signing in Windows Server

This article describes how to enable LDAP signing in Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, and Windows 10.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
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

> [!NOTE]
> Logging anomaly of Event ID 2889
>
> Applications that use third-party LDAP clients may cause Windows to generate incorrect Event ID 2889 entries. This occurs when you log of LDAP interface events and if `LDAPServerIntegrity` is equal to **2**. The use of sealing (encryption) satisfies the protection against the MIM attack, but Windows logs Event ID 2889 anyway.
>
> This happens when LDAP clients use only sealing together with SASL. We have seen this in the field in association with third-party LDAP clients.
>
> When a connection does not use both signing and sealing, the connection security requirements check uses the flags correctly and disconnect. The check generates Error 8232 (ERROR_DS_STRONG_AUTH_REQUIRED).

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

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\\\<*InstanceName>*\Parameters

> [!NOTE]
> The placeholder \<InstanceName> represents the name of the AD LDS instance that you want to change.

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

## References

- [ADV190023: Microsoft Guidance for Enabling LDAP Channel Binding and LDAP Signing](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/ADV190023)
- [2020 LDAP channel binding and LDAP signing requirement for Windows](https://support.microsoft.com/help/4520412)
