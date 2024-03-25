---
title: Set up AD FS for Microsoft 365 for Single Sign-On
description: This article includes a step-by-step video that explains how to configure AD FS to work together with Microsoft 365 for Single Sign-On solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: abizerh, willfid, rkiran
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 10/20/2023
---

# Set up AD FS for Microsoft 365 for Single Sign-On

This video shows how to set up Active Directory Federation Service (AD FS) to work together with Microsoft 365. It doesn't cover the AD FS proxy server scenario. This video discusses AD FS for Windows Server 2012 R2. However, the procedure also applies to AD FS 2.0 — except for steps 1, 3, and 7. In each of those steps, see the "Notes for AD FS 2.0" section for more information about how to use this procedure in Windows Server 2008.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/9ffdb7ee-07bf-45ba-adec-f1acf576bd65]

## Useful notes for the steps in the video

### Step 1: Install Active Directory Federation Services

Add AD FS by using Add Roles and Features Wizard.

**Notes for AD FS 2.0**

If you're using Windows Server 2008, you must download and install AD FS 2.0 to be able to work with Microsoft 365. You can obtain AD FS 2.0 from the following Microsoft Download Center website:

[Active Directory Federation Services 2.0 RTW](https://support.microsoft.com/help/974408)

After the installation, use Windows Update to download and install all applicable updates.

### Step 2: Request a certificate from a third-party CA for the Federation server name

Microsoft 365 requires a trusted certificate on your AD FS server. Therefore, you must obtain a certificate from a third-party certification authority (CA). 

When you customize the certificate request, make sure that you add the Federation server name in the **Common name** field. 

In this video, we explain only how to generate a certificate signing request (CSR). You must send the CSR file to a third-party CA. The CA returns a signed certificate to you. Then, follow these steps to import the certificate to your computer certificate store:

1. Run `Certlm.msc` to open the local computer's certificate store.   
2. In the navigation pane, Expand **Personal**, expand **Certificate**, right click the Certificate folder, and then click **Import**.   

**About the Federation server name**

The Federation Service name is the Internet-facing domain name of your AD FS server. The Microsoft 365 user is redirected to this domain for authentication. Therefore, make sure that you add a public A record for the domain name. 

### Step 3: Configure AD FS

You can't manually type a name as the Federation server name. The name is determined by the subject name (Common name) of a certificate in the local computer's certificate store.

**Notes for AD FS 2.0**

In AD FS 2.0, the Federation server name is determined by the certificate that binds to "Default Web Site" in Internet Information Services (IIS). You must bind the new certificate to the Default website before you configure AD FS.

You can use any account as the service account. If the service account's password is expired, AD FS stops working. Therefore, make sure that the password of the account is set to never expire.

### Step 4: Download Microsoft 365 tools

Windows Azure Active Directory module for Windows PowerShell and Azure Active Directory Sync appliance are available in the Microsoft 365 portal. To obtain the tools, click **Active Users**, and then click **Single sign-on: Set up**.

### Step 5: Add your domain to Microsoft 365

The video doesn't explain how to add and verify your domain to Microsoft 365. For more information about that procedure, see [Verify your domain in Microsoft 365](https://support.office.com/en-ca/article/verify-your-domain-in-office-365-6383f56d-3d09-4dcb-9b41-b5f5a5efd611).

### Step 6: Connect AD FS to Microsoft 365

To connect AD FS to Microsoft 365, run the following commands in Windows Azure Directory Module for Windows PowerShell.

**Note** In the `Set-MsolADFSContext` command, specify the FQDN of the AD FS server in your internal domain instead of the Federation server name.

```powershell
Enable-PSRemoting 
Connect-MsolService 
Set-MsolADFSContext –computer <the FQDN of the AD FS server>
Convert-MsolDomainToFederated –domain <the custom domain name you added into Microsoft 365>
```

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

If the commands run successfully, you should see the following:

- A "Microsoft 365 Identify Platform" Relying Party Trust is added to your AD FS server.   
- Users who use the custom domain name as an email address suffix to log in to the Microsoft 365 portal are redirected to your AD FS server.   

### Step 7: Sync local Active Directory user accounts to Microsoft 365

If your internal domain name differs from the external domain name that is used as an email address suffix, you have to add the external domain name as an alternative UPN suffix in the local Active Directory domain. For example, the internal domain name is "company.local" but the external domain name is "company.com." In this situation, you have to add "company.com" as an alternative UPN suffix.

Sync the user accounts to Microsoft 365 by using the Directory Sync Tool.

**Notes for AD FS 2.0**

If you're using AD FS 2.0, you must change the UPN of the user account from "company.local" to "company.com" before you sync the account to Microsoft 365. Otherwise, the user isn't validated on the AD FS server. 

### Step 8: Configure the client computer for Single Sign-On

After you add the Federation server name to the local Intranet zone in Internet Explorer, the NTLM authentication is used when users try to authenticate on the AD FS server. Therefore, they are not prompted to enter their credentials. 

Administrators can implement Group Policy settings to configure a Single Sign-On solution on client computers that are joined to the domain.
