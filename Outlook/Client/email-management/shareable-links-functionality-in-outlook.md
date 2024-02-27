---
title: Shareable links overview and troubleshooting
description: Provides an overview of shareable links in Outlook and resolutions for common issues.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 155669
  - CSSTroubleshoot
ms.reviewer: meerak, stevenle, gbratton, aruiz, vijayde, v-lianna
appliesto: 
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Shareable links in Outlook

In the body of an email message in Microsoft Outlook, if you add a link that points to files that are stored on OneDrive or Microsoft SharePoint, Outlook recognizes the link as shareable, and it displays additional information about the link. This includes a visual indicator for the shareable link, the icon for the type of file that's shared through the link, the recipients who can access the link, and options to manage access to the link. The shareable links functionality in Outlook helps you make sure that links to other Microsoft 365 apps are shared appropriately from within Outlook without you having to open those applications to share the files.

Outlook recognizes shareable links in an email message when you take any of the following actions:

- Copy a link to a OneDrive or SharePoint file, and then paste it into the body of an email message.
- Navigate to the **Message** tab, select **Link** > **Insert Link**, and then select a file in OneDrive or SharePoint.

    **Note:** If you insert a recently used file from the list that's displayed under **Link**, Outlook will share the link by using the [default settings](/sharepoint/turn-external-sharing-on-or-off) that are set up for your organization by the tenant administrator.
- Right-click the body of an email message, select **Link** > **Insert Link**, and then select a file in OneDrive or SharePoint.
- Reply to or forward an email message that contains existing links.
- Resume working on a draft that includes existing links. For example, you start the draft in an earlier version of Outlook, and you resume working on it in a newer version.

When Outlook detects a shareable link, it applies special formatting to the link which includes a gray background, blue color for the link, and an appropriate icon for the shared document. These visual indicators make the link stand out to your recipients. If you paste the URL for a shared document into the body of an email message, Outlook automatically shortens it to display the name of the file.

:::image type="content" source="media/shareable-links-functionality-in-outlook/shareable-link-with-information.png" alt-text="Screenshot of the pop-up information windows of a shareable link after you insert a new link.":::

Outlook also displays information about the permissions that are required to access the link.

**Tip:** If you use a screen-reading app, such as [Windows Narrator](https://support.microsoft.com/windows/complete-guide-to-narrator-e4397a0d-ef4f-b386-d8ae-c172f109bdb1), the information about access permissions will be read out to you after you navigate the cursor into the link.

## Undo link shortening

If you prefer to use the full URL instead of the shortened URL that Outlook inserts automatically, use one of the following methods:

- Right-click the link, and select **Show Full URL**.

    **Note:** You can also access this menu by pressing the Menu key when the cursor is inside the link.
- Select the **Undo** button or press Ctrl+Z after the automatically shortened link appears but before you continue to type.
- Press the Backspace key after the shortened URL appears but before you continue to type.

## Manage access to a shareable link

Select the permission information that's displayed in the link to manage which users can access it and the level of their access, such as being allowed to view but not edit the link.

:::image type="content" source="media/shareable-links-functionality-in-outlook/shareable-link-settings.png" alt-text="Screenshot of the Link settings with which you can manage access.":::

After you select your options and select **Apply**, Outlook checks whether the recipients of your message will be able to access the shareable link. If you try to send a message while the check is in progress, Outlook displays the following warning:

> We are still checking if recipients can access links in this message.

:::image type="content" source="media/shareable-links-functionality-in-outlook/link-permission-checking-warning.png" alt-text="Error message about still checking whether recipients can access links in this message.":::

You can choose to skip the remaining checks and send the email message anyway or not send it. Select either option to continue.

If you choose not to send the message, and you wait for the checks to finish, Outlook displays the results of the checks.

### Result: All recipients can access the link

If Outlook confirms that the links can be accessed by all recipients, you'll see the following confirmation message:

> Recipients can access links in your message.

:::image type="content" source="media/shareable-links-functionality-in-outlook/link-permission-checking-complete.png" alt-text="Screenshot of the message that recipients can access links in your message.":::

### Result: One or more recipients can't access the link

If Outlook determines that one or more recipients can't access the shareable link, it changes the color of the shareable link to red, and displays a red exclamation mark in the upper-right corner of the link text. When you left-click the link, you'll see information about the cause of the access issue.

:::image type="content" source="media/shareable-links-functionality-in-outlook/link-permission-checking-no-access.png" alt-text="Screenshot of the error message that states that a recipient is outside your organization and won't have access to this link.":::

In this screenshot, the recipient is determined to be outside the organization and won't have access to the link. Therefore, Outlook provides the following options to continue:

- **Manage access**: Change the recipient to someone who might be able to access the link.
- **Attach as a copy**: Attach the file as a copy if you have the required permissions to access its location.
- **Ignore**: Ignore the error so that the link appears functional and no warnings are displayed when you try to send the message.

You can also access these options by using the following methods:

- Right-click the link.
- Use the keyboard to access the context menu while the cursor is on the link.

If you don't take steps to fix the access issue, then Outlook will display the following warning when you try to send the message:

> Some recipients don't have access to links in your message.

:::image type="content" source="media/shareable-links-functionality-in-outlook/link-permission-checking-warning-before-sending.png" alt-text="Error message that states that some recipients don't have access to links in your message.":::

This provides you another opportunity to fix your recipient list before you send the message to make sure that everyone can access the link.

**Tip**: If there are multiple links in your email message that have access issues, use Ctrl+Alt+F1 to navigate between them.

### Result: Recipient access can't be verified

If Outlook can't verify whether recipients have access to the link, it will display the following warning:

> We couldn't verify that recipients can access this link because you're offline.

:::image type="content" source="media/shareable-links-functionality-in-outlook/link-permission-checking-can-not-verify-recipients.png" alt-text="Screenshot of the error message that states that We couldn't verify that recipients can access this link because you're offline.":::

A gray exclamation mark is displayed in the upper-right corner of the link text, and the reason that Outlook can't check for recipient access is also displayed. Select **Ignore** to ignore the error so that no warnings are displayed when you try to send the message.

## Resolve common issues

Here are resolutions to common issues that you might experience when you use shareable links.

**Q1:** A link shows a gray background, but the permission checking for the link doesn't seem to be working. Also, the option to manage access to the link isn't available.

**A1:** It's possible for a link to have a gray background and yet not be recognized by Outlook as a link to a OneDrive or SharePoint file. This issue commonly occurs when the link is in a message that you received from someone else, and you reply to or forward the message. In this case, there are several possible reasons why this issue might occur:

- The original sender of the link manually applied a gray background to it.
- Your Outlook client doesn't recognize the service that the link points to. For example, if the sender hosts their SharePoint site on a custom domain instead of sharepoint.com, Outlook can't recognize the site unless you're signed in to an account that's associated with the domain under **File** > **Office Account** > **Connected Services**.
- The link is a Safe link that's [wrapped](/microsoft-365/security/office-365-security/safe-links#safe-links-settings-for-email-messages) by using the Microsoft standard URL prefix: `https://nam01.safelinks.protection.outlook.com`. If you copy a wrapped link from an email message, and paste it into a new email message, Outlook can't unwrap the link to recognize the file that's stored on OneDrive or SharePoint.

The only situation in which Outlook can unwrap such a message is if you view or preview the message and then reply or forward it.

**Q2:** A link points to file on OneDrive or SharePoint, but there's no gray background, and the option to manage link access isn't available.

**A2:** There are several reasons why Outlook might be unable to recognize where the link is pointing to.

- The link isn't shareable. When you first insert the link, Outlook checks with the server about what the link points to. If Outlook can't manage access or check permissions for the location that the link points to, then the link appears as a normal hyperlink.

    **Note:** It's possible that if Outlook can't contact the server when you insert the link (for example, if you work offline), it will run the check later, and update what you see accordingly.
- The link uses a fictitious domain name such as "`contoso.com`." Outlook can recognize the link only if you're also signed in to a OneDrive or SharePoint account by using that domain name through **File** > **Office Account** > **Connected Services**.
- The link is a Safelink, and Outlook can't check whether the link is pointing to OneDrive or SharePoint.
- The link is for the Consumer version of OneDrive, but only the Business version of One Drive is currently supported.

**Q3:** In which situations might Outlook not be able to check whether the recipients can access the links in a message, and then display warnings?

**A3:** Here are some common situations:

- You're working offline

    Outlook can't communicate with the server when you [work offline](https://support.microsoft.com/office/work-offline-in-outlook-f3a1251c-6dd5-4208-aef9-7c8c9522d633). If you add a link or recipients while you're working offline, Outlook will automatically communicate with the server after you're online.
- You're not signed in by using an account that's associated with a link

    If you add a link to a site (such as `sharepoint.com`), but you're not signed in to an account on the tenant that hosts the link, Outlook will not communicate with the server. For example, a link might point to `contoso.sharepoint.com`, but you might not be signed in to a Contoso account. Outlook sends requests to only the tenants that you are signed in to.
- Your sending account isn't associated with the link

    You're signed in to an account that's associated with the link. However, you don't send the link from that account but from a different email account, instead. In this case, Outlook shortens the URL, and provides the correct file icon and the current link information. However, it won't check whether your recipients have access to the link, or allow you to manage their access.
- Your message has too many recipients  

    Outlook limits the number to 100 of recipients whose access it can check per email message. If the number of recipients in your message exceeds that limit, Outlook can't check whether the recipients have access to the links in the message.

    **Note:** Each recipient in a distribution list also counts towards the limit.

**Q4:** When you respond to an email message, if one of the links in the original message is red, why doesn't Outlook display a warning when the message is sent?

**A4:** The link could be displayed as red because the original sender might not have access to the link. They might have forwarded you a message that includes a link that they didn't open. For example, if they used either an earlier version of Outlook or a different email client, they might not be warned before they send the message.

If you reply to the original sender, Outlook doesn't warn you about the link before you send the reply. However, if you add more links, make changes to the existing links, or add new recipients, Outlook will check all the links, and then warn you before it sends the message if there are links that won't work for your recipients.

**Q5:** Why doesn't the **Recipients of this message** option appear for a link that's added in a meeting invitation?

**A5:** The option isn't available currently.

**Q6:** Can I turn off the shareable links functionality?

**A6:** No.
