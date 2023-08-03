---
title: View emails and web links side-by-side with Outlook and Microsoft Edge
description: Describes the productivity benefits of Outlook opening web links in Microsoft Edge and how you can manage this feature in your organization.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gquintin, aruiz, meerak
appliesto: 
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 07/20/2023
---

# Web links from Outlook emails and Teams chats open using Microsoft Edge browser in a side-by-side feature experience

Web links from Outlook for Windows emails and from Teams for Windows chats will open using the Microsoft Edge browser. When those links open using Edge, the full email or chat opens next to them in the Edge sidebar. This side-by-side feature experience is designed to minimize switching between windows and to help users stay in the flow of work while referencing web links.

Organizations can manage which browser is used to open web links from Outlook emails and Teams chats using the _Choose Which Browser Opens Web Links_ policy. Individual users can also manage this feature through each application’s individual settings.

Managing this setting only applies to the Outlook for Windows and Teams desktop client for Windows and does not change the system default browser for Windows.

This feature requires Outlook Build 16.0.16227.20280 or later.

For more information, see: [Discover new ways to multitask with Microsoft 365 and Microsoft Edge](https://www.microsoft.com/microsoft-365/blog/2023/02/16/discover-new-ways-to-multitask-with-microsoft-365-and-edge/).


## Manage the new feature for both Outlook and Teams by configuring a policy

To manage this change in your organization for both Outlook and Teams, you need to configure the following policy:

**Name:** *Choose Which Browser Opens Web Links*

**Description:** *This policy controls which browser will open web links from within supported Microsoft 365 apps. By default, web links will open in Microsoft Edge.*

*Note: This policy doesn't override any user settings or policies that specify that document links should open in the desktop apps instead of their web app counterparts.*

*If you enable this policy, you can choose either "System default browser" or a specific browser, such as "Microsoft Edge." "System default browser" refers to the browser setting specified on the user's Windows device.*

*If you disable or don't configure this policy, web links will open in Microsoft Edge. The user can set their preferred browser from the settings for the specific Microsoft 365 app.*

If you want Outlook or Teams to open web links using the system default browser, you need to enable this policy and select **System default browser**.

Note: This policy manages the feature experience for both Outlook and Teams. You will not be able to use this policy to manage the feature experience individually for each app.

You have two options where you can manage this policy:

### Option 1: Cloud Policy service for Microsoft 365

Follow these steps to manage the policy in the [Cloud Policy service for Microsoft 365](/deployoffice/admincenter/overview-cloud-policy):

1. Navigate to the [Microsoft 365 Apps admin center](https://config.office.com/), and then select **Sign in**.

2. Under **Office policies**, select **Go to Microsoft 365 Cloud Policy**.

3. Under **Policy configurations**, select **Create**.

4. Provide a name and description for your policy, and then select **Next**.

5. Select the appropriate scope, such as creating a group or adding to an existing group.

6. Select **Next**.

7. Under **Configure Settings**, search for "Choose which browser opens web links".

   :::image type="content" source="media/view-emails-and-web-links-in-browser/microsoft365-policy-settings.png" alt-text="Screenshot of a settings page in the Cloud Policy service for Microsoft 365.":::

8. Select the **Choose which browser opens web links** policy.

9. Adjust **Configuration setting** to the desired configuration, and then select **Apply**.

10. Select **Next**.

11. Review your policy, then select **Create**.

12. Select **Done**.

### Option 2: Administrative Templates for Microsoft 365

1. Download the latest [Administrative Templates for Microsoft 365](https://www.microsoft.com/download/details.aspx?id=49030) (ADMX files).

2. Open them in the Group Policy Management Editor.

3. Locate the policy: **Policies** \> **Administrative Templates: Policy definitions (ADMX files)** \> **Microsoft Office 2016** \> **Links** \> **Choose which browser opens web links**.

4. Configure the policy.

5. Select **Apply**.

   :::image type="content" source="media/view-emails-and-web-links-in-browser/administrative-templates-group-policy.png" alt-text="Screenshot of the 'Choose which browser opens web links' policy in the Group Policy Management Editor.":::

> [!NOTE]
> If your organization uses a **Microsoft 365 for business** plan, then you can use the policy to manage the feature for Teams. However, the policy is unavailable for Outlook with this plan. Users will need to manage the feature by using Outlook settings as described in the following section.

## Allow users to manage the new feature

If you prefer to let your users manage this feature, then either leave the policy unconfigured or disable the policy. The Microsoft Edge browser will be used when users open web links, and they can manage this behavior using the app settings or through a banner notification:

- Outlook settings: **File** \> **Options** \> **Advanced** \> **File and browser preferences**.
- Teams settings: **Settings** \> **Files and links** \> **Link open preferences**.
- Banner notification: A banner notification is shown when users first see the experience. They can either select the **Try Edge** option to keep using the feature or select **Manage my settings** to revert to their system's default browser experience. Please see an example of the banner below.

  :::image type="content" source="media/view-emails-and-web-links-in-browser/microsoft-edge-banner.png" alt-text="Screenshot of the Microsoft Edge banner that asks users to select how to open email links.":::

The choices that a user makes in Outlook settings or Teams settings will apply across both apps. 

**Note**: If you confirm this experience by enabling the policy and selecting **Microsoft Edge**, users will still receive this banner, but the **Manage my settings** option will be grayed out and unavailable to use.

For more information about how users can individually control this experience, see [Web links from Outlook emails and Teams chats open in Microsoft Edge](https://support.microsoft.com/topic/stay-in-your-flow-with-microsoft-365-on-microsoft-edge-b0e1a1c1-bd62-462c-9ed5-5938b9c649f0).
