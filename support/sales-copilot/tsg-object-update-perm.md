---
title: Unable to update records because of missing object access in Salesforce CRM
description: Troubleshoot and resolve error issues when users are unable to update CRM records in Sales Copilot because of missing object access in Salesforce CRM.
ms.date: 10/31/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Unable to update records because of missing object access in Salesforce CRM

This article helps you troubleshoot and resolve issues when users are unable to update CRM records in Sales Copilot because of missing object access in Salesforce CRM.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to update a CRM record from Sales Copilot |

## Symptom

When trying to update a CRM record from the Sales Copilot add-in for Outlook, the following error message is displayed: `To update Salesforce, ask for edit access for this object.`

:::image type="content" source="media/tsg-object-access-error.png" alt-text="Error about unable to update records because of missing object access in Salesforce CRM.":::

## Cause

User doesn't have edit access to an object in Salesforce.

When a user tries to edit an object, Sales Copilot checks if the user has **Write** access to the object in Salesforce. If the user doesn't have **Write** access to the object, the error message is displayed.

You can confirm if the user not having **Write** access to the entity is the root cause of issue if you see the following error in the logs:

```
Exception thrown in VivaSalesContacts/UpdateContact -  
Microsoft.SalesProductivity.Common.Base.SPServiceException: Salesforce failed to complete task: Message: entity is deleted clientRequestId: 01665660-aeb5-45fe-83d3-59bf69f1e85e-self --->  
System.Exception: {  
    "status": 400,  
    "message": "Object type contact is not supported. If you are attempting to use a custom object, be sure to append the '__c' after the entity name.  
                Please reference your WSDL or the describe call for the appropriate names\r\nclientRequestId: <CLIENT REQUEST ID>-self",  
    "error": null,  
    "source": "Salesforce.Common",  
    "errors": []  
} 

```

In the above error message, the `Object type contact is not supported` indicates that the user doesn't have **Write** access to the Contact object.

## Solution

To resolve the issue, ensure that the user has:

- Read/write level permissions to the object that the user is trying to edit in Salesforce
- Read/write permissions on all of the fields configured for editing

For information about object-level security, field-level security, and record-level security in Salesforce, see [Control Who Sees What](https://help.salesforce.com/s/articleView?id=sf.security_data_access.htm&type=5). You can also contact your Salesforce administrator for help with [setting object permissions in profiles](https://help.salesforce.com/s/articleView?id=sf.perm_sets_object_perms_edit.htm&type=5).

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.