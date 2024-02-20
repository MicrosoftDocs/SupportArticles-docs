---
title: Set a user's password with Ldifde
description: Describes how to set a user's password by using the Ldifde tool.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, davidg, dhook
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# How to set a user's password with Ldifde

This article describes how to set a user's password by using the Ldifde tool.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 263991

## More information

The password attribute used by Active Directory is "unicodePwd". This attribute can be written under restricted conditions, but cannot be read. This attribute can only be modified, not added on object creation or read by a search.

To modify this attribute, the client must have a 128-bit Secure Sockets Layer/Transport Layer Security(SSL/TLS) or SASL encrypted connection to the server. The High Encryption pack must be installed on both the client and the server.  

> [!NOTE]
> When you want to use SASL encryption, you can use the "/h" argument of LDIFDE.  
> When you use a base-64 encoder, you must make sure that it supports Unicode, or you will create an incorrect password.

There are two ways to modify the unicodePwd attribute. The first is analogous to a typical user change-password operation. In this case, the modify request must contain both a delete operation and an add operation. The delete operation must contain the current password enclosed in quotation marks and be Base64 encoded as described in RFC 1521. The add operation must contain the new password enclosed in quotation marks and be Base64 encoded.

The second way to modify the attribute is analogous to an administrator resetting a password for a user. To do this, the client must have bound as an administrator a user who has sufficient rights to modify other users' passwords. The modify request should contain a single replace operation with the new password enclosed in quotation marks and be Base64 encoded. If the client has sufficient rights, this password becomes the new password regardless of what the old password was.

The following sample Ldif file (chPwd.ldif) changes a password to newPassword:  

> dn: CN=TestUser,DC=testdomain,DC=com  
changetype: modify  
replace: unicodePwd  
unicodePwd::IgBuAGUAdwBQAGEAcwBzAHcAbwByAGQAIgA=  
\-  

To import the chPwd.ldif file, use the following command:  

- SSL/TLS:  
`ldifde -i -f chPwd.ldif -t 636 -s \<dcname> -b \<username> \<domain> \<password>`  
- SASL:  
`ldifde -i -f chPwd.ldif -h -s \<dcname>  -b \<username> \<domain> \<password>`  

If the password does not fulfill the criteria of the enforced Password Policies, then it will throw an error:  
> Add error on entry starting on line 1: Unwilling To Perform The server-side error is "A device attached to the system is not functioning

For more information, see the following documents:  
The "LDAP Data Interchange Format (LDIF) - Technical Specification" document on the following IETF Web site:

[IETF 109 Online](https://search.ietf.org/internet-drafts/draft-good-ldap-ldif-06.txt)  
RFC 1521 on the following IETF Web site:

[RFC 1521](https://www.ietf.org/rfc/rfc1521.txt)  

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
