---
title: Tenant doesn't have premium license when querying user sign-in activities using Microsoft Graph
description: Provides solutions to the "either tenant is B2C or tenant doesn't have premium license" error when you query user sign-in activities using Microsoft Graph
ms.date: 04/25/2025
ms.service: entra-id
ms.author: bachoang
ms.custom: sap:Getting access denied errors (Authorization)
---

# Neither tenant is B2C or tenant doesn't have premium license when querying sign-in activities

This article describes the error that occurs when you make Microsoft Graph API calls related to user sign-in activities or user registration details.

## Symptoms

When you run one of the following Microsoft Graph API calls, you might see this error:

```http
GET https://graph.microsoft.com/v1.0/auditLogs/signIns

GET https://graph.microsoft.com/v1.0/users?$select=displayName,userPrincipalName,signInActivity

GET https://graph.microsoft.com/v1.0/reports/UserRegistrationDetails
```

Example response

```output
'error': {
    'code': 'Authentication\_RequestFromNonPremiumTenantOrB2CTenant',
    'message': 'Neither tenant is B2C or tenant doesn't have premium license',
    'innerError': {
        'date': '2021-03-04T07:53:51',
        'request-id': 'a0a074e6-xxx-c511669fa420',
        'client-request-id': 'a0a074e6-xxx-c511669fa420'
    }
}
```
## Solution

### Scenario 1: Query user sign-in activities

1. Make sure the target tenant has an Entra ID Premium P1 or P2 license. In the Azure portal, go to **Microsoft Entra ID**, select Overview, and then check the **License**.  For more information, see [Sign up for Microsoft Entra ID P1 or P2 editions](/entra/fundamentals/get-started-premium).
1. Verify that the Microsoft Graph Access Token has been granted the `AuditLog.Read.All` and `Directory.Read.All` permissions.

### Scenario 2: Query credential user registration details

1. Make sure the target tenant has an Entra ID Premium P1 or P2 license.
1. Verify that the Microsoft Graph Access Token has been granted the `Reports.Read.All` permission.
1. The authenticating user or the service principle of the application must be in one of these Administrative roles:
    - Reports Reader
    - Security Reader
    - Security Administrator
    - Global Reader
    - Global Administrator

## More information

If an application is configured with only the **AuditLog.Read.All** permission, this error may occur intermittently. This is expected behavior, as the **Directory.Read.All** permission is required to retrieve tenant licensing information when it isn't already cached. Ensure both permissions are included to avoid this issue.