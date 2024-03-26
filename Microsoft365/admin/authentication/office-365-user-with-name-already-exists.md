---
title: A user with this name already exists error in Microsoft 365 portal
description: Describes an issue in which you receive an A user with this name already exists. Use a different name error message in the Microsoft 365 portal. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# "A user with this name already exists. Use a different name." error in the Microsoft 365 portal

## Problem

In Microsoft 365, you receive an error message that's like the following in the Microsoft 365 portal:

**A user with this name already exists. Use a different name.**

## Cause 

This issue may occur if the user name is already used or if an existing email address that's based on the user name already exists. 

The licensing attempt will fail if the provisioning process determines that another object already has a user name or an email address that matches the user name that's being created.

By default, when users are added or assigned an Exchange Online license, the users are provided with a primary SMTP address that's based on their user name. And, users are provided with an email address that's based on the Microsoft Online Direct Routing Domain (MODRD) such as, for example, contoso.onmicrosoft.com. Additionally, when a user name is changed, the primary SMTP address may also be changed. However, alternate addresses aren't updated or removed.

Here are some example scenarios.

**Scenario 1**

A user is added who has a user name of john@contoso.com, the MODRD for the organization is contoso.onmicrosoft.com, and the user is assigned an Exchange Online License. In this scenario, the following email addresses are provided: 


- The user is provided with a primary SMTP address that's john@contoso.com.   
- The user is provided with an alternate email address that's john@contoso.onmicrosoft.com.   

**Scenario 2**

A user is added who has a user name of john@contoso.onmicrosoft.com, the MODRD for the organization is contoso.onmicrosoft.com, and the user is assigned an Exchange Online License. In this scenario, the following email address is provided:

- The user is provided with a primary SMTP address that's john@contoso.onmicrosoft.com.   

**Scenario 3**

A user name is changed from john@contoso.com to johnsmith@contoso.com. In this scenario, the following events occur:

- The primary SMTP address, john@contoso.com, may be changed to johnsmith@contoso.com.   
- The alternate email address, john@contoso.com, isn't changed. Therefore, problems occur if you try to add john@contoso.com later.   
- No alternate email address for johnsmith@contoso.onmicrosoft.com is created.   

## Solution 

To fix this issue, do one or more of the following:

- When you add a user, use a different user name.   
- When you add a user, find and change the existing user name so that you can use the user name with which you are experiencing the issue.   
- When you add or assign a user to an Exchange Online license, find and change the existing email addresses that are based on the user name that you are trying to use.   

To check whether an email address already exists, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more info about how to do this, go to the following Microsoft website:
   
   [Connect to Exchange Online Using Remote PowerShell](/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell)   
2. Run the following cmdlet:

   ```powershell
   get-mailbox| where {$_.EmailAddresses -match "user name"} | ft Name, RecipientType, EmailAddresses
   ```
   > [!NOTE]
   > "user name" is the user name with which you are experiencing the issue.   
3. Based on the results that you receive after you run the cmdlet, update or delete the existing email address.   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).