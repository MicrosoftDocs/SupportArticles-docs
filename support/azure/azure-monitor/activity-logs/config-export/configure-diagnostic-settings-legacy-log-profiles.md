---
title: Resolve problems when configuring Azure Diagnostic Settings for legacy log profiles
description: Resolve Azure Diagnostic Settings problems for deprecated legacy log profiles and keep Activity Log export working. Follow the migration steps today.
ms.date: 03/31/2026
ms.author: jarrettr
ms.editor: v-gsitser
ms.reviewer: v-ryanberg 
ms.service: azure-monitor
ms.custom: I can't configure export of Activity Logs
---

# Resolve problems when configuring Azure Diagnostic Settings for legacy log profiles

## Summary

When managing Azure subscriptions, you might receive notifications about legacy log profiles being deprecated. This guide provides steps to transition to Azure Diagnostic Settings, ensuring a modern and flexible approach to log management.

Azure is phasing out legacy log profiles in favor of Diagnostic Settings by September 2026. This change affects subscriptions using older monitoring solutions. See the following steps to update your configurations and maintain efficient log management.

### Common issues and solutions

- **Issue**: Legacy log profiles aren't visible.
- **Solution**: Ensure you have the necessary permissions to view and manage log profiles.

- **Issue**: You receive errors when creating Diagnostic Settings.
- **Solution**: Ensure the resource selection and configuration settings are correct.

### Resolve legacy log profile problems

1. **Identify legacy log profiles**
 
    1. In the [Azure portal](https://portal.azure.com), go to **Monitor**.
    1. In **Settings**, select **Activity Log**.
    1. Review the list of log profiles and identify any labeled as legacy.

1. **Delete legacy log profiles**

    1. Select the legacy log profile you want to delete.
    1. Select **Delete**.
   
1. **Create new diagnostic settings**

    1. Go to **Monitor** and select **Diagnostic Settings**.
    1. Select **Add diagnostic setting**.
    1. Choose the resources you want to monitor and configure the necessary settings.
    1. Save the new configuration.

1. **Verify configuration**

    1. Ensure that the new diagnostic settings are active and collecting data as expected.
    1. Monitor the logs to confirm that they're exported correctly.

### References

- [Azure Monitor documentation](/azure/monitor/)
- [Diagnostic Settings guide](/azure/monitor/platform/diagnostic-settings)
