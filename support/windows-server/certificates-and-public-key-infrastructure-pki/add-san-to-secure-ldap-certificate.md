---
title: Add SAN to secure Lightweight Directory Access Protocol (LDAP) certificate
description: Describes how to add a subject alternative name to a secure LDAP certificate.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Certificate Enrollment Technologies (Auto Enrollment, NDES, CWE, CEP, CES), csstroubleshoot
---
# Add a subject alternative name to a secure LDAP certificate

This article describes how to add a subject alternative name (SAN) to a secure Lightweight Directory Access Protocol (LDAP) certificate.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 931351

## Summary

The LDAP certificate is submitted to a certification authority (CA) that is configured on a Windows Server 2003-based computer. The SAN lets you connect to a domain controller by using a Domain Name System (DNS) name other than the computer name. This article includes information about how to add SAN attributes to a certification request that's submitted to an enterprise CA, a stand-alone CA, or a third-party CA.

This article also discusses how to do the following actions:

- Configure a CA to accept a SAN attribute from a certificate request.
- Create and submit a certificate request to an enterprise CA.
- Create and submit a certificate request to a stand-alone CA.
- Create a certificate request by using the Certreq.exe tool.
- Create and submit a certificate request to a third-party CA.

## Create and submit a certificate request

When you submit a certificate request to an enterprise CA, the certificate template must be configured to use the SAN in the request instead of using information from the Active Directory directory service. The Version 1 Web Server template can be used to request a certificate that will support LDAP over the Secure Sockets Layer (SSL). Version 2 templates can be configured to retrieve the SAN either from the certificate request or from Active Directory. To issue certificates that are based on Version 2 templates, the enterprise CA must be running on a computer that is running Windows Server 2003 Enterprise Edition.

When you submit a request to a stand-alone CA, certificate templates aren't used. Therefore, the SAN must always be included in the certificate request. SAN attributes can be added to a request that is created by using the Certreq.exe program. Or, SAN attributes can be included in requests that are submitted by using the web enrollment pages.

### Use web enrollment pages to submit a certificate request to an enterprise CA

To submit a certificate request that contains a SAN to an enterprise CA, follow these steps:

1. Open Internet Explorer.
2. In Internet Explorer, connect to `http://<servername>/certsrv`.

    > [!NOTE]
    > The placeholder \<servername> represents the name of the web server that is running Windows Server 2003 and that has the CA that you want to access.

3. Click **Request a Certificate**.
4. Click **Advanced certificate request**.
5. Click **Create and submit a request to this CA**.
6. In the **Certificate Template** list, click **Web Server**.

    > [!NOTE]
    > The CA must be configured to issue web server certificates. You may have to add the Web Server template to the Certificate Templates folder in the Certification Authority snap-in if the CA is not already configured to issue web server certificates.

7. Provide identifying information as required.
8. In the **Name** box, type the fully qualified domain name of the domain controller.
9. Under **Key Options**, set the following options:

    - **Create a new key set**  
    - **CSP: Microsoft RSA SChannel Cryptographic Provider**  
    - **Key Usage: Exchange**  
    - **Key Size: 1024 - 16384**  
    - **Automatic key container name**  
    - **Store certificate in the local computer certificate store**

10. Under **Advanced Options**, set the request format to **CMC**.
11. In the **Attributes** box, type the desired SAN attributes. SAN attributes take the following form:

    `san:dns=dns.name[&dns=dns.name]`

    Multiple DNS names are separated by an ampersand (&). For example, if the name of the domain controller is `corpdc1.fabrikam.com` and the alias is `ldap.fabrikam.com`, both names must be included in the SAN attributes. The resulting attribute string is displayed as follows:

    `san:dns=corpdc1.fabrikam.com&dns=ldap.fabrikam.com`

12. Click **Submit**.
13. If you see the **Certificate Issued**  webpage, click **Install this Certificate**.

### Use web enrollment pages to submit a certificate request to a stand-alone CA

To submit a certificate request that includes a SAN to a stand-alone CA, follow these steps:

1. Open Internet Explorer.
2. In Internet Explorer, connect to `http://<servername>/certsrv`.

    > [!NOTE]
    > The placeholder \<servername> represents the name of the web server that is running Windows Server 2012 R2 and that has the CA that you want to access.

3. Click **Request a Certificate**.
4. Click **Advanced certificate request**.
5. Click **Create and submit a request to this CA**.
6. Provide identifying information as required.
7. In the **Name** box, type the fully qualified domain name of the domain controller.
8. In the **Type of Certificate Needed Server** list, click **Server Authentication Certificate**.
9. Under **Key Options**, set the following options:

    - **Create a new key set**  
    - **CSP: Microsoft RSA SChannel Cryptographic Provider**  
    - **Key Usage: Exchange**  
    - **Key Size: 1024 - 16384**  
    - **Automatic key container name**  
    - **Store certificate in the local computer certificate store**

10. Under **Advanced Options**, set the request format as **CMC**.
11. In the **Attributes** box, type the desired SAN attributes. SAN attributes take the following form:

    `san:dns=dns.name[&dns=dns.name]`

    Multiple DNS names are separated by an ampersand (&). For example, if the name of the domain controller is corpdc1.fabrikam.com and the alias is ldap.fabrikam.com, both names must be included in the SAN attributes. The resulting attribute string is displayed as follows:

    `san:dns=corpdc1.fabrikam.com&dns=ldap.fabrikam.com`

12. Click **Submit**.
13. If the CA isn't configured to issue certificates automatically, a **Certificate Pending** webpage is displayed and requests that you wait for an administrator to issue the certificate that was requested.

    To retrieve a certificate that an administrator has issued, connect to `http://<servername>/certsrv`, and then click **Check on a Pending Certificate**. Click the requested certificate, and then click **Next**.

    If the certificate was issued, the **Certificate Issued** webpage is displayed. Click **Install this Certificate** to install the certificate.

## Use Certreq.exe to create and submit a certificate request that includes a SAN

To use the Certreq.exe utility to create and submit a certificate request, follow these steps:

1. Create an .inf file that specifies the settings for the certificate request. To create an .inf file, you can use the sample code in the **Creating a RequestPolicy.inf file** section in [How to Request a Certificate With a Custom Subject Alternative Name](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff625722(v=ws.10)).

    SANs can be included in the **[Extensions]** section. For examples, see the sample .inf file.

1. Save the file as Request.inf.
1. Open a command prompt.
1. At the command prompt, type the following command, and then press ENTER:

    ```console
    certreq -new request.inf certnew.req
    ```

    This command uses the information in the Request.inf file to create a request in the format that is specified by the **RequestType** value in the .inf file. When the request is created, the public and private key pair is automatically generated and then put in a request object in the enrollment requests store on the local computer.

1. At the command prompt, type the following command, and then press ENTER:

    ```console
    certreq -submit certnew.req certnew.cer
    ```

    This command submits the certificate request to the CA. If there's more than one CA in the environment, the `-config` switch can be used in the command line to direct the request to a specific CA. If you don't use the `-config` switch, you're prompted to select the CA to which the request should be submitted.

    The `-config` switch uses the following format to refer to a specific CA:

    `computername\Certification Authority Name`

    For example, assume that the CA name is Corporate Policy CA1 and that the domain name is `corpca1.fabrikam.com`. To use the certreq command together with the `-config` switch to specify this CA, type the following command:

    ```console
    certreq -submit -config "corpca1.fabrikam.com\Corporate Policy CA1" certnew.req certnew.cer
    ```

    If this CA is an enterprise CA and if the user who submits the certificate request has Read and Enroll permissions for the template, the request is submitted. The issued certificate is saved in the Certnew.cer file. If the CA is a stand-alone CA, the certificate request will be in a pending state until it's approved by the CA administrator. The output from the certreq -submit  command contains the Request ID number of the submitted request. As soon as the certificate is approved, it can be retrieved by using the Request ID number.

1. Use the Request ID number to retrieve the certificate by running the following command:

    ```console
    certreq -retrieve RequestID certnew.cer
    ```

    You can also use the `-config` switch here to retrieve the certificate request from a specific CA. If the `-config` switch isn't used, you're prompted to select the CA from which to retrieve the certificate.

1. At the command prompt, type the following command, and then press ENTER:

    ```console
    certreq -accept certnew.cer
    ```

    After you retrieve the certificate, you must install it. This command imports the certificate into the appropriate store and then links the certificate to the private key that is created in step 4.

## Submit a certificate request to a third-party CA

If you want to submit a certificate request to a third-party CA, first use the Certreq.exe tool to create the certificate request file. You can then submit the request to the third-party CA by using whatever method is appropriate for that vendor. The third-party CA must be able to process certificate requests in the CMC format.

> [!NOTE]
> Most vendors refer to the certificate request as a Certificate Signing Request (CSR).

## References

For more information about how to enable LDAP over SSL together with a third-party certification authority, see [How to enable LDAP over SSL with a third-party certification authority](https://support.microsoft.com/help/321051).

For more information about how to request a certificate that has a custom subject alternative name, see [How to Request a Certificate With a Custom Subject Alternative Name](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff625722(v=ws.10)).

For more information about how to use certutil tasks to manage a certification authority (CA), go to the following Microsoft Developer Network (MSDN) website: [Certutil tasks for managing a Certification Authority (CA)](/previous-versions/orphan-topics/ws.10/cc772751(v=ws.10))
