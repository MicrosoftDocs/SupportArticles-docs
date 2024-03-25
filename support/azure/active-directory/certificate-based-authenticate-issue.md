---
title: Troubleshoot Microsoft Entra Certificate-Based Authentication issues
description: Provides information to help you troubleshoot Certificate-Based Authentication issues in Microsoft Entra ID.
ms.date: 05/22/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: users
ms.custom: has-azure-ad-ps-ref
---
# Troubleshoot Microsoft Entra Certificate-Based Authentication issues

The Certificate-Based Authentication feature in Microsoft Entra ID for iOS or Android devices allows Single Sign-On (SSO) by using X.509 certificates. By enabling this feature, you can log in to accounts or services without having to enter a user name and password when you connect to your Exchange Online account or Office mobile applications.

This article provides information to help you troubleshoot Certificate-Based Authentication issues.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 4032987

## General requirements

- Certificate-Based Authentication supports only Federated environments by using Modern Authentication (ADAL). The one exception is Exchange ActiveSync (EAS) for Exchange Online that can be used by Managed Accounts.
- The user certificate that's issued in the user's profile requires the user's routable email address to be listed in the **Subject Alternative Name**. This can be in either the UserPrincipalName or RFC822 format. Microsoft Entra ID maps the RFC822 value to the **Proxy Address** attribute in the directory.

## Determine if Certificate-Based Authentication works on Azure portal

1. Browse to the [Azure portal](https://portal.office.com) from the device for testing the Certificate-Based Authentication.

    > [!NOTE]
    > The browser cache must be cleared before you try the connection in order for the user to see the certificate approval prompt.

2. Type the user's email address. This redirects to the ADFS authentication page.
3. Instead of typing a password (if the forms-based authentication method is enabled in ADFS), select **Sign in using an X.509 certificate**, and approve the use of the client certificate when you are prompted.

    If no certificate approval prompt is received after you clear the browser cache on a device, follow these steps:

    1. Verify that the user certificate and the issuing certificate authority root certificates are installed on the device.
    2. Verify that TCP port 49443 is open on the ADFS/Web Application Proxy servers, and that the certificate chain of the issuing certificate authority is installed on all ADFS/Web Application Proxy servers.

<a name='determine-if-azure-ad-is-correctly-configured'></a>

## Determine if Microsoft Entra ID is correctly configured

1. Run the following PowerShell command to Install the Azure Active Directory PowerShell (Preview) module:

    ```powershell
    Install-Module AzureAD
    ```

2. To create a trusted certificate authority, use the [New-AzureADTrustedCertificateAuthority](/powershell/module/azuread/new-azureadtrustedcertificateauthority?view=azureadps-2.0&preserve-view=true) cmdlet, and set the **crlDistributionPoint** attribute to a correct value.

    > [!NOTE]
    > When you create the **TrustedRootCertificateAuthority** objects in Microsoft Entra ID, the CRL URLs that are defined within the .CER file are not used. The **CrlDistributionPoint** and **DeltaCrlDistributionPoint** values must be manually populated by a web location where Microsoft Entra ID can access the CRLs. The CRL paths within the issued certificates do not have to contain the URLs that are accessible to Microsoft Entra ID. Also, large CRLs that take more than 15 seconds to download should be put on a faster link, such as Azure Storage, to avoid caching delays that can cause intermediate authentication failures.

    ```powershell
    $cert=Get-Content -Encoding byte "[LOCATION OF THE CER FILE]"
    $new_ca=New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation $new_ca.AuthorityType=0 $new_ca.TrustedCertificate=$cert
    $new_ca.crlDistributionPoint="<CRL Distribution URL>"
    New-AzureADTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca
    ```

3. Make sure that the following values are correctly defined on the **TrustedCertificateAuthority** objects according to the following guidelines:
   - All **CrlDistributionPoint** and **DeltaCrlDistributionPoint** URLs must be accessible from the Internet by the client devices and the ADFS and Web Application Proxy servers.
   - The *.CER for the Root CA should be listed as **AuthorityType = RootAuthority**.
   - The *.CER for the Intermediate CA should be listed as follows:

        AuthorityType = IntermediateAuthority  
        AuthorityType = 0 = RootAuthority  
        AuthorityType = 1 = IntermediateAuthority
    > [!NOTE]
    > To make changes to these objects, see [Configure the certificate authorities](/azure/active-directory/authentication/active-directory-certificate-based-authentication-get-started#step-2-configure-the-certificate-authorities).

4. Run the following commands to make sure that the ADFS settings are not set to **PromptLoginBehavior: true**. Otherwise, users will be prompted to enter their user name and password for some modern apps.

    ```powershell
    Connect-msolService
    ```

    ```powershell
     Get-MSOLDomainFederationSettings -DomainName contoso.com
    ```

    > [!NOTE]
    > This occurs because some modern apps send _prompt=login_ to Microsoft Entra ID in their request. Microsoft Entra ID translates this in the ADFS request to **wauth=usernamepassworduri** (this tells ADFS to do username/password authentication) and **wfresh=0** (tells ADFS to ignore the SSO state and do a fresh authentication). If users have to use Certificate Based Authentication, the **PromptLoginBehavior** must be set to **False**.

    To disable **PromptLoginBehavior** on the Microsoft Entra domain, run the following command:

    ```powershell
    Set-MSOLDomainFederationSettings -domainname <domain> -PromptLoginBehavior Disabled
    ```

## Determine if the ADFS and Web Application Proxy configurations are configured correctly

1. Certificate-Based Authentication requires ADFS 2012R2 or a later version, and it must use Web Application Proxy.

    > [!NOTE]
    > Using a third-party Web Application Proxy is not supported unless it supports all the MUSTs in the [MS-ADFSPIP protocol document](/openspecs/windows_protocols/ms-adfspip/76deccb1-1429-4c80-8349-d38e61da5cbb).

2. The Root `*.CER` file must be in the computer's **Trusted Root Certificate Authority\Certificates** container. Also, all Intermediate `*.CER` files must be in the computer's **Intermediate Root Certificate Authority\Certificates** container. You can verify this by running `certlm.msc` or by running the following `certutil.exe` commands at an elevated command prompt:

    ```console
    certutil -verifystore root
    ```

    ```console
    certutil -verifystore CA**
    ```

3. The client devices, the ADFS servers, and the Web Application Proxy must be able to resolve the CRL endpoints that exist on the Intermediate CA *.CER and on the user certificates that were issued to the user profile on the devices.

    To verify that the ADFS servers and the Web Application Proxy can resolve these, follow these steps:

    1. Export the Intermediate CA *.CER:
        1. View the computer certificate store. To do this, run **certlm.msc**, expand **\Intermediate Certification Authorities\Certificates**, and then double-click the Intermediate CA certificate.
        2. Click the **Details** tab, and then click the **Copy to file** button.
        3. Click **Next** two times and accept all the defaults in the wizard.
        4. Specify a file name and location, click **Next**, and then click **Finish**.
    2. On the issuing CA, export one of the user certificates that was issued to a device. To do this, follow these steps:  
        1. Run **certsrv.msc**, and then select the **Issued Certificates** node.
        2. In the **Issued Common Name** column, locate the certificate that was issued to the user who cannot connect.
        3. Double-click the certificate, and then click the **Details**  tab to export the certificate to a *.CER file.
            > [!NOTE]
            > If more than one certificate is issued to the user, locate the serial number for the certificate on the **Details**  tab, and verify that it matches the certificate on the device.
        4. Download [PSEXEC.EXE](https://technet.microsoft.com/sysinternals/pxexec.aspx), and then copy psexec.exe together with the *.CER files from the Intermediate CA and user to all ADFS and Web Application Proxy servers.
        5. Open a new command prompt in the SYSTEM security context. To do this, open an elevated command prompt for each server, and then run the following command:

            ```console
            psexec -s -i -d cmd.exe
            ```

        6. At the new command prompt, run the following commands to determine whether the CRL can be accessed:

            ```console
            certutil.exe -verify -urlfetch SubCA.cer > %computername%_%username%_SubCA.txt
            ```

            ```console
            certutil.exe -verify -urlfetch usercert.cer > %computername%_%username%_usercert.txt
            ```

        7. In the output, check the **---------------- Certificate CDP ----------------** section, and determine whether all endpoints can be resolved.
        8. If the ADFS servers cannot resolve the HTTP URL, make sure that the Group Managed Service Accounts that ADFS is running under has access through the firewall and proxy. The Web Application Proxy service runs under Network Service, so the **ComputerName$** account requires access through the firewall and proxy.
4. Pass Through Claims for **serialNumber** and **issuer** must be configured for the **Active Directory** Claims Provider Trust and for the **Microsoft Office 365 Identity Platform** Relying Party Trust. These can be retrieved from the ADFS servers by running the following PowerShell commands at an elevated prompt:

    ```powershell
    Get-AdfsClaimsProviderTrust -Name "Active Directory"
    @RuleTemplate = "PassThroughClaims"
    @RuleName = "<serialnumber AD for cert based auth>"
    c:[Type ==
    http://schemas.microsoft.com/ws/2008/06/identity/claims/serialnumber]
      => issue(claim = c);
    @RuleTemplate = "PassThroughClaims"
    @RuleName = "<Issuer AD for cert based auth>"
    c:[Type ==
    http://schemas.microsoft.com/2012/12/certificatecontext/field/issuer]
      => issue(claim = c);
    ```

    ```powershell
    Get-AdfsRelyingPartyTrust -Name "Microsoft Office 365 Identity Platform"
    @RuleTemplate = "PassThroughClaims"
    @RuleName = "<serialnumber RP for cert based auth>"
    c:[Type ==
    http://schemas.microsoft.com/ws/2008/06/identity/claims/serialnumber]
      => issue(claim = c);
    @RuleTemplate = "PassThroughClaims"
    @RuleName = "<Issuer RP for cert based auth>"
    c:[Type ==
    http://schemas.microsoft.com/2012/12/certificatecontext/field/issuer]
      => issue(claim = c);
    ```

5. Because most devices that use certificate authentication are likely to be located on the extranet (out of the corporate network), you could enable Certificate-Based Authentication only for the extranet or also for the Intranet, as necessary. To determine whether the "Certificate Authentication" method is enabled for either or both options, run the following cmdlet from an elevated PowerShell command prompt:

    ```powershell
    Get-AdfsAuthenticationProvider:
  
    ----------Output sample----------

    AdminName                          : Certificate Authentication
    AllowedForPrimaryExtranet          : True
    AllowedForPrimaryIntranet          : True
    AllowedForAdditionalAuthentication : True
    AuthenticationMethods              : {urn:ietf:rfc:2246, urn:oasis:names:tc:SAML:1.0:am:X509-PKI,
                                         urn:oasis:names:tc:SAML:2.0:ac:classes:TLSClient,
                                         urn:oasis:names:tc:SAML:2.0:ac:classes:X509...}
    Descriptions                       : {}
    DisplayNames                       : {}
    Name                               : CertificateAuthentication
    IdentityClaims                     : {}
    IsCustom                           : False
    RequiresIdentity                   : False
    ```

    1. Locate the **AdminName** entry that is named **Certificate Authentication**.
    2. Verify that **AllowedForPrimaryExtranet** is set to **True.**  
    3. Optionally, you can also set **AllowedForPrimaryIntranet** to **True** if you want Certificate-Based Authentication from Intranet users.
    4. Click the **Details** tab, and then click the **Copy to file** button.

6. TCP port 49443 must be accessible between the client device and ADFS,  also between the client device and Web Application Proxy servers. To verify that TCP 49443 is listening and bound to ADFS on the ADFS servers and Web Application Proxy, run the following command:

    ```console
    netsh http show urlacl > %computername%_49443.txt
    ```

    If the TCP port 49443  is accessible, you should see output such as the following:

    ```console
    Reserved URL: https://<URL>:49443/adfs/
    User: NT SERVICE\adfssrv
    Listen: Yes
    Delegate: Yes
    SDDL: D:(A;;GA;;;S-1-5-80-2246541699-21809830-3603976364-117610243-975697593)
    ```

7. On a client device, try to connect to the CertificateTransport endpoint. For example, use the following URL for `Contoso.com`:

    `https://sts.contoso.com:49443/adfs/services/trust/2005/certificatetransport`

    > [!NOTE]
    > If the endpoint is accessible and listening, the connection attempt should spin indefinitely while it waits for an answer.

## More information

- [Microsoft Entra ID: Certificate based authentication for iOS and Android now in preview.](https://techcommunity.microsoft.com/t5/azure-active-directory-identity/azuread-certificate-based-authentication-for-ios-and-android-now/ba-p/244999)
- [Get started with certificate based authentication on iOS - Public Preview](/azure/active-directory/authentication/active-directory-certificate-based-authentication-ios)
- [ADFS: Certificate Authentication with Microsoft Entra ID & Office 365](/archive/blogs/samueld/adfs-certauth-aad-o365)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
