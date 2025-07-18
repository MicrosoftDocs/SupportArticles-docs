---
title: Centralized Configuration of Activity Logs to Event Hub
description: Provides guidance to set up Azure Activity Logs to be centrally exported to a single Event Hub.
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Centralized Configuration of Aactivity Logs to Event Hub

## Introduction

This article provides guidance for setting up Azure Activity Logs to be centrally exported to a single hub in Azure Event Hubs. This setup is useful for organizations that want to streamline log management across multiple Azure subscriptions and forward logs to third-party SIEM solutions.

Organizations often require a centralized approach to manage Activity Logs across numerous subscriptions. This guide discusses common challenges and considerations for configuring Azure Policies to automate streaming these logs to a specified event hub.

## Instructions to configure Activity Logs

1. **Create an Azure Policy for Activity Logs:**
   - Navigate to the Azure portal, and access the **Azure Policy** service.
   - Create a policy definition by using the JSON file that's provided in the community example. This policy should automate the enablement of activity log diagnostic settings across all subscriptions under a management group.

2. **Assign the Policy to Management Group:**
   - Assign the newly created policy to the desired management group that contains the required subscriptions.
   - Make sure that the policy is set to send data to the specified Event Hub.

3. **Configure Log Analytics Workspace:**
   - Access **Log Analytics Workspace** in the Azure portal.
   - Set up data export rules to forward logs from the Log Analytics Workspace to the event hub. Specify the source table as `AzureActivity` and the destination as the central event hub.

4. **Verify event hub configuration:**
   - Make sure that the event hub is configured to handle the expected log volume from all subscriptions.
   - Review performance benchmarks and adjust the event hub tier if it's necessary to manage logs efficiently.

5. **Monitor and adjust:**
   - Regularly monitor the event hub performance and log flow.
   - Adjust configurations as neecessary to optimize performance and cost.

## Common issues and solutions

- **Performance concerns:** If the event hub experiences difficulty in handling the log volume, consider upgrading the tier or distributing logs across multiple hubs.
- **Policy Limitations:** Azure Policy might require manual steps for each subscription. Make sure that all configurations are correctly applied.

## Reference

- [Azure Policy Assignment to Enable Activity Log on Subscription](https://learn.microsoft.com/azure/policy-assignment-to-enable-activity-log-on-subscription)
- [Azure Event Hubs Overview](https://learn.microsoft.com/azure/event-hubs/event-hubs-about)

If the issue persists after you follow these steps, open a support case for further assistance.
