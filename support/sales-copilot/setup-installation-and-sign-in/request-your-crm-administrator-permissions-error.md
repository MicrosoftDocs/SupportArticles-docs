---
title: Error after connecting and signing in to Salesforce CRM
description: Resolves an error message that occurs after connecting and signing in to Salesforce CRM in Sales app.
ms.date: 02/05/2025
author: sbmjais
ms.author: shjais
manager: shujoshi
ms.custom: sap:Setup, Installation and Sign-in\CRM Sign-In & Sign Out
---
# "Request your CRM administrator permissions to access Salesforce using APIs" error

This article helps you troubleshoot and resolve issues when an error message is displayed after connecting and signing in to Salesforce CRM in Sales app.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales app in Outlook        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to use Sales app with Salesforce CRM |

## Symptoms

After you sign in to Salesforce CRM through the [Sales app in Outlook](/microsoft-sales-copilot/open-app#access-copilot-for-sales-in-outlook), the following error message is displayed:

> Request your CRM administrator permissions to access Salesforce using APIs

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

An admininstrator can grant the **API Enabled** permission to the user or the affected user's profile by following these steps:

1. Sign in to Salesforce as an administrator.
1. In the search box, enter **User**.
1. In the left navigation pane, select **Profiles**, and then select the affected user's profile.
1. In the **Administrative Permissions** section, select **API Enabled**.
1. Select **Save**.

    :::image type="content" source="media/request-your-crm-administrator-permissions-error/api-enabled-option.png" alt-text="Screenshot that shows the API Enabled option on the Profiles page." lightbox="media/request-your-crm-administrator-permissions-error/api-enabled-option.png":::

## More information

If your issue is still unresolved, go to the [Sales solution in Microsoft 365 Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]