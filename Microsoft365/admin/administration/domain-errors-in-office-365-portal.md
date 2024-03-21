---
title: Domain errors in the Microsoft 365 portal
description: Describes all domain error messages that you may experience in the Microsoft 365 portal.
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
  - Azure Active Directory
  - Microsoft 365 User and Domain Management
ms.date: 03/31/2022
---

# Domain errors in the Microsoft 365 portal

## Introduction 

This article lists all domain error messages that you may experience in the Microsoft 365 portal.

## More information

The following table contains the cause and the resolution for each error message.

|Error message |Cause| Resolution |
|---|---|---|
| Number of unverified domains exceeded. Your account has too many unverified domains. Verify or delete one of your unverified domains, and then add the new domain.|The maximum number of 100 unverified domains is reached.|To resolve this issue, see [An administrator cannot add a domain to a Microsoft 365 account](https://support.microsoft.com/help/2279117).   |
| Domain already exists. The domain is already associated with your account.|The domain already exists within the Microsoft 365 subscription.|To resolve this issue, see [An administrator cannot add a domain to a Microsoft 365 account](https://support.microsoft.com/help/2279117). |
|From the Office 365 portal: Unable to remove domain. From Windows PowerShell: Remove-MsolDomain: Unable to remove this domain. Use Get-MsolUser -DomainName. \<**DomainName**\> to retrieve a list of objects that are blocking removal. At line: 1 char:18 +Remove-MsolDomain <<<< -DomainName \<**DomainName**\>+CategoryInfo: OperationStopped: (:) [Remove-MsolDomain], MicrosoftOnlineException +FullyQualifiedErrorId: Microsoft.Online.Administration.Automation DomainNotEmptyException Microsoft.Online.Administration.Automation.RemoveDomain|This issue may occur if the two conditions are true: There are user accounts that are associated with this domain. There are email accounts or Skype for Business Online (formerly Lync Online) accounts that are using this domain.|To resolve this issue, see ["Unable to remove this domain" error when you try to remove a domain from Microsoft 365](https://support.microsoft.com/help/2787210).
|From the Office 365 portal: Domain has associated subdomains. From Windows PowerShell: Remove-MsolDomain: You cannot remove a domain that has subdomains. You must first delete the subdomains before you can remove this domain. At line: 1 char:18 + Remove-MsolDomain <<<< -DomainName \<**DomainName**\> + CategoryInfo: OperationStopped: (:) [Remove-MsolDomain], MicrosoftOnlineException + FullyQualifiedErrorId: Microsoft.Online.Administration.Automation.Domai nHasChildDomainException Microsoft.Online.Administration.Automation.RemoveDomain|The domain has associated subdomains.|To resolve this issue, see  ["Domain has associated subdomains" or "You cannot remove a domain that has subdomains" error when you try to remove a domain from Microsoft 365 ](https://support.microsoft.com/help/2787792).
|From the Office 365 portal: Domain is the primary/default domain. From Windows PowerShell: Remove-MsolDomain: You cannot delete the default domain. Use the Set-MsolDomain cmdlet to set another domain as the default domain before you delete this domain. At line: 1 char:18 + Remove-MsolDomain <<<< -DomainName\<**DomainName**\> + CategoryInfo: OperationStopped: (:) [Remove-MsolDomain], MicrosoftOnlineException + FullyQualifiedErrorId: Microsoft.Online.Administration.Automation.DefaultDomainDeletionException,Microsoft.Online.Administration.Automation.RemoveDomain |The domain is the primary or default domain.|To resolve this issue, see ["You cannot delete the default domain" error when you try to remove a domain from Microsoft 365 ](https://support.microsoft.com/help/2787250).
|Cannot Remove Domain \<**DomainName**\> can't be removed because you're using it for your SharePoint Online website. If you want to remove the domain, first change the address that you're using for SharePoint Online to a different domain.|You are using the domain for your SharePoint Online website address.|To resolve this issue, see ["Cannot Remove Domain" error when you try to remove a domain from Microsoft 365 ](https://support.microsoft.com/help/2787264).  |
|The "Remove domain" link is unavailable Remove-MsolDomain: You cannot delete the default domain. Use the Set-MsolDomain cmdlet to set another domain as the default domain before you delete this domain. At line: 1 char:18 + Remove-MsolDomain <<<< -DomainName \<**DomainName**\> + CategoryInfo: OperationStopped: (:) [Remove-MsolDomain], MicrosoftOnlineException + FullyQualifiedErrorId: Microsoft.Online.Administration.Automation.DefaultDomainDeletionException,Microsoft.Online.Administration.Automation.RemoveDomainRemove-MsolDomain: You cannot remove the initial domain created for you in Office 365. At line: 1 char:18 + Remove-MsolDomain <<<< -DomainName \<**DomainName**\> + CategoryInfo: OperationStopped: (:) [Remove-MsolDomain], MicrosoftOnlineException + FullyQualifiedErrorId: Microsoft.Online.Administration.Automation.InitialDomainDeletionException,Microsoft.Online.Administration.Automation.RemoveDomain|You're trying to delete the Microsoft Online Routing Domain. (For example, you're trying to delete contoso.onmicrosoft.com.) This domain can't be deleted.|To resolve this issue, see [ The "Remove" domain link is unavailable or "You cannot remove the initial domain" error when you try to remove a domain from Microsoft 365](https://support.microsoft.com/help/2284755).
| Verification DNS record not found. We couldn't verify **DomainName**. Make sure that the verification DNS record that you created at your domain registrar is correct, and that you've waited at least 72 hours after you added the record. Or, you receive this error: Sorry, we can't find the record you created.|This issue may occur if the two conditions are true: The Domain Name System (DNS) record was not created correctly. The DNS record hasn't propagated to all DNS servers. Changes to the Simple Mail Transfer Protocol (SMTP) domain may take 72 hours to propagate to all DNS servers. |To resolve this issue, see [Troubleshoot domain verification issues in Microsoft 365](https://support.microsoft.com/help/2515404)
| **DomainName** has already been verified for your account, or for another Microsoft Online Services account.|The domain exists in another Microsoft 365 organization.|To resolve this issue, see [Troubleshoot domain verification issues in Microsoft 365 ](https://support.microsoft.com/help/2515404)
| Can't verify domain. We can't verify the domain because it is associated with another Microsoft hosted service. A domain can be associated with only one service. To use this domain, first remove it from the other service, and then try again to verify the domain. If you still can't verify the domain, contact Microsoft Online Services Support to resolve the issue.|The domain exists in another Microsoft 365 organization.|To resolve this issue, see [Troubleshoot domain verification issues in Microsoft 365](https://support.microsoft.com/help/2515404)
| Sorry, we can't display information about your domains right now. Wait a few minutes, and try again.|Microsoft 365 portal can't communicate with Microsoft Entra ID in which domain information for the company is stored.|To resolve this issue, try again later and wait up to 24 hours. 
| Sorry, we can't add your domain right now. Wait a few minutes, and try again.|Microsoft 365 portal can't communicate with Microsoft Entra ID in which domain information for the company is stored.|To resolve this issue, try again later and wait up to 24 hours. 
| Sorry, we can't verify your domain right now. Try again later.|Microsoft 365 portal can't communicate with Microsoft Entra ID in which domain information for the company is stored.|To resolve this issue, try again later and wait up to 24 hours. 
| Sorry, we can't display DNS record information for Office 365 services right now. Try again later.|Microsoft 365 portal can't communicate with Microsoft Entra ID in which domain information for the company is stored.|To resolve this issue, try again later and wait up to 24 hours. 
| Sorry, we can't display DNS record information for your domain right now. Try again later.|Microsoft 365 portal can't communicate with the DNS in which your DNS records are hosted.|To resolve this issue, try again later and wait up to 24 hours. 
| Sorry, we can't save your record right now. Try again later.|Microsoft 365 portal can't communicate with the DNS in which your DNS records are hosted.|To resolve this issue, try again later and wait up to 24 hours. 
| Sorry, we can't remove your domain right now. Try again later.|Microsoft 365 portal can't communicate with Microsoft Entra ID in which domain information for the company is stored.|To resolve this issue, try again later and wait up to 24 hours. 
| Sorry, we can't help troubleshoot right now. Try again later.|Microsoft 365 portal can't communicate with Microsoft Entra ID in which domain information for the company is stored.|To resolve this issue, try again later and wait up to 24 hours. 
| Sorry, we can't complete this right now. Wait a little bit, and then try again.|Microsoft 365 portal can't communicate with Microsoft Entra ID in which domain information for the company is stored.|To resolve this issue, try again later and wait up to 24 hours. 
| Sorry, we can't complete this right now. Try again later.|Microsoft 365 portal can't load the page.|To resolve this issue, try again later and wait up to 24 hours. |

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
