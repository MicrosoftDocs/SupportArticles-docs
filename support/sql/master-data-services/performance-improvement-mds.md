---
title: Issues when modifying entities, attributes, users, or groups in MDS 
description: Provides the historical background and a resolution for the issues that occur after a performance improvement in Master Data Services.
ms.date: 11/06/2024
ms.custom: sap:Master Data Services
ms.reviewer: v-biguan, jiwang6
---
# Performance issues when modifying entities, attributes, users, or groups in MDS

This article helps you understand and solve performance issues in [Master Data Services (MDS)](/sql/master-data-services/master-data-services-overview-mds) when you create or modify entities, attributes, users, or groups.

## Symptoms

When you add, remove, create, or modify entities, attributes, users, or groups, you experience performance issues like high memory usage, long load times, or slow response times. 

## Cause

MDS introduced a significant improvement that enhanced the performance of all `GET` operations for data requiring permission checks through Portal and API (that is, all the entities, attributes, and model permissions). However, the side effect of this change is decreased performance when you add, remove, create, or modify entities, attributes, users, or groups.

- Benefits (Performance improvement):

  - Improved performance for loading pages that need permission checks, such as the explore page, model page, entities list page, and attributes list page.
  - Resolved timeout exceptions on model permissions setting page
  - Improved load time of add or edit condition page on the Business Rules page.

- Costs (Side effect):

  - Decreased performance when you create or modify entities or attributes.
  - Decreased performance when you add users or groups.

## Resolution

Enable or disable the system setting [PerformanceImprovementEnable](/sql/master-data-services/system-settings-master-data-services#Performance) (the setting is enabled by default) depending on your situation:

- To improve the performance of load permissions related pages, enable the performance setting.

  Run the following commands in SQL Server Management Studio (SSMS):

  ```SQL
  UPDATE mdm.tblSystemSetting SET SettingValue = 1 WHERE SettingName = 'PerformanceImprovementEnable';
  EXEC [mdm].[udpPerformanceToggleSwitch];
  GO
  ```

  After you enable the performance setting, loading large user security related data will be faster.

- To improve performance when creating or modifying entities, attributes, users, or groups, disable the performance setting.

  Run the following commands in SSMS:

  ```SQL
  UPDATE mdm.tblSystemSetting SET SettingValue = 0 WHERE SettingName = 'PerformanceImprovementEnable';
  EXEC [mdm].[udpPerformanceToggleSwitch];
  GO
  ```
  After you disable the performance setting, creating and modifying models, entities, or attributes will be faster.

> [!NOTE]
> Alternatively, you can change the setting on the **Database Configuration** page in MDS Configuration Manager:
> :::image type="content" source="media/performance-improvement-mds/switch-enable-performance-setting.png" alt-text="Screenshot of the performance setting  PerformanceImprovementEnable.":::
> After changing this setting, you must run the command `EXEC [mdm].[udpPerformanceToggleSwitch];` to make sure that the view and data is correct.

## More information

[Immediately apply member permissions (Master Data Services)](/sql/master-data-services/immediately-apply-member-permissions-master-data-services)
