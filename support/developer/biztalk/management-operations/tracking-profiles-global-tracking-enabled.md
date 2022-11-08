---
title: Wrong behavior of tracking profiles
description: Explains the behavior of tracking profiles when Global Tracking is turned off.
ms.date: 03/16/2020
ms.custom: sap:Management and Operations
ms.reviewer: xuehongg
---
# Tracking profiles behavior when more than one tracking profile associate with an entity and global tracking is turned off

This article provides information about the wrong behavior of tracking profiles when there's more than one tracking profile associated with an entity and global tracking is turned off.

_Original product version:_ &nbsp; BizTalk Server 2010, 2013  
_Original KB number:_ &nbsp; 2873488

## Summary

A profile is a set of characteristics that define a business process. It maps these characteristics from activity to orchestrations and ports. Tracking profile files have a .btt extension.

## Symptoms

If there's more than one tracking profile associated with an entity (say an orchestration) and the global tracking settings is turned off, only the latest tracking profile will get reflected. However, when **Global Tracking** is turned on, all tracking profiles are functional.

## Resolution

Make sure global tracking is turned on when deploying tracking profiles. You can turn it off once the deployment is completed.
