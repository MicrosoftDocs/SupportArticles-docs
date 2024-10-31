---
title: Troubleshoot issues with automatic assignment
description: Provides troubleshooting steps for automatic assignment issues in Microsoft Dynamics 365 Customer Service.
ms.reviewer: nenellim
ms.author: ssugandha
ms.date: 10/31/2024
ms.custom: sap:Work classification and assignment
---
# Troubleshoot issues with automatic assignment

This article describes some common issues about automatic assignment and helps you troubleshoot these issues.

## Issue 1: Customer service representatives are available but not getting work items

Customer service representatives are available in the queue according to their presence but don't receive new work items.

### Cause

Customer service representatives might not meet the assignment criteria. The auto assignment process considers presence and capacity as availability criteria along with any skills or other attributes added in the assignment configuration.

### Troubleshooting steps

To troubleshoot this issue,

- Check the work distribution settings in the workstream if you use an [out-of-the-box assignment method](/dynamics365/customer-service/administer/assignment-methods#types-of-assignment-methods) such as "highest capacity" or "advanced round robin." Verify that the customer service representatives' presences match the allowed presences in the work distribution settings.
- Check the customer service representatives' available capacity in [Agent details drill–down](/dynamics365/customer-service/use/realtime-agents-analytics#agent-details-drill-down) in the real-time analytics dashboard available to supervisors.
- Verify the available unit capacity if the workstream uses unit-based capacity.
- Verify the available capacity profile units in the profile used by the workstream if you use a [capacity profile](/dynamics365/customer-service/administer/capacity-profiles). Also, see if another capacity profile blocks capacity and assignment from other profiles.

## Issue 2: Customer service representatives' capacity isn't refreshed

A customer service representative closes the conversations, but their capacity isn't refreshed.

### Cause

The customer service representative doesn't close the conversation using the recommended method or the wrap-up time is lengthy.

### Troubleshooting steps

To troubleshoot this issue,

- Verify that the customer service representative uses the [End](/dynamics365/customer-service/use/oc-conversation-state#wrap-up) button on the communication panel to close the conversation.
- Verify if the **Block capacity for wrap up** field is set in the [work distribution settings](/dynamics365/customer-service/administer/create-workstreams#configure-work-distribution) of the workstream.
- Supervisors can look up the active conversations assigned to the customer service representative in the [ongoing conversations dashboard](/dynamics365/customer-service/use/realtime-ongoing) and verify the status.

### More information

- [Assignment methods](/dynamics365/customer-service/administer/assignment-methods)
- [Set allowed presence in workstream](/dynamics365/customer-service/administer/create-workstreams#configure-work-distribution)  
