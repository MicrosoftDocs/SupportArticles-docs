---
title: External sharing is disabled for the site when a delegated partner administrator tries to access a client's SharePoint Online Admin Center
description: Describes an issue in which External sharing is disabled for the site when a delegated partner administrator tries to access a client's SharePoint Online Admin Center.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# "External sharing is disabled for the site" error when a delegated partner administrator tries to access a client's SharePoint Online Admin Center

## Problem

When a delegated partner administrator tries to access the SharePoint Online Admin Center of one of the partner's clients in Microsoft SharePoint Online, he or she receives the following error message:

**External sharing is disabled for the site.**

## Solution

To resolve this issue, use the SharePoint Online management shell to delete the guest account from the client's organization. To do this, run the following cmdlet (you can't run this step using the same delegated partner administrator account, it must be run using a SharePoint Online administrator or Global Administrator account of the partner's client):

```powershell
$user = Get-SPOExternalUser -Filter someone@example.com
Remove-SPOExternalUser -UniqueIDs @($user.UniqueId)
```

For more information about this cmdlet, go to the following Microsoft websites:

- [Remove-SPOExternalUser](/powershell/module/sharepoint-online/Remove-SPOExternalUser)

- [What is the SharePoint Online Management Shell?](/powershell/sharepoint/sharepoint-online/introduction-sharepoint-online-management-shell)

## More information

This issue occurs when the account that the delegated partner administrator uses for sign-in was originally invited to the SharePoint Online site of the partner's client as an guest. Guest permissions override a delegated partner's permissions. This prevents guests from accessing the SharePoint Online Admin Center.

For more information, go to [Partners: Build your business and administer your Office 365 partner account](https://support.office.com/article/partners-build-your-business-and-administer-your-office-365-partner-subscription-30dd1681-47e0-4cbc-abfe-a222cd111319?ocmsassetID=HA102927574&CorrelationId=af24bbd4-dab1-4c25-a7f3-dc0767260c34&ui=en-US&rs=en-US&ad=US).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
