---
title: NTLM user authentication
description: Provides some information about NTLM user authentication.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
---
# NTLM user authentication  

This article provides some information about NTLM user authentication.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 102716

## Summary

This article discusses the following aspects of NTLM user authentication in Windows:

- Password storage in the account database
- User authentication by using the MSV1_0 authentication package
- Pass-through authentication

## More information

### Password storage in the account database

User records are stored in the security accounts manager (SAM) database or in the Active Directory database. Each user account is associated with two passwords: the LAN Manager-compatible password and the Windows password. Each password is encrypted and stored in the SAM database or in the Active Directory database.

The LAN Manager-compatible password is compatible with the password that is used by LAN Manager. This password is based on the original equipment manufacturer (OEM) character set. This password is not case-sensitive and can be up to 14 characters long. The OWF version of this password is also known as the LAN Manager OWF or ESTD version. This password is computed by using DES encryption to encrypt a constant with the clear text password. The LAN Manager OWF password is 16 bytes long. The first 7 bytes of the clear text password are used to compute the first 8 bytes of the LAN Manager OWF password. The second 7 bytes of the clear text password are used to computer the second 8 bytes of the LAN Manager OWF password.

The Windows password is based on the Unicode character set. This password is case-sensitive and can be up to 128 characters long. The OWF version of this password is also known as the Windows OWF password. This password is computed by using the RSA MD4 hash function. This function computes a 16-byte digest of a variable-length string of clear text password bytes.

Any user account might lack either the LAN Manager password or the Windows password. However, every attempt is made to maintain both versions of the password.  

For example, if the user account is ported from a LAN Manager UAS database by using PortUas, or if the password is changed from a LAN Manager client or from a Windows for Workgroups client, only the LAN Manager version of the password will exist. If the password is set or changed on a Windows client, and the password has no LAN Manager representation, only the Windows version of the password will exist. (The password might have no LAN Manager representation because the password is longer than 14 characters or because the characters cannot be represented in the OEM character set.)  

User interface limits in Windows do not let Windows passwords exceed 14 characters. The implications of this limitation are discussed later in this article.

In Windows 2000 Service Pack 2 and in later versions of Windows, a setting is available that lets you prevent Windows from storing a LAN Manager hash of your password. For more information, check the following article number to view the article in the Microsoft Knowledge Base:

[299656](https://support.microsoft.com/help/299656) How to prevent Windows from storing a LAN manager hash of your password in Active Directory and local SAM databases  

> [!NOTE]
> Microsoft does not support manually or programmatically altering the SAM database.

### User authentication by using the MSV1_0 authentication package

Windows uses the LsaLogonUser API for all kinds of user authentications. The LsaLogonUser API authenticates users by calling an authentication package. By default, LsaLogonUser calls the MSV1_0 (MSV) authentication package. This package is included with Windows NT. The MSV authentication package stores user records in the SAM database. This package supports pass-through authentication of users in other domains by using the Netlogon service.

Internally, the MSV authentication package is divided into two parts. The first part of the MSV authentication package runs on the computer that is being connected to. The second part runs on the computer that contains the user account. When both parts run on the same computer, the first part of the MSV authentication package calls the second part without involving the Netlogon service. The first part of the MSV authentication package recognizes that pass-through authentication is required because the domain name that is passed is not its own domain name. When pass-through authentication is required, MSV passes the request to the Netlogon service. The Netlogon service then routes the request to the Netlogon service on the destination computer. In turn, the Netlogon service passes the request to the other part of the MSV authentication package on that computer.

LsaLogonUser supports interactive logons, service logons, and network logons. In the MSV authentication package, all forms of logon pass the name of the user account, the name of the domain that contains the user account, and some function of the user's password. The different kinds of logon represent the password differently when they pass it to LsaLogonUser.

For interactive logons, batch logons, and service logons, the logon client is on the computer that is running the first part of the MSV authentication package. In this case, the clear-text password is passed to LsaLogonUser and to the first part of the MSV authentication package. For service logons and batch logons, the Service Control Manager and the Task Scheduler provide a more secure way of storing the account's credentials.

The first part of the MSV authentication package converts the clear-text password both to a LAN Manager OWF password and to a Windows NT OWF password. Then, the first part of the package passes the clear-text password either to the NetLogon service or to the second part of the package. The second part then queries the SAM database for the OWF passwords and makes sure that they are identical.

For network logons, the client that connects to the computer was previously given a 16-byte challenge, or "nonce." If the client is a LAN Manager client, the client computed a 24-byte challenge response by encrypting the 16-byte challenge with the 16-byte LAN Manager OWF password. The LAN Manager client then passes this "LAN Manager Challenge Response" to the server. If the client is a Windows client, a "Windows NT Challenge Response" is computed by using the same algorithm. However, the Windows client uses the 16-byte Windows OWF data instead of the LAN Manager OWF data. The Windows client then passes both the LAN Manager Challenge Response and the Windows NT Challenge Response to the server. In either case, the server authenticates the user by passing all the following to the LsaLogonUser API:  

- The domain name
- The user name
- The original challenge
- The LAN Manager Challenge Response
- The optional Windows NT Challenge Response  

The first part of the MSV authentication package passes this information unchanged to the second part. First, the second part queries the OWF passwords from the SAM database or from the Active Directory database. Then, the second part computes the challenge response by using the OWF password from the database and the challenge that was passed in. The second part then compares the computed challenge response to passed-in challenge response.

> [!NOTE]
> NTLMv2 also lets the client send a challenge together with the use of session keys that help reduce the risk of common attacks.

As mentioned earlier, either version of the password might be missing from the SAM database or from the Active Directory database. Also, either version of the password might be missing from the call to LsaLogonUser. If both the Windows version of password from the SAM database and the Windows version of the password from LsaLogonUser are available, they both are used. Otherwise, the LAN Manager version of the password is used for comparison. This rule helps enforce case sensitivity when network logons occur from Windows to Windows. This rule also allows for backward compatibility.

### Pass-through authentication

The NetLogon service implements pass-through authentication. It performs the following functions:  

- Selects the domain to pass the authentication request to.
- Selects the server within the domain.
- Passes the authentication request through to the selected server.  

Selecting the domain is straightforward. The domain name is passed to LsaLogonUser. The domain name is processed as follows:

- If the domain name matches the name of the SAM database, the authentication is processed on that computer. On a Windows workstation that is a member of a domain, the name of the SAM database is considered to be the name of the computer. On an Active Directory domain controller, the name of the account database is the name of the domain. On a computer that isn't a member of a domain, all logons process requests locally.
- If the specified domain name is trusted by this domain, the authentication request is passed through to the trusted domain. On Active Directory domain controllers, the list of trusted domains is easily available. On a member of a Windows domain, the request is always passed through to the primary domain of the workstation, letting the primary domain determine whether the specified domain is trusted.
- If the domain name specified is not trusted by the domain, the authentication request is processed on the computer being connected to as if the domain name specified were that domain name. NetLogon doesn't differentiate between a nonexistent domain, an untrusted domain, and an incorrectly typed domain name.  

NetLogon selects a server in the domain by a process called discovery. A Windows workstation discovers the name of one of the Windows Active Directory domain controllers in its primary domain. An Active Directory domain controller discovers the name of an Active Directory domain controller in each trusted domain. The component that does the discovery is the DC Locator that runs in the Netlogon service. The DC Locator uses either NETBIOS or DNS name resolution to locate the necessary servers, depending on the type of domain and trust that is configured.
