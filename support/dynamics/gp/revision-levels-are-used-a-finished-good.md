---
title: Revision levels are used in a finished good
description: Describes how subassembly revision levels are used in a finished good bill of materials in Manufacturing Order Processing.
ms.reviewer: beckyber, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How subassembly revision levels are used in a finished good bill of materials in Manufacturing Order Processing in Microsoft Dynamics GP

This article describes how subassembly revision levels are used in a "finished good" bill of materials in Manufacturing Order Processing in Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 937818

## Introduction

This article describes how a "finished good" bill of materials uses the most recent revision level for the subassembly bill of materials when a manufacturing order is entered. The "finished good" bill of materials doesn't use the original revision level that was added to the "finished good" bill of materials.

## More information

Consider the following scenario. "Subassembly A revision level 1" has the following two components:

- An arm
- A leg

"Subassembly A revision level 1" is added to "finished good A" bill of materials. Then, a new revision level is added for subassembly A. The new revision level is revision level 2. "Subassembly A revision level 2" has the following three components:

- An arm
- A leg
- A backrest

In this scenario, when a manufacturing order is entered for "finished good A" bill of materials, it uses "subassembly A revision level 2." It's true even though "subassembly A revision level 1" was the first revision level that was added to "finished good A" bill of materials. So the picklist for this manufacturing order has an arm component, a leg component, and a backrest component.

If you want to use an earlier revision level, you can use the BOM Copy window to copy the earlier revision level. You can copy the earlier revision level to an archived bill of materials or to a configured bill of materials. If you have a subassembly that has revision level 1 through revision level 10, you can set up 10 configured bills of materials for this subassembly. Then, you can name each bill of materials by using the revision level number.

If you set up a configured bill of materials for each revision level, you don't have to set up a new item for each of these revision levels in the Item Maintenance window. You can use the BOM Copy window to copy each revision level to a configured bill of materials.
