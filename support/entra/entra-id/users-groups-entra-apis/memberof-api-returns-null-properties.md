---
title: Microsoft Graph API MemberOf Returns Null Values for Properties
description: Provides a solution to an issue where some properties are indicated as null when you call the Microsoft Graph API memberOf.
ms.date: 04/03/2025
ms.service: entra-id
ms.reviewer: bhvootla, adoyle, nualex, v-weizhu
ms.custom: sap:Problem with querying or provisioning resources
---
# Microsoft Graph API memberOf returns null values for some properties

This article provides a solution to an issue where some properties are indicated as `null` when you call the Microsoft Graph API `memberOf`.

## Symptoms

When calling one of the following APIs that can return the list of groups and directory roles that a user is a direct member of, you see `null` values for all properties except the object type and ID in the JSON response:

```msgraph
GET https://graph.microsoft.com/v1.0/me/memberOf
```

```msgraph
GET https://graph.microsoft.com/v1.0/users/{id | userPrincipalName}/memberOf
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

When an application queries the membership that returns a `directoryObject` type collection, if it doesn't have permission to read a resource type, members of that type are returned with limited information. For example, only the object type and ID might be returned, and other properties are indicated as null. Complete information is returned for the object types that the application has permission to read.

For more information, see [List a user's direct memberships](/graph/api/user-list-memberof) and [Limited information returned for inaccessible member objects](/graph/permissions-overview#limited-information-returned-for-inaccessible-member-objects).

## Solution

To get complete information, configure at least the `Directory.Read.All` permission for your application.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]