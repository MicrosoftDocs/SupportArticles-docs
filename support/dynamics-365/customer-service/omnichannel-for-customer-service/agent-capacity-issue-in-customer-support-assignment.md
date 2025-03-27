---
title: Agent capacity issue in customer support assignment
description: Solves an issue where customer support representatives (CSRs) in Dynamics 365 Customer Service receive fewer than the configured number of customers before their status automatically changes to Busy.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/27/2025
ms.reviewer: bavasude, srubinstein
ms.custom: sap:Licensing, provisioning, and installation, DFM
---
# Agent capacity issue in customer support assignment

This article addresses the issue where customer support representatives (CSRs) in Dynamics 365 Customer Service receive fewer than the configured number of customers before their status automatically changes to **Busy**.

## Symptoms

Customer support representatives (CSRs) are configured to handle a specific quota of customers (e.g., 5 customers per CSR). However, their status changes to **Busy** after receiving fewer customers (e.g., 3 customers), thereby preventing further customer assignments.

## Cause

This issue can occur due to the configuration of the workstream capacity units. Each customer case is assigned a specific number of capacity units, which determines how many customers an agent can handle simultaneously.

For example, consider the scenario:

- Each customer case is configured to consume 30 capacity units.

- The total capacity assigned to the agent is 90 units.

In this scenario, even though the agent may be configured to handle 5 customer cases, they can only handle 3 simultaneously due to the total capacity limit (3 cases × 30 units each = 90 units total). Once this capacity is reached, the agent's status changes to **Busy**.

## Solution

To resolve this issue, adjust the total capacity units assigned to the affected agents. This ensures that the agent can handle the intended number of customers simultaneously.

1. **Determine the required capacity:**

    - Identify the number of customers an agent is expected to handle (e.g., 5 customers).

    - Determine the capacity units consumed by each customer case (e.g., 30 units per case).

    - Calculate the total capacity needed for the agent:Required capacity = Number of customers × Capacity units per case.Example: For 5 customers, the required capacity = 5 × 30 = 150 units.

2. **Update the agent's capacity profile:**

    - Go to the Dynamics 365 Customer Service admin settings.

    - Navigate to the capacity profiles for agents.

    - Increase the total capacity units for the affected agents to the calculated value (e.g., 150 units for 5 customers).

3. **Save and test changes:**

    - Save the updated capacity profile.

    - Test the configuration to ensure agents can now handle the desired number of customer cases without their status changing to **Busy**.

For detailed instructions on managing capacity profiles, see [Create and manage capacity profiles](/dynamics365/customer-service/administer/capacity-profiles).
