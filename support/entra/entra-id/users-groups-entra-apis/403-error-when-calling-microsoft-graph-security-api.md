---
title: HTTP 403 Authorization Error When Calling Microsoft Graph Security API
description: Provides solutions to an HTTP 403 error that occurs when you call the Microsoft Graph Security API.
ms.date: 05/14/2025
ms.service: entra-id
ms.custom: sap:Getting access denied errors (Authorization)
ms.reviewer: bachoang, v-weizhu
---
# HTTP 403 authorization error when calling the Microsoft Graph Security API

This article provides solutions to an HTTP 403 error that occurs when you call the Microsoft Graph Security API.

## Symptoms

When using the Microsoft Graph Security API to call endpoints such as `https://graph.microsoft.com/v1.0/security/alert` and `https://graph.microsoft.com/beta/security/secoreScores`, you might receive a 403 error with the following message:

> Auth token does not contain valid permissions or user does not have valid roles

## Cause

The error occurs due to one of the following reasons:

- The access token lacks the necessary Microsoft Graph permissions for the security endpoints.
- The authenticating user that obtains the access token doesn't have a Microsoft Entra admin role required for the delegated permission type token.

## Solution 1: Use valid Microsoft Graph permissions

There are two types of tokens: application and delegated permission tokens. For more information, see [Application and delegated permissions for access tokens in the Microsoft identity platform](../app-integration/application-delegated-permission-access-tokens-identity-platform.md).

For delegated permission tokens, the Microsoft Graph permissions are in the `scp` claim. For application permission tokens, the permissions are in the `roles` claim. To get the required Microsoft Graph permissions, you can refer to the following table, which is also listed in [Authorization and the Microsoft Graph Security API](/graph/security-authorization#register-an-application-with-the-microsoft-identity-platform-endpoint):

|Permission | Entity | Supported requests |
|:----------|:-------|:-------------------|
|SecurityActions.Read.All| &bull; [securityActions](/graph/api/resources/securityaction) (preview) | GET |
|SecurityActions.ReadWrite.All| &bull; [securityActions](/graph/api/resources/securityaction) (preview) | GET, POST |
|SecurityEvents.Read.All | &bull; [alerts](/graph/api/resources/alert)</br> &bull; [secureScores](/graph/api/resources/securescore) </br> &bull; [secureScoreControlProfiles](/graph/api/resources/securescorecontrolprofiles) | GET |
|SecurityEvents.ReadWrite.All | &bull; [alerts](/graph/api/resources/alert)</br> &bull; [secureScores](/graph/api/resources/securescore) </br> &bull; [secureScoreControlProfiles](/graph/api/resources/securescorecontrolprofiles) | GET, POST, PATCH |
|ThreatIndicators.ReadWrite.OwnedBy | &bull; [tiIndicator](/graph/api/resources/tiindicator) (preview) | GET, POST, PATCH, DELETE|

For more information, see [Use the Microsoft Graph security API](/graph/api/resources/security-api-overview) and [Microsoft Graph permissions reference](/graph/permissions-reference).

## Solution 2: Use valid Microsoft Entra admin roles

For delegated permission tokens, the authenticating user needs to have one of the following admin roles:

|Microsoft Entra role|Role template ID|
|---|---|
|Security Reader|5d6b6bb7-de71-4623-b4af-96380a352509|
|Security Administrator|194ae4cb-b126-40b2-bd5b-6091b380977d|
|Global Administrator|62e90394-69f5-4237-9190-012177145e10|

For more information, see [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference) and [Authorization and the Microsoft Graph Security API](/graph/security-authorization).

The `wids` claim in the token contains the Microsoft Entra role. It can be used to determine whether the user has sufficient privileges.

```json
"ver": "1.0"
"wids": [
   "62e90394-69f5-4237-9190-012177145e10",
   "b79fbf4d-3ef9-4689-8143-76b194e85509"
],
"xms_st":{
  "sub": "<sub>"
}
```

> [!NOTE]
> If the token is obtained via the [implicit grant flow](/entra/identity-platform/v2-oauth2-implicit-grant-flow), the `wids` claim might not exist. For more information, see [Access tokens in the Microsoft identity platform](/entra/identity-platform/access-tokens). In this case, use a different OAuth 2 grant flow, such as the [authorization code flow](/entra/identity-platform/v2-oauth2-auth-code-flow), to obtain the access token.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
