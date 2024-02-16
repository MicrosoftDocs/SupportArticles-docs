---
title: LDAP session security settings and requirements after ADV190023
description: Discusses LDAP session security settings and requirements after security advisory ADV190023 is installed.
ms.date: 07/07/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: herbertm, wincicadsec, kaushika
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# LDAP session security settings and requirements after ADV190023 is installed

This article discusses LDAP session security settings and requirements after security advisory ADV190023 is installed.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4563239

## Summary

This article introduces the functional changes that are provided by security advisory [ADV190023](https://portal.msrc.microsoft.com/security-guidance/advisory/ADV190023). Additionally, this article describes the security settings for each kind of Lightweight Directory Access Protocol (LDAP) session, and what is required to operate the LDAP sessions in a secure way.  

ADV190023 discusses settings for both LDAP session signing and additional client security context verification (Channel Binding Token, CBT). In the implementation, there are two separate items:

- **LDAPServerIntegrity** and events logged on Domain Controllers
- **LdapEnforceChannelBinding** and events logged on Domain Controllers.

When you determine the best path to improve security according to ADV190023, there may be actions needed by application owners in both areas. However, the settings and requirements to meet them are different. It's also quite possible that a solution for both topics consists in a single change. For example, by moving from simple bind to SASL using Kerberos or TLS with simple bind.

The new Channel Binding Token (CBT) option is the LDAP TLS implementation of the [Extended Protection for Authentication](/dotnet/framework/wcf/feature-details/extended-protection-for-authentication-overview) (EPA) scheme that is described in RFC 5056.

> [!NOTE]
> "EPA" and "CBT" can be used interchangeably in this context.

## More information

The method by which LDAP session security is handled depends on which protocol and authentication options are chosen. There are several possible session options:

- Sessions on ports 389 or 3268 or on custom LDS ports that don't use TLS/SSL for a simple bind: There's no security for these sessions. This is because credentials are transmitted in clear text. Therefore, there's no secure key material to provide protection. These sessions should be disabled by setting **LDAPServerIntegrity** to **Required**.
- Sessions on ports 389 or 3268 or on custom LDS ports that don't use TLS/SSL for a Simple Authentication and Security Layer (SASL) bind.
- Sessions that use TLS/SSL by using a predetermined port (636, 3269, or a custom LDS port), or standard ports (389, 3268, or a custom LDS port) that use the STARTTLS extended operation.

### LDAP sessions not using TLS/SSL, binding by using  SASL

If LDAP sessions are signed or encrypted by using an SASL logon, the sessions are secure from Man-In-the-Middle (MITM) attacks. This is because you can obtain the signing keys only if you know the user password. You don't have to have Extended Protection for Authentication (EPA) information.

The SASL method that is chosen may have its own attack vectors, such as NTLMv1. But the LDAP session itself is secure. If you're using Kerberos AES 256-bit encryption, that is as good as it gets in 2020.
The following policy guidelines apply:

- The **LDAPServerIntegrity=2** setting is important for this session option because it enforces the use of signing by the client. When you encrypt the sessions, this requirement is also met.
- The **LdapEnforceChannelBinding** setting has no bearing on this session option.

### LDAP sessions using TLS/SSL and simple bind for user authentication  

There's no CBT information added for these sessions. The quality of the TLS client implementation governs whether the client can detect an MITM attack (through server certificate name checking, verification of CRL, and so on).

The following policy guidelines apply:

- The requirement for **LDAPServerIntegrity** is met because the TLS channel provides signing. The level of security that the TLS channel provides depends on the TLS client implementation.
- The **LdapEnforceChannelBinding** setting has no bearing on this session option.

### LDAP sessions using TLS/SSL, binding by using certificate for user authentication  

Currently, there's no CBT information added for these sessions. The quality of the TLS client implementation governs whether the client can detect an MITM attack (through server certificate name checking, verification of CRL, and so on). Client certificate authentication is sufficient to block MITM attacks, but it doesn't prevent other categories of attacks that can be mitigated only by appropriate client-side validation of the TLS certificate that is presented by the server.

The following policy guidelines apply:

- The requirement for **LDAPServerIntegrity** is met because the TLS channel provides signing. The level of security that the TLS channel provides depends on the TLS client implementation.
- The **LdapEnforceChannelBinding** setting has no bearing on this session option.

### LDAP Sessions using TLS/SSL, binding with SASL for user authentication

In this scenario, TLS provides the session security for encryption, and the encryption keys are based on the server certificate. Specifically for SASL authentication that uses NTLM, the NTLM authentication data may have been relayed from the session that was held by the MITM attacker. In the case of such an attack, there's no proof that the client has a valid password hash.
The CBT information is protected against tampering through signing or encryption (depending on the authentication protocol) by using a session key that can be obtained only by knowing the user's or server's credentials. The MITM attacker wouldn't have this password hash if it intercepted an NTLM authentication.

The following policy guidelines apply:

- The **LdapEnforceChannelBinding** setting is used for this session option. When you set this value to **2**, the LDAP server requires CBT information (equivalent to EPA), and it's required to pass verification.
- The requirement for **LDAPServerIntegrity** is met because the TLS channel provides signing. The level of security that it provides depends on the TLS client implementation and whether CBT is required.

## References

For more information, see the following articles:

- [Extended Protection for Authentication](https://msrc.microsoft.com/blog/2009/12/extended-protection-for-authentication/)  
- [Control Extended Protection for Authentication using Security Policy](/archive/blogs/askds/control-extended-protection-for-authentication-using-security-policy)
- [Supporting Extended Protection for Authentication (EPA) in a service](/windows/win32/secauthn/epa-support-in-service)
