---
title: Centralized Configuration of Activity Logs to Event Hub
description: Step-by-step guidance on how to set up Azure Activity Logs to be centrally exported to a single Event Hub.
ms.date: 07/17/2025
ms.reviewer: v-liuamson; v-gsitser
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Centralized Configuration of Activity Logs to Event Hub

## Introduction

This article provides guidance on setting up Azure Activity Logs to be centrally exported to a single Event Hub. This setup is useful for organizations looking to streamline log management across multiple Azure subscriptions and forward logs to third-party SIEM solutions.

Organizations often require a centralized approach to manage Activity Logs across numerous subscriptions. This guide outlines the steps to configure Azure Policies to automate the streaming of these logs to a specified Event Hub, addressing common challenges and considerations.

## Step-by-Step Instructions to Configure Activity Logs

1. **Create an Azure Policy for Activity Logs:**
   - Navigate to the Azure portal and access the **Azure Policy** service.
   - Create a new policy definition using the JSON provided in the community example. This policy should automate the enablement of activity log diagnostics settings across all subscriptions under a management group.

2. **Assign the Policy to Management Group:**
   - Assign the newly created policy to the desired management group containing the required subscriptions.
   - Ensure that the policy is set to send data to the specified Event Hub.

3. **Configure Log Analytics Workspace:**
   - Access the **Log Analytics Workspace** in the Azure portal.
   - Set up data export rules to forward logs from the Log Analytics Workspace to the Event Hub. Specify the source table as `AzureActivity` and the destination as the central Event Hub.

4. **Verify Event Hub Configuration:**
   - Ensure the Event Hub is configured to handle the expected log volume from all subscriptions.
   - Review performance benchmarks and adjust the Event Hub tier if necessary to manage logs efficiently.

5. **Monitor and Adjust:**
   - Regularly monitor the Event Hub's performance and log flow.
   - Adjust configurations as needed to optimize performance and cost.

## Common Issues and Solutions

- **Performance Concerns:** If the Event Hub struggles with the log volume, consider upgrading the tier or distributing logs across multiple hubs.
- **Policy Limitations:** Azure Policy may require manual steps for each subscription. Ensure all configurations are correctly applied.

## Reference

- [Azure Policy Assignment to Enable Activity Log on Subscription](https://learn.microsoft.com/azure/policy-assignment-to-enable-activity-log-on-subscription)
- [Azure Event Hubs Overview](https://learn.microsoft.com/azure/event-hubs/event-hubs-about)

If the issue persists after following the solution steps, please open a support case for further assistance.
