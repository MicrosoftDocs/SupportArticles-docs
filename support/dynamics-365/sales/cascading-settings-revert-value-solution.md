---
title: Cascading settings revert to the value in solution
description: This article describes a problem for the regarding field on activity entities in Dynamics CRM that is experienced after you import solutions, install update rollups, or apply CRM Online updates.
ms.reviewer: clintwa
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Relationship for activity about fields is reset after you import a solution to Microsoft Dynamics CRM

This article describes a problem for the regarding field on activity entities in Dynamics CRM that is experienced after you import solutions, install update rollups, or apply CRM Online updates.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2013 Service Pack 1, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3027526  

## Symptoms

When you import a solution that contains an entity into Dynamics CRM, which has a relationship with activities through the regarding attribute, the cascading settings for the relationship will revert to whatever the value is in the solution.

This problem occurs even if the solution being imported does not make any changes to these relationships or the cascading settings. Additionally, if the requirement level or label of the regarding field for any out-of-the-box activity is changed, and a solution containing an entity that has a relationship to activities is imported or an update is applied, the changes will be reverted. This is because update rollups or updates to CRM Online contain solutions that are imported.

## More information

After you import any solution, apply update rollups for CRM on premise, or apply updates for CRM Online. Make sure you confirm that any modifications to the cascading settings, labels, or requirement levels of the regarding attribute for activities are configured correctly.
