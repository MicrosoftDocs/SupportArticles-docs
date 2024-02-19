---
title: MBAM and Secure Network Communication
description: Discusses how to configure Microsoft's BitLocker Administration and Monitoring (MBAM) with Secure Network Communication.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: manojse, nacan, kaushika
ms.custom: sap:bitlocker, csstroubleshoot
---
# MBAM and Secure Network Communication

This article discusses how to configure Microsoft's BitLocker Administration and Monitoring (MBAM) with Secure Network Communication.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 – all editions  
_Original KB number:_ &nbsp; 2754259

## Summary

MBAM can encrypt the communication between the MBAM Recovery and Hardware Database, the Administration, and Monitoring servers and the MBAM clients. If you decide to encrypt the communication, you're asked to select the certification authority-provisioned certificate that will be used for encryption.

The channel between MBAM Administration & Monitoring Server and SQL SSRS can also be encrypted. An Administrator needs a certificate approved from CA (Certificate Authority) or a Self-Signed Certificate before deploying MBAM.

> [!Note]
> If you decide to go with SSL, make sure you have the correct certificate to configure SSL before running MBAM Setup on your server.

Step 1: Encrypt Channel between MBAM Client and Administration & Monitoring Server.  

1. Using Self Signed Certificate.
      1. Connect to Server where MBAM Administration & Monitoring Role will be installed.
      2. Make sure you have installed IIS.
      3. Open Server Manager and Click on Roles.
      4. Select webserver and click on IIS.
      5. In Feature View, Double-Click Server Certificates.
      6. Under Actions Pane, Select Self-Signed Certificate.
      7. On the Create Self-Signed Certificate page, type a friendly name for the certificate in the Specify a friendly name for the certificate box, and then click OK.

      > [!Note]
      >
      > - This procedure generates a self-signed certificate that doesn't originate from a generally trusted source; therefore, you shouldn't use this certificate to help secure data transfers between Internet clients and your server.
      > - Self-signed certificates may cause your Web browser to issue phishing warnings.  

2. Using Certificate Approved by Certificate Authority  

   There are two ways to import a certificate

      1. Request or Import a certificate from a CA using IIS:

         - [Request an Internet Server Certificate in IIS](https://technet.microsoft.com/library/cc732906%28v=ws.10%29.aspx)  
         - [Import a Server Certificate in IIS](https://technet.microsoft.com/library/cc732785%28v=ws.10%29.aspx)

      2. Request or Import a certificate into the Personal Certificate Store using Certificate Manager:  
      [Windows help and learning](https://windows.microsoft.com/windows-vista/request-or-renew-a-certificate)  

         Certificate Templates to be used:

         MBAM Client to MBAM Administration & Monitoring Server: Use Standard Web Server Template.

         After you have certificate ready, when you execute MBAM Setup, we will show you the thumbprint of the certificate in "Configure Network Communication Security" wizard for MBAM Setup.

            :::image type="content" source="media/mbam-secure-network-communication/certificate-ready.png" alt-text="Screenshot of the Microsoft BitLocker Administration and Monitoring window, which shows the certificate for network communication encryption.":::

Step 2: Encrypt Channel between MBAM Administration & Monitoring Server and MBAM Recovery & Hardware SQL DB.

MBAM can encrypt the communication between the Recovery and Hardware Database and the Administration and Monitoring servers. If you choose the option to encrypt communication, you're asked to select the Certificate Authority-provisioned certificate that is used for encryption.

Certificate Templates to be used:

MBAM SQL DB Server to Admin & Monitoring Server: Standard Server Authentication Template

When you execute MBAM Setup Program on a server where you'll install MBAM Recovery & Hardware DB Role, you can see the certificate thumbprint in "Configure Network Communication Security" wizard for MBAM Setup Program.

:::image type="content" source="media/mbam-secure-network-communication/certificate-thumbprint.png" alt-text="Screenshot of the Microsoft BitLocker Administration and Monitoring window, which shows the thumbprint in the Configure network communication security wizard.":::

Step 3: How to configure SSL for SQL Compliance and Audit DB Server.  

> [!Note]
> You'll have to configure SSL for SQL before you run MBAM Setup on your server.

1. Open SQL Reporting Services Configuration Manager on Server where you installed MBAM Audit Reports Role.
2. Connect to your Server and click Web Service URL.

    :::image type="content" source="media/mbam-secure-network-communication/web-service-url.png" alt-text="Screenshot of the Connect window with Web Service URL selected on the left pane.":::

3. Click Advanced and then select your certificate. See image below:

    :::image type="content" source="media/mbam-secure-network-communication/select-certificate.png" alt-text="Screenshot of the Advanced Multiple Web Site Configuration window, and the Add a Report Server SSL Binding window.":::

4. Repeat "Step 3" for Report Manager URL in SQL Reporting Services Configuration Manager.
5. Now when you open MBAM Reports it will use SSL to connect to SQL SSRS.

Step 4: Configure SQL to force encryption on all protocols.  

1. Log in to SQL Server and Open SQL Server Configuration Manager.
2. Expand SQL Server Network Configuration and select "Protocols for MSSQLSERVER".
3. Right click on "Protocols for MSSQLSERVER" and select Yes for Force Encryption.

    :::image type="content" source="media/mbam-secure-network-communication/force-encrypt.png" alt-text="Screenshot of the Protocols for MSSQLSERVER Properties window, in which Yes is selected for Force Encryption under the Flags tab.":::

4. Select Certificates tab and choose your certificate from drop-down.
5. Click Apply and restart your SQL Services.
6. When you try to restart SQL Services, you'll hit an error message "The request failed or the service didn't respond in a timely fashion. Consult the event log or other applicable error logs for details."
7. It fails since SQL account doesn't have rights on Private keys of the certificate.
8. Open Certificate Manager MMC console and give the SQL account that is used for SQL services Full access on the certificate.

    :::image type="content" source="media/mbam-secure-network-communication/sql-account-permission.png" alt-text="Screenshot of the Security tab of the Certificate Manager MMC console, in which the SQL admin account has Full access.":::

9. Restart the SQL Server Services now and it should be successful.

## More information

- [Create a Self-Signed Server Certificate in IIS](https://technet.microsoft.com/library/cc753127%28v=ws.10%29.aspx)  
- [Configuring a Report Server for Secure Sockets Layer (SSL) Connections](https://msdn.microsoft.com/library/ms345223%28v=sql.105%29.aspx)
