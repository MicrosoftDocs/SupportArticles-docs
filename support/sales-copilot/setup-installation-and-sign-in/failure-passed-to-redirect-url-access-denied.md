---
title: Authentication issues when connecting to Salesforce CRM
description: Resolves authentication issues when connecting to Salesforce CRM from Microsoft Copilot for Sales.
ms.date: 01/10/2024
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Authentication issues when connecting to Salesforce CRM

This article helps you troubleshoot and resolve authentication issues when connecting to Salesforce CRM from the [Microsoft Copilot for Sales add-in for Outlook](/microsoft-sales-copilot/use-sales-copilot-outlook).

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshots in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in and Teams app   |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to sign in to Salesforce CRM |

## Symptoms

When you try to sign in to Salesforce CRM from the Copilot for Sales add-in for Outlook, the following error message is displayed:

> Failure passed to redirect url. error=OAUTH_APP_ACCESS_DENIED error_description=user is not admin approved to access this app

:::image type="content" source="media/failure-passed-to-redirect-url-access-denied/authentication-error.png" alt-text="Screenshot that shows the authentication error.":::

## Cause

Policies of the Microsoft Power Platform connected app block users from connecting to Salesforce CRM.

Copilot for Sales connects to Salesforce CRM through the Microsoft Power Platform connected app. To sign in to Salesforce CRM from Copilot for Sales, users must provide their consent to the Microsoft Power Platform app to contact Salesforce CRM on their behalf. When consent can't be provided, the sign-in process fails.

## Resolution

Copilot for Sales uses the Microsoft Power Platform connected app to connect to Salesforce CRM. Ensure that the policies of the Microsoft Power Platform app are configured to allow users to connect to Salesforce CRM.

1. Sign in to Salesforce CRM as an administrator.

2. Go to **Setup** > **Platform Tools** > **Apps** > **Connected Apps** > **Managed Connected Apps**.

3. On the **Connected Apps** page, select **Microsoft Power Platform**.

    :::image type="content" source="media/failure-passed-to-redirect-url-access-denied/connected-apps-page.png" alt-text="Screenshot that shows the Connected Apps page." lightbox="media/failure-passed-to-redirect-url-access-denied/connected-apps-page.png":::

4. Select **Edit policies**.

5. Under **OAuth Policies**, select one of the following values for **Permitted Users**:

    :::image type="content" source="media/failure-passed-to-redirect-url-access-denied/permitted-users.png" alt-text="Screenshot that shows the values for permitted users.":::

    1. **All users may self-authorize**: This option allows any authenticated Salesforce user to connect to the Salesforce instance through the Microsoft Power Platform connector used by Microsoft Copilot for Sales, Microsoft Power Automate, and potentially other apps to gain access to Salesforce, thus resolving the issue.

    1. **Admin approved users are pre-authorized**: This option enables administrators to explicitly grant permissions to individual users through **Profiles** and **Permission Sets**. For more information, see [Connected Apps](https://help.salesforce.com/s/articleView?id=sf.connected_app_overview.htm&type=5) and [Manage Access to a Connected App](https://help.salesforce.com/s/articleView?id=sf.connected_app_manage.htm&type=5).

        :::image type="content" source="media/failure-passed-to-redirect-url-access-denied/profiles-permission-sets.png" alt-text="Screenshot that shows the Profiles and Permission Sets sections.":::

6. Select **Save**.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
