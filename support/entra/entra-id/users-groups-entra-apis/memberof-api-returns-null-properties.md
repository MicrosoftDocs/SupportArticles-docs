---
title: Microsoft Graph API memberOf returns null properties
description: Provides a solution to an issue where some properties are indicated as null when you call the Microsoft Graph  API memberOf.
ms.date: 03/21/2025
ms.service: entra-id
ms.reviewer: bhvootla, adoyle, nualex, v-weizhu
ms.custom: sap:Microsoft Graph Users, Groups, and Entra APIs
---
# Microsoft Graph API memberOf returns null for some properties

This article provides a solution to an issue where some properties are indicated as `null` when you call the `memberOf` API in Microsoft Graph.

## Symptoms

When you call the one of following APIs, the JSON response might show `null` for other properties except for the object type and ID:

```msgraph
Get https://graph.microsoft.com/v1.0/me/memberOf
```

```msgraph
Get https://graph.microsoft.com/v1.0/users/{id | userPrincipalName}/memberOf
```

Here's a sample JSON response:

```json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#directoryObjects",
    "value": [
        {
            "@odata.type": "#microsoft.graph.group",
            "id": "b0a133d4-3f3d-4990-be22-879151155f19",
            "deletedDateTime": null,
            "classification": null,
            "createdDateTime": null,
            "creationOptions": [],
            "description": null,
            "displayName": null,
            "expirationDateTime": null,
            "groupTypes": [],
            "isAssignableToRole": null,
            "mail": null,
            "mailEnabled": null,
            "mailNickname": null,
            "membershipRule": null,
            "membershipRuleProcessingState": null
        }
    ]
}
```

## Cause

When an application queries the membership that returns a `directoryObject` type collection, if it doesn't have permission to read a certain resource type, members of that type are returned with limited information. For example, only the object type and ID may be returned and other properties are indicated as null. Complete information is returned for the object types that the application has permissions to read.

For more information, see [List a user's direct memberships](/graph/api/user-list-memberof) and [Limited information returned for inaccessible member objects](/graph/permissions-overview#limited-information-returned-for-inaccessible-member-objects).

## Solution

To get complete information, configure at least the `Directory.Read.All` permission for your application.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]