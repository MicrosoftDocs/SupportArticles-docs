---
title: External sharing is disabled for the site when a delegated partner administrator tries to access a client's SharePoint Online Admin Center
description: Describes an issue in which External sharing is disabled for the site when a delegated partner administrator tries to access a client's SharePoint Online Admin Center.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Sharing\External
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "External sharing is disabled for the site" error when a delegated partner administrator tries to access a client's SharePoint Online Admin Center

## Problem

When a delegated partner administrator tries to access the SharePoint Online Admin Center of one of the partner's clients in Microsoft SharePoint Online, the following error message is returned:

> External sharing is disabled for the site.

## Solution

To fix this issue, use the [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/introduction-sharepoint-online-management-shell) to delete the guest account from the client's organization. To do so, run the following cmdlet:

> [!NOTE]
> You must run the cmdlet by using a SharePoint admin or global admin account of the client's organization.

```powershell
$user = Get-SPOExternalUser -Filter someone@example.com
Remove-SPOExternalUser -UniqueIDs @($user.UniqueId)
```

For more information about this cmdlet, see [Remove-SPOExternalUser](/powershell/module/sharepoint-online/Remove-SPOExternalUser).

## More information

This issue occurs when the account that the delegated partner administrator uses for sign-in was originally invited to the SharePoint Online site of the partner's client as an guest. Guest permissions override a delegated partner's permissions. This prevents guests from accessing the SharePoint Online Admin Center.

For more information, see [Partners: Build your business and administer your Microsoft 365 partner account](https://support.microsoft.com/topic/partners-build-your-business-and-administer-your-office-365-partner-subscription-30dd1681-47e0-4cbc-abfe-a222cd111319).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
