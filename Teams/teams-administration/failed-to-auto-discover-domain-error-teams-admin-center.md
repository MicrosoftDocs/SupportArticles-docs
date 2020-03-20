---
title: Microsoft Teams admin center error "FAILED_TO_AUTO_DISCOVER_DOMAIN"
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 3/19/2020
audience: ITPro
ms.topic: article
ms.prod: Teams
localization_priority: Normal
search.appverid:
- SPO160
- MET150'
appliesto:
- Microsoft Teams
ms.custom: 
- CI 115814
- CSSTroubleshoot 
ms.reviewer: prbalusu 
description: Methods to resolve the error FAILED_TO_AUTO_DISCOVER_DOMAIN in the Microsoft Teams admin center. 
---

# "FAILED_TO_AUTO_DISCOVER_DOMAIN" error in Microsoft Teams admin center

## Summary

You see the error `FAILED_TO_AUTO_DISCOVER_DOMAIN` when connecting to the Microsoft Teams admin center.

## More information

The following situations might cause this error to appear:

### SIPDOmain is not enabled in the tenant

This issue can be resolved by following the instructions below:
 
1. Connect to Skype online with Powershell

   - [Skype for Business Online, Windows PowerShell Module](https://www.microsoft.com/download/details.aspx?id=39366)
   - [Manage Skype for Business Online with Office 365 PowerShell](https://docs.microsoft.com/office365/enterprise/powershell/manage-skype-for-business-online-with-office-365-powershell)

2. Verify whether SIPDomain is enabled by [Get-CsOnlineSipDomain](https://docs.microsoft.com/powershell/module/skype/get-csonlinesipdomain).

3. Enable [SipDomain for the domain](https://docs.microsoft.com/powershell/module/skype/enable-csonlinesipdomain).<br/>
   Powershell Cmdlet: `Enable-CsOnlineSipDomain -Domain <yourdomain>`

This fix can take anywhere from 15 minutes to an hour to take effect.

### No user is licensed for Skype for Business or Teams 

The domain should have at least one user licensed for Skype for Business or Teams. A global admin or company tenant needs to assign a Skype for Business license to a user account with either a Teams Admin role or a Global Admin role.​​

To assign a license:

1. Sign in to https://portal.office.com.
2. Navigate to **Admin** and then **Users**.
3. Select **Active users** and then **Product license**.
4. Select **Edit** and then select **Turn on Skype for Business license**.

If there is an Office 365 E5 plan, expand the available products list and select **Skype for Business license**. It must be active together with Microsoft Teams.​​

This fix can take 24 hours for synchronization to take effect.

### IP and URLs are not white-listed

To resolve this issue, follow the guidance in [Skype for Business Online and Microsoft Teams](https://docs.microsoft.com/office365/enterprise/urls-and-ip-address-ranges#skype-for-business-online-and-microsoft-teams) to allow or white-list IPs and URLs needed for Teams portal access.​

### A Skype for Business hybrid connection is not set up for Skype for Business on-premises and Teams interoperability (hybrid config only)

For Skype for Business and Teams interoperability, [a Skype for Business hybrid model is required](https://docs.microsoft.com/microsoftteams/migration-interop-guidance-for-teams-with-skype).

### The result of an ongoing service incident

This error can also result from any ongoing service incident. For a list of current incidents, see your [service health dashboard](https://admin.microsoft.com/Adminportal/Home?source=applauncher#/servicehealth).
