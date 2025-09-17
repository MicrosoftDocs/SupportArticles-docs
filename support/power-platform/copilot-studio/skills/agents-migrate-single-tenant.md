---
title: "Troubleshoot agents that use Bot Framework skills"
description: "Reference to troubleshoot issues with agents using Bot Framework skills no longer working."
ms.reviewer: cyanderson
ms.date: 04/15/2025
ms.topic: how-to
author: digantakumar
ms.author: digantak
manager: kjette
ms.service: copilot-studio
---

# Troubleshoot agents using Bot Framework skills

Copilot Studio creates an Azure app registration for each custom agent to enable secure communication with its channels and skills. The app registration doesn't access or expose any customer data, resources, or agent information. Copilot Studio securely and compliantly manages the app registration. However, in order to meet Secure Future Initiative requirements, many customers don't allow multitenant apps in their tenant. As a result, their makers won't be able to create Copilot Studio agents.

Currently, Copilot Studio creates a single-tenant Azure app registration for new agents. Existing agents continue to use multitenant Azure app registration. We're migrating existing agents to single-tenant Azure app registrations. Migration will start after May 30, 2025.

## How does this change affect me?  

No action is required if your agents aren't using Azure Bot Framework skills. Any agents using skills after May 30, 2025, when migration to single-tenant is enabled, will be affected.  

## What do I need to do to prepare?  

Perform the following steps to migrate the Azure app registrations of your existing custom agents with skills to single-tenant.

### Identify affected agents and inform agent owners and skill developers

First, you need to identify affected agents and communicated changes to their owner and their skill developer.

1. Go to your Azure app registration.

1. Search the affected agent’s application (client).

1. Select the app **Display name** and select **Manifest** under **Manage** in the left pane.

1. Find `Power Platform Environment` ID and `Bot Id` under the `description` field in the manifest.

1. Go to `https://make.powerapps.com/environments/<Power Platform Environment ID>`.

1. Select **Tables** in the left pane and then select **All** to view all tables.

1. Search for the agent table. Type "Copilot" in the search box. 

1. Search for the agent. Locate the **Owner** column for the agent owner and add "Bot" for bot ID.

1. Contact the agent owner and skill developer.

### Update skill to single tenant

The skill developer needs to update the skill to support single tenant and deploy that skill (or at least its app registration) in the same tenant that has the Copilot Studio agent's app registration. Perform the following steps to do the update:

1. [Update your multitenant skill](/azure/bot-service/skill-pva-update-skill-single-tenant) to support both single-tenant and multitenant agents. This ensures your skill continues to work during the migration.

1. If you're using Bot SDK to call Copilot Studio as a Skill, [update to single-tenant app registrations](advanced-use-pva-as-a-skill.md#update-a-multitenant-bot-service-bot-to-a-single-tenant-bot).

You don’t need to wait for Microsoft to complete the migration. You can export and import your custom agents using skills to a new environment. When you import an agent, the process creates a new Azure app registration with single-tenant. For more information about exporting and importing agents, see [export and import agents](authoring-solutions-import-export.md).

## Frequently asked questions

Here are some frequently asked questions about the migration of Copilot Studio agents to single-tenant Azure app registration.

### When is the migration of my Copilot Studio custom agents happening?

We're migrating the Azure app registrations of affected custom agents from multitenant to single tenant starting May 30, 2025.

### Where do I see the changes?

You can see the changes in your Azure App registration under **Authentication**.  

### Can I not just change my app registration to single tenant now?

No, you shouldn't change your custom agents Azure app registration to single tenant because it breaks the agent.  

### Can I get an extension?

Yes, we can give you another 30-day extension. [Open a support request](/power-platform/admin/get-help-support).
