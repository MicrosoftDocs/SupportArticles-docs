---
title: Invalid CRM Record ID error when saving notes from Sales agent
description: Resolves an error that occurs when a user tries to save notes from Sales agent due to an invalid CRM record ID.
ms.date: 05/12/2026
author: sbmjais
ms.author: shjais
ms.custom: sap:CRM Permissions and Configurations\CRM Settings
---

# Invalid CRM Record ID error when saving notes from Sales agent

This article helps you resolve an error that occurs when you try to save notes to CRM from Sales agent using voice notes.

## Who is affected?

| Requirement type |Description  |
|---------|---------|
|**Client app**     |  Sales agent in Outlook and Teams        |
|**Platform**     | Web, desktop, and mobile clients         |
|**OS**     | Windows, Mac, Android, iOS         |
|**Deployment**     | User managed and admin managed       |
|**CRM**     | Dynamics 365 and Salesforce        |
|**Users**     | All users  |

## Symptoms

When you try to save notes to CRM from Sales agent using voice notes, the operation fails with the following error message:

> Invalid CRM Record ID - The CRM Record ID provided is not valid. Please verify and try again.

This error occurs after you specify an opportunity (by ID or name) to associate with the note.

## Cause

Sales agent is unable to resolve the CRM record (opportunity) from the input provided. This can happen in the following scenarios:

- The opportunity ID provided is incorrect or incomplete.
- The opportunity name resembles an ID and is interpreted as a CRM record ID.
- Voice input is misinterpreted, resulting in an invalid or malformed ID.

## Resolution

Verify the opportunity reference and retry the operation using the appropriate scenario below.

### Scenario 1: Incorrect or invalid opportunity ID

If you entered an opportunity ID:

1. Don't retry with a manually provided ID.
1. Provide the opportunity name in natural language instead.
1. Retry saving the note using a clear and descriptive opportunity name.

**Example**

Instead of:
> Save notes to 8f3a2c1d-45b6-4c2a-9d1e-123456789abc

Use:
> Save this note to opportunity named Contoso Renewal Deal

### Scenario 2: Opportunity name interpreted as an ID

If you entered an opportunity name that resembles an ID:

1. Retry the operation using a clearly identifiable opportunity name.
1. Rephrase your input to explicitly indicate that it's a name.

**Example**

Instead of:
> Save to ABC12345

Use:
> Save this note to opportunity named Contoso Renewal Deal

> [!NOTE]
> - Use clear and descriptive opportunity names instead of IDs when possible.
> - Avoid short alphanumeric names that resemble CRM record IDs.
> - If the issue persists, verify the opportunity details directly in CRM.

## More information

If your issue is still unresolved, go to the [Sales agent - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/viva-sales/bd-p/VivaSales) to engage with our experts.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]