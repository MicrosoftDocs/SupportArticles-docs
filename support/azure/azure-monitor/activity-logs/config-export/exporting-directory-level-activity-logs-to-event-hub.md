---
title: Exporting Directory Level Activity Logs to Event Hub
description: Provides guidance on exporting directory-level activity logs to an Event Hub using Azure's management group level diagnostic settings.
ms.date: 07/16/2025
ms.reviewer: v-liuamson; v-gsitser; v-sisidhu
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Exporting Directory Level Activity Logs to Event Hub

This article provides guidance on exporting directory-level activity logs to an Event Hub using Azure's management group level diagnostic settings. This process is essential for users who need to monitor and analyze activity logs efficiently.

## Introduction

Exporting directory-level activity logs to an Event Hub can be achieved through an API call that creates management group level diagnostic settings. This solution is particularly useful for organizations looking to centralize their log data for better analysis and monitoring.

### Step-by-step instructions to export logs

1. **Access Azure Portal**
   - Navigate to the Azure portal and sign in with your credentials.

2. **Locate Diagnostic Settings**
   - Go to the **Azure Monitor** section.
   - Select **Diagnostic settings** from the menu.

3. **Create or Update Diagnostic Settings**
   - Click on **Add diagnostic setting**.
   - Choose the resource for which you want to export logs.

4. **Configure Export to Event Hub**
   - Under **Destination details**, select **Event Hub**.
   - Provide the necessary **Event Hub namespace** and **Event Hub name**.
   - Ensure the **Event Hub key ID** is correctly entered.

5. **Save and Verify**
   - Click **Save** to apply the settings.
   - Verify that logs are being exported by checking the Event Hub for incoming data.

### Common Issues and Solutions

- **Issue:** Logs are not appearing in Event Hub.
  - **Solution:** Double-check the Event Hub configuration and ensure the correct namespace and key ID are used.

- **Issue:** Permission errors when setting up diagnostic settings.
  - **Solution:** Ensure you have the necessary permissions to create or update diagnostic settings in Azure.

## Reference

- [Azure Monitor Documentation](https://learn.microsoft.com/azure/monitoring/)
- [Event Hubs Documentation](https://learn.microsoft.com/azure/event-hubs/)
- [Diagnostic settings in Azure Monitor](https://learn.microsoft.com/azure/azure-monitor/platform/diagnostic-settings#time-before-telemetry-gets-to-destination)

If the issue persists after following the solution steps, please open a support case for further assistance.
