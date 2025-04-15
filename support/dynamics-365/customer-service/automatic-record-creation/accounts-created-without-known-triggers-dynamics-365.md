---
title: Accounts Are Created Without Known Triggers or Actions
description: Resolves an issue where accounts are automatically created without known user actions or triggers in Microsoft Dynamics 365 apps.
ms.reviewer: ghoshsoham
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/14/2025
ms.custom: sap:Automatic Record Creation (ARC), DFM
---
# Accounts are created without known triggers in Dynamics 365

This article addresses the issue where accounts are automatically created in Dynamics 365 without any known user actions or triggers. This can apply to Dynamics 365 Customer Service, Dynamics 365 Sales, or other model-driven apps where accounts are used.

## Symptoms

Accounts are automatically created in Dynamics 365 apps without any manual input or recognized triggers.

## Cause

The issue could be due to one or more of the following:

- Unintended automations or scripts: Background processes running without proper controls can cause unintended account creation.
  - **Misconfigured ARC rules**: Automatic Record Creation (ARC) rules may be mistakenly set to create accounts based on specific triggers, such as incoming emails or external data.
  - **Unmonitored Power Automate flows**: Flows with triggers related to account creation may be running without proper oversight.
  - **Plugins and custom scripts**: Background plugins configured to create accounts under specific conditions.
  - **Dataverse APIs or third-party services**: External applications connected via the Dataverse API could be creating accounts in the system.
- **Unauthorized access or security breach**: A potential security issue could allow unauthorized processes or users to create accounts.

To identify the cause:

- Sequentially disable suspected areas, such as ARC rules, Power Automate flows, plugins, and external integrations.
- Re-enable each component one at a time while monitoring the environment to pinpoint the source of automatic account creation.

## Resolution

Follow these steps to help you identify and address the root cause of the issue resulting in unintended account creation.

### Step 1: Review ARC rules

1. Navigate to **Customer Service admin center** > **Case settings** > **Automatic record creation and update rules**.

2. Inspect all rules related to accounts:

   - Verify if rules are configured to trigger account creation under specific conditions (for example, incoming emails, forms, or external data.)
   - Check if any rules are inadvertently targeting the accounts entity instead of other entities like leads or contacts.

3. Temporarily deactivate ARC rules one by one to identify if they're responsible for the issue.

### Step 2: Inspect Power Automate flows

1. Go to **Power Automate** > **Solutions** (if applicable) or **My Flows/Team Flows**.

2. Look for any flows with triggers related to account creation, such as:

   - The "When a record is created" flow.

3. Review the configurations and connections of each flow to ensure security and proper setup.
4. Temporarily turn off flows to see if the automatic account creation ceases.

### Step 3: Check plugins and custom scripts

1. Navigate to **Advanced settings** > **Customization** > **Customize the System**.
2. Under **Plugins**, review all plugins targeting the account entity:

   - Check if any plugins are set to create accounts automatically based on specific conditions.

   - Identify and assess outdated or suspicious plugins.

3. Disable plugins temporarily to test if the issue persists.

### Step 4: Review security and access logs

1. Review the [audit logs](/dynamics365/customer-service/administer/enable-audit-tables#activities-available-for-audit) to identify:

   - The user or process responsible for creating the accounts.
   - Any unusual or unauthorized access attempts.

1. If API calls are enabled, verify whether external applications are making unexpected account creation requests.

### Step 5: Review third-party integrations

1. Check for external apps connected to your environment via Dataverse APIs or custom connectors.
2. Temporarily disable these integrations to determine if they're causing the problem.
3. Check the logs for unauthorized or unintended API requests related to account creation.
