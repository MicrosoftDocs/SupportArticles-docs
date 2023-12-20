---
title: Authentication issues when connecting to Salesforce CRM
description: Troubleshoot and resolve authentication issues when connecting to Salesforce CRM from Sales Copilot.
ms.date: 10/31/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Authentication issues when connecting to Salesforce CRM

This article helps you troubleshoot and resolve authentication issues when connecting to Salesforce CRM from Sales Copilot add-in for Outlook.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in and Teams app   |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to sign in to Salesforce CRM |

## Symptom

When trying to sign in to Salesforce CRM from Sales Copilot add-in for Outlook, the following error message is displayed:
`Failure passed to redirect url. error=OAUTH_APP_ACCESS_DENIED error_description=user is not admin approved to access this app`

:::image type="content" source="media/tsg-auth-error.png" alt-text="Screenshot showing authentication error.":::

## Cause

Policies of the Microsoft Power Platform connected app blocks users from connecting to Salesforce CRM.

Sales Copilot connects to Salesforce CRM through the **Microsoft Power Platform** connected app. To sign in to Salesforce CRM from Sales Copilot, users must provide their consent to the **Microsoft Power Platform** app to contact Salesforce CRM on their behalf. When consent can't be provided, the sign-in process fails.

## Solution

Sales Copilot uses the **Microsoft Power Platform** connected app to connect to Salesforce CRM. Ensure that the policies of the **Microsoft Power Platform** app are configured to allow users to connect to Salesforce CRM.

1. Sign in to Salesforce CRM as an administrator.

2. Go to **Setup** > **Platform Tools** > **Apps** > **Connected Apps** > **Managed Connected Apps**.

3. On the **Connected Apps** page, select **Microsoft Power Platform**. 

    :::image type="content" source="media/tsg-auth-issue1.png" alt-text="Screenshot showing connected app."::: 

4. Select **Edit policies**.

5. Under **OAuth Policies**, select one of the following values for **Permitted Users**:

    :::image type="content" source="media/tsg-auth-issue2.png" alt-text="Screenshot showing values for permitted users.":::    

    1. **All users may self-authorize**: This will resolve the issue by allowing any authenticated Salesforce user to connect to the Salesforce instance through the **Microsoft Power Platform** connector used by Microsoft Sales Copilot, Microsoft Power Automate, and potentially other apps, to gain access to Salesforce.

    1. **Admin approved users are pre-authorized**: This option enables administrators to explicitly grant permissions to individual users through profiles and permissions sets. More information: [Connected Apps](https://help.salesforce.com/s/articleView?id=sf.connected_app_overview.htm&type=5) and [Manage Access to a Connected App](https://help.salesforce.com/s/articleView?id=sf.connected_app_manage.htm&type=5).
    
        :::image type="content" source="media/tsg-auth-issue3.png" alt-text="Screenshot showing Profiles and Permission sets sections."::: 

6. Select **Save**.

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

