---
title: Troubleshoot Error 403 When Adding a User to a Group By Using Microsoft Graph API
description: Provides solutions for the 403 Authorization_RequestDenied error that occurs when you add a user to a group by using Microsoft Graph API.
ms.date: 04/21/2025
ms.service: entra-id
ms.author: bachoang
ms.custom: sap:Getting access denied errors (Authorization)
---

# Troubleshoot 403 error when adding a user to a group by using Microsoft Graph API

This article provides guidance for troubleshooting a "403 Authorization_RequestDenied" error that occurs when you try to add a user to a group by using the Microsoft Graph API.

## Symptoms

When you try to add a user to a group by using Microsoft Graph API, you receive the following "403" error message:

```output
{
"error": {
"code": "Authorization_RequestDenied",
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

This issue occurs if the group that you tried to add the user to can't be managed by Microsoft Graph. Microsoft Graph supports only Microsoft 365 groups and Security groups.

## Solution

### Step 1: Check the group type

Make sure that the group you trying to modify is supported by Microsoft Graph.

1. In Microsoft Graph, the group type can be determined by the settings of its `groupTypes`, `mailEnabled`, and `securityEnabled` properties. Use the [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to check the group's attributes:

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

2. Review the following table to verify that the group type is supported by Microsoft Graph API. In the example response, the "Test group A" group is a Distribution group that can't be supported by Microsoft Graph. For more information, see [Working with groups in Microsoft Graph](/graph/api/resources/groups-overview).

    | Type |groupTypes | mailEnabled | securityEnabled | Can be managed by using Microsoft Graph APIs |
    |--|--|--|--|--|
    | [Microsoft 365 groups](/graph/api/resources/groups-overview#microsoft-365-groups) | `["Unified"]` | `true` | `true` or `false` | Yes |
    | [Security groups](/graph/api/resources/groups-overview#security-groups-and-mail-enabled-security-groups) | `[]` | `false` | `true` | Yes |
    | [Mail-enabled security groups](/graph/api/resources/groups-overview#security-groups-and-mail-enabled-security-groups) | `[]` | `true` | `true` | No; read-only through Microsoft Graph |
    | Distribution groups | `[]` | `true` | `false` | No; read-only through Microsoft Graph |

    > [!NOTE]
    > - Group type can't be changed after creation. For more information, see [Edit group settings](/entra/fundamentals/how-to-manage-groups#edit-group-settings).
    > - The membership of a dynamic group (**groupTypes** contains "DynamicMembership") can't be managed through Microsoft Graph.

### Step 2: Verify required permissions

Different group member types require specific permissions. For user-type membership, make sure that the application or account that performs the operation has the `GroupMember.ReadWrite.All` permission.

For detailed permission requirements, see [Add members documentation](/graph/api/group-post-members).

### Step 3: Check whether the group is a role-assignable group

1. Role-assignable groups require extra permissions to manage their members. You can verify that the group is role-assignable by using Azure portal or Microsoft Graph Explorer:

    **Azure portal**
    
    1. In the [Azure portal](https://portal.azure.com), go to **Microsoft Entra ID**, select **Groups**, and then select **All groups**.
    1. Locate the target group, select **Properties**, and then check whether **Microsoft Entra role can be assigned to the group** is set to **Yes**.
     
    **Microsoft Graph Explorer**
    
    To check the `isAssignableToRoles` value, run the following request:
    
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
  
2. If the group is role-assignable, you need the `RoleManagement.ReadWrite.Directory` permission in addition to `GroupMember.ReadWrite.All`. For more information, see [Add members documentation](/graph/api/group-post-members).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
