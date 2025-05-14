---
title: The profile name is already in use. Pick a different name or rename the existing profile in Salesforce error when enabling Salesforce server-to-server flow
description: Resolves an error that occurs when the server is unable to create a new profile due to a duplicate profile name while enabling Salesforce Server-to-Server flow.
ms.date: 05/14/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---
# "The profile name is already in use. Pick a different name or rename the existing profile in Salesforce" error when enabling Salesforce server-to-server flow

This article helps you troubleshoot the error "The profile name is already in use. Pick a different name or rename the existing profile in Salesforce." when you enable Salesforce server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams        |
|**Platform**     | Web and desktop clients         |
|**OS**     | Windows and Mac         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Salesforce        |
|**Users**     | Administrator   |

## Symptoms

When you try to enable Salesforce with server-to-server flow, the following error message is displayed:

> The profile name is already in use.

## Cause

When a setup request is received, the server attempts to create a profile named **Copilot For Sales Integration Profile** for the Salesforce Server-to-Server flow. The error occurs when a profile with the same name already exists in the organization, preventing the creation process.

## Resolution

To resolve this issue, check if a profile with the same name already exists in the Salesforce organization. If it was created before enabling the Server-to-Server flow, rename the existing profile and try again. If the profile was not created previously, contact Microsoft Support.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
