---
title: Enable SSL for all customers
description: This article introduces how to enable SSL for all customers who interact with your Web site in IIS.
ms.date: 03/24/2020
ms.custom: sap:WWW administration and management
ms.topic: how-to
ms.technology: www-administration-management
---
# Enable SSL for all customers who interact with your Web site in IIS

This article describes how to enable Secure Sockets Layer (SSL) for  all customers who interact with your Web site in Microsoft Internet Information Services  (IIS).

_Original product version:_ &nbsp;  Internet Information Services  
_Original KB number:_ &nbsp; 298805

## Summary

This article contains the following topics:

- How to set up and enable server certificates so that your customers can be certain that your Web site is valid, and that any information that they send to you stays private and confidential.
- How to use third-party certificates to enable Secure Sockets Layer (SSL), as well as a general overview of the process that is used to generate a Certificate Signing Request (CSR), which is used to obtain a third-party certificate.
- How to enable SSL connectivity for your Web site.
- How to enforce SSL for all connections, and set the required encryption length between your clients and your Web site.

You can use your Web server's SSL security features for two types of authentication. You can use a *server certificate* to allow users to authenticate your Web site before they transmit personal information, such as a credit card number. Also, you can use *client certificates* to authenticate users that request information on your Web site.

This article assumes that you will use a third-party certificate authority (CA) to provide authentication for your Web server.

To enable SSL server certificate verification, and to provide the level of security that your customers desire, you should obtain a certificate from a third-party CA. Certificates that are issued to your organization by a third-party CA are typically tied to the Web server, and more specifically to the Web site to which you to bind SSL. You can create your own certificate with the IIS server, but if you do so, your clients must implicitly trust you as the certificate authority.

This article assumes the following:

- You have installed IIS.
- You have created and published the Web site that you wish to secure with SSL.

## Obtain a certificate

To begin the process to obtain the certificate, you must generate a CSR. You do this through the IIS management console; therefore, IIS must be installed before you can generate a CSR. A CSR is basically a certificate that you generate on your server that validates the computer-specific information about your server when you request a certificate from a third-party CA. The CSR is simply an encrypted text message that is encrypted with a public/private key pair.

Typically, the following information about your computer is included in the CSR that you generate:

- Organization
- Organizational unit
- Country/region
- State/province
- City/locality
- Common name

> [!NOTE]
> The common name is usually comprised of your host computer name and the domain to which it belongs, such as *xyz.com*. In this case, the computer is part of the .com domain, and is named *XYZ*. This may be the root server for your corporate domain, or simply a Web site.

### Generate the CSR

1. Access the IIS Microsoft Management Console (MMC). To do this, right-click **My Computer** and select **Manage**. This opens the Computer Management Console. Expand the **Services and Application** section. Locate IIS and expand the IIS console.
2. Select the specific Web site on which you want to install a server certificate. Right-click the site and select **Properties**.
3. Select the **Directory Security** tab. In the **Secure Communication** section, select **Server Certificate**. This starts the Web Server Certificate Wizard. Select **Next**.
4. Select **Create a New Certificate** and select **Next**.
5. Select **Prepare the request now**, but send it later and select **Next**.
6. In the **Name** field, enter a name that you can remember. It will default to the name of the Web site for which you're generating the CSR.

    > [!NOTE]
    > When you generate the CSR, you need to specify a bit length. The bit length of the encryption key determines the strength of the encrypted certificate which you send to the third-party CA. The higher the bit length, the stronger the encryption. Most third-party CAs prefer a minimum of 1024 bits.

7. In the **Organization Information** section, enter your organization and organizational unit information. This must be accurate, because you are presenting these credentials to a third-party CA and you must comply with their licensing of the certificate. Select **Next** to access the **Your Site's Common Name** section.
8. The **Your Site's Common Name** section is responsible for binding the certificate to your Web site. For SSL certificates, enter the host computer name with the domain name. For Intranet servers, you may use the NetBIOS name of the computer that is hosting the site. Select **Next** to access geographical information.
9. Enter your country or region, state or province, and city or locality information. Completely spell out your state or province and city or locality. And don't use abbreviations. Select **Next**.
10. Save the file as a .txt file.
11. Confirm your request details. Select **Next** to finish, and exit the Web Server Certificate Wizard.

## Request the certificate

There are different methods of submitting your request. Contact the certificate provider of your choice for the method to use and to determine the best certificate level for your needs. Depending on the method that is chosen for sending your request to the CA, you may send the CSR file from step 10 in the [Generate the CSR](#generate-the-csr) section, or you may have to paste the contents of this file into the request. This file will be encrypted and will contain a header and a footer for the contents. You must include both the header and the footer when you request the certificate. Your CSR should resemble the following:

```console
-----BEGIN NEW CERTIFICATE REQUEST-----
MIIDATCCAmoCAQAwbDEOMAwGA1UEAxMFcGxhbjgxDDAKBgNVBAsTA1BTUzESMBAG
A1UEChMJTWljcm9zb2Z0MRIwEAYDVQQHEwlDaGFybG90dGUxFzAVBgNVBAgTDk5v
cnRoIENhcm9saW5hMQswCQYDVQQGEwJVUzCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEAtW1koGfdt+EoJbKdxUZ+5vE7TF1ZuT+xaK9jEWHESfw11zoRKrHzHN0f
IASnwg3vZ0ACteQy5SiWmFaJeJ4k7YaKUb6chZXG3GqL4YiSKFaLpJX+YRiKMtmI
JzFzict5GVVGHsa1lY0BDYDO2XOAlstGlHCtENHOKpzdYdANRg0CAwEAAaCCAVMw
GgYKKwYBBAGCNw0CAzEMFgo1LjAuMjE5NS4yMDUGCisGAQQBgjcCAQ4xJzAlMA4G
A1UdDwEB/wQEAwIE8DATBgNVHSUEDDAKBggrBgEFBQcDATCB/QYKKwYBBAGCNw0C
AjGB7jCB6wIBAR5aAE0AaQBjAHIAbwBzAG8AZgB0ACAAUgBTAEEAIABTAEMAaABh
AG4AbgBlAGwAIABDAHIAeQBwAHQAbwBnAHIAYQBwAGgAaQBjACAAUAByAG8AdgBp
AGQAZQByA4GJAGKa0jzBn8fkxScrWsdnU2eUJOMUK5Ms87Q+fjP1/pWN3PJnH7x8
MBc5isFCjww6YnIjD8c3OfYfjkmWc048ZuGoH7ZoD6YNfv/SfAvQmr90eGmKOFFi
TD+hl1hM08gu2oxFU7mCvfTQ/2IbXP7KYFGEqaJ6wn0Z5yLOByPqblQZAAAAAAAA
AAAwDQYJKoZIhvcNAQEFBQADgYEAhpzNy+aMNHAmGUXQT6PKxWpaxDSjf4nBmo7o
MhfC7CIvR0McCQ+CBwuLzD+UJxl+kjgb+qwcOUkGX2PCZ7tOWzcXWNmn/4YHQl0M
GEXu0w67sVc2R9DlsHDNzeXLIOmjUl935qy1uoIR4V5C48YNsF4ejlgjeCFsbCoj
Jb9/2RM=
-----END NEW CERTIFICATE REQUEST-----
```

## Install the certificate

Once the third-party CA has completed your request for a server certificate, you will receive it by email or download site. The certificate must be installed on the Web site on which you want to provide secure communications.

To install the certificate, follow these steps:

1. Download or copy the certificate that you obtained from the CA to the Web server.
2. Open the IIS MMC as described in the **Generating the CSR** section.
3. Access the **Properties** dialog box for the Web site on which you are installing the certificate.
4. Select the **Directory Security** tab, and then select **Server Certificate**. This starts the Web Server Certificate Wizard. Select **Next**.
5. Select **Process the Pending Request and install the certificate**, and then select **Next**.
6. Browse to the location of the certificate that you saved in step 1. Select **Next** twice, and then select **Finish**.

## Enforce SSL connections

Now that the server certificate is installed, you can enforce SSL secure channel communications with clients of the Web server. First, you need to enable port 443 for secure communications with the Web site. To do this, follow these steps:

1. From the Computer Management console, right-click the Web site on which you want to enforce SSL and select **Properties**.
2. Select the **Web Site** tab. In the Web Site **Identification** section, verify that the SSL Port field is populated with the numeric value 443.
3. Select **Advanced**. You should see two fields. The IP address and port of the Web site should already be listed in the **Multiple identities** for this web site field. Under the **Multiple SSL Identities** for this web site field, select **Add** if port 443 isn't already listed. Select the server's IP address, and type the numeric value *443* in the SSL Port field. Select **OK**.

Now that port 443 is enabled, you can enforce SSL connections. To do this, follow these steps:

1. Select the **Directory Security** tab. In the **Secure Communication** section, **Edit** is now available. Select **Edit**.
2. Select **Require Secure Channel (SSL)**.

    > [!NOTE]
    > If you specify 128-bit encryption, clients who use 40-bit or 56-bit strength browser will not be able to communicate with your site unless they upgrade their encryption strength.
3. Open your browser and try to connect to your Web server by using the standard *http://* protocol. If SSL is being enforced, you receive the following error message:  

    > The page must be viewed over a secure channel  
    > The page you are trying to view requires the use of 'https' in the address.  
    > Please try the following: Try again by typing https:// at the beginning of the address you are attempting to reach. HTTP 403.4 - Forbidden: SSL required Internet Information Services  
    > Technical Information (for support personnel) Background: This error indicates that the page you are trying to access is secured with Secure Sockets Layer (SSL).

You can now connect to your Web site only by using the *https://* protocol.
