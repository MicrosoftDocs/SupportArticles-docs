---
title: Deleting a team in Teams also deletes the group
ms.author: luche
author: helenclu
ms.date: 10/30/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: Explains why a Teams group is deleted when the team is deleted.
---

# Deleting a team also deletes the group associated with it in Teams

## Summary

When deleting a team in Microsoft Teams, the group associated with the team is also deleted.

## More information

This behavior is by design. Users may not realize that the underlying Microsoft 365 Group is deleted when the team is deleted. Additionally, if the underlying Microsoft 365 Group is deleted, the team is deleted as well.

Additional language in Microsoft Teams provides this information to the user. This information isn't present in the Microsoft 365 Groups interface. Your help desk can recover a deleted Group/Team.

> [!warning]
> When you delete a group, you're permanently removing everything related to this group, including conversations, files, the group notebook, and Planner tasks. For more information, see [Delete a group in Outlook](https://support.microsoft.com/office/delete-a-group-in-outlook-ca7f5a9e-ae4f-4cbe-a4bc-89c469d1726f).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
