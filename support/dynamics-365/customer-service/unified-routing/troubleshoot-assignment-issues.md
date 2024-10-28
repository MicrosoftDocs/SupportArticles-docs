---
title: Troubleshoot assignment issues
description: Provides resolutions for various assignment scenarios.
ms.reviewer: nenellim
ms.author: ssugandha
ms.date: 10/28/2024
ms.custom: 
---

# Troubleshoot assignment issues

This article contains resolutions for troubleshooting issues in assignments.

## Agent is available but not getting work items

Agents are available in the queue according to their presence but aren't receiving new work items.

**Cause**

Agents might not be meeting the assignment criteria. Automated assignment considers presence and capacity as availability criteria along with any skills or other attributes added in the assignment configuration.

**Resolution**

Review the following settings:

If you are using out-of-the-box assignment methods like highest capacity or advanced round robin, check the work distribution settings in the workstream. Verify that the service representative’s presence matches the allowed presences in the work distribution settings.

- Confirm the agent’s available capacity in [Agent details drill–down](/dynamics365/customer-service/use/realtime-agents-analytics#agent-details-drill-down) in the real-time analytics dashboard available to supervisors.

- If the workstream is using unit-based capacity, verify the available unit capacity.

- If you are using capacity profile, verify the available capacity profile units in the profile used by the workstream. Also, confirm whether there's another capacity profile that's a blocking capacity and therefore is blocking assignment from other profiles.

## Agent capacity isn't refreshed 

Agent has closed the conversations, but their capacity isn't refreshed.

**Cause**

Agent hasn't closed the conversation using the recommended method or wrap-up time is lengthy.

**Resolution**

- Confirm that the agent used the “Close Conversation” button to close the conversation.
- Verify if a wrap-up time is set in the workstream. Agents can end the wrap-up by <>.
- Supervisors can look-up the active conversations assigned to the agent in the ongoing conversations dashboard and verify the status.

### Related information
 
