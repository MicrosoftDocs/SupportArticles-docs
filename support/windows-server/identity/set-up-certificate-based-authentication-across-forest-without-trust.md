---
title: How to set up certificate-based authentication across forests without trust for a web server
description: Describes how to configure a web server and Active Directory to use certificate authentication across forests without using forest trusts.
ms.date: 12/07/2020
ms.prod-support-area-path:  Windows Servers\Windows Server 2016\Windows Server 2016\Certificates and Public Key Infrastructure\Certificate-based authenticationWindows Servers\Windows Server 2016\Windows Server 2016 Datacenter\Certificates and Public Key Infrastructure\Certificate-based authenticationWindows Servers\Windows Server 2016\Windows Server 2016 Essentials\Certificates and Public Key Infrastructure\Certificate-based authenticationWindows Servers\Windows Server 2016\Windows Server 2016 Standard\Certificates and Public Key Infrastructure\Certificate-based authenticationWindows Servers\Windows Server 2019, all versions\Certificates and Public Key Infrastructure\Certificate-based authentication
ms.technology: [Replace with your value]
ms.reviewer: 
---
# How to set up certificate-based authentication across forests without trust for a web server

_Original product version:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4509680

## Summary

This article describes how to set up a web server to use smart cards for cross-forest certificate-based authentication when the user forests and the resource forest do not trust one another.

## Configuration

Consider an environment that uses the following configuration:
- A user forest that is named Contoso.com
- A resource forest that is named Fabrikam.com. The forest has Tailspin.com added as an alternate User Principal Name (UPN).
- There is no trust between the two forests.
- User smart cards use certificates that have Subject Alternative Name (SAN) entries of the format user@tailspin.com
- An IIS web server that is configured for Active Directory Certificate Based Authentication.
Configure Active Directory and the web server as described in the following procedures.

### Configure Active Directory

To configure the resource forest to authenticate smart cards:
1. Make sure that a Kerberos Authentication Certificate that has a KDC Authentication extended key usage (EKU) has been issued to the domain controllers.
2. Make sure that the Issuing CA certificate of the user's certificate is installed in the Enterprise NTAUTH store.

To publish the Issuing CA certificate in the domain, run the following command at a command prompt:certutil -dspublish -f <filename> NTAUTHCA
Note
In this command, <filename> represents the name of the CA certificate file, which has a .cer extension.

3. Users must have accounts that use the alternate UPN of the resource forest.
![User Properties](/media/4511146_en_1.png)

To configure the user forest, follow these steps:
1. Make sure that you have Smart Card Logon and Client Authentication EKU defined in the certificate.
2. Make sure that the SAN of the certificate uses the UPN of the user.
![SAN of the certificate](/media/4511147_en_1.png)

3. Make sure that you install the Issuing CA Certificate of the user certificate in the Enterprise NTAUTH store.
Note
If you want to set up delegation on the front end server or want to skip using the UPN in the SAN attribute of the certificate (AltSecID route), see the More information section.

### Configure the web server

To configure the IIS Web server in the resource forest:
1. Install the IIS Web server role, and select the **Client Certificate Mapping Authentication Security** feature.
![Select server roles](/media/4511148_en_1.png)

2. On the IIS Web server, enable **Active Directory Client Certificate Authentication**.
![IIS configuration](/media/4511149_en_1.png)

3. On your website, configure **SSL** **Settings** to **Require SSL**  and then under **Client certificates**, select **Require**.
![SSL Settings](/media/4511150_en_1.png)

Note
Make sure that no other authentication type is enabled on the website. We don't recommend enabling Certificate Based Authentication with any other authentication type because the DS Mapper service, which is responsible for mapping the user's presented certificate to the user account in Active Directory, is designed to only work with the **Active Directory Client Certificate Authentication** type. If you enable Anonymous Authentication, you may experience unexpected outcomes.  
![Other authentication types](/media/4511151_en_1.png)

## More information

If you want to set up delegation on this resource web server to query a backend server, such as a database server or a CA, you may also configure constrained delegation by using a custom service account. Additionally, you must set up the web server for constrained delegation (S4U2Self) or protocol transition. For more information, see [KB4494313, How to configure Kerberos Constrained Delegation (S4U2Proxy or Kerberos Only) on a custom service account for Web Enrollment proxy pages](https://support.microsoft.com/help/4494313/configuring-web-enrollment-proxy-for-s4u2proxy-constrained-delegation).
If you want to skip the UPN in the SAN attribute of the user smart card certificate, you have to either explicitly map by using [AltSecID attributes](https://docs.microsoft.com/previous-versions/dotnet/articles/bb905527%28v=msdn.10%29#BKMK_ClientCertificate.), or use [name hints](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff404287%28v=ws.10%29).
Note
We do not recommend this approach to configuring smart card certificates.

If you publish the SAN attribute as the intended UPN in the user's certificate, you should not enable AltSecID.
To check the NTAuth store on the web server, open a Command Prompt window and run the following command:Certutil -viewstore -enterprise NTAUTH

## References

[Prepare a non-routable domain for directory synchronization](https://docs.microsoft.com/office365/enterprise/prepare-a-non-routable-domain-for-directory-synchronization) 
 [How to import Third Party CA Certificates](https://support.microsoft.com/en-in/help/295663/how-to-import-third-party-certification-authority-ca-certificates-into) 
 [Complete list of changes to make to activate Client Certificate Mapping on IIS using Active Directory](https://docs.microsoft.com/archive/blogs/friis/the-complete-list-of-changes-to-make-to-activate-client-certificate-mapping-on-iis-using-active-directory) 
 [How Smart Card Sign-in Works in Windows](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows%2Fsecurity%2Fidentity-protection%2Fsmart-cards%2Fsmart-card-how-smart-card-sign-in-works-in-windows&data=02%7C01%7Cdelhan%40microsoft.com%7Cda7b30a76a2d4b01e60e08d6fc113c0f%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636973548337185573&sdata=MKQDc3cSHj5MqwsFNz4wYTXUIKlnF7VO3MLVcz9hi%2F8%3D&reserved=0) 
 [User Security Attributes](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows%2Fdesktop%2Fad%2Fsecurity-properties&data=02%7C01%7Cdelhan%40microsoft.com%7Cda7b30a76a2d4b01e60e08d6fc113c0f%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636973548337185573&sdata=OuJx5ca%2BFNEamXjjWngtrYSTbXO5jkW7zF5Iw6c4Nts%3D&reserved=0) 
 [HowTo: Map a user to a certificate via all the methods available in the altSecurityIdentities attribute](https://docs.microsoft.com/archive/blogs/spatdsg/howto-map-a-user-to-a-certificate-via-all-the-methods-available-in-the-altsecurityidentities-attribute)
