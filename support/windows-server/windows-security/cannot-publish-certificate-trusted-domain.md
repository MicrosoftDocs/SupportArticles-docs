---
title: CA doesn't publish certificates in trusted domain
description: Fixes an issue where the issued certificate isn't published in Active Directory when users from a child domain as a certification authority (CA) request a certificate.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.subservice: windows-security
---
# Certification Authority configuration to publish certificates in Active Directory of trusted domain

This article solves the issue where the issued certificate isn't published in Active Directory when users from a child domain as a certification authority (CA) request a certificate.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 281271

## Symptoms

In the following scenarios, if a user from the same domain as a CA requests a certificate, the issued certificate is published in Active Directory. If the user is from a child domain, this process isn't successful. Also, when users from the same domain as a CA request a certificate, the issued certificate may not be published in Active Directory.

### Scenario 1

In this scenario, the CA doesn't publish issued certificates to the user's DS object in the child domain when the following conditions are true:

- The user is in a two-level domain hierarchy with a parent and a child domain.
- The Enterprise CA is located on the parent domain and the user is in the child domain.
- The user in the child domain enrolls in the parent CA.

In a two-level domain hierarchy with a parent and a child domain, the Enterprise CA is located in the parent domain. And the users are in the child domain. The users in the child domain enroll in the parent CA, and the CA publishes issued certificates to the user's DS object in the child domain.

Additionally, the following event is logged on the CA server:

> Log Name: Application  
> Source: Microsoft-Windows-CertificationAuthority  
> Event ID: 80  
> Task Category: None  
> Level: Warning  
> Keywords:  
> User: SYSTEM  
> Computer: CA.CONTOSO.COM  
> Description:  
> Active Directory Certificate Services could not publish a Certificate for request XXX to the following location on server DC.CHILD.CONTOSO.COM: CN=CHILDSRV,CN=Computers,DC=CHILD,DC=CONTOSO,DC=COM. Insufficient access rights to perform the operation. 0x80072098 (WIN32: 8344 ERROR_DS_INSUFF_ACCESS_RIGHTS).  
> ldap: 0x32: 00002098: SecErr: DSID-XXXXXXXX, problem 4003 (INSUFF_ACCESS_RIGHTS), data 0

### Scenario 2

Consider the following scenario:

- The user is in a single-level domain or a parent domain.
- The Enterprise CA is located on the parent domain.
- The domain controllers don't have the hotfix [327825](https://support.microsoft.com/help/327825) installed.
- The user, either in the single-level or parent domain, enrolls in the single-level certification authority or the parent certification authority.

In this scenario, the certification authority doesn't publish the issued certificates to the user's domain server object in the single-level domain or in the parent domain.

## Cause

- For [Scenario 1](#scenario-1): two-level domain hierarchy

    Users from the child domain don't have appropriate permissions to enroll. Even when they do, the CA doesn't have the access permissions to publish the certificate to Active Directory.

    By default, only domain users from the same domain as the CA have enroll permissions.

    By default, the CA has the following necessary permissions granted on users within its domain:

  - Read `userCertificate`.
  - Write `userCertificate`.
  
    The CA in the parent domain doesn't have permissions to the `userCertificate` property on the users in the child domain.

- For [Scenario 2](#scenario-2): single-level domain or parent domain

    By default in Windows, the AdminSDHolder object does not grant the Cert Publishers group the necessary permissions for user accounts that are covered under the AdminSDHolder process. The following list contains the protected user account groups in Windows:

  - Enterprise Admins
  - Schema Admins
  - Domain Admins
  - Administrators

    After you apply the hotfix [KB327825](https://support.microsoft.com/help/327825), the following list of user account groups in Windows are now protected user account groups:

  - Administrators
  - Account Operators
  - Server Operators
  - Print Operators
  - Backup Operators
  - Domain Admins
  - Schema Admins
  - Enterprise Admins
  - Cert Publishers

## Resolution

Try the following resolution according to your scenario.

### For [Scenario 1](#scenario-1): two-level domain hierarchy

To enable the child domain users to obtain certificates and have them published to Active Directory, follow these steps:

1. Set the permissions on the CA's template to allow enrollment requests. Set the user object permissions to allow the CA to publish the certificate. Alter AdminSDHolder to push the user object permissions to users who are administrators.

2. Set the user object permissions to allow the CA to publish the certificate. Alter AdminSDHolder to push the user object permissions to users who are administrators.

3. Alter AdminSDHolder to push the user object permissions to users who are administrators.

> [!NOTE]
> You must first install Support Tools from the Windows Professional, or Windows Server CD-ROM.

#### Enable the child domain users to obtain certificates and have them published to Active Directory

1. Set permissions on the CA to allow users in the child domain to request a certificate. By default, it should be in place.
  
    1. Open the Certification Authority snap-in, right-click the CA, and then select **Properties**.
    2. On the **Security** tab, make sure that the Authenticated Users group is allowed to request certificates.

2. Set permissions on the applicable certificate templates to allow users in the child domain to enroll.

    > [!NOTE]
    > You must be logged on to the root domain with domain administrator rights.
  
    1. Open the Active Directory Sites and Services snap-in.
    2. Select **View**, and then select **Show Services Node**.
    3. Expand the **Services Node** folder, expand **Public Key Services**, and then select **Certificate Templates**.
    4. In the **Details** pane, select the desired template, or templates. For example, right-click the **User certificate** template, and then select **Properties**.
    5. On the **Security** tab, grant enroll permissions to the desired group, such as Authenticated Users.

3. Configure the CA Exit Module to publish certificates to Active Directory.
  
    1. In the Certification Authority snap-in, right-click the CA, and then select **Properties**.
    2. On the **Exit Module** tab, select **Configure**.
    3. In the properties for the Exit Module, select the **Allow certificates to be published in the Active Directory** box.

    On the child domain controller:

    > [!NOTE]
    > In Windows Server domains, the Cert Publishers group is a Domain Global group. You must manually add the Cert Publishers group to each child domain.

    You can enable the child domain users to obtain certificates and to have them published in Windows Server domains. To do so, change the group type to **Domain Local**, and include the CA server from the parent domain. This procedure creates the same configuration that is present in a freshly installed Windows Server domain. The user interface (UI) does not let you change the group type. However, you can use the `dsmod` command to change the Cert Publishers group from a Domain Global group to a Domain Local group:

    ```console
    dsmod group Group Distinguished Name -scope l
    ```

    In some cases, you cannot change groupType directly from global to domain local group. In this case, you have to change the global group into a universal group and change the universal group into a domain local group. To do so, follow these steps:

    1. Type the following command, and then press ENTER:

        ```console
        dsmod group Group Distinguished Name -scope u
        ```

        This command changes the global group into a universal group.

    2. Type the following command, and then press ENTER:

        ```console
        dsmod group Group Distinguished Name -scope l
        ```

        This command changes the universal group into a domain local group.

### For [Scenario 2](#scenario-2): single-level domain or parent domain

On the single-level domain controller or on the parent domain controller, run the following two commands, keeping the quotation marks:

```console
dsacls "cn=adminsdholder,cn=system, dc=<your domain>,dc=<com>" /G "<CA's domain> \Cert Publishers:WP;userCertificate"
dsacls "cn=adminsdholder,cn=system, dc=<your domain>,dc=<com>" /G "<CA's domain> \Cert Publishers:RP;userCertificate"
```

Where dc=\<your domain>,dc=\<com> is the distinguished name (DN) of your child domain. Where \<CA's domain> is the domain name that the CA is located.

## Status

Microsoft has confirmed that it's a problem in Windows Server.  

## More information

When a user from a child domain doesn't succeed in enrolling, the following error is generated in the CA application event log:

> Event Type: Warning  
> Event Source: CertSvc  
> Event Category: None  
> Event ID: 53  
> Date: 08/14/2000  
> Time: 05:13:00  
> User: N/A  
> Computer: \<Root CA name>  
> Description:  
> Certificate Services denied request \<request #> because Access is denied.  
> 0x80070005 (WIN32: 5). The request was for (Unknown Subject). Additional
information: Denied by Policy Module

If the ACLs are set so that the user can enroll, but the CA doesn't have permissions to publish to the user's Active Directory, the following error is generated in the CA application event log:

> Event Type: Error  
> Event Source: CertSvc  
> Event Category: None  
> Event ID: 46  
> Date: 08/14/2000  
> Time: 05:13:00  
> User: N/A  
> Computer: \<Root CA name>  
> Description:  
> The "Enterprise and Stand-alone Exit Module" Exit Module "Notify" method
returned an error. Access is denied. The returned status code is
0x80070005 (5). The Certification Authority was unable to publish the
certificate for Child\User to the Directory Service. Access is denied.  
> (0x80070005)
