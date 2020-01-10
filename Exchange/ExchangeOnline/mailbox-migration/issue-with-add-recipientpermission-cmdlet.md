---
title: You can't use the domain when you run the Add-RecipientPermission cmdlet
description: Describes an error message that you receive when you run the Add-RecipientPermission cmdlet in Exchange Online if the proxy address of the recipient uses a domain that isn't configured as an accepted domain. Provides a solution.
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

# "You can't use the domain because it's not an accepted domain for your organization" error when you run the Add-RecipientPermission cmdlet

## Problem 

### Scenario 1
 
When you try to run the Add-RecipientPermission cmdlet in Exchange Online, you receive the following error message: 

**You can't use the domain because it's not an accepted domain for your organization.
  CategoryInfo : NotSpecified: (:) [Add-RecipientPermission], NotAcceptedDomainException**


### Scenario 2

When you try to run the New-MoveRequest cmdlet in Exchange Online, in order to move a mailbox from on-premises to Exchange Online, you receive the following error message:


**You can't use the domain because it's not an accepted domain for your organization.
  CategoryInfo : NotSpecified: (:) [New-MoveRequest], NotAcceptedDomainException**

 
### Scenario 3

When you create a migration by using New-MigrationBatch command or from Exchange Online Exchange Admin Center, in order to move a mailbox from On-Premises to Exchange Online, after a while the migration will fail. And you'll see the following output on the ErrorSummary when you run:    

```powershell
Get-MigrationUserStatistics User1@contoso.com | fl
```

**You can't use the domain because it's not an accepted domain for your organization.**     

## Cause 

The proxy address of the recipient uses a domain that isn't configured as an accepted domain in the organization. 

## Solution 

Do one of the following: 
 
- Add and verify the domain. For more information, see [Adding additional domains to Office 365](https://support.office.com/article/adding-additional-domains-to-office-365-2d2fa996-b760-411d-a5cc-190d63f13207).     
- Remove the proxy address from the recipient. For more information, see [Add or remove email addresses for a mailbox](https://technet.microsoft.com/library/bb123794%28v=exchg.160%29.aspx).    
- Assign an Exchange Online license to the affected user. For more information, see [Assign licenses to users in Office 365 for business](https://docs.microsoft.com/office365/admin/subscriptions-and-billing/assign-licenses-to-users?view=o365-worldwide) or [Assign licenses to user accounts with Office 365 PowerShell](https://docs.microsoft.com/office365/enterprise/powershell/assign-licenses-to-user-accounts-with-office-365-powershell).    
  
## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).