---
title: Site mailbox retirement FAQs
description: Lists frequently asked questions about the retirement of site mailboxes.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 147171
  - CSSTroubleshoot
ms.reviewer: batre
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Site mailbox retirement - April 2021

<a id="summary"></a>

The site mailbox feature was [deprecated for Exchange Online in 2017](https://techcommunity.microsoft.com/t5/microsoft-sharepoint-blog/deprecation-of-site-mailboxes/ba-p/93028). In October 2020, we announced that all site mailboxes will be [discontinued after April 2021](https://techcommunity.microsoft.com/t5/microsoft-365-blog/update-retirement-of-sharepoint-site-mailboxes-in-microsoft-365/ba-p/1754704). No extension will be provided beyond this time frame.

To avoid disruption in your services, we encourage you to remove all dependencies from site mailboxes in your organization as soon as possible. This article answers questions that you might have about how the retirement will affect your organization and what actions you should take.

- [What is a site mailbox?](#what-is-a-site-mailbox)
- [How can I check whether my organization is using site mailboxes?](#how-can-i-check-whether-my-organization-is-using-site-mailboxes)
- [How can I keep the data from my site mailboxes?](#how-can-i-keep-the-data-from-my-site-mailboxes)
- [Will deleting a site mailbox remove the documents in the associated SharePoint site?](#will-deleting-a-site-mailbox-remove-the-documents-in-the-associated-sharepoint-site)
- [Are site mailboxes still accessible in Outlook and OWA?](#are-site-mailboxes-still-accessible-in-outlook-and-owa)

## What is a site mailbox?

A site mailbox is a data repository for email messages and documents that collaborating groups of users can access from a single client interface. Each site mailbox is associated with an Exchange mailbox that stores email messages and with a SharePoint site that stores documents. For more information, see [Site mailboxes](/exchange/collaboration/site-mailboxes).

[Back to top](#summary)

## How can I check whether my organization is using site mailboxes?

You can use Exchange Online PowerShell to determine the following:

- Whether your organization is using site mailboxes.
- How many site mailboxes, if any, it has.
- The URLs of the associated SharePoint sites.

In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), run the following cmdlet:

```powershell
Get-SiteMailbox -BypassOwnerCheck -ResultSize Unlimited | ft Name, WhenCreated, ClosedTime, SharePointUrl -AutoSize
```

If the cmdlet returns a blank output, your organization doesn't use site mailboxes. Therefore, your organization won't be affected by this feature retirement.

If your organization uses site mailboxes, you'll see a list of the mailboxes and their associated SharePoint site URLs. To prepare for the site mailbox retirement, we recommend that you [back up the site mailboxes and then delete them](/sharepoint/deprecation-of-site-mailboxes).

[Back to top](#summary)

## How can I keep the data from my site mailboxes?

If you want to keep the data that's in your site mailboxes, you can migrate the site mailboxes to either [Microsoft 365 Groups](/microsoft-365/admin/create-groups/office-365-groups) or shared mailboxes by using one of the following methods.

**Note:** If you have subfolders in your site mailboxes, and you want to preserve their structure after the migration, use Method 2 because Microsoft 365 Groups doesn't support subfolders.

Method 1: [Connect each associated SharePoint site to a new Microsoft 365 group](https://techcommunity.microsoft.com/t5/microsoft-sharepoint-blog/rolling-out-tenant-admin-tools-to-connect-existing-sharepoint/bc-p/188867).

Method 2: [Export the data in each site mailbox to a PST file, and then import the PST file to a shared mailbox](/sharepoint/deprecation-of-site-mailboxes).

The **Documents** folder in the site mailbox is a part of the associated SharePoint site. The links that it contains are shortcuts to the documents that are stored on the SharePoint site. When you export the site mailbox to a PST file, these shortcuts are broken and won't function reliably in the new shared mailbox that you import them to.

For example, when you access the **Documents** folder in a shared mailbox from Outlook on the web, email messages will include the SharePoint document links, as shown in the following screenshot. However, the links won't be active.

:::image type="content" source="media/site-mailbox-retirement-faq/owa-messages.png" alt-text="Screenshot of the links displayed in the Documents folder.":::

In the Microsoft Outlook client, the links will be marked as unsafe and won't be displayed.

:::image type="content" source="media/site-mailbox-retirement-faq/outlook-messages.png" alt-text="Screenshot of unsafe message displayed in the Documents folder.":::

[Back to top](#summary)

## Will deleting a site mailbox remove the documents in the associated SharePoint site?

Ideally, you would delete the associated SharePoint site to enable Exchange to be notified that it should delete that site mailbox. However, if you want to keep the SharePoint site, you can delete only the site mailbox by running the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

```powershell
Get-Mailbox <site_mailbox_name>:* | ?{$_.RecipientTypeDetails -eq "TeamMailbox"} | Remove-Mailbox -Confirm:$false
```

**Note:** In this command, replace \<site_mailbox_name> with the name of the site mailbox that you want to delete.

The system will remove the link to the site mailbox from the associated SharePoint site when the site mailbox is deleted. Deleting only the site mailbox won't affect the data that's stored on the SharePoint site.

[Back to top](#summary)

## Are site mailboxes still accessible in Outlook and OWA?

Following [our announcement to retire site mailboxes](https://techcommunity.microsoft.com/t5/microsoft-365-blog/update-retirement-of-sharepoint-site-mailboxes-in-microsoft-365/ba-p/1754704), access to site mailbox from the clients (Outlook and OWA) is now stopped. 

Because of this change, you'll experience the following conditions in Outlook and OWA:

- Outlook

   Outlook displays site mailboxes in the left pane in the same manner in which it displays automatically mapped delegate mailboxes. Outlook no longer receives site mailbox-related payloads in the Autodiscover feature that was used to automatically map site mailboxes. Any existing automatically mapped site mailboxes will be removed from the Outlook client. Users won't receive any related error messages.

- Outlook on the web (OWA) extension

  Selecting the site mailbox application in the SharePoint website starts the OWA extension to display site mailbox content. Because site mailboxes are no longer accessible, users will receive the following error message when they try to access a site mailbox:

  > HTTP 500 something went wrong, You don't have access to this mailbox.
  >
  > Microsoft.Exchange.Clients.Owa2.Server.Core.OwaExplicitLogonException

  This change doesn't block you from exporting site mailbox data to a .pst file by using eDiscovery. You can follow the steps under "How can I keep the data from my site mailboxes?" to export data from site mailboxes to a .pst file.
  
  [Back to top](#summary)  
