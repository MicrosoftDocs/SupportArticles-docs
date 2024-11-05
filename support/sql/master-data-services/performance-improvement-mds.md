---
title: Issues after performance improvement in MDS 
description: This article introduces the historical background and settings of performance improvement in MDS.
ms.date: 10/23/2024
ms.custom: sap:Master Data Services
ms.reviewer: v-biguan, jiwang6
---
# Issues after performance improvement in MDS 

This article helps you understand and solve the issues that occur after performance improvement in Master Data Services (MDS).

## Symptoms

We made a significant performance improvement several years ago. This change can benefit all the `GET` operation for the data requiring permission check through Portal and API (that is, all the entities, attributes, and model permissions). But the cost for this change is low performance when you add, remove, or modify entity or attribute.

## Benefits and costs for the performance improvement

- Benefits (Performance improvement):

  - This change improves the performance of loading pages that need permission checks, such as the explore page, model page, entities list page, and attributes list page.
  - On model permissions setting page, some customers reported that they sometimes faced the timeout exception. After this change, the issue is solved.
  - On the **Business Rules** page, loading add or edit condition page would take a long time. After this change, the page can load immediately.

- Costs (Side effect):

  - Low performance when you create or modify entities or attributes.
  - Low performance when you add users or groups.
 
In the Master Data Management (MDM) system, the `GET` operation is the most frequent operation. Operations for create or modify entities, attributes, or users(groups) have less frequency than the `GET` operation.

So, through this performance improvement, we improve the performance in the `GET` operations, but it also brings some side effects for the `Modify` operations. The benefits outweigh the side effects. 

## Resolution

This change causes degraded performance. We provide a system setting that you can use to flexibly disable and enable this change. For more information, see 
[Performance Settings](/sql/master-data-services/system-settings-master-data-services#Performance).

- After you enable the performance setting, it will be faster when you load large user security related data. For example:

  ```SQL
  UPDATE mdm.tblSystemSetting SET SettingValue = 1 WHERE SettingName = 'PerformanceImprovementEnable';
  EXEC [mdm].[udpPerformanceToggleSwitch];
  GO
  ```

- After you disable the performance setting, it will be faster when you create model, entity, or attribute. For example:

  ```SQL
  UPDATE mdm.tblSystemSetting SET SettingValue = 0 WHERE SettingName = 'PerformanceImprovementEnable';
  EXEC [mdm].[udpPerformanceToggleSwitch];
  GO
  ```

## More information

[Immediately apply member permissions (Master Data Services)](/sql/master-data-services/immediately-apply-member-permissions-master-data-services)
