---
title: Shareable links overview and troubleshooting
description: Provides an overview of shareable links in Outlook and a troubleshooting guide for common issues.
author: v-lianna
ms.author: v-lianna
manager: dcscontentpm 
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro 
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CI 155669
- CSSTroubleshoot
ms.reviewer: meerak; stevenle; gbratton; aruiz; vijayde
appliesto:
- Outlook for Office 365
search.appverid: MET150
---
# Shareable links in Outlook

Microsoft Outlook displays additional information for links to files on OneDrive or SharePoint site that you share in an email message. This information includes a visual indicator for the shareable link, the icon for the file type of the link, and recipients who can access the link. The shareable links functionality in Outlook helps you ensure that the links to other Microsoft 365 apps are shared appropriately without opening those apps to share the files.

## How Outlook displays shareable links

Outlook displays shareable links in the following ways:

### Recognizing links to OneDrive or SharePoint files

When Outlook detects such a link, it applies a gray background to the link, which makes it stand out to your recipients. It shows that the link has special functionality and options.

Outlook recognizes links to a shareable file in an email when you:

- Copy a link to a OneDrive or SharePoint file and paste it into the body of an email message.
- Navigate to the **Message** tab, select **Link** > **Insert Link…** and select a OneDrive or SharePoint file.

    **Note:** If you insert a recently used file under Link, Outlook will share the link by using the [default settings](/sharepoint/turn-external-sharing-on-or-off) of your organization that is set up by the tenant administrator.

- Right-click the body of an email message and select **Link** > **Insert Link…**. Then, select a OneDrive or SharePoint file.
- Reply or forward an email with existing links.
- Resume a draft with existing links. For example, if you started the draft on an earlier version of Outlook and resume it on a newer version.

### URL shortening

When Outlook recognizes a link to a shareable file, it automatically adds the file type icon (for example, Word, PowerPoint, or Excel) and shorten the URL to the name of the file.

You can undo this change and show the full URL by using one of the following ways:

- Right-click the link and select **Show Full URL**.

    **Note:** You can also access this menu by pressing the Menu key when the cursor is inside the link.

- Select the **Undo** button or press Ctrl+Z.
- Press the Backspace key.

    **Note:** It only works if the URL gets shortened before you continue typing.

### Link information

Outlook also provides link information, which pops up automatically after you insert a new link without any editing. This example shows that anyone within your organization can view and edit the link:

:::image type="content" source="media\shareable-links-functionality-in-outlook\shareable-link-with-information.png" alt-text="Shareable link pops up information automatically after you insert a new link.":::

**Tip:** If you use a screen-reading app (such as [Windows Narrator](https://support.microsoft.com/windows/complete-guide-to-narrator-e4397a0d-ef4f-b386-d8ae-c172f109bdb1)), the information will be read out by navigating the cursor into the link.

## Manage access to shareable links

You can manage access to shareable links, and Outlook will check whether the recipients have access before sending an email message.

### Adjusting who can access the link

In the above example, select the link information to manage who can access the link. When you share the link through OneDrive, SharePoint websites, or other Office 365 apps (such as Word or Excel), the same setting presents as follows:

:::image type="content" source="media\shareable-links-functionality-in-outlook\shareable-link-settings.png" alt-text="You can manage access by the link settings.":::

**Note:** You can also right-click the link or press the Menu key when the cursor is inside the link, and select **Manage Access…** to get the same setting.

### Link permission checking

Outlook checks whether the recipients of your email message can access the link. The check will be finished before you send the email message. There is no error or warning if all recipients can access the link. Otherwise, you will receive one of the three results:

#### One or more recipients don't have access

The link color shows red and there's a red exclamation mark over the upper right corner of the link. When you select the link, it gives the error message:

:::image type="content" source="media\shareable-links-functionality-in-outlook\link-permission-checking-no-access.png" alt-text="The error when one or more recipients don't have access.":::

In the above example, the recipient is outside of your organization and won't have access to this link. There are three options together with the information:

- **Manage access**  
    Change who can access the link.
- **Attach as a copy**  
    Attach the file as a copy instead if you have the permission to do so.
- **Ignore**  
    Ignore the error, then there will be no warning before you send the email message.

**Notes:**

- Right-click the link or press the Menu key when the cursor is inside the link, you can also get the same error message and options.
- The error message for not having access might differ.
- You can navigate between the links that have the error by pressing Ctrl+Alt+F1.

#### Unable to verify recipients' access

If Outlook can't verify whether the recipients have access to a link, it provides a warning. A gray exclamation icon shows over the upper right corner of the link, but the link color doesn't change. In addition, the reason that Outlook can't check the link for recipient access will be displayed when you select the link.

:::image type="content" source="media\shareable-links-functionality-in-outlook\link-permission-checking-can-not-verify-recipients.png" alt-text="We couldn't verify that recipients can access this link because you're offline error.":::

You also receive a MailTips at the top of your email message:

> We can't check if recipients can access a link in your message.

See the following screenshot for an example:

:::image type="content" source="media\shareable-links-functionality-in-outlook\link-permission-checking-mailtips-warning.png" alt-text="Error message for we can't check if recipients can access a link in your message.":::

**Note:** Right-click the link or press the Menu key when the cursor is inside the link, you can also get the same error information and options.

#### Warning before sending

If some of your recipients can't access the link in an email message, you receive a warning when you try to send the email message.

:::image type="content" source="media\shareable-links-functionality-in-outlook\link-permission-checking-warning-before-sending.png" alt-text="Error message for some recipients don't have access to links in your message.":::

This checking allows you to adjust your email before sending if you want all the recipients can access to all your links.

**Note:** Outlook will not warn you if it can't verify the recipient's access.

You will receive the following warning if the permission check hasn't been finished when you try to send the email.

:::image type="content" source="media\shareable-links-functionality-in-outlook\link-permission-checking-warning.png" alt-text="Error message for still checking if the recipients can access links in this message.":::

You can skip the remaining checks and send the email anyway or not send it right now. Alternatively, you can also wait for the checks to be finished until you get this message:

:::image type="content" source="media\shareable-links-functionality-in-outlook\link-permission-checking-complete.png" alt-text="Recipients can access links in your message.":::

## Troubleshooting common issues

You may experience the following issues when you use the functionality in Outlook.

**Q:** A link shows with a gray background, but the permission checking for this link isn't working. I can't manage access on the link, or get the expected UI.

**A:** The most common cause is that the link is sent from someone else, and you reply or forward the email message. In this case, there are a few possibilities:

- The original sender of the link manually applied a gray background.
- Your Outlook client doesn't recognize the service that the link points to, but the sender may recognize. For example, if the sender uses a custom domain to host a SharePoint site that isn't hosted on sharepoint.com), then Outlook can't recognize the site. Unless you sign in to an account associated with that domain via **File** > **Office Account** > **Connected Services**.
- The link is [Safelink wrapped](https://support.microsoft.com/office/advanced-outlook-com-security-for-microsoft-365-subscribers-882d2243-eab9-4545-a58a-b36fee4a46e2) using the Microsoft standard URL prefix: `https://nam01.safelinks.protection.outlook.com`. For example, you copy a wrapped link from an email message, and paste it into a new email message. Outlook can't unwrap it to recognize the OneDrive or SharePoint file. But if the email message is viewed or previewed, and you reply or forward, Outlook can unwrap the link. If you turn off the preview pane and don't open the email message before you reply or forward, Outlook can't unwrap it.

**Q:** I have a link that points to a OneDrive or SharePoint file, but there is no gray background, and I can't interact with the link as described.

**A:** Here are several reasons:

- The link isn't shareable. When you first insert the link, Outlook checks with the server what the link points to. If Outlook can't manage access or check permissions for the location the link points to (for example, a web page hosted on sharepoint.com), then it appears as a normal hyperlink.

    **Note:** It's possible that Outlook can't contact the server when you insert the link (for example, you work offline), but Outlook performs the check later and update what you see accordingly.

- The link doesn't have "SharePoint.com" but uses a fictitious domain name such as "contoso.com", Outlook can only recognize the link if you are also signed in with a OneDrive or SharePoint account using that domain name via **File** > **Office Account** > **Connected Services**.
- The link may be [Safelink wrapped](https://support.microsoft.com/office/advanced-outlook-com-security-for-microsoft-365-subscribers-882d2243-eab9-4545-a58a-b36fee4a46e2), and Outlook can't check whether the link pointing to OneDrive or SharePoint.
- The link is for the consumer version of OneDrive, but only the business version is supported now.

**Q:** What warnings that Outlook might give me if it can't check whether my recipients can access to my links?

**A:** Here are some common reasons why Outlook can't check whether your recipients have access to the links:

- Outlook is working offline

    Outlook can't communicate with the server if you [work offline](https://support.microsoft.com/office/work-offline-in-outlook-f3a1251c-6dd5-4208-aef9-7c8c9522d633). If you add a link or recipients while you are offline, Outlook will automatically communicate with the server once you are online.

- Not signed in to an account associated with a link

    If you add a link to a site (such as sharepoint.com) Outlook can generally recognize, but you are not sign in to an account on the tenant the link is hosted on (for example, the link points to contoso.sharepoint.com, but you are not signed in with a Contoso company account), then Outlook will not communicate with the server. Outlook only sends requests to tenants you are signed in to.

- Sending account is not associated with the link

    You signed in to an account associated with the link, but you don't send the link from that account (for example, you send it from a personal email account). In this case, Outlook can shorten the URL and provide an icon and the current link information, but Outlook will not check whether your recipients have access to the link or allow you to manage the access.

- Too many recipients

    Outlook limits the number of recipients that can be checked for an email message. If the number exceeds the limit, Outlook can't check whether the recipients have access to your links.

    **Note:** Each recipient inside of a distribution list counts towards the limit.

**Q:** I reply to someone's email message and notice that one of the links they sent me is red. Why didn't I get a warning before sending the email message?

**A:** The sender may not have access to the link. This issue may happen if they forward you an email message with a link that they didn't open. For example, if they use an earlier version of Outlook (or a different email client), they may not be warned before sending you the email message.

If you reply to the original sender, Outlook doesn't warn you about it before you send the reply. However, if you add more links, make changes to the existing links, or add new recipients, then Outlook will warn you before sending if any links don't work for any of your recipients.

**Q:** I don't see the **Recipients of this message** option when I try to manage access for a link in a meeting invitation.

**A:** It's currently unavailable.

**Q:** Can I turn off this functionality?

**A:** There's no way to disable the functionality now.
