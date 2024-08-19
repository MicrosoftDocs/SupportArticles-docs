---
title: There was a problem accessing the site error from AD FS
description: Describes an issue in which a federated user receives an error message from Active Directory Federation Services (AD FS) when the user tries to sign in to a Microsoft cloud service such as Microsoft 365, Azure, or Microsoft Intune.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: v-jocomf
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Azure Backup
  - Microsoft Intune
  - Microsoft 365
ms.date: 03/31/2022
---

# "There was a problem accessing the site" error from AD FS when a federated user signs in to Microsoft 365, Azure, or Intune

## Problem

When a federated user tries to sign in to a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune, the user receives the following error message from Active Directory Federation Services (AD FS):

```adoc
There was a problem accessing the site. Try to browse to the site again.
If the problem persists, contact the administrator of this site and provide the reference number to identify the problem.
Reference number: <GUID>
```

When this error occurs, the web browser's address bar points to the on-premises AD FS endpoint at an address that resembles the following: 

"https://sts.domain.com/adfs/ls/?cbcxt=&vv=&username=username%40domain.com&mkt=&lc=1033&wa=wsignin1.0&wtrealm=urn:federation:MicrosoftOnline&wctx=MEST%3D0%26LoginOptions%3D2%26wa%3Dwsignin1.0%26rpsnv%3D2%26ct%3D1299115248%26rver%3D6.1.6206.0%26wp%3DMCMBI%26wreply%3Dhttps:%252F%252Fportal.office.com%252FDefault.aspx%26lc%3D1033%26id%3D271346%26bk%3D1299115248"

## Cause

This issue may occur for one of the following reasons: 
- The setup of single sign-on (SSO) through AD FS wasn't completed.    
- The AD FS token-signing certificate expired.    
- The AD FS client access policy claims are set up incorrectly.   
- The relying party trust with Microsoft Entra ID is missing or is set up incorrectly.   
- The AD FS federation proxy server is set up incorrectly or exposed incorrectly.   
- The AD FS IUSR account doesn't have the "Impersonate a client after authentication" user permission.    

## Solution

To resolve this issue, use the method that's appropriate for your situation.

### Scenario 1: The AD FS token-signing certificate expired

#### Check whether the token-signing certificate is expired

To check whether the token-signing certificate is expired, follow these steps: 

1. Click **Start**, click **All Programs**, click **Administrative Tools**, and then click **AD FS (2.0) Management**.    
2. In the AD FS management console, click **Service**, click **Certificates**, and then examine the **Effective** and **Expiration** dates for the AD FS token-signing certificate.    

If the certificate is expired, it has to be renewed to restore SSO authentication functionality.

#### Renew the token-signing certificate (if it has expired)

To renew the token-signing certificate on the primary AD FS server by using a self-signed certificate, follow these steps: 

1. In the same AD FS management console, click **Service**, click **Certificates**, and then, under **Certifications **in the **Actions** pane, click **Add Token-Signing Certificate**.    
2. If a "Certificates cannot be modified while the AD FS automatic certificate rollover feature is enabled" warning appears, go to step 3. Otherwise, check the certificate **Effective** and **Expiration** dates. If the certificate is successfully renewed, you don't have to perform steps 3 and 4.    
3. If the certificate isn't renewed, click **Start**, point to **All Programs**, click **Accessories**, click the **Windows PowerShell** folder, right-click **Windows PowerShell**, and then click **Run as administrator**.   
4. At the Windows PowerShell command prompt, enter the following commands. Press Enter after you enter each command: 
   - Add-PSSnapin Microsoft.Adfs.Powershell    
   - Update-ADFSCertificate -CertificateType: Token-Signing    

To renew the token-signing certificate on the primary AD FS server by using a certification authority (CA)-signed certificate, follow these steps: 
1. Create the WebServerTemplate.inf file. To do this, follow these steps:
   1. Start Notepad, and open a new, blank document.    
   2. Paste the following into the file: 

      ```adoc
      [Version] Signature=$Windows NT$[NewRequest] ;EncipherOnly=False Exportable=True KeyLength=2048 KeySpec=1 KeyUsage=0xa0MachineKeySet=True ProviderName="Microsoft RSA SChannel Cryptographic Provider"
      ProviderType=12 RequestType=CMC subject="CN=adfs.contoso.com"[EnhancedKeyUsageExtension] OID=1.3.6.1.5.5.7.3.1 [RequestAttributes] 
      ```
   3. In the file, change subject="CN=adfs.contoso.com" to the following: 

      subject="CN=**your-federation-service-name**"   
   4. On the **File** menu, click **Save As**.    
   5. In the** Save As **dialog box, click** All Files (*.*)** in the **Save as type** box.    
   6. Type WebServerTemplate.inf in the **File name** box, and then click **Save**.    
2. Copy the WebServerTemplate.inf file to one of your AD FS Federation servers.    
3. On the AD FS server, open an Administrative Command Prompt window.    
4. Use the cd(change directory) command to change to the directory where you copied the .inf file.    
5. Type the following command, and then press Enter: 

   CertReq.exe -New WebServerTemplate.inf AdfsSSL.req
1. Send the output file, AdfsSSL.req, to your CA for signing.    
1. The CA will return a signed public key portion in either a .p7b or .cer format. Copy this file to your AD FS server where you generated the request.   
1. On the AD FS server, open an Administrative Command Prompt window.    
1. Use the cd(change directory) command to change to the directory where you copied the .p7b or .cer file.    
1. Type the following command, and then press Enter: 

   CertReq.exe -Accept "file-from-your-CA-p7b-or-cer"

#### Finish restoring SSO functionality

Regardless of whether a self-signed or CA-signed certificate is used, you should finish restoring SSO authentication functionality. To do this, follow these steps: 

1. Add Read access to the private key for the AD FS service account on the primary AD FS server. To do this, follow these steps: 
   1. Click **Start**, click **Run**, type mmc.exe, and then press Enter.    
   2. On the **File** menu, click **Add/Remove Snap-in**.    
   3. Double-click **Certificates**, select **Computer account**, and then click **Next**.    
   4. Select **Local computer**, click **Finish**, and then click **OK**.    
   5. Expand **Certificates (Local Computer)**, expand **Personal**, and then click **Certificates**.    
   6. Right-click the new token-signing certificate, point to **All Tasks**, and then click **Manage Private Keys**.    
   7. Add Read access to the AD FS service account, and then click **OK**.    
   8. Exit the Certificates snap-in.    
2. Update the new certificate's thumbprint and the date of the relying party trust with Microsoft Entra ID. To do this, see the "How to update the configuration of the Microsoft 365 federated domain" section in [How to update or repair the settings of a federated domain in Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2647048).
3. Re-create the AD FS proxy trust configuration. To do this, follow these steps: 
   1. Restart the AD FS Windows Service on the primary AD FS server.    
   2. Wait 10 minutes for the certificate to replicate to all the members of the federation server farm, and then restart the AD FS Windows Service on the rest of the AD FS servers.    
   3. Rerun the Proxy Configuration Wizard on each AD FS proxy server. For more information, see [Configure a computer for the federation server proxy role](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd807067(v=ws.10)).   

### Scenario 2: You recently updated the client access policy through claims, and now sign-in doesn't work

Check whether the client access policy was applied correctly. For more information, see [Limiting access to Microsoft 365 services based on the location of the client](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh526961(v=ws.10)).

### Scenario 3: The federation metadata endpoint or the relying party trust may be disabled

Enable the federation metadata endpoint and the relying party trust with Microsoft Entra ID on the primary AD FS server. To do this, follow these steps: 

1. Open the AD FS 2.0 Management Console.    
2. Make sure that the federation metadata endpoint is enabled. To do this, follow these steps: 
   1. In the left navigation pane, browse to **AD FS (2.0), Service, Endpoints**.    
   2. In the center pane, right-click the **/Federation Metadata/2007-06/FederationMetadata.xml** entry, and then click to select **Enable** and **Enable on Proxy**.
3. Make sure that the relying party trust with Microsoft Entra ID is enabled. To do this, follow these steps: 
   1. In the left navigation pane, browse to **AD FS (2.0)**, then **Trust Relationships**, and then **Relying Party Trusts**.    
   2. If **Microsoft Office 365 Identity Platform** is present, right-click this entry, and then click **Enable**.    
4. Repair the relying party trust with Microsoft Entra ID by seeing the "Update trust properties" section of [Verify and manage single sign-on with AD FS](/previous-versions/azure/azure-services/jj151809(v=azure.100)).   

### Scenario 4: The relying party trust may be missing or corrupted

Remove and re-add the relying party trust. To do this, follow these steps:

1. Log on to the core AD FS server.    
2. Click **Start**, point to **All Programs**, click **Administrative Tools**, and then click **AD FS (2.0) Management**.    
3. In the management console, expand **AD FS (2.0)**, expand **Trust Relationships**, and then expand **Relying Party Trusts**.    
4. If **Microsoft Office 365 Identity Platform** is present, right-click this entry, and then click **Delete**.   
5. Re-add the relying party trust by seeing the "Update trust properties" section of [Verify and manage single sign-on with AD FS](/previous-versions/azure/azure-services/jj151809(v=azure.100)).   

### Scenario 5: The AD FS service account doesn't have the "Impersonate a client after authentication" user permission

To grant the "Impersonate a client after authentication" user permission to the AD FS IUSR service account, see [Event ID 128 — Windows NT token-based application configuration](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd353726(v=ws.10)).

## References

For more information about how to troubleshoot sign-in issues for federated users, see the following Microsoft Knowledge Base articles: 

- [2530569 ](https://support.microsoft.com/help/2530569) Troubleshoot single sign-on setup issues in Microsoft 365, Intune, or Azure   
- [2712961 ](https://support.microsoft.com/help/2712961) How to troubleshoot AD FS endpoint connection issues when users sign in to Microsoft 365, Intune, or Azure     

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
