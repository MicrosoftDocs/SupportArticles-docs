---
title: Remove Windows 365 Business Cloud PCs from Grace with Graph Explorer and Microsoft Graph API
description: Learn how to remove Windows 365 Business Cloud PCs from grace period using Microsoft Graph Explorer and API. Follow this step-by-step guide to resolve issues and reassign licenses.
manager: dcscontentpm
ms.reviewer: kaushika, anwill
ms.date: 04/30/2026
ms.topic: troubleshooting
ms.custom:
- pcy:Provisioning\Grace Period Issues
- sap:WinComm User Experience
---
# Remove Windows 365 Business Cloud PCs from grace period using Graph Explorer and Microsoft Graph API

## Summary

When a license is removed from a user, Windows 365 Business Cloud PCs enter a seven-day grace period before permanent removal. This article explains how to manually remove Cloud PCs from grace to reassign licenses and avoid provisioning issues.

This article provides step-by-step instructions for using Microsoft Graph Explorer and the Microsoft Graph API to perform this deprovision.

## Prerequisites

- Administrator access to your Microsoft 365 tenant

- Permissions to use Microsoft Graph API (Cloud PC administrator or equivalent)

- Access to Microsoft Graph Explorer

- Cloud PCs in `inGracePeriod` status in your Windows 365 environment

## Step 1: Sign in to Graph Explorer

1.  Go to [Graph Explorer \| Try Microsoft Graph APIs - Microsoft Graph](https://developer.microsoft.com/en-us/graph/graph-explorer).

1.  Select **Sign in to Graph Explorer** (top right corner).

1.  Authenticate by using your administrator credentials and set the tenant.

## Step 2: Identify Cloud PCs in grace period

1.  In the query box, set the following **GET** request:

```
https://graph.microsoft.com/beta/deviceManagement/virtualEndpoint/cloudPCs?$filter=status eq 'inGracePeriod'
```

1.  In Graph Explorer, select **Modify Permissions**.

1.  Consent to the following permissions for your session:

- CloudPC.Read.All

- CloudPC.ReadWrite.All

1.  If not already granted, select **Consent** to add these permissions.

1.  Select **Run Query**.

1.  Review the results to locate the Cloud PCs you want to remove. Note the **id** value for each relevant Cloud PC.

## Step 3: Remove a Cloud PC from grace

1.  For each Cloud PC, send a **POST** request to remove it from grace. In the query box, select **POST** and use the following request:

```
https://graph.microsoft.com/beta/deviceManagement/virtualEndpoint/cloudPCs/{cloudPCId}/endGracePeriod
```

1.  Replace `{cloudPCId}` with the actual ID of the Cloud PC. For example:

```
https://graph.microsoft.com/beta/deviceManagement/virtualEndpoint/cloudPCs/4b18de4b-ab05-4059-8c61-0323a7df4ced/endGracePeriod
```

1.  Leave the request body empty.

1.  Select **Run Query**.

1.  If successful, you receive a **No Content - 204** response.

## Step 4: Verify removal

1.  To confirm removal from grace, repeat the **GET** request from Step 3.

1.  The Cloud PC shouldn't appear with status eq 'inGracePeriod'.

## Troubleshooting and notes

- If you receive a permissions error, verify that you have the correct roles and all necessary permissions are consented.

- Changes made through the Graph API might take a few minutes to reflect in the Windows 365 portal.

- Removing a Cloud PC from grace permanently deletes the Cloud PC and any associated user data.

## Additional resources

- Microsoft Graph Cloud PC Documentation

  - [List cloudPCs - Microsoft Graph beta](/graph/api/virtualendpoint-list-cloudpcs?view=graph-rest-beta&tabs=http)

  - [cloudPC: endGracePeriod - Microsoft Graph beta](/graph/api/cloudpc-endgraceperiod?view=graph-rest-beta&tabs=http)
