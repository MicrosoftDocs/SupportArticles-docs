---
title: Error when testing access from Dynamics CRM E-mail Router
description: Describes a problem that occurs when you try to test access from the Microsoft Dynamics CRM E-mail Router. A resolution is provided.
ms.reviewer: henningp, mmaasjo
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Could not establish trust relationship for the SSL/TLS secure channel error when testing access from Dynamics CRM E-mail Router

This article provides resolutions for the issue that test access to a mailbox from Microsoft Dynamics CRM E-mail Router, you receive a **Could not establish trust relationship for the SSL/TLS secure channel** error.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 954584

## Symptoms

You configure the Microsoft Dynamics CRM E-mail Router to access a mailbox that is located on a server that is running Exchange Server 2007 or Exchange Server 2010. When you try to test access to the mailbox, you receive the following error message:

> Incoming Status: Failure - The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel. The remote certificate is invalid according to the validation procedure.

This problem occurs if you use self-signed certificates.

## Cause

This problem occurs for one or more of the following reasons:

Cause 1: The Microsoft Dynamics CRM E-mail Router uses the Microsoft .NET libraries for certificate validation. The Microsoft Dynamics CRM E-mail Router does not support self-signed certificates.

Cause 2: The URL that you have specified on your Incoming Profile in the Microsoft Dynamics CRM E-mail Router does not match the URL that you have on your Microsoft Exchange Web Site Certificate.

## Resolution 1

Implement a signed certificate on the server that is running Exchange Server 2007 or Exchange Server 2010.

## Resolution 2

Verify the URL that you have specified on your Incoming Profile in the Microsoft Dynamics CRM E-mail Router matches the URL that you have on your Microsoft Exchange Web Site Certificate.

To verify the URL you have specified for the Incoming Profile for the Microsoft Dynamics CRM E-mail Router, complete the following steps on the machine where the Microsoft Dynamics CRM E-mail Router is installed:

1. Select **Start**, select **All programs**, select **Microsoft Dynamics CRM E-mail Router**, and then select **Microsoft CRM Email Router.exe**.
2. Select the **Configuration Profiles** tab, open the **Incoming Profile**, and then note the URL in the **Server** field.

> [!NOTE]
> To verify your certificate, copy this URL and paste it into an Internet Explorer browser. The certificate is valid if you do not get any errors or warnings.

To check which URL you have on your certificate, follow these steps on your Windows 2008 Microsoft Exchange Server:

1. Select **Start**, select **Run**, type *Inetmgr*, and then select **OK**.
2. Select your server and then select **Server Certificates** in the **Preview Pane**.
3. Open the certificate that is being used for your Microsoft Exchange Server.
4. Note the URL that is specified on **Certificate**. Verify that it matches the URL that is specified on your Incoming Profile in the Microsoft Dynamics CRM E-mail Router you found in step 2 above.

To check which URL you have on your certificate, follow these steps on your Windows 2003 Microsoft Exchange Server:

1. Select **Start**, select **Run**, type *Inetmgr*, and then select **OK**.
2. Locate your Exchange Web Site.
3. Right-click your Exchange Web Site, and then select **Properties**.
4. Select the **Directory Security** tab, select **View Certificate**, and then note the URL that is specified on **Certificate**. Verify that it matches the URL that is specified on your Incoming Profile in the Microsoft Dynamics CRM E-mail Router you found in step 2 above.

## More information

There are three primary types of digital certificates that are described as follows:

- Self-signed certificates: A self-signed certificate is signed by an application. The subject of the certificate matches the name of the certificate. The issuer and the subject are defined in the certificate. By using a self-signed certificate, some client protocols can use Secure Socket Layer (SSL) for communications.
- Windows PKI-generated certificates: A public key infrastructure (PKI) is a system of digital certificates, certification authorities, and registration authorities. The PKI uses public key cryptography to verify and authenticate the validity of each party that is used in an electronic transaction. When you implement a certification authority in an organization that uses the Active Directory directory service, you provide an infrastructure for the certificate life-cycle management, for the renewal, for the trust management, and for the revocation. However, some additional costs are required to deploy the servers and the infrastructure to create and manage Windows PKI-generated certificates. Certificate Services is required to deploy a Windows PKI. You can use the **Add or Remove Programs** item in Control Panel to install Certificate Services on any servers in the domain.

  - For more information about the PKI for Windows Server 2003, see [PKI Technologies](/previous-versions/windows/it-pro/windows-server-2003/cc779826(v=ws.10)).
  - For more information about best practices for implementing a Windows PKI, see [Best Practices for Implementing a Microsoft Windows Server 2003 Public Key Infrastructure](/previous-versions/windows/it-pro/windows-server-2003/cc772670(v=ws.10)).
  - For more information about how to deploy a Windows-based PKI, see [Windows Server 2003 PKI Operations Guide](/previous-versions/windows/it-pro/windows-server-2003/cc787594(v=ws.10)).

- Third-party certificates: Third-party certificates or commercial certificates are certificates that are generated by a third-party certification authority or by a commercial certification authority. You purchase these certificates, and then you use the certificates on servers. Client computers and mobile devices do not automatically trust self-signed certificates and Windows PKI-generated certificates. Therefore, you must import the certificates into the trusted root certificate store on client computers and on mobile devices. However, most third-party certificates or commercial certificates already exist in the trusted root certificate store. Therefore, the deployment process is simplified by using third-party certificates or commercial certificates. For larger organizations or for organizations for which you must publicly deploy certificates, using a third-party certificate or a commercial certificate may be a good solution even though you must pay for the certificate. However, third-party certificates or commercial certificates might not be a good solution for small organizations or for medium organizations. You can use the other certificate types that are available for small organizations and for medium organizations.

## References

- For more information about how to manage SSL for a client access server, see [Managing SSL for a Client Access Server](/previous-versions/office/exchange-server-2007/bb310795(v=exchg.80)).
- For more information about how to configure SSL certificates to use multiple client access server host names, see [How to Configure SSL Certificates to Use Multiple Client Access Server Host Names](/previous-versions/office/exchange-server-2007/aa995942(v=exchg.80)).
- For more information about how to install SSL certificates on a Windows mobile powered device, see [How to Install Root Certification Authority Certificates on a Windows Mobile-based Device](/previous-versions/office/exchange-server-2007/aa997575(v=exchg.80)).
- For more information about how to configure Outlook Web access virtual directories to use SSL, see [How to Configure Outlook Web Access Virtual Directories to Use SSL](/previous-versions/office/exchange-server-2007/bb123583(v=exchg.80)).
- For more information about certificates that are used in Exchange Server 2007, see [Certificate Use in Exchange Server 2007](/previous-versions/office/exchange-server-2007/bb851505(v=exchg.80)).
