---
title: SharePoint identity and permission issues in two-way domain trust if active accounts share SID history
description: Fixes SharePoint exhibits identity and permission issues in a two-way domain trust if active accounts share an SID history.
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
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# SharePoint identity and permission issues in two-way domain trust

## Symptoms  

Assume that there's a two-way domain trust between two domains (Domain A and Domain B). Users are migrated to Domain B together with the SID history from Domain A, and the users are still active in Domain A. In a SharePoint farm that resides in one of the domains, you may experience the following issues:   

- Users from one of the domains can't be found in the people picker. This behavior might be consistent or intermittent.     
- When you try to assign permissions to a user, you receive the following error message:   

  **The User does not exist or isn't unique.**    

- Users lose their permissions to SharePoint sites, or they can't access SharePoint sites where they have permissions assigned.     
- User profile data disappears randomly.       

## Cause  

This issue occurs because the underlying .NET assemblies that are used by SharePoint query for user accounts by the objectSid attribute. When two Active Directory accounts share an SID history (the objectSid attribute from one account is listed in the sidHistory attribute of another account), the two accounts are basically considered as the same account by Active Directory. A call to Active Directory to retrieve the account information may return the account from Domain A or the account from Domain B.   

## Resolution  

This scenario is unsupported. SharePoint can't reside in a domain that's part of a two-way domain trust where users who have active accounts in both domains share SID history. Each account must be unique. To make sure that this is the case, you need to do one of the following in Active Directory:   

- Disable the source account.     
- Delete the source account's objectSid attribute from the SID history of the destination account.       

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
