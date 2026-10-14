---
title: Troubleshoot Issues with Automatic Assignment in Unified Routing
description: Fix issues in the automatic assignment feature of Customer Service unified routing when work items aren't assigned, capacity isn't released, or cases aren't routed.
ms.reviewer: nenellim, mgandham
ai-usage: ai-assisted
ms.date: 09/08/2026
ms.custom: sap:Work classification and assignment
---
# Troubleshoot issues with automatic assignment

## Summary

This article helps you troubleshoot common automatic assignment issues in unified routing for Dynamics 365 Customer Service. It covers customer service representatives who are available but don't receive work items, capacity that isn't released after a conversation closes, and manually assigned cases that don't reach the expected queue.

## Issue 1: Customer service representatives are available but don't receive work items

Customer service representatives are available in the queue according to their presence but don't receive new work items.

### Cause

Customer service representatives might not meet the assignment criteria. The automatic assignment process considers presence and capacity as availability criteria, along with any skills or other attributes added in the assignment configuration.

### Solution

To troubleshoot this issue:

- Check the work distribution settings in the workstream if you use an [out-of-the-box assignment method](/dynamics365/customer-service/administer/assignment-methods#types-of-assignment-methods) such as "highest capacity" or "advanced round robin." Verify that the customer service representatives' presences match the allowed presences in the work distribution settings.
- Check the customer service representatives' available capacity in the [Agent details drill-down](/dynamics365/customer-service/use/realtime-agents-analytics#agent-details-drill-down) in the real-time analytics dashboard available to supervisors.
- Verify the available unit capacity if the workstream uses unit-based capacity.
- Verify the available capacity profile units in the profile used by the workstream if you use a [capacity profile](/dynamics365/customer-service/administer/capacity-profiles). Also, see if another capacity profile blocks capacity and assignment from other profiles.

## Issue 2: Customer service representatives' capacity isn't refreshed

A customer service representative closes a conversation, but their capacity isn't refreshed.

### Cause

The customer service representative doesn't close the conversation by using the recommended method, or the wrap-up time is lengthy.

### Solution

To troubleshoot this issue:

- Verify that the customer service representative closed the conversation. For voice and chat conversations, if the representative ends the conversation without closing it by using the **X** button, the conversation goes into the wrap-up state and the representative's capacity remains occupied until the configured [wrap-up time](/dynamics365/customer-service/administer/create-workstreams#configure-work-distribution) is completed. For social, Teams, SMS, and persistent chat channels, if the representative closes an active conversation without ending it while the capacity is released, the conversation goes into the waiting state. The conversation becomes active and consumes capacity if the customer comes back.
- Supervisors can look up the active conversations assigned to the customer service representative in the [ongoing conversations dashboard](/dynamics365/customer-service/use/realtime-ongoing) and track agent presence and capacity in the real-time dashboard.
- Verify if the default time set for the [conversations to be closed automatically](/dynamics365/customer-service/administer/auto-close-conversation-powerapps) by the system meets your business needs.

## Issue 3: Manually assigned cases don't reach the expected queue

You assign a case by using the **Assign** command or from a case grid, but the case doesn't reach the expected queue through unified routing.

### Cause

The **Assign** command changes the owner of a case but doesn't route the case through unified routing. Cases that you create manually have the **Route Case** attribute set to `false`, so they aren't routed automatically.

### Solution

To troubleshoot this issue:

- Confirm that the case was routed by using **Save & Route** rather than only assigned.
- To route a case by using your routing rules, select **Save & Route** on the case. To route multiple cases, select them in the grid, and then select **Save & Route**.
- If the case still doesn't reach the expected queue, use [routing diagnostics](/dynamics365/contact-center/use/diagnose-dashboard) to trace the routed record.

## Related content

[Assignment methods in unified routing](/dynamics365/customer-service/administer/assignment-methods)  
[Set allowed presences in workstreams](/dynamics365/customer-service/administer/create-workstreams#configure-work-distribution)
