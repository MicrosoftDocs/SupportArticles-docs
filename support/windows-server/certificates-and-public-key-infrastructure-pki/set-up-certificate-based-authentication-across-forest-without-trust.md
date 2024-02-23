---
title: How to set up certificate-based authentication across forests without trust for a web server
description: Describes how to configure a web server and Active Directory to use certificate authentication across forests without using forest trusts.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, wincicadsec, jitha
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# How to set up certificate-based authentication across forests without trust for a web server

This article describes how to set up a web server to use smart cards for cross-forest certificate-based authentication when the user forests and the resource forest do not trust one another.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4509680

## Environment configuration

Consider an environment that uses the following configuration:

- A user forest that is named `Contoso.com`.
- A resource forest that is named `Fabrikam.com`. The forest has `Tailspintoys.com` added as an alternate User Principal Name (UPN).
- There is no trust between the two forests.
- User smart cards use certificates that have Subject Alternative Name (SAN) entries of the format `user@tailspintoys.com`.
- An IIS web server that is configured for Active Directory Certificate Based Authentication.

Configure Active Directory and the web server as described in the following procedures.

## Configure Active Directory

To configure the resource forest to authenticate smart cards, follow these steps:

1. Make sure that a Kerberos Authentication Certificate that has a KDC Authentication extended key usage (EKU) has been issued to the domain controllers.
2. Make sure that the Issuing CA certificate of the user's certificate is installed in the Enterprise NTAUTH store.

    To publish the Issuing CA certificate in the domain, run the following command at a command prompt:

    ```console
    certutil -dspublish -f <filename> NTAUTHCA
    ```

    In this command, \<filename> represents the name of the CA certificate file, which has a .cer extension.

3. Users must have accounts that use the alternate UPN of the resource forest.

    :::image type="content" source="./media/set-up-certificate-based-authentication-across-forest-without-trust/user-account-has-alternate-upn.png" alt-text="Set the user account to use the alternate U P N of the resource forest in the Account tab of the User Properties dialog box." border="false":::

To configure the user forest, follow these steps:

1. Make sure that you have Smart Card Logon and Client Authentication EKU defined in the certificate.
2. Make sure that the SAN of the certificate uses the UPN of the user.

    :::image type="content" source="./media/set-up-certificate-based-authentication-across-forest-without-trust/verify-certificate-san-use-user-upn.png" alt-text="The S A N of the certificate is using the U P N of the user.":::

3. Make sure that you install the Issuing CA Certificate of the user certificate in the Enterprise NTAUTH store.

    > [!NOTE]
    > If you want to set up delegation on the front end server or want to skip using the UPN in the SAN attribute of the certificate (AltSecID route), see the More information section.

## Configure the web server

To configure the IIS Web server in the resource forest, follow these steps:

1. Install the IIS Web server role, and select the **Client Certificate Mapping Authentication Security** feature.

    :::image type="content" source="./media/set-up-certificate-based-authentication-across-forest-without-trust/install-iis-web-server-role.png" alt-text="Select the Client Certificate Mapping Authentication Security feature in the I I S Web server role.":::

2. On the IIS Web server, enable **Active Directory Client Certificate Authentication**.

    :::image type="content" source="./media/set-up-certificate-based-authentication-across-forest-without-trust/enable-active-directory-client-certificate-authentication.png" alt-text="Enabling the Active Directory Client Certificate Authentication.":::

3. On your website, configure **SSL Settings** to **Require SSL** and then under **Client certificates**, select **Require**.

    :::image type="content" source="./media/set-up-certificate-based-authentication-across-forest-without-trust/set-ssl-settings-to-require.png" alt-text="Setting Required SSL for your default web site.":::

    Make sure that no other authentication type is enabled on the website. We don't recommend enabling Certificate Based Authentication with any other authentication type because the DS Mapper service, which is responsible for mapping the user's presented certificate to the user account in Active Directory, is designed to only work with the **Active Directory Client Certificate Authentication** type. If you enable Anonymous Authentication, you may experience unexpected outcomes.  

    :::image type="content" source="./media/set-up-certificate-based-authentication-across-forest-without-trust/other-authentication-types.png" alt-text="Make sure other authentication types are disabled on the website.":::

## More information

If you want to set up delegation on this resource web server to query a backend server, such as a database server or a CA, you may also configure constrained delegation by using a custom service account. Additionally, you must set up the web server for constrained delegation (S4U2Self) or protocol transition. For more information, see [How to configure Kerberos Constrained Delegation for Web Enrollment proxy pages](configure-kerberos-constrained-delegation.md).

If you want to skip the UPN in the SAN attribute of the user smart card certificate, you have to either explicitly map by using [AltSecID attributes](/previous-versions/dotnet/articles/bb905527%28v=msdn.10%29#BKMK_ClientCertificate.), or use [name hints](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff404287%28v=ws.10%29).

> [!NOTE]
> We do not recommend this approach to configuring smart card certificates.

If you publish the SAN attribute as the intended UPN in the user's certificate, you should not enable AltSecID.

To check the NTAuth store on the web server, open a Command Prompt window and run the following command:

```console
Certutil -viewstore -enterprise NTAUTH
```

## References

- [Prepare a non-routable domain for directory synchronization](/microsoft-365/enterprise/prepare-a-non-routable-domain-for-directory-synchronization)

- [How to import Third Party CA Certificates](../windows-security/import-third-party-ca-to-enterprise-ntauth-store.md)

- [Complete list of changes to make to activate Client Certificate Mapping on IIS using Active Directory](/archive/blogs/friis/the-complete-list-of-changes-to-make-to-activate-client-certificate-mapping-on-iis-using-active-directory)

- [How Smart Card Sign-in Works in Windows](/windows/security/identity-protection/smart-cards/smart-card-how-smart-card-sign-in-works-in-windows)

- [User Security Attributes](/windows/win32/ad/security-properties)

- [HowTo: Map a user to a certificate via all the methods available in the altSecurityIdentities attribute](/archive/blogs/spatdsg/howto-map-a-user-to-a-certificate-via-all-the-methods-available-in-the-altsecurityidentities-attribute)
