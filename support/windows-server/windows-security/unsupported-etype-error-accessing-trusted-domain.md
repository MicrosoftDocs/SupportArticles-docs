---
title: Kerberos Unsupported etype error
description: Describes how to resolve a configuration problem that prevents clients from authenticating when they attempt to access resources in a trusted domain.
ms.date: 11/10/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, Arrenc, justintu, lindakup, herbertm, waynmc
ms.custom: sap:kerberos-authentication, csstroubleshoot
ms.subservice: windows-security
---
# "Unsupported etype" error when accessing a resource in a trusted domain

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4492348

## Symptoms

A computer in a child domain of an Active Directory Domain Services (AD DS) forest cannot access a service that resides in a different domain within the same forest. If you run a network trace on communications to and from the client computer, the trace contains the following Kerberos messages:

```output
6 9:35:19 AM 8/14/2018   17.8417442   192.168.1.101   192.168.1.2  KerberosV5   KerberosV5:AS Request Cname: Administrator Realm: contoso.com Sname: krbtgt/contoso.com   {TCP:4, IPv4:1}  
  
7 9:35:19 AM 8/14/2018   17.8452544   192.168.1.2   192.168.1.101  KerberosV5   KerberosV5:KRB_ERROR - KDC_ERR_ETYPE_NOSUPP (14)  {TCP:4, IPv4:1}  
```

On the domain controller of the child domain, Event Viewer records the following Event 14 entry:

```output
Log Name: System  
Source: Microsoft-Windows-Kerberos-Key-Distribution-Center  
Event ID: 14  
Task Category: None  
Level: Error  
Keywords: Classic  
Description:  
While processing an AS request for target service krbtgt, the account Administrator did not have a suitable key for generating a Kerberos ticket (the missing key has an ID of 1). The requested etypes : 18 17 3. The accounts available etypes : 23 -133 -128. Changing or resetting the password of Administrator will generate a proper key.  
```

## Cause

This problem occurs when you configure the child domain (or just the client) as follows:  

- You disable the RC4_HMAC-MD5 encryption type, leaving the AES128-CTS-HMAC-SHA1-96 and AES256-CTS-HMAC-SHA1-96 encryption types enabled.
- You disable NTLM authentication.

### Kerberos encryption types

RC4 encryption is considered less secure than the newer encryption types, AES128-CTS-HMAC-SHA1-96 and AES256-CTS-HMAC-SHA1-96. Security guides such as the [Windows 10 Security Technical Implementation Guide](https://www.stigviewer.com/stig/windows_10/2017-04-28/)  provide instructions for improving the security of a computer by configuring it to use only AES128 and/or AES256 encryption (see [Kerberos encryption types must be configured to prevent the use of DES and RC4 encryption suites](https://www.stigviewer.com/stig/windows_10/2017-04-28/finding/V-63795)).  

Such a client can continue to connect to services within its own domain that use AES128 or AES256 encryption. However, other factors can prevent the client from connecting to similar services in another trusted domain, even if those services also use AES128 or AES256 encryption.  

At a very high level, a domain controller (DC) is responsible for managing access requests within its own domain. As part of the Kerberos authentication process, the DC checks that both the client and the service can use the same Kerberos encryption type. However, when a client requests access to a service in a different, trusted domain, the client's DC must "refer" the client to a DC in the service's domain. When the DC builds the referral ticket, instead of comparing the encryption types of the client and the service, it compares the encryption types of the client and the trust.  

The problem occurs because of the configuration of the trust itself. In Active Directory, a domain object has associated trusted domain objects (TDOs) that represent each domain that it trusts. The attributes of a TDO describe the trust relationship, including the Kerberos encryption types that the trust supports. The default relationship between a child domain and a parent domain is a two-way transitive trust that supports the RC4 encryption type. Both the parent and the child domain have TDOs that describe this relationship, including the encryption type.  

When the client contacts the `child.contoso.com` DC to request access to the service, the DC determines that the service is in the trusted domain `contoso.com`. The DC checks the trust configuration to identify the encryption type that the trust supports. By default, the trust supports RC4 encryption but not AES128 or AES256 encryption. On the other hand, the client cannot use RC4 encryption. The DC cannot identify a common encryption type, so it cannot build the referral ticket, and the request fails.

### NTLM authentication

After the Kerberos authentication fails, the client tries to fall back to NTLM authentication. However, if NTLM authentication is disabled, the client has no other alternatives. Therefore, the connection attempt fails.

## Resolution

To resolve this problem, use one of the following methods:  

- Method 1: Configure the trust to support AES128 and AES 256 encryption in addition to RC4 encryption.
- Method 2: Configure the client to support RC4 encryption in addition to AES128 and AES256 encryption.
- Method 3: Configure the trust to support AES128 and AES 256 encryption instead of RC4 encryption.

The choice depends on your security needs and your need to minimize disruption or maintain backward compatibility.

### Method 1: Configure the trust to support AES128 and AES 256 encryption in addition to RC4 encryption

This method adds the newer encryption types to the trust configuration, and does not require any changes to the client or the service. In this method, you use the `ksetup` command-line tool to configure the trust.  

To configure the Kerberos encryption type of a trust, open a Command Prompt window on a DC in the trusted domain and then enter the following command:  

```console
ksetup /setenctypeattr <trustingdomain> RC4-HMAC-MD5 AES128-CTS-HMAC-SHA1-96 AES256-CTS-HMAC-SHA1-96
```

> [!Note]
> In this command, \<trustingdomain> represents the fully qualified domain name (FQDN) of the trusting domain.

In the example in which `contoso.com` is the root domain (where the service resides) and `child.contoso.com` is the child domain (where the client resides), open a command prompt window on a `contoso.com` DC and then enter the following command:  

```console
ksetup /setenctypeattr child.contoso.com RC4-HMAC-MD5 AES128-CTS-HMAC-SHA1-96 AES256-CTS-HMAC-SHA1-96
```

After this command finishes, the `child.contoso.com` DC can successfully build the referral ticket that the client can use to reach the `contoso.com` DC.  

Because the relationship between the two domains is a two-way transitive trust, configure the other side of the trust by opening a Command Prompt window on a `child.contoso.com` DC and then enter the following command:  

```console
ksetup /setenctypeattr contoso.com RC4-HMAC-MD5 AES128-CTS-HMAC-SHA1-96 AES256-CTS-HMAC-SHA1-96
```

After this command finishes, a `contoso.com` DC can build referral tickets for any clients in `contoso.com` that cannot use RC4 encryption but must use resources in `child.contoso.com`.  

For more information about the ksetup tool, see [ksetup](/windows-server/administration/windows-commands/ksetup).

### Method 2: Configure the client to support RC4 encryption in addition to AES128 and AES256 encryption

This method involves changing the configuration of the client instead of the trust. You can change the configuration of a single client, or use Group Policy to change the configuration of multiple clients in a domain. However, the main drawback to this configuration change is that if you disabled RC4 encryption in order to improve security, rolling back that change may not be possible.  

For complete instructions to change the encryption types that clients can use, see [Windows Configurations for Kerberos Supported Encryption Type](/archive/blogs/openspecification/windows-configurations-for-kerberos-supported-encryption-type).

### Method 3: Configure the trust to support AES128 and AES 256 encryption instead of RC4 encryption

This method resembles method 1 in that you configure the trust attributes.  

In the case of Windows forest trusts, both sides of the trust support AES. Therefore, all ticket requests on the trust use AES. However, a third-party Kerberos client that inspects the referral ticket might notify you that the ticket uses an encryption type that the client does not support. In order to continue to allow such a client to inspect the ticket, update it to support AES.  

When you use this method, configure the trust by using the Active Directory Domains and Trusts MMC snap-in.
To use this method, follow these steps:  

1. In Active Directory Domains and Trusts, navigate to the trusted domain object (in the example,`contoso.com`). Right-click the object, select **Properties**, and then select **Trusts**.
2. In the **Domains that trust this domain (incoming trusts)**  box, select the trusting domain (in the example, `child.domain.com`).
3. Select **Properties**, select **The other domain supports Kerberos AES Encryption**, and then select **OK**.

    :::image type="content" source="media/unsupported-etype-error-accessing-trusted-domain/properties-of-a-child-domain.png" alt-text="Screenshot of the properties of a child domain, and the Properties window includes the other domain supports Kerberos AES Encryption checkbox.":::

    > [!Note]
    > To validate the trust configuration, select **Validate** in the trusting domain dialog box.

    > [!Important]
    > In the case of a one-way trust, the trusted domain lists the trusting domain as an incoming trust, and the trusting domain lists the trusted domain as an outgoing trust.  
    >
    > If the relationship is a two-way trust, each domain lists the other domain as both an incoming and outgoing trust. In this configuration, make sure to check the domain configuration in both **Domains that trust this domain (incoming trusts)** and **Domains trusted by this domain (outgoing trusts)**. In both cases, the checkbox must be selected.

4. On the **Trusts** tab, click **OK**.
5. Navigate to the domain object for the trusting domain (`child.contoso.com`).
6. Repeat steps 1 - 4 to make sure that the trust configuration for this domain mirrors the trust configuration for the other domain (in this case, the incoming and outgoing trust lists include `contoso.com`).

## More information

For more information about TDOs, see the following articles:  

- [Primary and Trusted domains](/windows/win32/secmgmt/primary-and-trusted-domains)  
- [Trust Properties - General Tab](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd145414%28v=ws.11%29)  
- [Essential Attributes of a Trusted Domain Object](/openspecs/windows_protocols/ms-adts/c9efe39c-f5f9-43e9-9479-941c20d0e590)  

For more information about Kerberos encryption types, see the following articles:  

- [Windows Configurations for Kerberos Supported Encryption Type](/archive/blogs/openspecification/windows-configurations-for-kerberos-supported-encryption-type)  
- [Kerberos Parameters](https://www.iana.org/assignments/kerberos-parameters/kerberos-parameters.xml)  
- [Ksetup:setenctypeattr](/windows-server/administration/windows-commands/ksetup-setenctypeattr)  
- [The RC4 Removal Files Part 2: In AES We Trust](https://techcommunity.microsoft.com/t5/premier-field-engineering/the-rc4-removal-files-part-2-in-aes-we-trust/ba-p/1029439?search-action-id=202020616032&search-result-uid=1029439)  
