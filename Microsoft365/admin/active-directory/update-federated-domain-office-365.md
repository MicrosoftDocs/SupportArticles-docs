---
title: Update or repair settings of a federated domain in Microsoft 365, Azure, or Intune
description: Describes how to update or repair the settings of a federated domain configuration in Microsoft 365, Azure, or Microsoft Intune by using the Azure Active Directory module for Windows PowerShell.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# Update or repair the settings of a federated domain in Microsoft 365, Azure, or Intune

## Introduction 

Single sign-on (SSO) in a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune depends on an on-premises deployment of Active Directory Federation Services (AD FS) that functions correctly. Several scenarios require rebuilding the configuration of the federated domain in AD FS to correct technical problems. This article contains step-by-step guidance on how to update or to repair the configuration of the federated domain.

## More information

### How to update the configuration of the federated domain
 
The configuration of the federated domain has to be updated in the scenarios that are described in the following Microsoft Knowledge Base articles. 

- [2713898 ](https://support.microsoft.com/help/2713898) "There was a problem accessing the site" error from AD FS when a federated user signs in to Microsoft 365, Azure, or Intune    
- [2535191 ](https://support.microsoft.com/help/2535191)""Sorry, but we're having trouble signing you in" and "80048163" error when a federated user tries to sign in to Microsoft 365, Azure, or Intune    
- [2647020 ](https://support.microsoft.com/help/2647020)  "Sorry, but we're having trouble signing you in" and "80041317" or "80043431" error when a federated user tries to sign in to Microsoft 365, Azure, or Intune    

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

To update the configuration of the federated domain on a domain-joined computer that has Azure Active Directory module for Windows PowerShell installed, follow these steps:

1. Click **Start**, click **All Programs**, click **Windows Azure Active Directory**, and then click **Windows Azure Active Directory module for Windows PowerShell**.   
2. At the command prompt, type the following commands, and press Enter after each command:
   ```powershell
   $cred = get-credential
   ```
   > [!NOTE]
   > When you're prompted, enter your cloud service administrator credentials.   
   
   ```poweshell
   Connect-MSOLService –credential:$cred
   ```    
  
   ```powershell
   Set-MSOLADFSContext –Computer: <AD FS 2.0 ServerName>
   ``` 
   > [!NOTE]
   > In this command, the placeholder **<AD FS 2.0 Server Name>** represents the Windows host name of the primary AD FS server.  
    
   ```powershell
   Update-MSOLFederatedDomain –DomainName: <Federated Domain Name>
   ```
   or 
   ```powershell
   Update-MSOLFederatedDomain –DomainName: <Federated Domain Name> –supportmultipledomain 
   ```
   > [!NOTE]
   > - Using the –supportmultipledomain switch is required when multiple top-level domains are federated by using the same AD FS federation service.
   > - In these commands, the placeholder \<**Federated Domain Name**> represents the name of the domain that is already federated.   
   
> [!IMPORTANT]
> A script is available to automate the update of federation metadata regularly to make sure that changes to the AD FS token signing certificate are replicated correctly. 

The script creates a Windows scheduled task on the primary AD FS server to make sure that changes to the AD FS configuration such as trust info, signing certificate updates, and so on are propagated regularly to the Microsoft Entra ID. 

If the token-signing certificate is automatically renewed in an environment where the script is implemented, the script will update the cloud trust info to prevent downtime that is caused by out-of-date cloud certificate info.

#### How to repair the configuration of the federated domain 

The configuration of the federated domain has to be repaired in the scenarios that are described in the following Microsoft Knowledge Base articles. 

- [2523494 ](https://support.microsoft.com/help/2523494)  You receive a certificate warning from AD FS when you try to sign in to Microsoft 365, Azure, or Intune    
- [2618887 ](https://support.microsoft.com/help/2618887)  "Federation service identifier specified in the AD FS 2.0 server is already in use." error when you try to set up another federated domain in Microsoft 365, Azure, or Intune    
- [2713898 ](https://support.microsoft.com/help/2713898)  "There was a problem accessing the site" error from AD FS when a federated user signs in to Microsoft 365, Azure, or Intune     
- [2647020 ](https://support.microsoft.com/help/2647020) "Your organization could not sign you in to this service" error and "80041317" or "80043431" error code when a federated user tries to sign in to Microsoft 365   
- The Federation Service name in AD FS is changed. For more info, go to the following Microsoft website: [AD FS 2.0: How to Change the Federation Service Name](https://social.technet.microsoft.com/wiki/contents/articles/ad-fs-2-0-how-to-change-the-federation-service-name.aspx)   

To repair the federated domain configuration on a domain-joined computer that has Azure Active Directory module for Windows PowerShell installed, follow these steps.

> [!WARNING]
> - The following procedure removes any customizations that are created by [limiting access to Microsoft 365 services by using the location of the client](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh526961(v=ws.10)). After the configuration of the federated domain is repaired, you may have to reconfigure limited AD FS access.   
> - The following steps should be planned carefully. Users for whom the SSO functionality is enabled in the federated domain will be unable to authenticate during this operation from the completion of step 4 until the completion of step 5. If the update-MSOLFederatedDomain cmdlet test in step 1 is not followed successfully, step 5 will not finish correctly. Federated users will be unable to authenticate until the update-MSOLFederatedDomain cmdlet can be run successfully.   

1. Run the steps in the "How to update the federated domain configuration" section earlier in this article to make sure that the update-MSOLFederatedDomain cmdlet finished successfully.
   - If the cmdlet did not finish successfully, do not continue with this procedure. Instead, see the "Known issues that you may encounter when you update or repair a federated domain" section later in this article to troubleshoot the issue.   
   - If the cmdlet finishes successfully, leave the Command Prompt window open for later use.   
2. Log on to the AD FS server. To do this, click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **AD FS (2.0) Management**.   
3. In the left navigation pane, click **AD FS (2.0)**, click **Trust Relationships**, and then click **Relying Party Trusts**.   
4. In the rightmost pane, delete the **Microsoft Office 365 Identity Platform** entry.   
5. In the Windows PowerShell window that you opened in step 1, re-create the deleted trust object. To do this, run the following command, and then press Enter:
   ```powershell
   Update-MSOLFederatedDomain -DomainName <Federated Domain Name>
   ```
   or 
   ```powershell
   Update-MSOLFederatedDomain –DomainName:<Federated Domain Name> –supportmultipledomain
   ``` 
   > [!NOTE]
   > - Using the –supportmultipledomain switch is required when multiple top-level domains are federated by using the same AD FS federation service.
   > - In these commands, the placeholder \<**Federated Domain Name**> represents the name of the domain that is already federated.   

#### Known issues that you may encounter when you update or repair a federated domain

The following scenarios cause problems when you update or repair a federated domain:

- You can't connect by using Windows PowerShell. For more info about this issue, see the following Microsoft Knowledge Base article: 

  [2494043 ](https://support.microsoft.com/help/2494043)  You cannot connect by using the Azure Active Directory module for Windows PowerShell   
- The Azure Active Directory module for Windows PowerShell can't load because of missing prerequisites. For more info, see the following Microsoft Knowledge Base article:  
  
  [2461873 ](https://support.microsoft.com/help/2461873)  You can't open the Azure Active Directory module for Windows PowerShell    
- You get an "Access Denied" error message when you try to run the set-MSOLADFSContext cmdlet. For more info, see the following Microsoft Knowledge Base article: 

  [2587730 ](https://support.microsoft.com/help/2587730) "The connection to \<ServerName> Active Directory Federation Services 2.0 server failed" error when you use the Set-MsolADFSContext cmdlet    

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
