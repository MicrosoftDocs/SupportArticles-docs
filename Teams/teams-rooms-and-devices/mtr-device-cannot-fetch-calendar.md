---
title: Teams Rooms devices can't fetch calendar from Exchange Online
description: Resolves an issue that a Microsoft Teams Rooms (MTR) device can't fetch calendar from Exchange Online.
ms.date: 10/30/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI163362
ms.reviewer: subansal, meerak, scapero
---

# Teams Rooms devices can't fetch calendar from Exchange Online

## Symptoms

After you sign in to a Microsoft Teams Rooms device, the following error message is displayed:

> Cannot fetch calendar

:::image type="content" source="media/mtr-device-cannot-fetch-calendar/error.png" alt-text="Screenshot of the Cannot fetch calendar error.":::

And the following error is logged in the [sign-in logs in Microsoft Entra ID](/azure/active-directory/reports-monitoring/concept-sign-ins):

```output
“requestId": "<request ID>",
"userDisplayName": "Teamsroom@contoso.com
"userPrincipalName": " Teamsroom@contoso.com ",
"userId": "<user ID>",
"appId": "<app ID>",
"appDisplayName": "Office 365 Exchange Online",
"ipAddress": "<IP address>",
"clientAppUsed": "AutoDiscover",
"userAgent": "MicrosoftTeamsRoom/<version>",
"correlationId": <correlation ID>",
"conditionalAccessStatus": "failure",
status": {
    "errorCode": 53003,
    "failureReason": "Access has been blocked by Conditional Access policies. The access policy does not allow token issuance.",
    "additionalDetails": "If this is unexpected, see the conditional access policy that applied to this request in the Azure Portal."
}
```

## Cause

This issue occurs if modern authentication isn't enabled for Teams Rooms, and your organization uses a Conditional Access policy to block basic authentication.

To find out which Conditional Access policy is applied, review the [Microsoft Entra sign-in events](/azure/active-directory/conditional-access/troubleshoot-conditional-access#azure-ad-sign-in-events).

## Resolution

To fix the issue, enable the client-side setting for modern authentication on Teams Rooms:

1. In Teams Rooms, select the **More (...)** button.
2. Select **Settings**, and then enter the username and password for the device administrator.
3. On the **Account** tab, turn on the **Modern Authentication** switch, and then select **Save and exit**.
