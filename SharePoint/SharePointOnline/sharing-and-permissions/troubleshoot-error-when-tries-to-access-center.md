---
title: Error when a delegated partner administrator accesses a client's SharePoint Online admin center
description: Provides a resolution for an issue in which external sharing is disabled for the site when a delegated partner administrator tries to access a client's SharePoint Online admin center.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Sharing\External
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 08/09/2024
---

# Error when a delegated partner administrator accesses a client's SharePoint Online admin center

## Symptoms

When a delegated partner administrator tries to access the SharePoint Online admin center of one of the partner's clients in Microsoft SharePoint Online, the following error message displays:

> External sharing is disabled for the site.

## Cause

This issue occurs when the account that the delegated partner administrator used to sign in is originally invited to the SharePoint Online site of the partner's client as a "Guest". Guest permissions override a delegated partner's permissions. Therefore guests can't access the SharePoint Online admin center.

## Solution

To fix this issue, use [SharePoint Online Management Shell](/powershell/sharepoint/sharepoint-online/introduction-sharepoint-online-management-shell) to delete the guest account from the client's organization. Run the following cmdlet:

> [!NOTE]
> You must run the cmdlet by using a SharePoint admin account in the client's organization.

```powershell
$user = Get-SPOExternalUser -Filter someone@example.com
Remove-SPOExternalUser -UniqueIDs @($user.UniqueId)
```

For more information about this cmdlet, see [Remove-SPOExternalUser](/powershell/module/sharepoint-online/Remove-SPOExternalUser).

## More information

For more information, see [Partners: Build your business and administer your Microsoft 365 partner account](https://support.microsoft.com/topic/partners-build-your-business-and-administer-your-office-365-partner-subscription-30dd1681-47e0-4cbc-abfe-a222cd111319).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
