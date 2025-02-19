---
title: The Add Object Wizard displays only 500 objects
description: Describes an issue that prevents more than 500 objects from being displayed in System Center Operations Manager, even when there are more than 500 objects.
ms.date: 04/15/2024
ms.reviewer: viksahay, adoyle
---
# The Add Object Wizard in Operations Manager displays only 500 objects even if more than 500 exist

This article helps you work around an issue that prevents more than 500 objects from being displayed in Microsoft System Center Operations Manager, even when there are more than 500 objects.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2976809

## Symptoms

When you use the **Add Groups** or **Add Object** button while creating a report in System Center Operations Manager, no more than 500 objects are displayed in the Add Object Wizard even if more than 500 exist.

## Cause

This default limit of 500 objects is by design, and this setting is controlled through the system registry.

## Workaround

To work around this issue, create a registry key to manually set the maximum object limit in the Add Object Wizard.

To do this, follow these steps:

1. On the computer that's hosting the Operations Manager console, close all running instances of the console.
2. Start Registry Editor. Make sure that you're using the same user account that's used to run the console.
3. Locate and then select the following registry subkey:

   `HKEY_CURRENT_USER\Software\Microsoft\Microsoft Operations Manager\3.0\Console`

4. Create a new DWORD value key, and save it as `MaximumSearchItemLimit`. Assign a value to this key that reflects the maximum number of objects that you want to display. For example, use a value of 1000 if you want to limit the maximum number of objects to 1000 instead of to the default limit of 500.

   - Location: `HKEY_CURRENT_USER\Software\Microsoft\Microsoft Operations Manager\3.0\Console`
   - Name: `MaximumSearchItemLimit`
   - Type: **REG_DWORD**
   - Value: 0 to 65535

5. Exit Registry Editor.

To verify the new setting, start the Operations Manager console, and then open a report that uses the **Add Group** or **Add Object** button. Select the **Search** button in the **Add Object** dialog box, and then verify that the maximum number of available items that are now displayed matches the `MaximumSearchItemLimit` value.

> [!NOTE]
> Make sure that you repeat steps 1-5 on all computers that are hosting the Operations Manager console.
