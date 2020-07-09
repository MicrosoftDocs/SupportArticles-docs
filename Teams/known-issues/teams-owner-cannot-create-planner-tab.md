---
title: Teams owner unable to create a Planner tab
description: Describes an issue in which Teams owner unable to create a Planner tab in Teams client.
author: TobyTu
ms.author: Colin.Witkowski
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: o365-proplus-itpro
localization_priority: Normal
ms.custom: 
- CI 120274
- CSSTroubleshoot
ms.reviewer: Colin.Witkowski
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# Teams owner unable to create a Planner tab

## Symptoms

When trying to create a new Planner tab in Microsoft Teams, a team owner receives this error message from the Teams client:

> "Failed to create the plan".

## Cause

The owner isn't a member of the Microsoft 365 group associated with the team. This prevents the Planner API from triggering the plan creation.

## Resolution

Add the owner as a member of the Microsoft 365 group. For more information, see [Add or remove members from Microsoft 365 groups using the admin center](https://docs.microsoft.com/microsoft-365/admin/create-groups/add-or-remove-members-from-groups?view=o365-worldwide).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
