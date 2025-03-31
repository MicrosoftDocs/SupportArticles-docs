---
title: Agent Capacity Issue in Customer Support Assignment
description: Solves an issue where customer support representatives (CSRs) in Microsoft Dynamics 365 Customer Service receive fewer than the configured number of customers before their status automatically changes to Busy.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/31/2025
ms.reviewer: bavasude, srubinstein
ms.custom: sap:Licensing, provisioning, and installation, DFM
---
# Agent capacity issue in customer support assignment

This article addresses the issue where customer support representatives (CSRs) in Dynamics 365 Customer Service receive fewer than the configured number of customers before their status automatically changes to **Busy**.

## Symptoms

Customer support representatives (CSRs) are configured to handle a specific quota of customers (for example, five customers per CSR). However, their status changes to **Busy** after receiving fewer customers (for example, three customers), thereby preventing further customer assignments.

## Cause

This issue can occur due to the configuration of the workstream capacity units. Each customer case is assigned a specific number of capacity units, which determines how many customers an agent can handle simultaneously.

For example, consider the scenario:

- Each customer case is configured to consume 30 capacity units.
- The total capacity assigned to the agent is 90 units.

In this scenario, even though the agent may be configured to handle five customer cases, they can only handle three simultaneously due to the total capacity limit (3 cases × 30 units each = 90 units total.) Once this capacity is reached, the agent's status changes to **Busy**.

## Resolution

To resolve this issue, adjust the total capacity units assigned to the affected agents. This ensures that the agent can handle the intended number of customers simultaneously.

1. Determine the required capacity:

    - Identify the number of customers an agent is expected to handle (for example, five customers.)
    - Determine the capacity units consumed by each customer case (for example, 30 units per case.)
    - Calculate the total capacity needed for the agent: Required capacity = Number of customers × Capacity units per case. For example: For five customers, the required capacity = 5 × 30 = 150 units.

2. Update the agent's capacity profile:

    - Go to the Dynamics 365 Customer Service admin settings.
    - Navigate to the capacity profiles for agents.
    - Increase the total capacity units for the affected agents to the calculated value (for example, 150 units for five customers.)

3. Save and test changes:

    - Save the updated capacity profile.
    - Test the configuration to ensure agents can now handle the desired number of customer cases without their status changing to **Busy**.

For detailed instructions on managing capacity profiles, see [Create and manage capacity profiles](/dynamics365/customer-service/administer/capacity-profiles).
