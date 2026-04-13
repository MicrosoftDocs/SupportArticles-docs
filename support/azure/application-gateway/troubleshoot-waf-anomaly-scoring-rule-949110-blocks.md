---
title: Troubleshoot anomaly scoring and Rule 949110 blocks in Azure Application Gateway WAF
description: Learn why rule ID 949110 blocks traffic in WAF and identify contributing rules to resolve blocks effectively.
ms.date: 04/01/2026
ms.author: lalbadarneh
ms.editor: v-jsitser
ms.reviewer: giverm
ms.service: azure-web-application-firewall
ms.custom: sap:Application Gateway

#customer intent: As an Azure Application Gateway administrator, I want to understand why traffic is blocked by rule ID 949110 so that I can identify and tune the underlying WAF rules correctly.
---

# Troubleshoot anomaly scoring behavior and rule ID 949110 in Azure Application Gateway WAF

## Summary

By default, Azure Application Gateway Web Application Firewall (WAF) uses anomaly scoring if you enable the OWASP Core Rule Set (CRS). If you use anomaly scoring, the WAF doesn't block requests immediately when a single rule matches, even if you configure the WAF policy in Prevention mode.

This article explains anomaly scoring behavior, and clarifies scenarios in which rule ID 949110 blocks traffic.

For general WAF troubleshooting guidance, see [Troubleshoot WAF for Azure Application Gateway](/azure/web-application-firewall/ag/web-application-firewall-troubleshoot).

## Prerequisites

- An Azure Application Gateway that has WAF enabled
- OWASP CRS configured
- WAF diagnostic logs that are enabled and sent to Log Analytics

## How anomaly scoring works

Each OWASP rule ID has an associated *severity* that contributes to an overall *anomaly score*.

When the cumulative anomaly score reaches 5 or greater, one of the following actions occurs:

- **Prevention mode**: The request is blocked
- **Detection mode**: The request is logged but not blocked

For example:

- A single **Critical** rule ID match increases the anomaly score to **5**. This score is sufficient to block the request in Prevention mode.
- A **Warning** rule ID match increases the anomaly score by **3**. This score isn't enough on its own to block the request.

If a rule that contributes to anomaly scoring is triggered, the rule is identified in the logs as **Action = Matched**.  

If the total anomaly score reaches the blocking threshold, an additional rule is triggered and marked as **Action = Blocked** or **Detected**, depending on the WAF mode.

## Mandatory rule triggered (rule ID: 949110)

When you review WAF logs, you might see that traffic appears as blocked by `mandatory rule ID 949110`. You can't disable a manadatory rule.

Rule ID 949110 doesn't represent a specific attack signature. Instead, it enforces the final block when the cumulative anomaly score reaches the configured threshold.

This behavior often causes users to try to disable rule ID 949110 as a workaround. However, because rule ID 949110 is a mandatory evaluation rule, it doesn't appear as a configurable rule in the WAF policy.

## Identify the rule that caused the block

To determine which rules contributed to the issue that triggered rule ID 949110, follow these steps:

1. Filter the WAF logs by **hostname** and **Action = Blocked**.
1. From the blocked entry, note the **transaction ID** value.
1. Remove the **Blocked** filter, and search for logs that contain the same **transaction ID** value.
1. Identify the rule IDs that are listed in the **Matched** action.

These matched rules are the rules that contributed to the anomaly score that caused the block.

## Resolution

After you identify the contributing rules, take one of the following actions:

- Disable the specific rule (if supported).
- Create a custom WAF rule.
- Configure a WAF exclusion to allow expected traffic.

Don't try to disable rule ID 949110 directly because it's a mandatory enforcement rule and it can't be modified.

## Related content

- [Troubleshoot WAF for Azure Application Gateway](/azure/web-application-firewall/ag/web-application-firewall-troubleshoot)
- [CRS and DRS rule groups and rules](/azure/web-application-firewall/ag/application-gateway-crs-rulegroups-rules)
- [Anomaly scoring mode](/azure/web-application-firewall/ag/ag-overview#anomaly-scoring-mode)
