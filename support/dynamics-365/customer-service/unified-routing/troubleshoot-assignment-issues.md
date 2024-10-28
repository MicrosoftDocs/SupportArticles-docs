---
title: Troubleshoot issues with automatic assignment
description: Provides resolutions for various scenarios where automatic assignment has issues.
ms.reviewer: nenellim
ms.author: ssugandha
ms.date: 10/28/2024
ms.custom: 
---

# Troubleshoot issues with automatic assignment

This article contains resolutions for troubleshooting issues with automatic assignments.

## Customer service representative is available but not getting work items

Customer service representatives are available in the queue according to their presence but aren't receiving new work items.

**Cause**

Customer service representatives might not be meeting the assignment criteria. Automated assignment considers presence and capacity as availability criteria along with any skills or other attributes added in the assignment configuration.

**Resolution**

Review the following settings:

If you are using out-of-the-box assignment methods like highest capacity or advanced round robin, check the work distribution settings in the workstream. Verify that the customer service representative’s presence matches the allowed presences in the work distribution settings.

- Confirm the Customer service representatives’s available capacity in [Agent details drill–down](/dynamics365/customer-service/use/realtime-agents-analytics#agent-details-drill-down) in the real-time analytics dashboard available to supervisors.

- If the workstream is using unit-based capacity, verify the available unit capacity.

- If you are using a [capacity profile](/dynamics365/customer-service/administer/capacity-profiles), verify the available capacity profile units in the profile used by the workstream. Also, confirm whether there's another capacity profile that's blocking capacity and therefore is blocking assignment from other profiles.

## Customer service representatives' capacity isn't refreshed

Customer service representative has closed the conversations, but their capacity isn't refreshed.

**Cause**

Customer service representative hasn't closed the conversation using the recommended method or wrap-up time is lengthy.

**Resolution**

- Confirm that the Customer service representative used the [**End**](/dynamics365/customer-service/use/oc-conversation-state#wrap-up) button on the communication panel to close the conversation.
- Verify if **Block capacity for wrap up** is set in the [work distribution settings](/dynamics365/customer-service/administer/create-workstreams#configure-work-distribution) of the workstream.
- Supervisors can look-up the active conversations assigned to the Customer service representatives in the [ongoing conversations dashboard](/dynamics365/customer-service/use/realtime-ongoing) and verify the status.

### Related information

[Assignment methods](/dynamics365/customer-service/administer/assignment-methods)   
[Set allowed presence in workstream](/dynamics365/customer-service/administer/create-workstreams#configure-work-distribution)  
