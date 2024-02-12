---
title: Remove this item if it is no longer applied option
description: Describes the behavior of the Remove this item if it is no longer applied option in Group Policy preferences.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
---
# "Remove this item if it is no longer applied" option behavior in Group Policy preferences

This article describes the behavior of the **Remove this item if it is no longer applied** option in Group Policy preferences.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 3060859

## Summary

Windows Server 2008 and later versions of Windows use the Group Policy preferences feature. On the **Common**  tab in Group Policy preferences, there's a **Remove this Item when it is no longer applied**  option. This option removes a preferences item if it was applied before. There is a local database on the computer that stores this information.  

Because the **Remove this item when it is no longer applied**  option is considered on a per-machine basis, this database is not roamed under Roaming User Profiles. Therefore, if a change is made by Group Policy preferences to portions of the user profile that roam between computers (for example, the user registry), the **Remove this item if it is no longer applied**  option should not be used. This option does not work in a roaming scenario.

## More information

For a computer policy setting, the database is stored in the following location:

C:\ProgramData\Microsoft\Group Policy\History  
For a user policy setting, the database is stored in the following location:

C:\Users\%username%\AppData\Local\Microsoft\Group Policy\History
