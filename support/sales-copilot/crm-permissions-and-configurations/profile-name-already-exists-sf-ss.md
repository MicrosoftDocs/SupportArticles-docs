---
title: Profile name already in use when enabling Salesforce server-to-server flow
description: Resolves an error that occurs due to a profile with the same name already existing in Salesforce.
ms.date: 05/14/2025
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# Profile name already in use when enabling Salesforce server-to-server flow

This article helps you troubleshoot the "The profile name is already in use. Pick a different name or rename the existing profile in Salesforce." error when you enable Salesforce server-to-server flow.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Teams   |
|**Platform**     | Web and desktop clients |
|**OS**     | Windows and Mac |
|**Deployment**     | User managed and admin managed |
|**CRM**     | Salesforce  |
|**Users**     | Administrator |

## Symptoms

When you try to enable Salesforce with server-to-server flow, the following error message is displayed:

> The profile name is already in use. Pick a different name or rename the existing profile in Salesforce.

## Cause

During Salesforce server-to-server flow setup, a profile named **Copilot For Sales Integration Profile** is created in the Salesforce organization. The error occurs when a profile with the same name already exists, thereby preventing the creation process. 

## Resolution

To resolve this issue, check if a profile with the same name already exists in the Salesforce organization. If it was created before enabling the server-to-server flow, rename the existing profile and try again. If the profile was not created previously, contact Microsoft Support.

## More information

If your issue is still unresolved, go to the [Copilot for Sales - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
