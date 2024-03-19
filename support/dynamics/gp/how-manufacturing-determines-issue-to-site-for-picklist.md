---
title: How Manufacturing determines issue-to site for a picklist
description: Describes how Manufacturing determines the issue-to site for a picklist.
ms.reviewer: theley, beckyber, aeckman
ms.date: 03/13/2024
---
# Information about how Manufacturing in Microsoft Dynamics GP determines the issue-to site for a picklist in Microsoft Dynamics GP

This article describes how Manufacturing in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains determines the issue-to site for a picklist.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855902

Manufacturing determines the issue-to site by checking in the following order:

1. Manufacturing checks if a Bill of Materials (BOM) routing link exists between a component item and a routing sequence in the BOM Routing Link window. If the link exists, the default issue-to site is the Work Center ID that is assigned to the sequence number in the Routing Sequence Entry window.

2. Manufacturing checks if a BOM routing link does not exist between a component item and a routing sequence in the BOM Routing Link window. If the link does not exist, the default issue-to site is the Issue To site for the component item in the Bill of Materials Entry window.

3. Manufacturing checks if a BOM routing link does not exist between a component item and a routing sequence in the BOM Routing Link window. Additionally, Manufacturing checks if no Issue To site is assigned to the component in the Bill of Materials Entry window. If the link does not exist and no Issue To site is assigned to the component, the default issue-to site is the Work Center ID that is assigned to the first sequence number in the Routing Sequence Entry window.
