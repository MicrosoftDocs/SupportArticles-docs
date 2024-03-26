---
title: Can't verify domain error when you try to verify a domain in Microsoft 365
description: Describes a scenario in which you can't verify a domain in Microsoft 365 if the domain exists in another Microsoft cloud service or was federated with Exchange Online. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# "Can't verify domain" error message when you try to verify a domain in Microsoft 365

## Problem 

When you try to verify a domain in Microsoft 365, you receive the following error message:

> Can't verify domain 
>
> We can't verify the domain because it is associated with another Microsoft hosted service. A domain can be associated with only one service. To use this domain, first remove it from the other service, and then try again to verify the domain. If you still can't verify the domain, contact Microsoft Online Services Support to resolve the issue 

## Cause 

This issue occurs if one of the following conditions is true:

- The domain exists in another Microsoft cloud service. For example, this domain exists in Live@edu.   
- The domain is federated with Microsoft Exchange Online.   


## Solution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### You use your domain in Live@edu
 The domain can exist only in one service. If you use the domain in Live@edu and you want to use the domain in Microsoft 365, remove the domain from Live@edu. 

### You previously set up an Exchange federation trust (Exchange delegation) 
If the domain exists from an Exchange federation trust that was previously set up, remove the Exchange federation trust. For more information about how to do this, go to the following Microsoft website:

[Remove a Federation Trust](/previous-versions/office/exchange-server-2010/dd297972(v=exchg.141))

### You still receive the error message

If you still receive the error message, contact Live@edu Support at (800) 455-6399, and have them check whether the domain is currently provisioned or whether it's used for Exchange federation. Specifically, have Live@edu Support check the Known to Systemand Passport Namespace State values in Syndication Central.

## More Information

To check whether your Microsoft 365 account has an Exchange federation trust set up 

If you previously verified your domain in your Microsoft 365 account or in another Microsoft 365 account, use Windows PowerShell in Exchange Online to check whether the domain is set up for an Exchange federation trust. To do this, run the following Windows PowerShell cmdlet from Exchange Online PowerShell:
 
```PowerShell
Get-FederationInformation -DomainName <domain.onmicrosoft.com> Examine the DomainNamesproperty in the output. If the domain that you are trying to verify is listed, remove the federation trust for that domain. 
```

For example, the output will resemble the following:

```adoc
>PS C:\users\administrator\Desktop> Get-FederationInformation -DomainName contoso.onmicrosoft.com 

>RunspaceId : e5d5c1a3-1c2a-4747-9c7e-170cfb848b2e 
  TargetApplicationUri : outlook.com Br/>DomainNames : {contoso.onmicrosoft.com, contoso.com } 
  TargetAutodiscoverEpr : https://pod51008.outlook.com/autodiscover/autodiscover. 
  svc/WSSecurity 
  TokenIssuerUris : {uri:WindowsLiveID, urn:federation:MicrosoftOnline} 
  IsValid : True 
```

## References

For more information about how to troubleshoot domain verification issues in Microsoft 365, see the following Microsoft Knowledge Base article:

[2515404](https://support.microsoft.com/help/2515404) Troubleshoot domain verification issues in Microsoft 365

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).