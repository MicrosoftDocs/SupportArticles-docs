---
title: Resolve Invalid CRM Record ID error When saving notes from Sales agent
description: Fix the Invalid CRM Record ID error that appears when you save voice notes from Sales agent. Follow these steps to identify the cause and retry successfully.
ms.date: 05/18/2026
ms.reviewer: shjais, v-shaywood
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# Invalid CRM Record ID error when saving notes from Sales agent

## Summary

This article helps you fix an error that occurs when you try to [save voice notes to CRM](/microsoft-sales-copilot/sales-agent-chat-mobile#capture-voice-notes-and-save-to-crm-records) from [Sales agent](/microsoft-sales-copilot/sales-chat-overview).

This issue affects the following areas.

| Requirement type | Description                      |
| ---------------- | -------------------------------- |
| **Client app**   | Sales agent in Outlook and Teams |
| **Platform**     | Web, desktop, and mobile clients |
| **OS**           | Windows, Mac, Android, iOS       |
| **Deployment**   | User managed and admin managed   |
| **CRM**          | Dynamics 365 and Salesforce      |
| **Users**        | All users                        |

## Symptoms

When you try to save a voice note to CRM from Sales agent, after you specify an opportunity by ID or name, the operation fails and returns the following error message:

> Invalid CRM Record ID - The CRM Record ID provided is not valid. Please verify and try again.

## Cause

Sales agent can't resolve the opportunity from the input that you provided. This problem can occur in the following scenarios:

- The opportunity ID is incorrect or incomplete.
- The opportunity name resembles an ID and is interpreted as a CRM record ID.
- Voice input is misinterpreted. This condition creates an invalid or malformed ID.

## Solution

Check the opportunity reference, and then retry the operation by using the following scenario, as appropriate:

### Incorrect or invalid opportunity ID

If you entered an opportunity ID:

- Try again to save the note by using a clear, descriptive opportunity name in natural language. For example, `Save this note to the opportunity named Contoso Renewal Deal`.
- Don't retry with a manually provided ID, such as `Save notes to 8f3a2c1d-45b6-4c2a-9d1e-123456789abc`.

### Opportunity name interpreted as an ID

If you entered an opportunity name that resembles an ID:

1. Retry the operation by using a clearly identifiable opportunity name. For example, instead of `Save to ABC12345`, use `Save this note to the opportunity named Contoso Renewal Deal`.
1. Rephrase your input to explicitly indicate that it's a name.

> [!NOTE]
>
> - When possible, use clear, descriptive opportunity names instead of IDs.
> - Avoid short alphanumeric names that resemble CRM record IDs.
> - If the problem continues, check the opportunity details directly in CRM.

## Get help from the community

If your problem isn't resolved, go to the [Sales agent - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to connect with other users and Microsoft experts.

## Related content

- [Use Sales agent in Microsoft 365 Copilot](/microsoft-sales-copilot/use-sales-chat)
- [Functional overview of Sales agent](/microsoft-sales-copilot/functional-overview)
- [Set up record creation in Dynamics 365 with Sales agent](/microsoft-sales-copilot/set-up-record-creation-dynamics-365)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
