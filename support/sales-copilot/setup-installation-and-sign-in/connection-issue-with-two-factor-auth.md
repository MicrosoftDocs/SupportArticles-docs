---
title: Copilot for Sales doesn't connect to Dynamics 365 with two-factor authentication enabled
description: Resolves an issue where the Copilot for Sales app for Microsoft Teams doesn't connect to Dynamics 365 when two-factor authentication is enabled.
ms.date: 01/04/2024
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Copilot for Sales doesn't connect to Dynamics 365 with two-factor authentication enabled

This article helps you troubleshoot and resolve an issue where the Microsoft Copilot for Sales app for Microsoft Teams doesn't connect to Microsoft Dynamics 365 when the [two-factor authentication (2FA)](https://www.microsoft.com/security/business/security-101/what-is-two-factor-authentication-2fa) is enabled.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Copilot for Sales Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce        |
|**Users**     | All users   |

## Symptoms

The Copilot for Sales app can't communicate with Dynamics 365, but users can access Dynamics 365 directly.

## Cause

The two-factor authentication is enabled in Dynamics 365, but not in Microsoft Teams.

If the Dynamics 365 organization has two-factor authentication enabled, but Microsoft Teams doesn't, the Copilot for Sales app for Microsoft Teams can't communicate with Dynamics 365. This is intended to prevent security incidents. When Dynamics 365 has two-factor authentication enabled, any communication from users who log in to an app without two-factor authentication is considered untrusted.

## Resolution

To solve this problem, take one of the following actions:

- Enable two-factor authentication in [Dynamics 365](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#microsoft-cloud-applications) and [Microsoft Teams](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication?view=o365-worldwide&preserve-view=true). This is the preferred action.
- Disable two-factor authentication in Dynamics 365 and Microsoft Teams.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
