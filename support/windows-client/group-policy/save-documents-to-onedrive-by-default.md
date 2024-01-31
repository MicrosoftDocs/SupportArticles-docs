---
title: Inaccurate policy name (Save documents to OneDrive by default) in OneDrive Administrative Templates
description: Describes a discrepancy in the policy name in Microsoft OneDrive Group Policy Administrative Templates.
ms.date: 09/16/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, ryanman
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
ms.subservice: windows-group-policy
---
# Save documents to OneDrive by default is a OneDrive Group Policy Administrative Templates discrepancy in Windows 8.1

This article explains a discrepancy in the policy name in Microsoft OneDrive Group Policy Administrative Templates.

_Applies to:_ &nbsp; Windows 8.1  
_Original KB number:_ &nbsp; 3017037

## Symptoms

In the OneDrive Group Policy Administrative Templates that are dated September 12, 2014, there is a discrepancy in the policy name and description for where you can save documents by default.

## More information

Currently, the inaccurate policy name is: **Save documents to OneDrive by default**.

And the policy description is as follows:

This policy setting lets you disable OneDrive as the default save location. It does not prevent apps and users from saving files on OneDrive. If you disable this policy setting, files will be saved locally by default. Users will still be able to change the value of this setting to save to OneDrive by default. They will also be able to open and save files on OneDrive using the OneDrive app and file picker, and Microsoft Store apps will still be able to access OneDrive using the WinRT API. If you enable or do not configure this policy setting, users with a connected account will save documents to OneDrive by default.

Actually, the policy name should be: **Save documents to the local PC by default**  

And the policy description should read: This policy setting lets you select the local PC as the default save location. It does not prevent apps and users from saving files on OneDrive. If you enable this policy setting files will be saved locally by default. Users will still be able to change the value of this setting to save to OneDrive by default. They will also be able to open and save files on OneDrive using the OneDrive app and file picker and Microsoft Store apps will still be able to access OneDrive using the WinRT API. If you disable or do not configure this policy setting, users with a connected account will save files to OneDrive by default.
