---
title: Microsoft Teams admin center error FAILED_TO_AUTO_DISCOVER_DOMAIN
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 10/30/2023
audience: ITPro
ms.topic: troubleshooting
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

# FAILED_TO_AUTO_DISCOVER_DOMAIN error in Microsoft Teams admin center

## Summary

You see a FAILED_TO_AUTO_DISCOVER_DOMAIN error message when you try to connect to the Microsoft Teams admin center.

The following situations might cause this error to occur.

### SIPDomain is not enabled in the tenant

This issue can be resolved by following these steps:

1. Connect to Skype for Business Online with PowerShell:

   - [Manage Skype for Business Online with Microsoft 365 PowerShell](/office365/enterprise/powershell/manage-skype-for-business-online-with-office-365-powershell)

2. Verify that SIPDomain is enabled by running [Get-CsOnlineSipDomain](/powershell/module/skype/get-csonlinesipdomain).

3. Enable [SipDomain for the domain](/powershell/module/skype/enable-csonlinesipdomain).<br/>
   PowerShell cmdlet: `Enable-CsOnlineSipDomain -Domain <yourdomain>`

This fix can take from 15 minutes to an hour to take effect.

### No user is licensed for Skype for Business or Teams 

The domain should have at least one user licensed for Skype for Business or Teams. A global admin or company tenant has to assign a Skype for Business license or a Teams license to a user account that has either a Teams Admin role or a Global Admin role.

To assign a license:

1. Sign in to the [Microsoft 365 admin center](https://go.microsoft.com/fwlink/p/?linkid=2024339) with your admin account.
2. Go to the **Users** > **Active Users** page.
3. Select the user that you want to assign a license to.
4. In the right pane, select **Licenses and Apps**.
5. Expand the **Licenses** section, select the **Skype for Business Online** or **Microsoft Teams** checkbox, and then select **Save changes**.

This fix can take 24 hours for synchronization to take effect.

### IP and URLs are not allowed

To resolve this issue, follow the guidance in [Skype for Business Online and Microsoft Teams](/office365/enterprise/urls-and-ip-address-ranges#skype-for-business-online-and-microsoft-teams) to allow (or allowlist) IPs and URLs that are required for Teams portal access.​

### A Skype for Business hybrid connection is not set up for Skype for Business on-premises and Teams interoperability (hybrid configuration only)

For Skype for Business and Teams interoperability, [a Skype for Business hybrid model is required](/microsoftteams/migration-interop-guidance-for-teams-with-skype).

### The result of an ongoing service incident

This error can also be caused by any ongoing service incident. For a list of current incidents, see your [service health dashboard](https://admin.microsoft.com/Adminportal/Home?source=applauncher#/servicehealth).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
