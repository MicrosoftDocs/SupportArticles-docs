---
title: Unable to remove this domain when remove a domain from Microsoft 365
description: Describes an issue in which you receive an Unable to remove this domain error message when you try to delete a domain from Microsoft 365 by using Windows PowerShell. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# "Unable to remove this domain" when you try to remove a domain from Microsoft 365

## Problem

When you try to remove a domain from Microsoft 365 by using Windows PowerShell, you get the following error message:

```asciidoc
Remove-MsolDomain : Unable to remove this domain. Use Get-MsolUser -DomainName<domain name> to retrieve a list of objects that are blocking removal.
At line:1 char:18
+ Remove-MsolDomain <<<< -DomainName <DomainName>
+ CategoryInfo : OperationStopped: (:) [Remove-MsolDomain], MicrosoftOnlineException
+ FullyQualifiedErrorId : Microsoft.Online.Administration.Automation.DomainNotEmptyException,Microsoft.Online.Administration.Automation.RemoveDomain
```

## Cause 

This issue occurs if one or more of the following conditions are true: 

- User accounts or groups are associated with the domain.    
- The proxies that correspond to the domain for all mail-licensed users and for all mail-enabled groups aren't removed. Microsoft 365 blocks the deletion of a domain until the proxies that correspond to the domain are removed.   
- Skype for Business Online (formerly Lync Online) Session Initiation Protocol (SIP) addresses are used by the domain.   

## Solution

Use the Microsoft 365 admin center to remove the domain. The Domain Manager in Microsoft 365 will help admins remove any dependencies that block domain removal without having to use Windows PowerShell. 

For more info about how to remove a domain in the Microsoft 365 admin center, go to [Remove a domain](/microsoft-365/admin/get-help-with-domains/remove-a-domain). 

### Troubleshoot domain removal by using Windows PowerShell

> [!NOTE]
> The following steps require admins to use Windows PowerShell. 

#### Step 1: Check whether user names contain the domain name

> [!NOTE]
> You can also create a user view and then set the domain to the domain that you're trying to remove. Use this view to note the user names, and then change the user names so that the domain in question isn't part of the user name.

To check whether user names contain the domain name, follow these steps: 
1. Connect to Microsoft Entra ID by using the Azure Active Directory module for Windows PowerShell. To do this, open the Microsoft Entra Modules for Windows PowerShell, type the following cmdlet, and then press Enter.
   ```powershell
   Connect-MsolService
   ```
   Enter your admin credentials when you're prompted for them.
2. Run the following cmdlet:  
   ```powershell
   Get-MsolUser -DomainName [Domain] | fl UserPrincipalName  
   ```
   For example, run the following, where the contoso.com placeholder represents the domain in question:  
   ```powershell
   Get-MsolUser -DomainName contoso.com | fl UserPrincipalName
   ```      
3. Examine the results, and then change the user principal name (UPN) so that the domain isn't used. The UPN is the same as the user name and the user ID property. You can use the Microsoft 365 portal or Windows PowerShell to change the UPN. The goal is to have no results returned.    
 
#### Step 2: Check email addresses

> [!NOTE]
> - This step applies only if you have a subscription that includes Exchange Online.
> - If you're running the Azure Active Directory Sync tool, you can update email addresses from the on-premises environment.

To check email addresses, follow these steps: 

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online Using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).     
2. Find all users and groups that use the domain that you're trying to remove. To do this, run the following cmdlet. (In this cmdlet, contoso.com represents the domain in question).   
   ```powershell
   get-recipient | where {$_.EmailAddresses -match "contoso.com"} | fl Name, RecipientType, EmailAddresses
   ```       
3. In the output, note the value of the EmailAddresses property and the RecipientTypeproperty. For example, the output may resemble the following:     
   ```asciidoc
   Name : John Smith RecipientType : UserMailbox EmailAddresses : {SIP:john@contoso.com, SMTP:john@contoso.com,   smtp:john@contoso.onmicrosoft.com}
   ```

4. Do one of the following, as appropriate for your situation:  
   - If RecipientType is set to UserMailbox, you can use the Set-Mailboxcmdlet together with the EmailAddresses parameter to change the smtp, SMTP, and SIP addresses. To learn more about this cmdlet, see [Set-Mailbox](/powershell/module/exchange/set-mailbox). 
      
     Or, you can remove the user or license. However, we don't recommend doing this.
     > [!NOTE]
     > If this is the last administrator user, create a new global administrator, sign in, and then remove the problem user.    
   - If RecipientType is set to MailUniversalDistributionGroupor MailUniversalSecurityGroup, you can use the Set-DistributionGroup cmdlet together with the EmailAddresses parameter to change the smtp and SMTP addresses. To learn more about this cmdlet, see [Set-Distribution Group](/powershell/module/exchange/set-distributiongroup).
        
      Or, you can remove the group. However, we don't recommend doing this. If you can't remove the group, follow the steps in ["You don't have sufficient permissions" error when you try to remove or make a change to a distribution group in Microsoft 365"](https://support.microsoft.com/help/2731947).      
   - If the RecipientType is set to DynamicDistributionGroup, you can use the Set-DynamicDistributionGroup cmdlet together with the EmailAddresses parameter to change the smtp and SMTP addresses. To learn more about this cmdlet, see [Set-DynamicDistributionGroup](/powershell/module/exchange/set-dynamicdistributiongroup).
        
     Or, you can remove the group. However, we don't recommend doing this. If you can't remove the group, follow the steps in ["You don't have sufficient permissions" error when you try to remove or make a change to a distribution group in Microsoft 365"](https://support.microsoft.com/help/2731947).      
     
## More information

For more information, see [You get an error message when you try to remove a domain from Microsoft 365](https://support.microsoft.com/help/2284755).  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
