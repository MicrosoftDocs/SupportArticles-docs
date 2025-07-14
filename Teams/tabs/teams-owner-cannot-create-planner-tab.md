---
title: Teams owner unable to create a Planner tab
description: Describes an issue in which Teams owner unable to create a Planner tab in Teams client.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Apps and Connectors\Planner
  - CI 120274
  - CSSTroubleshoot
ms.reviewer: cowitkow
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# Teams owner unable to create a Planner tab

## Symptoms

When trying to create a new Planner tab in Microsoft Teams, a team owner receives this error message from the Teams client:

> "Failed to create the plan".

## Cause

The owner isn't a member of the Microsoft 365 group associated with the team. This prevents the Planner API from triggering the plan creation.

## Resolution

Add the owner as a member of the Microsoft 365 group. For more information, see [Add or remove members from Microsoft 365 groups using the admin center](/microsoft-365/admin/create-groups/add-or-remove-members-from-groups?preserve-view=true&view=o365-worldwide).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
