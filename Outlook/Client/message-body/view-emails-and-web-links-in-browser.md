---
title: View emails and web links side-by-side with Outlook and Microsoft Edge
description: Describes the productivity benefits of Outlook opening web links in Microsoft Edge and how you can manage this feature in your organization.
author: gquintin
ms.author: gquintin
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
ms.date: 05/12/2023
---

# View emails and web links side-by-side with Outlook and Microsoft Edge

Multitasking between email and the web has become the new standard for work, but unless your users are app windowing experts, switching back and forth between both can be a frustrating experience. To improve the user experience, Outlook and Microsoft Edge have a new feature that lets users see their email and the links they open at the same time, in the same place&mdash;no more switching back and forth between apps.

With this feature, when a user clicks on a web link from the Outlook for Windows app, that link will open alongside their email in Microsoft Edge so they can easily access, read, and respond to their email using their matching authenticated profile. No more disruptive switching—just their email in the Edge sidebar pane, right next to the online content from the link in a single, side-by-side view.

For additional information, please see: [Discover new ways to multitask with Microsoft 365 and Edge](https://www.microsoft.com/microsoft-365/blog/2023/02/16/discover-new-ways-to-multitask-with-microsoft-365-and-edge/).

> [!NOTE]
> A similar experience will roll out for Microsoft Teams in the future. Configuring the feature policy below will also apply to the Teams experience when it arrives.

## How to manage this feature via policy

To manage this change in your organization, you will need to configure the following policy:

**Name:** *Choose Which Browser Opens Web Links*

**Description:** *This policy controls which browser will open web links from within supported Microsoft 365 apps. By default, web links will open in Microsoft Edge.*

*Note: This policy doesn't override any user settings or policies that specify that document links should open in the desktop apps instead of their web app counterparts.*

*If you enable this policy, you can choose either "System default browser" or a specific browser, such as "Microsoft Edge." "System default browser" refers to the browser setting specified on the user's Windows device.*

*If you disable or don't configure this policy, web links will open in Microsoft Edge. The user can set their preferred browser from the settings for the specific Microsoft 365 app.*

If you want Outlook to open web links using the system default browser, you will need to enable this policy and select "System default browser".

You have two options where you can manage this policy:

### Option 1: [Cloud Policy service for Microsoft 365](/deployoffice/admincenter/overview-cloud-policy)

1. Navigate to https://config.office.com/ and click Sign in.

2. Under Office policies, click Go to Microsoft 365 Cloud Policy.

3. Under Policy configurations, click + Create.

4. Provide a Name and Description for your policy, click Next.

5. Select the appropriate scope, such as creating a group or adding to an existing group.

6. Click Next.

7. Under Configure Settings, search for "Choose which browser opens web links" and press enter.

8. Click the **Choose which browser opens web links** policy.

9. Adjust Configuration setting to desired configuration, click Apply.

10. Click Next.

11. Review your policy, then click Create.

12. Click Done.

*Policy in Cloud Policy service for Microsoft 365*

:::image type="content" source="media/view-emails-and-web-links-in-browser/microsoft365-policy-settings.png" alt-text="Screenshot of a settings page in the Cloud Policy service for Microsoft 365.":::

### Option 2: [Administrative Templates for Microsoft 365](https://www.microsoft.com/download/details.aspx?id=49030)

1. Download the latest ADMX files.

2. Open them in the Group Policy Management Editor.

3. Locate the policy: Policies \> Administrative Templates: Policy definitions (ADMX files) \> Microsoft Office 2016 \> Links \> Choose which browser opens web links

4. Configure the policy.

5. Click Apply.

:::image type="content" source="media/view-emails-and-web-links-in-browser/administrative-templates-group-policy.png" alt-text="Screenshot of the 'Choose which browser opens web links' policy in the Group Policy Management Editor.":::

> [!NOTE]
> If your organization uses a **Microsoft 365 for business** plan, your users will need to manage this change individually. They can either click **Manage my settings** in the Edge notification banner when the experience first opens, or they can manage the change through the Outlook settings menu: **File** > **Options** > **Advanced** > **Link Handling**.

## How to allow users to manage this feature

If you'd prefer to let your users manage this change, then either leave the policy unconfigured or disable the policy. Users will then be able to manage this at any point through Outlook settings: **File** \> **Options** \> **Advanced** \> **Link Handling**.

Additionally, users will be notified of this change with a banner when they first experience it. They can either choose **Try Edge** to keep using the feature or select **Manage my settings** to revert to their system default browser.

:::image type="content" source="media/view-emails-and-web-links-in-browser/microsoft-edge-banner.png" alt-text="Screenshot of the Microsoft Edge banner that asks users to select how to open email links.":::

Note: If you confirm this experience by enabling the policy and selecting **Microsoft Edge**, users will still receive this banner, but **Manage my settings** will be greyed out and unavailable to use.

For additional information on how users can individually control this experience, please see our Microsoft Support page: [Outlook emails open next to web links in Microsoft Edge](https://support.microsoft.com/topic/stay-in-your-flow-with-microsoft-365-on-microsoft-edge-b0e1a1c1-bd62-462c-9ed5-5938b9c649f0).
