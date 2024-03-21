---
title: Certificate warning from AD FS when sign in to Microsoft 365, Azure, or Intune
description: Describes an issue in which you receive a certificate warning from AD FS when you try to sign in to Microsoft 365, Azure, or Microsoft Intune by using a federated account. A resolution is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# You receive a certificate warning from AD FS when you sign in to Microsoft 365, Azure, or Intune

## Problem

When you try to sign in to a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune by using a federated account, you receive a certificate warning from the AD FS web service in your browser.

## Cause 

This issue occurs when a validation error is encountered during a certificate test. 

Before a certificate can be used to help secure a Secure Sockets Layer (SSL) or Transport Layer Security (TLS) session, the certificate must pass the following standard tests:

- Certificate isn't time valid. If the date on the server or client is earlier than the **Valid from** date or the issue date of the certificate, or if the date on the server or client is later than the **Valid to** date or the expiration date of the certificate, the connection request issues a warning that's based on this state. To make sure that the certificate passes this test, check whether the certificate actually expired or was applied before it became active. Then, take one of the following actions:
  - If the certificate actually expired or was applied before it became active, a new certificate must be generated that has the appropriate delivery dates to help secure the communication for AD FS traffic.   
  - If the certificate didn't expire or wasn't applied before it became active, verify the time on the client and server computers, and then update them as required.   
   
- Service-name mismatch. If the URL that's used to make the connection doesn't match the valid names for which the certificate may be used, the connection request issues a warning that's based on this state. To make sure that the certificate passes this test, follow these steps:
  1. Examine the URL in the address bar of the browser that's used to establish the connection.

     > [!NOTE]
     > Focus on the server address (for example, sts.contoso.com) and not on the trailing HTTP syntax (for example, /?request=…).   
  2. After you reproduce the error, follow these steps:
     1. Click **View Certificates**, and then click the **Details** tab. Compare the URL from step A to the **Subject** field and to the **Subject Alternative Name** fields in the **Properties** dialog box of the certificate.

         :::image type="content" source="media/certificate-warning-from-ad-fs/mismatched-address.png" alt-text="Screenshot shows the error on the Mismatched Address page.":::
     1. Verify that the address that's used in step A isn't listed or doesn't match any entries in these fields, or both. If this is the case, the certificate must be reissued to include the server address that was used in step A.
   
- Certificate wasn't issued by a trusted root certification authority (CA). If the client computer that's requesting the connection doesn't trust the CA chain that generated the certificate, the connection request will issue a warning that's based on this state. To make sure that the certificate passes this test, follow these steps:
  1. Regenerate the certificate warning, and then click **View Certificate** to examine the certificate. On the **Certification Path** tab, notice the root note entry on that's displayed at the top.   
  2. Click **Start**, click **Run**, type **MMC**, and then click **OK**.    
  3. Click **File**, click **Add/remove Snap-in**, click **Certificates**, click **Add**, select **Computer Account**, click **Next**, click **Finish**, and then click **OK**.   
  4. In the MMC snap-in, locate **Console Root**, expand **Certificates**, expand **Trusted Root Certification Authorities**, click **Certificates**, and then verify that a certificate for the root note entry that you noted in step A doesn't exist.   

## Solution

To resolve this issue, use one of the following methods, depending on the warning message.

### Method 1: Time-valid issues

To resolve time-valid issues, follow these steps. 
 
1. Reissue the certificate with an appropriate validity date. For more info about how to install and set up a new SSL certificate for AD FS, see [How to change the AD FS 2.0 service communications certificate after it expires](https://support.microsoft.com/help/2921805).      
2. If an AD FS proxy was deployed, you have to also install the certificate on the default website of the AD FS proxy by using the certificate export and import functions. For more info, see [How to remove, import, and export digital certificates](https://support.microsoft.com/help/179380).  

   > [!IMPORTANT]
   > Make sure that the private key is included in the export or import process. The AD FS Proxy server or servers must also have a copy of the private key installed.    
3. Make sure that the date and time settings on the client computer or on all AD FS servers are correct. The warning will be displayed in error if the operating system date settings are incorrect, and it will incorrectly indicate a value that's outside the Valid fromand Valid torange.    
 
### Method 2: Service name mismatch issues

 The AD FS service name is set when you run the AD FS Configuration Wizard and is based on the certificate that's bound to the default website. To resolve service name mismatch issues, follow these steps: 
 
1. If the wrong certificate name was used to generate a replacement certificate, follow these steps:  
   1. Verify that the certificate name is incorrect.
   1. Reissue the correct certificate. For more info about how to install and set up a new SSL certificate for AD FS, see [How to change the AD FS 2.0 service communications certificate after it expires](https://support.microsoft.com/help/2921805).    
2. If the AD FS idP endpoint or smart links are leveraged for a customized sign-in experience, make sure that the server name that's used matches the certificate that's assigned to the AD FS service.  
3. In rare cases, this condition can also be caused by incorrectly trying to change the AD FS service name after implementation. For more information about how to manually change the AD FS endpoint service name, see
[AD FS 2.0: How to Change the Federation Service Name](https://social.technet.microsoft.com/wiki/contents/articles/ad-fs-2-0-how-to-change-the-federation-service-name.aspx). 
 
   > [!IMPORTANT]
   > These kinds of changes will cause an AD FS service outage. After the update, you must follow these steps to restore single sign-on (SSO) functionality:  
   > 1. Run the Update-MSOLFederatedDomain cmdlet on all federated namespaces.    
   > 2. Rerun the setup configuration wizard for any AD FS proxy servers in the environment.    

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

### Method 3: Issuing certification chain trust issues

You can resolve issuing certification authority (CA) trust issues by performing one of the following tasks: 
 
- Get and use a certificate from a source that participates in the Microsoft Root Certificate Program.    
- Request that the certificate issuer enroll in the Microsoft Root Certificate Program. For more information about the Root Certificate Program and the operation of root certificates in Windows, see [Microsoft Root Certificate Program](/previous-versions//cc751157(v=technet.10)).     
 
> [!WARNING]
> We don't recommend that AD FS use an internal CA when it's leveraged for SSO with Microsoft 365. Using a certificate chain that's not trusted by the Microsoft 365 data center will cause Microsoft Outlook connectivity to Microsoft Exchange Online to fail when Outlook is used with SSO features. 

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
