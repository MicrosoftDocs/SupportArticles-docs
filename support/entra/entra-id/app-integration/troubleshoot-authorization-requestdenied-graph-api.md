---
title: Troubleshoot Authorization_RequestDenied error with Microsoft Graph
description: Guides to troubleshoot Authorization_RequestDenied error with Microsoft Graph in Postman.
ms.author: anukala
ms.date: 12/24/2024
ms.service: entra-id
ms.custom: sap:Microsoft Graph Users, Groups, and Entra APIs
---

# Troubleshoot Authorization_RequestDenied error with Microsoft Graph

When you use Microsoft Graph API to manage users, you might receive the following error message:

> `Authorization_RequestDenied. Insufficient privileges to complete the operation.`

This article demonstrates how to troubleshoot the `Authorization_RequestDenied` error in Microsoft Graph API by using Postman, through a "disable user" scenario.

## Cause of the Authorization_RequestDenied error

This error typically occurs because the user or app doesn't have sufficient permissions. To call Graph APIs, your app registration must have the following permissions:

- The appropriate Microsoft Entra RBAC role for the required access level. For more information, see [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference).
- The necessary API permissions to access Microsoft Graph.

## Troubleshooting Microsoft Graph API by using Postman

### Step 1: Assign Microsoft Entra RBAC role to the app registration (Service Principal)

1. Log in to the [Azure portal](https://portal.azure.com), and go to **Microsoft Entra ID**.
1. In the **Manage** section, select **Roles and administrators**.
1. Select the appropriate role based on the required level of access. In this article, the app will manage the users. Therefore, **User Administrator** is selected.
1. Select **Add assignments**, select your app registration, and then select **Add**.

### Step 2: Locate the application ID, client secret, and token endpoints of your app

1. In the [Azure portal](https://portal.azure.com), go to **App registrations**, and then select your app registration.  
1. On the **Overview** page, record the **Application (client) ID**.
1. Select **Endpoints**. This selection provides information, such as token endpoints, that will be used in the Postman configuration. This article uses OAuth 2.0 and token-based authentication together with Entra ID. In this case, you should record the **OAuth 2.0 token endpoint (v2)**.

    :::image type="content" source="media/troubleshoot-authorization-requestdenied-graph-api/check-endpoints.png" alt-text="Screenshot that shows checking the endpoints of the app registration." lightbox="media/troubleshoot-authorization-requestdenied-graph-api/check-endpoints.png":::
1. In the **Manage** section, select **Certificates & secrets**. Create a client secret or use an existing client secret for testing.

    In the Postman configuration, ensure you use the Client secret value, not the Secret ID. The client secret value cannot be viewed, except immediately after it's created.

### Step 3: Configure Postman

1. In Postman, select a request or collection, and then select **Authorization**.
1. Set Auth type to **OAuth 2.0**.
1. In the **Configure New Token** section, specify the following configuration:

   - Grant type: Client Credentials
   - Access Token URL: \<OAuth 2.0 token endpoint\>.
   - Client ID: \<Application (client) ID\>
   - Client secret: \<Client secret value\>
   - Scope: `https://graph.microsoft.com/.default`
   - Client Authentication: Send as Basic Auth header

    :::image type="content" source="media/troubleshoot-authorization-requestdenied-graph-api/postman-config.png" alt-text="Screenshot of Postman configurations." lightbox="media/troubleshoot-authorization-requestdenied-graph-api/postman-config.png":::

1. Select **Get New Access Token**. If the configuration is correct, you should receive a token that will be used to run the Microsoft Graph API call.
1. Select **Proceed**, and then select **Use token**.

### Step 4: Test and troubleshoot the Microsoft Graph API

1. Send the following PATCH request to disable a user. `1f953789-0000-0000-0000-6f21508fd4e2` is the object ID of a user in the Entra ID.

    ``` HTTP
    Patch https://graph.microsoft.com/v1.0/users/1f953789-0000-0000-0000-6f21508fd4e2
    ```

    ```JSON
    {
    "accountEnabled": false
    }
    ```

1. The `Authorization_RequestDenied` error message is received in the response:

    ```Output
    {
        "error": {
            "code": "Authorization_RequestDenied",
            "message": "Insufficient privileges to complete the operation.",
            "innerError": {
                "date": "2024-12-24T03:25:32",
                "request-id": "096361b2-75be-479b-b421-078610030949",
                "client-request-id": "096361b2-75be-479b-b421-078610030949"
            }
        }
    }
    ```
        
1. Check the [Update user scenario in Microsoft Graph REST API v1.0 endpoint reference](/graph/api/user-update?view=graph-rest-1.0&tabs=http#permissions&preserve-view=true). The following permission is required to enable and disable a user, as described in the Microsoft Graph REST API v1.0 endpoint reference.

    | Property        | Type    | Description |
    |:----------------|:--------|:------------|
    | accountEnabled  | Boolean | `true` if the account is enabled; otherwise, `false`. This property is required when a user is created. <br/> - *User.EnableDisableAccount.All* + *User.Read.All* is the least privileged combination of permissions required to update this property. <br/> - In delegated scenarios, *Privileged Authentication Administrator* is the least privileged role that's allowed to update this property for all administrators in the tenant. |

1. Check whether the app registration has the required permissions:
    1. Locate your app registration in the Azure portal.
    2. In the **Manage** section, select **API permissions**
    3. Check the configured API permissions. In this case, the app registration doesn't have the **User.EnableDisableAccount.All** permission that is the root cause of the issue.

        :::image type="content" source="media/troubleshoot-authorization-requestdenied-graph-api/check-api-permissions.png" alt-text="Screenshot that shows checking API permissions." lightbox="media/troubleshoot-authorization-requestdenied-graph-api/check-api-permissions.png":::

1. Select **Add a permission** to add **User.EnableDisableAccount.All** to the app registration.
1. You must also select **Grant admin consent for default directory** for the permissions. Select **Yes** to confirm that you want to grant admin consent.
1. Send the PATCH request to disable a user. If the request is successful, you should receive a `204 No Content` response.

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
