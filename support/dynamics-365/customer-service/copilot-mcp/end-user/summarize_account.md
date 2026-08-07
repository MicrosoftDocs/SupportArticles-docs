---
title: Account Summary
description: Learn how to use the Account Summary capability in Dynamics 365 Customer Service.
ms.date: 06/25/2026
ms.topic: reference
ms.service: dynamics-365-customer-service
author: dleblond
ms.author: dleblond
ms.reviewer: laalexan
---

# Account Summary

> [!NOTE]
> This tool is available by default on the following MCP servers: Dynamics 365 Customer Service. [Learn more about adding this tool to other MCP servers](/dynamics365/customer-service/administer/configure-customer-service-mcp-server).

> [!NOTE]
> **Tool compatibility and versioning**
> The tools and examples in this documentation illustrate current capabilities. Tool names, descriptions, parameters, response formats, and available functionality can change over time.
>
> When you build agents, integrations, or orchestration logic, don't hard-code dependencies on specific tool names, parameter structures, tool metadata, or response schemas. Instead, design your solution to discover and use available tools at runtime.
>
> As the platform evolves, Microsoft might add, remove, rename, or modify tools and tool metadata. Designing against capabilities rather than specific tool identifiers helps maintain compatibility across service updates.

Use this capability when you want a quick overview of a customer account without opening the full account form.

## What it does
The assistant generates a text summary of the account, including:

- Entitlement tier
- Open and total case counts
- Primary contact
- Last activity date
- How long the account has been a customer (relationship tenure)

This is useful for getting context on a company before a customer call, during triage, or when you need a quick refresher on the relationship.

## Try prompts like
- "Brief me about Contoso"
- "Tell me about Sysco Corporation"
- "Summarize the Fabrikam account"
- "Who is Adventure Works?"
- "Recap the Litware account"
- "Give me context on this customer"
- "What's the case history for Northwind Traders?"

## What you'll see in chat
The assistant displays a text summary directly in the chat conversation. There is no interactive widget or app-in-chat component for this capability.

## Helpful tips
- You can refer to the account by name. The assistant finds the account for you automatically.
- If you already have a case open, you can say "summarize the account for this case."
- For the full account form with all fields, say "open account Contoso" instead.
- For contact-level (person) summaries, say "summarize contact Jordan Reyes."

> [!TIP]
> The account summary is a good starting point before handling a customer call or reviewing a new case.

## What happens next
After the summary appears, you can continue with prompts like:

- "Open the Contoso account"
- "Show contacts at this account"
- "List cases for this account"
- "Show my active cases for this customer"

## Does this change data?
**No, summarizing an account does not change data.**

The summary is read-only and does not modify any records.

## Prerequisites
This tool requires the following:

- Case and account summaries require Copilot to be enabled in Power Platform admin center.

Learn more in [Manage Copilot features in Customer Service](/dynamics365/customer-service/administer/configure-copilot-features).

## Tool summary
| Property | Value |
|---|---|
| User-facing name | Account Summary |
| Internal tool name | `summarize_account` |
| Purpose | Returns an AI-generated text summary of a CRM account, covering entitlement tier, open and total case counts, primary contact, last activity, and relationship tenure |

## Tool behavior
Returns an AI-generated text summary of a CRM account, covering entitlement tier, open and total case counts, primary contact, last activity, and relationship tenure. This is a text-only tool with no app-in-chat widget.

## Annotations
| Annotation | Value | Meaning |
|------------|-------|---------|
| `readOnlyHint` | `true` | This tool does not modify data. |
| `destructiveHint` | Not set | Not applicable (read-only tool). |
| `idempotentHint` | Not set | Not applicable (read-only tool). |
| `openWorldHint` | Not set | Uses default (queries Dataverse). |

## Input concepts
### Account identifier

| Input | Description | Required |
|---|---|---|
| `accountId` | `accountId` (string, required). The Dataverse `accountid` GUID of the account to summarize. If the user provides a company name instead of a GUID, the assistant calls `list_accounts` first to resolve the name to a GUID, then calls this tool with the top match. | Yes |

## Response and UI behavior
This tool returns a text-only response with no app-in-chat component.

This MCP tool is supported by an MCP App. [Learn more about MCP Apps](/dynamics365/customer-service/administer/use-mcp-apps-in-chat).

### Response type

Text narrative

The response includes entitlement tier, open and total case counts, primary contact name, last activity date, and relationship tenure.

## Routing notes
Use `summarize_account` for:

- "brief me about", "summarize", "recap", "tell me about", "who is" + a company name
- Quick account context before triage or customer interaction
- Try this tool before concluding a company is not in CRM

Don't use `summarize_account` when the prompt explicitly says:

- **"Open" or "view" account details** - route to `get_account`
- **"List accounts"** - route to `list_accounts`
- **"Summarize contact" (a person, not a company)** - route to `summarize_contact`

## Related tools
| Tool | Relationship |
|---|---|
| [`list_accounts`](list_accounts.md) | Lists accounts; use to resolve a company name to a GUID before calling this tool |
| [`get_account`](get_account.md) | Opens the full account form for detailed field-level view |
| [`summarize_contact`](summarize_contact.md) | Summarizes a contact (person) rather than an account (company) |
| [`list_contacts`](list_contacts.md) | Lists contacts; useful for finding contacts under the account |

## Data mutation classification
Read-only.

This tool does not change data. It reads account, case, contact, and entitlement records to generate a summary.
