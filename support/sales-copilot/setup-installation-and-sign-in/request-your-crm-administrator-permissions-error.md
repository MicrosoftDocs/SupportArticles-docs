---
title: Error after connecting and signing in to Salesforce CRM
description: Resolves the error message that occurs after connecting and signing in to Salesforce CRM in Microsoft Copilot for Sales.
ms.date: 12/27/2023
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# "Request your CRM administrator permissions to access Salesforce using APIs" error

This article helps you troubleshoot and resolve issues when an error message is displayed after connecting and signing in to Salesforce CRM in Microsoft Copilot for Sales.

> [!NOTE]
> Sales Copilot is rebranded as Copilot for Sales in January 2024. The screenshots in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to use Copilot for Sales with Salesforce CRM |

## Symptoms

After you sign in to Salesforce CRM through the [Copilot for Sales add-in for Outlook](/microsoft-sales-copilot/use-sales-copilot-outlook), the following error message is displayed:

> Request your CRM administrator permissions to access Salesforce using APIs

:::image type="content" source="media/request-your-crm-administrator-permissions-error/request-admin-permission-salesforce-apis.png" alt-text="Screenshot that shows the API permission error.":::

## Cause

The issue occurs when you don't have API permissions in Salesforce. You can confirm if this is the root cause of the issue if you see the following error in the logs:

```output
Exception thrown in VivaSalesContacts/GetContactsByEmailAddress - 
Microsoft.SalesProductivity.Common.Base.SPServiceException: Salesforce failed to complete task: Message: entity is deleted clientRequestId: {CLIENT REQUEST ID HERE}-self ---> 
System.Exception: { 
    "error": { 
        "code": 502, 
        "source": "{APIM SOURCE}", 
        "message": "BadGateway", 
        "innerError": { 
            "status": 502, 
            "message": "Salesforce failed to complete task: Message: **API is disabled for this User**\r\nclientRequestId: {CLIENT REQUEST ID HERE}", 
            "error": null, 
            "source": "Salesforce.Common", 
            "errors": [] 
        } 
    } 
} 
```

## Resolution

You must grant the **API Enabled** permission to the user or user profile for the affected user.

1. Sign in to Salesforce as an administrator.
1. In the search box, enter **User**.
1. In the left navigation pane, select **Profiles**, and then select the profile for the affected user.
1. In the **Administrative Permissions** section, select **API Enabled**.
1. Select **Save**.

    :::image type="content" source="media/request-your-crm-administrator-permissions-error/api-enabled-option.png" alt-text="Screenshot that shows the API Enabled option on the Profiles page.":::

## More information

If your issue is still not resolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
