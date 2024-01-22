---
title: Sign-in issue when opening the Copilot for Sales pane in Outlook
description: Resolves an error message that occurs in Microsoft Copilot for Sales when users have issues opening the Copilot for Sales pane in Outlook.
ms.date: 01/10/2024
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Sign-in issue when opening the Copilot for Sales pane in Outlook

This article helps you troubleshoot and resolve an error message that occurs in Microsoft Copilot for Sales when users can't open the Copilot for Sales pane in Outlook.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshots in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web    |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce        |
|**Users**     | All users   |

## Symptoms

When you open the Copilot for Sales pane in Microsoft Outlook, the following error message is displayed:

> There was a problem starting Copilot for Sales.

:::image type="content" source="media/problem-starting-copilot-for-sales/sign-in-copilot-for-sales-error.png" alt-text="Screenshot that shows the sign-in error when you open the Copilot for Sales pane in Microsoft Outlook.":::

When you copy the error details, the error name displayed is:

> Error occurred in the authentication request from Office.

## Cause 1: Pop-ups or cross-site tracking are blocked in the browser

When you open the Copilot for Sales Outlook add-in, an authentication pop-up window is opened to link the add-in to the current Outlook context. If pop-up or cross-site tracking are blocked in the browser, the add-in isn't authenticated and the error message is displayed.

### Resolution

You must allow pop-ups and cross-site tracking in the browser. Different browsers have different settings to allow pop-ups and cross-site tracking. We have provided the steps to allow pop-ups and cross-site tracking in the following browsers:

#### Microsoft Edge

You'll receive a notification in the address bar if pop-ups are blocked. Select the option to always allow pop-ups from the Office 365 website. After you allow pop-ups, refresh the page, and then open the Copilot for Sales add-in.

:::image type="content" source="media/problem-starting-copilot-for-sales/pop-ups-blocked-notification.png" alt-text="Screenshot that shows the Pop-ups blocked notification.":::

If the notification doesn't appear in the address bar, follow these steps:

1. Open browser settings.

1. In the left pane, select **Cookies and site permissions**.

1. In the right pane, select **Pop-ups and redirects**.

1. In the **Allow** section, select **Add**, enter `https://outlook.office365.com`, and then select **Add**.

    :::image type="content" source="media/problem-starting-copilot-for-sales/allow-popup-edge.png" alt-text="Allow pop-ups in Microsoft Edge.":::

1. Refresh the page, and then open the Copilot for Sales add-in.

#### Google Chrome

You'll receive a notification in the address bar if pop-ups are blocked. Select the option to always allow pop-ups from the Office 365 website. After you allow pop-ups, refresh the page, and then open the Copilot for Sales add-in.

:::image type="content" source="media/problem-starting-copilot-for-sales/pop-ups-blocked-notification.png" alt-text="Screenshot that shows the Pop-ups blocked notification.":::

If the notification doesn't appear in the address bar, follow these steps:

1. Open browser settings.

1. In the left pane, select **Privacy and security**.

1. In the right pane, select **Site settings**, and then select **Pop-ups and redirects**.

1. In the **Allowed to send pop-ups and use redirects** section, select **Add**, enter `https://outlook.office365.com`, and then select **Add**.

    :::image type="content" source="media/problem-starting-copilot-for-sales/allow-popup-chrome.png" alt-text="Allow pop-ups in Chrome.":::

1. Refresh the page, and then open the Copilot for Sales add-in.

#### Safari

1. In the Safari browser, select **Safari** > **Settings**, and then select **Privacy**.

1. Clear the **Prevent cross-site tracking** checkbox.

    :::image type="content" source="media/problem-starting-copilot-for-sales/prevent-cross-site-tracking.png" alt-text="Screenshot that shows the Prevent cross-site tracking option in Safari.":::

1. Refresh the page, and then open the Copilot for Sales add-in. When you're asked to allow pop-ups, allow pop-ups from the Office 365 website.

    After you allow pop-ups, refresh the page, and then open the Copilot for Sales add-in.

## Cause 2: Browser needs to clear the session and restart

In some scenarios, the browser session needs to be cleared and restarted to resolve the issue.

### Resolution

1. Sign out of Outlook on the web.
1. Close all browser tabs and windows.
1. Open the browser and sign in to Outlook on the web.
1. Open the Copilot for Sales add-in.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
