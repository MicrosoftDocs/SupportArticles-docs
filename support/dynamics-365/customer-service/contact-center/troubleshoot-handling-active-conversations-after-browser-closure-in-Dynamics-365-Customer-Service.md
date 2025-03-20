---
author: srreddy
ms.author: srreddy
ms.service: dynamics-365-customer-service
ms.topic: troubleshooting-general
ms.date: 03/20/2025
title: Troubleshoot handling active conversations after browser closure in Dynamics 365 Customer Service
description: Troubleshoot handling active conversations after browser closure in Dynamics 365 Customer Service
---
# Troubleshoot handling active conversations after browser closure in Dynamics 365 Customer Service

This article addresses the issue of active conversations persisting after an agent closes the browser or browser tab in Dynamics 365 Customer Service or Dynamics 365 Contact Center. It provides troubleshooting steps, explains the cause, and outlines solutions to resolve the problem effectively.

## Prerequisites

- Access to Dynamics 365 Customer Service or Dynamics 365 Contact Center.
- Administrative privileges to configure chat settings, if required.

## Potential quick workarounds

### Workaround: Close the conversation before exiting the browser

1. Ensure that agents manually close the conversation from the session panel before closing the browser tab or the browser.
2. Verify that the conversation transitions from the **Wrap-up** state to the **Closed** state.

## Troubleshooting checklist

### Troubleshooting step

1. Confirm that the agent did not close the browser without ending the active conversation.
2. Check if reconnection settings are enabled for customers to reconnect to the previous chat session.

## Cause: System does not detect disconnection properly

The issue occurs because the system fails to detect the agent's disconnection, leaving the conversation in an active state. This prevents the agent from continuing or ending the session and impacts the customer's ability to receive responses.

### Solution: Adjust session handling settings and agent practices

1. Train agents to close conversations manually in the session panel before exiting the browser.
2. Enable reconnection settings to allow customers to reconnect to the previous chat session. Refer to [Configure reconnection to a chat session | Microsoft Learn](/dynamics365/customer-service/administer/configure-reconnect-chat) for detailed instructions.

## Advanced troubleshooting and data collection

If the issue persists despite following the solutions above:

1. Collect logs and session data from impacted users to identify any anomalies in system behavior.
2. Submit a support ticket to Microsoft, including relevant session details and logs, for further investigation.