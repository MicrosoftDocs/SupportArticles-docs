---
title: Copilot for Sales doesn't connect to Dynamics 365 with multifactor authentication enabled
description: Resolves an issue where the Copilot for Sales app for Microsoft Teams doesn't connect to Dynamics 365 when multifactor authentication is enabled.
ms.date: 01/10/2024
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---
# Copilot for Sales doesn't connect to Dynamics 365 with multifactor authentication enabled

This article helps you troubleshoot and resolve an issue where the Microsoft Copilot for Sales app for Microsoft Teams doesn't connect to Microsoft Dynamics 365 when the multifactor authentication (MFA) is enabled.

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

The MFA or conditional access policy is enabled in Dynamics 365, but not in Microsoft Teams.

If the Dynamics 365 organization has MFA or conditional access policy enabled, but Microsoft Teams doesn't, the Copilot for Sales app for Microsoft Teams can't communicate with Dynamics 365. This is intended to prevent security incidents. When Dynamics 365 has MFA or conditional access policy enabled, any communication from users who log in to an app without MFA or conditional access policy is considered untrusted.

## Resolution

To solve this problem, you must [enable multifactor authentication](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication?view=o365-worldwide&preserve-view=true) or [conditional access policy](/entra/identity/conditional-access/concept-conditional-access-cloud-apps) in Dynamics 365 and Microsoft Teams. Microsoft Teams and the Dataverse resource require the same MFA or conditional access policy. 

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.
