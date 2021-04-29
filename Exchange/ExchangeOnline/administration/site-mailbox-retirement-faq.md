---
title: Site mailbox retirement FAQs
description: Lists frequently asked questions about the retirement of site mailboxes.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 147171
- CSSTroubleshoot
ms.reviewer: batre
appliesto:
- Exchange Online
search.appverid: MET150
---
# Site mailbox retirement - April 2021

<a id="summary"></a>

The site mailbox feature was [deprecated for Exchange Online in 2017](https://techcommunity.microsoft.com/t5/microsoft-sharepoint-blog/deprecation-of-site-mailboxes/ba-p/93028). In October 2020, we announced that all site mailboxes will be [discontinued after April 2021](https://techcommunity.microsoft.com/t5/microsoft-365-blog/update-retirement-of-sharepoint-site-mailboxes-in-microsoft-365/ba-p/1754704). No extension will be provided beyond this timeframe.

To avoid disruption in your services, we encourage you to remove all dependencies from site mailboxes in your organization as soon as possible. This article answers questions that you might have about how the retirement will affect your organization and what actions you should take.

- [What is a site mailbox?](#what-is-a-site-mailbox)
- [How can I check whether my organization is using site mailboxes?](#how-can-i-check-whether-my-organization-is-using-site-mailboxes)
- [What should I do if I want to keep the data in my site mailboxes?](#what-should-i-do-if-i-want-to-keep-the-data-in-my-site-mailboxes)
- [Will deleting a site mailbox remove the documents in the associated SharePoint site?](#will-deleting-a-site-mailbox-remove-the-documents-in-the-associated-sharepoint-site)

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

If the output is not blank, you'll see a list of the site mailboxes and their associated SharePoint site URLs. To prepare for the site mailbox retirement, we recommend that you [back up the site mailboxes and then delete them](/sharepoint/deprecation-of-site-mailboxes).

[Back to top](#summary)

## What should I do if I want to keep the data in my site mailboxes?

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
