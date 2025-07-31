---
title: Export Directory-Level Activity Logs to Event Hubs
description: Provides guidance for exporting directory-level activity logs to Event Hubs by using Azure management group-level diagnostic settings.
ms.date: 07/28/2025
ms.reviewer: v-liuamson; v-gsitser; v-sisidhu
ms.service: azure-monitor
ms.custom: I can’t configure export of Activity Logs
---

# Export directory-level Activity Logs to Event Hubs

This article provides guidance to export directory-level activity logs to Event Hubs by using Microsoft Azure management group-level diagnostic settings. This process is essential for users who have to monitor and analyze activity logs efficiently.

You can export directory-level activity logs to an event hub through an API call that creates management group-level diagnostic settings. This solution is useful for organizations that want to centralize their log data for better analysis and monitoring.

## Common issues and solutions

- **Issue:** Logs don't appear in Event Hubs.
  - **Solution:** Double-check the event hub configuration to make sure that the correct namespace and key ID are used.

- **Issue:** Permission errors occur when making diagnostic settings.
  - **Solution:** Make sure that you have the necessary permissions to create or update diagnostic settings in Azure.

### Instructions to export logs

1. Navigate to the Azure portal, and sign in by using your credentials.

2. Go to the **Azure Monitor** section, and select **Diagnostic settings** on the menu.

3. Select **Add diagnostic setting**, and select the resource that you want to export logs for.

4. Under **Destination details**, select **Event Hub**, and then provide the required **Event Hub namespace** and **Event Hub name** values. Make sure that the **Event Hub key ID** value is entered correctly.

5. Select **Save** to apply the settings. Check the event hub for incoming data to verify that the logs are exported.

## References

- [Azure Monitor documentation](/azure/monitoring/)
- [Event Hubs documentation](/azure/event-hubs/)
- [Diagnostic settings in Azure Monitor](/azure/azure-monitor/platform/diagnostic-settings#time-before-telemetry-gets-to-destination)

[!INCLUDE [azure-help-support](../../../../includes/azure-help-support.md)]
