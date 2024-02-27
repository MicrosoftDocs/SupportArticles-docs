---
title: Description of password-change protocols in Windows
description: Describes the mechanisms for changing passwords in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, davidg
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Description of password-change protocols in Windows

This article describes the mechanisms for changing passwords in Windows.

_Applies to:_ &nbsp; Windows 10, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 264480

## Summary

Windows uses many different mechanisms for changing passwords. This article describes those mechanisms.

## More information

The supported password-change protocols are:  

1. The NetUserChangePassword protocol
2. The NetUserSetInfo protocol
3. The Kerberos change-password protocol (IETF Internet Draft Draft-ietf-cat-kerb-chg-password-02.txt) [port 464]
4. Kerberos set-password protocol (IETF Internet Draft Draft-ietf-cat-kerberos-set-passwd-00.txt) [port 464]
5. Lightweight Directory Access Protocol (LDAP) write-password attribute (if 128-bit Secure Sockets Layer [SSL] is used)
6. XACT-SMB for pre-Microsoft Windows NT (LAN Manager) compatibility

Change-password operations require that the user's current password be known before the change is allowed. Set-password operations don't have this requirement, but are controlled by the Reset Password permissions on the account.

When you're using LDAP (method 5), the domain controller and the client must both be able to use 128-bit SSL to protect the connection. If the domain controller isn't configured for SSL or if appropriately long keys aren't available, the password-change write is denied.

An Active Directory domain controller listens for change-password requests on all of these protocols.

As stated earlier in this article, different protocols are used in different circumstances. For example:

- Interoperable Kerberos clients use the Kerberos protocols. UNIX-based systems with MIT Kerberos version 5 1.1.1 can change user passwords in a Windows-based domain by using the Kerberos change-password protocol (method 3).
- When users change their own passwords by pressing CTRL+ALT+DELETE and then clicking Change Password, Windows NT up to Windows 2003 the NetUserChangePassword mechanism (method 1) is used if the target is a domain. From Windows Vista onwards, the Kerberos change password protocol is used for domain accounts. If the target is a Kerberos realm, the Kerberos change-password protocol (method 3) is used.
- Requests to change a password from computers that are running Microsoft Windows 95/Microsoft Windows 98 use XACT-SMB (method 6).
- A program that uses the ChangePassword method on the Active Directory Services Interface (ADSI) IaDSUser interface first tries to change the password by using LDAP (method 5), and then by using the NetUserChangePassword protocol (method 1).
- A program that uses the SetPassword method on the ADSI IaDSUser interface first tries to change the password by using LDAP (method 5), then the Kerberos set-password protocol (method 4), and then the NetUserSetInfo protocol (method 2).
- The Active Directory Users and Computers snap-in uses ADSI operations for setting user passwords.
