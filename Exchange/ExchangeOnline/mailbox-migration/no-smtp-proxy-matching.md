---
title: Target mailbox doesn't have an smtp proxy matching in a mailbox migration
description: Describes an issue that returns a "The target mailbox doesn't have an smtp proxy matching '<domain>.mail.onmicrosoft.com" error message when you try to move mailboxes from your on-premises Exchange environment to Exchange Online in a hybrid deployment.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
manager: dcscontentpm
ms.custom: CSSTroubleshoot
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# Target mailbox doesn't have an smtp proxy matching in a mailbox migration

## Problem 

Assume that you have a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online in Office 365. When you try to move mailboxes from your on-premises environment to Exchange Online, you receive the following error message:  

**The target mailbox doesn't have an smtp proxy matching '\<domain>.mail.onmicrosoft.com'**   

## Cause 

This issue may occur if one of the following conditions is true: 
- The source mailbox isn't stamped to have a \<domain>.mail.onmicrosoft.com smtp address.     
- The proxy address \<domain>.mail.onmicrosoft.com is not synced to Office 365 on the corresponding cloud mail-user object.     

## Solution 

To find the cause of the issue and determine from which mailbox the \<domain>.mail.onmicrosoft.com email address is missing, run the following commands in the Exchange Management Shell and Exchange Online PowerShell: 

- In [Exchange Management Shell on-premises](https://docs.microsoft.com/powershell/exchange/exchange-server/open-the-exchange-management-shell?view=exchange-ps):   

```powershell
Get-Mailbox <AffectedUser> | FL EmailAddresses, EmailAddressPolicyEnabled
```      
- In [Exchange Online PowerShell](https://docs.microsoft.com/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps):   

```powershell
Get-MailUser <AffectedUser> | Select -ExpandProperty emailaddresses      
```

### Scenario 1: \<domain>.mail.onmicrosoft.com email address is missing from on-premises source mailbox (Exchange Management Shell)

To resolve this issue, add the \<domain>.mail.onmicrosoft.com email address to the on-premises source mailbox.

If the on-premises mailbox has an email address policy applied (that is, the **EmailAddressPolicyEnabled** parameter value is **True** or the **Automatically update email addresses based on the email address policy applied to this recipient** checkbox is selected for the user in Exchange Admin Center or Exchange Management Console), this means that the email address policy doesn't contain the secondary SMTP \<domain>.mail.onmicrosoft.com domain in the email address policy template. You can double-check this policy by running the following command in Exchange Management Shell:   

```powershell
Get-EmailAddressPolicy | FL Identity, EnabledEmailAddressTemplates  
```

In this case, add \<domain>.mail.onmicrosoft.com to the email address policy. To do this, follow these steps: 
 
1. Open the Exchange Admin Center on the on-premises Exchange server.    
2. Click **Mail flow**, and then click **Email address policies**.    
3. Select the email address policy that you want to change, and then click **Edit**.    
4. In **email address format**, add the domain (\<domain>.mail.onmicrosoft.com) to the policy, click **Save**, and then click **apply to** to apply the change to the recipients.    
5. You should now see that the \<domain>.mail.onmicrosoft.com SMTP address is stamped on the on-premises mailbox when you run the following command:  

    ```powershell
    Get-Mailbox <AffectedUser> | FL EmailAddresses, EmailAddressPolicyEnabled
    ```
1. Wait for directory synchronization to run. Or, force a delta directory synchronization. For more information about how to do this, see [Start the Scheduler](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-sync-feature-scheduler#start-the-scheduler).    
 
If the on-premises mailbox doesn't have an email address policy applied (that is, the **EmailAddressPolicyEnabled** parameter value is **False** or the **Automatically update email addresses based on the email address policy applied to this recipient** checkbox isn't selected for the user in Exchange Admin Center or Exchange Management Console), or if, for whatever reason, the email address policy doesn't stamp or apply the user@domain.mail.onmicrosoft.com smtp address on the recipient, you have to manually add the \<domain>.mail.onmicrosoft.com email address on the user, and then synchronize the change to Azure AD. To do this, follow these steps: 
 
1. Open the Exchange Admin Center on the on-premises Exchange server.    
2. Click **recipients**, and then click **mailboxes**.    
3. Select and double-click the on-premises mailbox that you want to change.    
4. In **email addresses**, click the add icon () to add** **user@domain.mail.onmicrosoft.com email address to the user's email addresses.    
5. Click **OK**, and then **Save**.    
6. You should now see the \<domain>.mail.onmicrosoft.com stamped on the on-premises mailbox when you run the following command:   

    ```powershell
    Get-Mailbox <AffectedUser> | FL EmailAddresses
    ```
1. Wait for directory synchronization to run. Or, force a delta directory synchronization. For more information about how to do this, see [Start the Scheduler](https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-sync-feature-scheduler#start-the-scheduler).     
 
### Scenario 2: \<domain>.mail.onmicrosoft.com email address is stamped on the on-premises source mailbox but is missing from the cloud mail-user object (Exchange Online PowerShell)

In this case, you probably have a synchronization issue. Determine whether the directory synchronization works and whether you have any synchronization errors that are reported in the Azure Active Directory (Azure AD) Connect tool or Office 365 admin center. For more information about how to do this, see [View directory synchronization errors in Office 365](https://docs.microsoft.com/office365/enterprise/identify-directory-synchronization-errors).  

You may also have a user validation error, if you already have a cloud user object on which the user@domain.mail.onmicrosoft.com email address is stamped. 

To see this error, you have to connect to [Office 365 PowerShell](https://docs.microsoft.com/office365/enterprise/powershell/connect-to-office-365-powershell) and then run one of the following commands, depending whether you connect to MSOnline (MSOL) service or Azure AD for Windows PowerShell:

```powershell
(Get-MsolUser -UserPrincipalName <AffectedUserUPN>).Errors.ErrorDetail.ObjectErrors.ErrorRecord.ErrorDescription   
(Get-AzureADUser -ObjectId <AffectedUserUPN>).Errors.ErrorDetail.ObjectErrors.ErrorRecord.ErrorDescription 
```

For more information, refer to [You see validation errors for users in the Office 365 portal or in the Azure Active Directory Module for Windows PowerShell](https://support.microsoft.com/help/2741233/you-see-validation-errors-for-users-in-the-office-365-portal-or-in-the).  
Then, in Office 365 PowerShell, check whether the proxy addresses in Azure AD contain the email address user@domain.mail.onmicrosoft.com. To do this, run one of the following commands:   

```powershell
(Get-MsolUser -UserPrincipalName <AffectedUserUPN>).ProxyAddresses   
(Get-AzureADUser -ObjectId <AffectedUserUPN>).ProxyAddresses 
```

If you find the user@domain.mail.onmicrosoft.com smtp address for the user in the command result, but you still don't have this email address in Exchange Online PowerShell by using the **Get-MailUser** command, this means that the Directory Synchronization tool brought the address successfully into Azure AD, and you probably have a synchronization issue between Azure AD and Exchange Online. 

Another cause may be if the domain.mail.onmicrosoft.com smtp domain  that is stamped on the on-premises user is incorrect. For example, the domain doesn't exist in your Office 365 tenant or Exchange Online accepted domains. For more information about accepted domains, see [View accepted domains](https://docs.microsoft.com/exchange/mail-flow-best-practices/manage-accepted-domains/manage-accepted-domains#view-accepted-domains).  

If you cannot determine the cause of the issue, open a support case with Microsoft Support team to investigate further.  

## MORE INFORMATION 

For more info about email address policies and Exchange hybrid deployments, see the "Email address policy" section of the [The cloud on your terms (PART I): deploying hybrid](https://blogs.technet.com/b/exchange/archive/2012/09/20/the-cloud-on-your-terms-part-i-deploying-hybrid.aspx) blog post.

For more info about how to edit an email address policy, see [Edit an email address policy](https://docs.microsoft.com/exchange/edit-an-email-address-policy-exchange-2013-help).

For more info about the coexistence domain that's added by the Hybrid Configuration wizard, see the "Domains" entry at [Hybrid Configuration wizard](https://docs.microsoft.com/exchange/hybrid-configuration-wizard#bkmk_hybridconfigoptions).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).