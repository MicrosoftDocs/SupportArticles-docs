---
title: Troubleshoot 403 error when adding a user to a group using Microsoft Graph API
description: Provides solutions to 403 Authorization_RequestDenied error that occurs when you add a user to a group using Microsoft Graph API.
ms.date: 04/21/2025
ms.service: entra-id
ms.author: bachoang
ms.custom: sap:Getting access denied errors (Authorization)
---

# Troubleshoot 403 error when adding a user to a group using Microsoft Graph API

This article provides guidance on troubleshooting a 403 Authorization_RequestDenied error when you try to add a user to a group using the Microsoft Graph API.

## Symptoms

When you try to add a user to a group using Microsoft Graph API, you receive the 403 error with the following error message:

```output
{
"error": {
"code": "Authorization\_RequestDenied",
"message": "Insufficient privileges to complete the operation.",
"innerError": {
"date": "2024-05-07T15:39:39",
"request-id": "aa324f0f-b4a3-4af6-9c4f-996e195xxxx",
"client-request-id": "aa324f0f-b4a3-4af6-9c4f-996e1959074e"
}
}
}
```

## Cause

This issue might occur if the group you tried to add the use to can't be managed by Microsoft Graph. Microsoft Graph only supports Microsoft 365 groups and Security groups.

For the Microsoft Graph supported group types, see [Working with groups in Microsoft Graph](/graph/api/resources/groups-overview?view=graph-rest-1.0&tabs=http#group-types-in-microsoft-entra-id-and-microsoft-graph)

## Solution

### Step 1: Check the group type

Make sure that the group you are working is supported by Microsoft Graph.

1. In Microsoft Graph, the type of group can be identified by the settings of its `groupTypes`, `mailEnabled`, and `securityEnabled` properties. Use the [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) tool to check the group's attributes:

    ```http
    https://graph.microsoft.com/v1.0/groups/<Group Object ID>?$select=displayName,groupTypes,mailEnabled,securityEnable
    ```

    Example response:

    ```output
        {
         "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#groups(displayName,groupTypes,mailEnabled,securityEnabled)/$entity",
        "displayName": "Test group A",
        "groupTypes": [],
        "mailEnabled": true,
        "securityEnabled": false
        }
    
   ```

2. Review the following table to verify if the group type is supported by Microsoft Graph API. In the example response, the "Test group A" group is a security group.  For more information, see [Working with groups in Microsoft Graph](/graph/api/resources/groups-overview?view=graph-rest-1.0&tabs=http#group-types-in-microsoft-entra-id-and-microsoft-graph).

    | Type |groupTypes | mailEnabled | securityEnabled | Created and managed via the groups APIs |
    |--|--|--|--|--|
    | [Microsoft 365 groups](#microsoft-365-groups) | `["Unified"]` | `true` | `true` or `false` | Yes |
    | [Security groups](#security-groups-and-mail-enabled-security-groups) | `[]` | `false` | `true` | Yes |
    | [Mail-enabled security groups](#security-groups-and-mail-enabled-security-groups) | `[]` | `true` | `true` | No; read-only through Microsoft Graph |
    | Distribution groups | `[]` | `true` | `false` | No; read-only through Microsoft Graph |

> [!NOTE]
> - Group type cannot be changed after creation. For more information, see [Edit group settings](/entra/fundamentals/how-to-manage-groups#edit-group-settings).
> - Dynamic groups (groupTypes contains "DynamicMembership") cannot have their membership managed via Microsoft Graph.

### Step 2: Verify required permissions

Different group member types require specific permissions. For user-type membership, ensure that the application or account performing the operation has the `GroupMember.ReadWrite.All` permission.

Refer to the [Add members documentation](https://learn.microsoft.com/en-us/graph/api/group-post-members?view=graph-rest-1.0&amp;tabs=http) for detailed permission requirements.

### Step 3: Check if the group is a role-assignable group

1. Role-assignable groups require additional permissions to manage their members. You can confirm if the group is role-assignable using Azure Portal or Microsoft Graph Explorer:

    **Azure Portal**
    
    1. In the [Azure portal](https://portal.azure.com), go to **Microsoft Entra ID**, select **Groups**, and then select **All groups**.
    1. Locate the group that you are working on, select **Properties**. Review the  **Microsoft Entra role can be assigned to the group** option.
     
    **Microsoft Graph Explorer:**
    
    Perform the following query and check the `isAssignableToRoles` value.
    
    ```http
    GET https://graph.microsoft.com/v1.0/groups/<group object="" id="">?$select=displayName,groupTypes,mailEnabled,securityEnabled,isAssignableToRole
    ```
    Example response:

    ```output
     {
         "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#groups(displayName,groupTypes,mailEnabled,securityEnabled,isAssignableToRole)/$entity",
        "displayName": "Test group B",
        "groupTypes": [],
        "mailEnabled": false,
        "securityEnabled": true,
        "isAssignableToRole": true
        }
    ```
  
2. If the group is role-assignable, you need the `RoleManagement.ReadWrite.Directory` permission in addition to `GroupMember.ReadWrite.All`. Fore more information, see [Add members documentation](/graph/api/group-post-members?view=graph-rest-1.0&amp;tabs=http#permissions).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]