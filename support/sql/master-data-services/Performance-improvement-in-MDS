---
title: Performance improvement in MDS 
description: This article introduces the historical background and setttings of performance improvement in MDS.
ms.date: 10/23/2024
ms.custom: sap:Master Data Services
ms.reviewer: v-biguan, jiwang6
---
# Performance improvement in MDS

This article helps you understand and resolve the performance problem in MDS.

## Symptoms and Cause

We did a big performance improvement several years ago. 
According this change, it will benefit for all the GET operation for the data requiring permission check through Portal and API, i.e. all the entities/attirbutes/model permissions….  But the cost for this that change is add/remove user, add/remove/modify Entity/Attribute became slow.
Benefits (Performance improvement):
	1. Performance improvement in all load permission needs page like explore/model/entities/attributes list page. 
	2. On model permissions setting page. Previously, load this page or expand tree for Models need take 3~4 minutes. And some customer reported that they sometimes faced timeout exception.
	After this change, load this page and expand tree only spend 1~2 seconds.
	1. On Business rule edit page, load add/edit condition page will take more than 1 minutes. And some customer reported that the UI will freeze more 3 minutes and they cannot do any operation.
	After this change, this page can load immediately. 
Costs (Side effect):
	1. Create/modify entities/attributes will have the low performance. According count for attributes/users, it will take more than 1 minutes (Dependences on attributes and users/groups) .
	2. Add users/groups will have the low performance. According count for attributes/users, it will take more than 1 minutes (Dependences on attributes and users/groups).
 
Since for in the MDM system, GET operation is the most frequent operations. Operations for create/modify entities/attributes/users(groups)  have less frequency than get operation. 
So through this performance improvement, we tried to improve the performance in Get operations, but it brings some side effect for the Modify operations. We thought the benefit overweigh the side effect. 
 
Also after this performance change,  it will cause degraded performance. We provided a system setting that you can disable/enable this change flexibility.

##  <a name="Performance"></a> Performance Settings  

|Configuration Manager Setting|System Setting|Description|  
|-----------------------------------|--------------------|-----------------|  
|**Enable performance improvement setting**|**PerformanceImprovementEnable**|We default to enable this setting (**Set to 1**) that load permission related page will have a good performance. But in this situation create/modify entities, attributes, users, or groups will have a low performance. To avoid this, you can disable this setting (**Set to 0**). After change this setting. You must run command "**EXEC [mdm].[udpPerformanceToggleSwitch];**" to make sure that the view and data is correct.|  

For example, enable the performance setting, load large user security related data will be faster

```SQL
UPDATE mdm.tblSystemSetting SET SettingValue = 1 WHERE SettingName = 'PerformanceImprovementEnable';

EXEC [mdm].[udpPerformanceToggleSwitch];

GO
```

Disable the performance setting, create model/entity/attribute will be faster

```SQL
UPDATE mdm.tblSystemSetting SET SettingValue = 1 WHERE SettingName = 'PerformanceImprovementEnable';

EXEC [mdm].[udpPerformanceToggleSwitch];

GO
```

 For more information, see [Immediately Apply Member Permissions &#40;Master Data Services&#41;](/sql/master-data-services/immediately-apply-member-permissions-master-data-services).
