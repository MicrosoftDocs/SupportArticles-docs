---
title: Issues when modifying entities, attributes, users, or groups in MDS 
description: Provides the historical background and a resolution for performance issues that occur when modifying entities, attributes, users, or groups in Master Data Services.
ms.date: 11/11/2024
ms.custom: sap:Master Data Services
ms.reviewer: v-biguan, jiwang6, v-sidong
---
# Performance issues when modifying entities, attributes, users, or groups in MDS

This article helps you understand and solve performance issues in [Master Data Services (MDS)](/sql/master-data-services/master-data-services-overview-mds) when you create or modify entities, attributes, users, or groups.

## Symptoms

When you add, remove, create, or modify entities, attributes, users, or groups, you experience performance issues like high memory usage, long load times, or slow response times. 

## Cause

MDS introduced a significant improvement that enhances the performance of all `GET` operations for data requiring permission checks through the portal and API (that is, all the entities, attributes, and model permissions). However, this change has a side effect: decreased performance when you add, remove, create, or modify entities, attributes, users, or groups.

- Benefits (performance improvements):

  - Improved performance for loading pages that need permission checks, such as the explore page, model page, entity list page, and attribute list page.
  - Resolved time-out exceptions on the model permissions setting page.
  - Improved the load time of the add or edit condition page on the Business Rules page.

- Costs (side effects):

  - Decreased performance when you create or modify entities or attributes.
  - Decreased performance when you add users or groups.

## Resolution

Enable or disable the system setting [PerformanceImprovementEnable](/sql/master-data-services/system-settings-master-data-services#Performance) (the setting is enabled by default) depending on your situation:

- To improve performance when loading permission-related pages, enable the performance setting by running the following commands in SQL Server Management Studio (SSMS):

  ```SQL
  UPDATE mdm.tblSystemSetting SET SettingValue = 1 WHERE SettingName = 'PerformanceImprovementEnable';
  EXEC [mdm].[udpPerformanceToggleSwitch];
  GO
  ```

  After you enable the performance setting, large user security-related data will load faster.

- To improve performance when creating or modifying entities, attributes, users, or groups, disable the performance setting by running the following commands in SSMS:

  ```SQL
  UPDATE mdm.tblSystemSetting SET SettingValue = 0 WHERE SettingName = 'PerformanceImprovementEnable';
  EXEC [mdm].[udpPerformanceToggleSwitch];
  GO
  ```
  After you disable the performance setting, creating and modifying models, entities, or attributes will be faster.

> [!NOTE]
> Alternatively, you can change the setting on the [Database Configuration page](/sql/master-data-services/database-configuration-page-master-data-services-configuration-manager) in MDS Configuration Manager:
> 
> :::image type="content" source="media/performance-improvement-mds/switch-enable-performance-setting.png" alt-text="Screenshot of the performance setting PerformanceImprovementEnable.":::
> 
> After changing this setting, you must run the `EXEC [mdm].[udpPerformanceToggleSwitch];` command to make sure that the view and data are correct.

## More information

[Immediately apply member permissions (Master Data Services)](/sql/master-data-services/immediately-apply-member-permissions-master-data-services)
