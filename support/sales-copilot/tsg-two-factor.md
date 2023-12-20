---
title: Sales Copilot doesn't connect to Dynamics 365 with two-factor authentication enabled
description: Troubleshoot and resolve errors where the Sales Copilot app for Microsoft Teams doesn't connect to Dynamics 365 when two-factor authentication is enabled.
ms.date: 10/31/2023
ms.topic: troubleshooting-problem-resolution
ms.service: microsoft-sales-copilot
author: sbmjais
ms.author: shjais
manager: shujoshi
---

# Sales Copilot doesn't connect to Dynamics 365 with two-factor authentication enabled

This article helps you troubleshoot and resolve errors where the Sales Copilot app for Microsoft Teams doesn't connect to Dynamics 365 when two-factor authentication is enabled.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales Copilot Outlook add-in        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce        |
|**Users**     | All users   |

## Symptom

The Sales Copilot app is unable to communicate with Dynamics 365, but a user can access Dynamics 365 directly. 

## Cause

Two-factor authentication is enabled in Dynamics 365, but not in Microsoft Teams.

If the Dynamics 365 organization has two-factor authentication enabled, but Microsoft Teams doesn't, the Sales Copilot app for Teams can't communicate with Dynamics 365. This is intended to prevent security incidents. When Dynamics 365 has two-factor authentication enabled, any communication from users that logged into an app without two-factor authentication is considered as untrusted.

## Solution

To solve this problem, you must perform one of the following actions:

- Enable two-factor authentication in [Dynamics 365](/azure/active-directory/conditional-access/concept-conditional-access-cloud-apps#microsoft-cloud-applications) and [Teams](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication?view=o365-worldwide&preserve-view=true). This is the preferred action.
 
- Disable two-factor authentication in Dynamics 365 and Teams.

## Is your issue still not resolved?

Visit the [Sales Copilot - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.