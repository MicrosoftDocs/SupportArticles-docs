---
title: Troubleshoot account issues for federated users in Microsoft 365, Azure, or Intune
description: Describes how to troubleshoot single sign-on (SSO) user account issues in Microsoft 365, Azure, or Microsoft Intune.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# Troubleshoot account issues for federated users in Microsoft 365, Azure, or Intune

## Problem

When you try to authenticate to a Microsoft a cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune by using a federated account, the authentication is unsuccessful, and one or more of the following issues occur:

- At the sign-in prompt, when you try to update the Usernamefield by using a federated user name, the browser address bar contains a URL that resembles the following example, instead of a webpage that includes a "Sign in at \<AD FS endpoint name\>" link: https://login.microsoftonline.com/login.srf?...   
- After you sign in by using a federated account and you try to access a cloud service resource, such as the Microsoft 365, Outlook Web App, SharePoint Online, or Skype for Business Online (formerly Lync Online), you get the following error message:

    **Access Denied**   


## Cause 

If these issues only occur for some user accounts, this indicates that those user accounts are likely set up incorrectly in the on-premises Active Directory environment. In this scenario, one or more of the following items may be set up incorrectly:

- The wrong user principal name (UPN) and password are being used.   
- The UPN isn't updated for user accounts.

  In this case, the UPN suffix for each identity-federated account must be updated to reflect the federated domain name. To verify a user account UPN, follow these steps:
  1. On the local Active Directory domain controller, click Start, point to All Programs, click Administrative Tools, and then click Active Directory Users and Computers.    
  2. Right-click the user account that you want to change, and then click Properties.    
  3. On the Account tab, make sure that the UPN suffix of the federated namespace is listed in the list in the upper-left corner, and then click OK.   
   
- Microsoft 365 user account isn't licensed for the Microsoft 365 resource

  Access to Microsoft 365 resources for which the user account doesn't have a license is restricted. To check the license status for a user account, follow these steps:
  1. Sign in to the Microsoft 365 portal ([https://portal.office.com](https://portal.office.com/)) by using a Microsoft 365 admin user account. You can use a managed account if it's required.   
  2. Select **Admin**, and then in the left navigation pane, select **Users**.   
  3. In the list of users, locate the user accounts that you want to test, and then select **Display Name**. Check that each user account has the required licensing for the Microsoft 365 resource.   
  4. Select the **Select all items** check box.

     If a user account that you want to test isn't listed, Active Directory synchronization may be syncing the account to Microsoft Entra ID.

     Note If the user account has an on-premises mailbox, a Microsoft 365 mailbox isn't created. This specific resource remains unavailable, even when the user account is licensed for Exchange Online.   
   
- Subdomain doesn't inherit parent domain's federation settings

  When a subdomain, such as **subdomain.contoso.com**, is added before its parent domain, for example **contoso.com**, the subdomain automatically inherits the parent domain's federation status. To determine the inheritance status, follow these steps:
  1. Sign in to Microsoft 365 ([https://portal.office.com](https://portal.office.com/)) by using a Microsoft 365 admin user account. You can use a managed account if this is required.   
  2. Click **Admin**, and then in the left navigation pane, click **Domains**.    
  3. In the list of domains, locate the federated subdomain name, and then determine whether the **Domain type** setting is set to **Single Sign-On**.   
  4. Repeat step 1 to step 3 for the parent domain. If the Domain type setting differs from the subdomain setting, the subdomain has been orphaned from its parent.   
   
- Directory synchronization issues are preventing proper user account configuration on-premises from syncing to Microsoft Entra ID.

  Single sign-on (SSO) relies on identical user accounts being represented in both the on-premises Active Directory and in Microsoft Entra ID. Directory synchronization is responsible for making sure that the same Microsoft 365 user account is created for each on-premises user account. Sign in may fail when directory synchronization doesn't sync correct account settings from the on-premises Active Directory to Microsoft Entra ID.   


## Solution

To resolve this issue, use one or more of the following methods:

- Make sure that the correct UPN and password are used for sign in.   
- The UPN isn't updated for federated accounts.

   For more info about how to resolve this issue, see the following Microsoft Knowledge Base article:

   [2392130 ](https://support.microsoft.com/help/2392130) Troubleshoot user name issues that occur for federated users when they sign in to Microsoft 365, Azure, or Intune    
- The Microsoft 365 user account isn't licensed for Microsoft 365 resources.

   To resolve this issue, use the Microsoft 365 portal to assign the appropriate licenses to the user accounts that require a license.   
- Microsoft 365 subdomain doesn't inherit parent domain's federation settings.

  To resolve this issue, remove the subdomain from the Microsoft 365 portal. For more info about how to remove a domain, go to the following Microsoft website:

   [Remove a domain](/microsoft-365/admin/get-help-with-domains/remove-a-domain)

  After the domain is removed, you have to re-create the domain.

  When the domain is re-created, the subdomain inherits the parent domain's Domain type setting.

  **Note** Domain verification by using DNS TXT records or MX records isn't required for subdomain re-creation because the subdomain is recognized as part of the already-verified parent domain.   
- Directory synchronization issues prevent the on-premises user account configuration from syncing properly to Windows Azure AD.

  To determine whether an account mismatch has occurred, follow these steps: 
  1. Make a minor (arbitrary) change to the on-premises Active Directory user account.   
  2. Force directory synchronization. For more info about how to force synchronization, go to the following Microsoft website:

     [Force directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity#bkmk_synchronizedirectories)

     For info about how to determine whether synchronization was successful, go to the following Microsoft website: 

     [Verify directory synchronization](/azure/active-directory/hybrid/whatis-hybrid-identity)

     If minor changes are not synced to the Microsoft 365 user account, a directory synchronization problem may cause this issue.

     **Note** Directory synchronization may sync successfully without updating the user's UPN to the appropriate value if the user account is already licensed.


## More Information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
