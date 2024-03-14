---
title: Service Manager connector doesn't remove an uninstalled software relationship
description: Fixes an issue in which the Service Manager connector to Configuration Manager doesn't remove a software-installed relationship even though the software is uninstalled.
ms.date: 03/14/2024
ms.reviewer: khusmeno
---
# The Service Manager connector to Configuration Manager doesn't transfer uninstalled software information

This article helps you fix an issue in which the Service Manager connector to Configuration Manager doesn't remove a software-installed relationship even though the software is uninstalled.

_Original product version:_ &nbsp; System Center 2016 Service Manager, System Center 2012 R2 Service Manager, System Center 2012 Service Manager, Configuration Manager (current branch), Microsoft System Center 2012 R2 Configuration Manager, Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2874780

## Symptoms

Software that's installed on computers is successfully brought over to Microsoft System Center Service Manager through the Configuration Manager connector. However, when you uninstall the software from a computer and then perform a hardware inventory in Configuration Manager, the software-installed relationship is not removed in Service Manager even though the relationship is successfully removed in Configuration Manager.

## Cause

The Service Manager connector to Configuration Manager uses software-deletion records to remove the software-installed relationship. However, a change that was introduced in System Center 2012 Configuration Manager SP1 prevents these deletion records from being written.

## Resolution

To resolve this issue, re-enable the triggers that write the deletion records in Configuration Manager. Then, the Service Manager connector will be able to successfully recognize and perform the associated action to remove the software-installed relationship.

To do this, use the stored procedure that is described in [How to Enable and Disable Extraction Views](/previous-versions/hh949655(v=msdn.10)?redirectedfrom=MSDN).
