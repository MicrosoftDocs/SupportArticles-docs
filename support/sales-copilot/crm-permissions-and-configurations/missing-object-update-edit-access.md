---
title: Can't update records due to missing object access in Salesforce CRM
description: Resolves an error that occurs when users can't update CRM records in Microsoft Copilot for Sales because of missing object access in Salesforce CRM.
ms.date: 01/10/2024
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Can't update records because of missing object access in Salesforce CRM

This article helps you troubleshoot and resolve issues when users can't update CRM records in Microsoft Copilot for Sales because of missing object access in Salesforce CRM.

> [!NOTE]
> Microsoft Sales Copilot is rebranded as Microsoft Copilot for Sales in January 2024. The screenshot in this article will be updated with the new name soon.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Users trying to update a CRM record from Copilot for Sales |

## Symptoms

When a user tries to update a CRM record from the [Copilot for Sales add-in for Outlook](/microsoft-sales-copilot/use-sales-copilot-outlook), the following error message is displayed:

> To update Salesforce, ask for edit access for this object.

:::image type="content" source="media/missing-object-update-edit-access/update-salesforce-ask-edit-access-object.png" alt-text="Error about unable to update records because of missing object access in Salesforce CRM.":::

## Cause

The user doesn't have edit access to an object in Salesforce.

When a user tries to edit an object, Copilot for Sales checks if the user has **Write** access to the object in Salesforce. If the user doesn't have **Write** access to the object, the error message is displayed.

You can confirm if the user not having **Write** access to the entity is the root cause of the issue if you see the following error in the logs:

```output
Exception thrown in VivaSalesContacts/UpdateContact -  
Microsoft.SalesProductivity.Common.Base.SPServiceException: Salesforce failed to complete task: Message: entity is deleted clientRequestId:<CLIENT REQUEST ID>-self --->  
System.Exception: {  
    "status": 400,  
    "message": "Object type contact is not supported. If you are attempting to use a custom object, be sure to append the '__c' after the entity name.  
                Please reference your WSDL or the describe call for the appropriate names\r\nclientRequestId: <CLIENT REQUEST ID>-self",  
    "error": null,  
    "source": "Salesforce.Common",  
    "errors": []  
} 
```

In the above error message, `Object type contact is not supported` indicates that the user doesn't have **Write** access to the `Contact` object.

## Resolution

To resolve the issue, ensure that the user has:

- Read or write level permissions to the object that the user is trying to edit in Salesforce.
- Read or write permissions to all the fields configured for editing.

For information about object-level security, field-level security, and record-level security in Salesforce, see [Control Who Sees What](https://help.salesforce.com/s/articleView?id=sf.security_data_access.htm&type=5). You can also contact your Salesforce administrator for help with [setting object permissions in profiles](https://help.salesforce.com/s/articleView?id=sf.perm_sets_object_perms_edit.htm&type=5).

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
