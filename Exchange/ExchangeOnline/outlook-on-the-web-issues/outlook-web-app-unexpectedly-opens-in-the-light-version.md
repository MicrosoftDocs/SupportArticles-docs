---
title: Outlook Web App opens in the light version
description: Discusses a scenario in Microsoft 365 in which Outlook Web App opens in the light version even though the user is using a web browser that supports the comprehensive set of features that are available in the standard version of Outlook Web App.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jhayes, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook Web App opens in the light version when it's used in Microsoft 365 even though the user has a supported web browser

_Original KB number:_ &nbsp; 2506626

## Symptoms

When a user opens Outlook Web App in a Microsoft 365 environment, Outlook Web App opens only in the light version. Therefore, the user doesn't have access to the comprehensive set of features that are available in the standard version of Outlook Web App. This occurs even though the user has a web browser that supports the comprehensive feature set in the standard version of Outlook Web App.

Other users in your organization don't experience these symptoms. When other users open Outlook Web App, they have access to the comprehensive set of features that are available in Outlook Web App.

## Cause

This scenario occurs if the user unintentionally selects the **Use the blind and low vision experience** option in Outlook Web App.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that the user is using a supported web browser.
2. In Outlook Web App, select **Options**.

   :::image type="content" source="media/outlook-web-app-unexpectedly-opens-in-the-light-version/options-button.png" alt-text="Screenshot of the light version of Outlook Web App showing the Options button.":::

3. In the navigation pane on the left, select **Outlook Web App version**, and then clear the **Use the Light Version of Outlook Web App** checkbox.
4. Select **Save** at the top of the page.
5. Sign out of Outlook Web App. The next time that the user signs in to Outlook Web App, the user is presented with the standard version of Outlook Web App.

## More information

The light version of Outlook Web App is optimized to support users who are blind or who have low vision. Additionally, it supports older web browsers. For more info about the light version of Outlook Web App, see [Learn more about the light version of Outlook](https://support.microsoft.com/office/learn-more-about-the-light-version-of-outlook-2aec8c2d-da48-4707-ba37-c800e1c284cd).

For more info about accessibility features in Microsoft 365, see [Accessibility support for Outlook](https://support.microsoft.com/office/accessibility-support-for-outlook-a8267cc4-aba3-4045-81d7-df11b016f2fe).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
