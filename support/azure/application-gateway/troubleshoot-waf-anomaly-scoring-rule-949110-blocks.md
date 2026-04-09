---
title: Troubleshoot anomaly scoring and rule 949110 blocks in Azure Application Gateway WAF
description: Learn why rule 949110 blocks traffic in WAF and identify contributing rules to resolve blocks effectively.
ms.date: 04/01/2026
ms.author: lalbadarneh
ms.editor: v-jsitser
ms.reviewer: giverm
ms.service: azure-web-application-firewall
ms.custom: sap:Application Gateway

#customer intent: As an Azure Application Gateway administrator, I want to understand why traffic is blocked by rule 949110 so that I can identify and tune the underlying WAF rules correctly.
---

# Troubleshoot anomaly scoring behavior and rule 949110 in Azure Application Gateway WAF

## Summary

Azure Application Gateway Web Application Firewall (WAF) uses anomaly scoring by default when you enable the OWASP Core Rule Set (CRS). When you use anomaly scoring, the WAF doesn't block requests immediately when a single rule matches, even when you configure the WAF policy in Prevention mode.

This article explains anomaly scoring behavior and clarifies scenarios where rule ID 949110 blocks traffic.

For general WAF troubleshooting guidance, see [Troubleshoot WAF for Azure Application Gateway](/azure/web-application-firewall/ag/web-application-firewall-troubleshoot).

## Prerequisites

- An Azure Application Gateway with WAF enabled.
- OWASP CRS configured.
- WAF diagnostic logs enabled and sent to Log Analytics.

## How anomaly scoring works

Each OWASP rule has an associated *severity* that contributes to an overall *anomaly score*.

When the cumulative anomaly score reaches 5 or higher, one of the following actions occurs:

- **Prevention mode**: The request is blocked.
- **Detection mode**: The request is logged but not blocked.

For example:

- A single **Critical** rule match increases the anomaly score to **5**, which is sufficient to block the request in Prevention mode.
- A **Warning** rule match increases the anomaly score by **3**, which isn't enough on its own to block the request.

When a rule contributing to anomaly scoring is triggered, it appears in the logs with **Action = Matched**.  
If the total anomaly score reaches the blocking threshold, an additional rule is triggered with **Action = Blocked** or **Detected**, depending on the WAF mode.

## Mandatory rule triggered (rule ID: 949110)

While reviewing WAF logs, traffic might appear as blocked by `mandatory rule ID 949110`, which you can't disable.

Rule 949110 doesn't represent a specific attack signature. Instead, it enforces the final block when the cumulative anomaly score reaches the configured threshold.

This behavior often leads users to attempt disabling rule 949110 as a workaround. However, because it's a mandatory evaluation rule, it doesn't appear as a configurable rule in the WAF policy.

## Identify the rule that caused the block

To determine which rules contributed to triggering rule 949110, follow these steps:

1. Filter WAF logs by **hostname** and **Action = Blocked**.
1. From the blocked entry, note the **transaction ID**.
1. Remove the **Blocked** filter and search for logs with:
   - The same **transaction ID**.
1. Identify the rule IDs listed in the **Matched** action.

These matched rules are the ones contributing to the anomaly score that resulted in the block.

## Resolution

After identifying the contributing rules, take one of the following actions:

- Disable the specific rule (if supported).
- Create a custom WAF rule.
- Configure a WAF exclusion to allow expected traffic.

Don't attempt to disable rule 949110 directly as it's a mandatory enforcement rule and can't be modified.

## Related content

- [Troubleshoot WAF for Azure Application Gateway](/azure/web-application-firewall/ag/web-application-firewall-troubleshoot)
- [CRS and DRS rule groups and rules](/azure/web-application-firewall/ag/application-gateway-crs-rulegroups-rules)
- [Anomaly scoring mode](/azure/web-application-firewall/ag/ag-overview#anomaly-scoring-mode)
