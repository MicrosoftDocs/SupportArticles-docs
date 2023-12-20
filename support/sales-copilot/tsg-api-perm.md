---
title: Error after connecting and signing in to Salesforce CRM
description: Troubleshoot and resolve issues when an error message is displayed after connecting and signing in to Salesforce CRM.
ms.date: 10/31/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Error after connecting and signing in to Salesforce CRM

This article helps you troubleshoot and resolve issues when an error message is displayed after connecting and signing in to Salesforce CRM.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to use Sales Copilot with Salesforce CRM |

## Symptom

After a user signs in to Salesforce CRM through Sales Copilot add-in for Outlook, the following error message is displayed: `Request your CRM administrator permissions to access Salesforce using APIs`

:::image type="content" source="media/tsg-api-perm-error.png" alt-text="API permission error":::

## Cause

The issue occurs when the user doesn't have API permissions in Salesforce. You can confirm if this is the root cause of the issue if you see the following error in the logs:

```
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

## Solution

You must grant the **API Enabled** permission the user or user profile for the affected user.

1. Sign in to Salesforce as an administrator.

1. In the search box, enter **User**.

1. In the left navigation pane, select **Profiles**, and then select the profile for the affected user.

1. In the **Administrative Permissions** section, select **API Enabled**. 

1. Select **Save**.

    :::image type="content" source="media/tsg-api-perm-sf.png" alt-text="f":::

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
