---
title: Couldn't assign permission set when enabling Salesforce server-to-server flow
description: Resolves an error that occurs due to an inactive integration user in Salesforce.
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# Couldn't assign permission set when enabling Salesforce server-to-server flow

This article helps you troubleshoot the "Couldn't assign permission set because the integration user is inactive in Salesforce." error when you enable Salesforce server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce      |
|**Users**     | Administrator  |

## Symptoms

When you try to enable Salesforce with server-to-server flow, the following error message is displayed.

> Couldn't assign permission set because the integration user is inactive in Salesforce.

## Cause

During Salesforce server-to-server flow setup, a connected app is deployed to the Salesforce organization. The connected app is associated with an integration user that is created automatically. A permission set is then assigned to the integration user. The error occurs when the integration user is inactive in Salesforce. The permission set can't be assigned to an inactive user.

## Resolution

To resolve this issue, check if there's a user with prefix "copilotforsalesintegrationuser" in the username. If the user exists, confirm that the user is active. If the user is set to inactive manually, revert the status to active. Otherwise, reach out to Microsoft support.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]