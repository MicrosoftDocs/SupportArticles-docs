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
# Site mailbox retirement FAQs

<a id="summary"></a>

The site mailboxes are being retired and will be out of service and removed. Here's a list of frequently asked questions (FAQs) about the retirement of site mailboxes. Select a question to find the answer.

- [What is a site mailbox?](#what-is-a-site-mailbox)
- How do I know whether my organization is using site mailboxes and how many site mailboxes are in the organization? How can I find SharePoint sites that are associated with the site mailboxes?
- What should I do if I have been heavily invested in using site mailboxes?
- What will happen to the SharePoint site that hosts a site mailbox after the site mailbox is deleted?
- How do I migrate the site mailbox functionality to a group mailbox?
- Do you have any recommendations for Microsoft 365 Groups not supporting multiple folders?
- How do I bulk import the site mailbox PST files to a shared mailbox?
- What will happen to site mailboxes after April 2021? Will they be automatically deleted?
- Can the retirement deadline of site mailboxes be extended?

## What is a site mailbox?

The [site mailbox](/exchange/collaboration/site-mailboxes), first introduced in Exchange Server 2013, improves the collaboration and user productivity by allowing access to both Microsoft SharePoint documents and Exchange email messages using the same client interface. A site mailbox is functionally comprised of the following components:

- SharePoint site membership (owners and members)
- Shared storage through an Exchange mailbox for email messages and a SharePoint site for documents
- A management interface that addresses provisioning and lifecycle needs

The site mailbox feature was [deprecated for Exchange Online in 2017](https://techcommunity.microsoft.com/t5/microsoft-sharepoint-blog/deprecation-of-site-mailboxes/ba-p/93028) and the [retirement of site mailboxes was announced in October 2020](https://techcommunity.microsoft.com/t5/microsoft-365-blog/update-retirement-of-sharepoint-site-mailboxes-in-microsoft-365/ba-p/1754704). Use [Microsoft 365 Groups](/microsoft-365/admin/create-groups/office-365-groups) as the successor to the site mailbox and related features.

[Back to top](#summary)

## How do I know whether my organization is using site mailboxes and how many site mailboxes are in the organization? How can I find SharePoint sites that are associated with the site mailboxes?

To list site mailboxes that are present in your organization and list the associated SharePoint sites, follow these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Run the following cmdlet:

   ```powershell
   Get-SiteMailbox -BypassOwnerCheck -ResultSize Unlimited | ft Name, WhenCreated, ClosedTime, SharePointUrl -AutoSize
   ```

If you don't get any site mailboxes in the result, there is no action required. Otherwise, [backup the mailboxes and remove them](/sharepoint/deprecation-of-site-mailboxes).

[Back to top](#summary)

## What should I do if I have been heavily invested in using site mailboxes?

You can [connect the SharePoint team site that hosts the site mailbox to Microsoft 365 Groups](https://techcommunity.microsoft.com/t5/microsoft-sharepoint-blog/rolling-out-tenant-admin-tools-to-connect-existing-sharepoint/bc-p/188867). Alternatively, you can export the site mailbox data to a PST file, and then import the PST file. For more information about the steps, see [Retirement of site mailboxes](/sharepoint/deprecation-of-site-mailboxes).  

[Back to top](#summary)

## What will happen to the SharePoint site that hosts a site mailbox after the site mailbox is deleted?

Ideally, when you delete a site mailbox, the associated SharePoint site should be deleted. However, if you want to keep the SharePoint site, delete only the site mailbox by using the following [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) command:

```powershell
Get-Mailbox <site mailbox name>:* | ?{$_.RecipientTypeDetails -eq "TeamMailbox"} | Remove-Mailbox -Confirm:$false 
```

**Note:** Replace \<site mailbox name> with the name of the site mailbox you want to delete. Here's an example:

```powershell
Get-Mailbox MDEL:* | ?{$_.RecipientTypeDetails -eq "TeamMailbox"} | Remove-Mailbox -Confirm:$false
```

By using this command, the system removes the site mailbox link from the SharePoint site when a site mailbox is deleted. Deleting only the site mailbox doesn't affect the data on the SharePoint site.

[Back to top](#summary)

## How do I migrate the site mailbox functionality to a group mailbox?

You can [connect the SharePoint team site that hosts the site mailbox to Microsoft 365 Groups](https://techcommunity.microsoft.com/t5/microsoft-sharepoint-blog/rolling-out-tenant-admin-tools-to-connect-existing-sharepoint/bc-p/188867). Alternatively, you can export the site mailbox data to a PST file, and then import the PST file. For more information about the steps, see [Retirement of site mailboxes](/sharepoint/deprecation-of-site-mailboxes).

[Back to top](#summary)

## Can I keep the folder structure since Microsoft 365 Groups don't support multiple folders?

Site mailboxes support multiple subfolders, but Microsoft 365 Groups don't support the folder structure. To keep the folder structure from a site mailbox, export the site mailbox data, and then import the data to a shared mailbox. For more information about the steps, see [How do I bulk import the site mailbox PST files to a shared mailbox?](#how-do-i-bulk-import-the-site-mailbox-pst-files-to-a-shared-mailbox)

[Back to top](#summary)

## How do I bulk import the site mailbox PST files to a shared mailbox?

It's possible to bulk export site mailbox data to PST files, and then bulk import the PST files to shared mailboxes. For more information about the steps, see the following articles:

- [Export site mailboxes to PST (using script)](/sharepoint/deprecation-of-site-mailboxes#export-site-mailboxes-to-pst-using-script)
- [Use network upload to import PST files to Office 365](/microsoft-365/compliance/use-network-upload-to-import-pst-files)
- [Use drive shipping to import PST files](/microsoft-365/compliance/use-drive-shipping-to-import-pst-files-to-office-365)

**Note:** The *Documents* folder in a site mailbox is part of a SharePoint site. The folder is supported for operation in only the site mailbox and the associated SharePoint site. The folder stores shortcut links to the actual documents that are stored in the SharePoint site. Exporting the site mailbox to a PST file breaks these shortcut links. If such PST file is imported into a normal user mailbox or a shared mailbox, the folder will behave unreliably. Here's an example:

In Outlook on the web, the *Documents* folder displays the email messages with links to the documents that are stored in the SharePoint site. These links may or may not work.

:::image type="content" source="media/site-mailbox-retirement-faq/owa-messages.png" alt-text="Screenshot of the links displayed in the Documents folder.":::

In Outlook, these email messages are displayed as unsafe.

:::image type="content" source="media/site-mailbox-retirement-faq/outlook-messages.png" alt-text="Screenshot of unsafe message displayed in the Documents folder.":::

[Back to top](#summary)

## What will happen to site mailboxes after April 2021? Will they be automatically deleted?

The retirement of site mailboxes was [announced in October 2020](https://techcommunity.microsoft.com/t5/microsoft-365-blog/update-retirement-of-sharepoint-site-mailboxes-in-microsoft-365/ba-p/1754704). You're encouraged to export site mailboxes and remove them by following the steps in [retirement of site mailboxes](/sharepoint/deprecation-of-site-mailboxes). You should remove all dependencies from your site mailbox (for example, any workflow that you use for the site mailbox) to avoid any disruptions to services after April 2021.

[Back to top](#summary)

## Can the retirement deadline of site mailboxes be extended?

The site mailbox deprecation was [announced in 2017](https://techcommunity.microsoft.com/t5/microsoft-sharepoint-blog/deprecation-of-site-mailboxes/ba-p/93028) and the retirement was [announced in October 2020](https://techcommunity.microsoft.com/t5/microsoft-365-blog/update-retirement-of-sharepoint-site-mailboxes-in-microsoft-365/ba-p/1754704). No further extension will be provided. We strongly encourage tenants to back up the site mailboxes by following the steps in [retirement of site mailboxes](/sharepoint/deprecation-of-site-mailboxes) and remove the dependencies from the site mailboxes.

[Back to top](#summary)
