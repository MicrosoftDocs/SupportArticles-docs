---
title: Error when you open a lookup window in Dexterity debug Test Mode
description: Provides a solution to an error that occurs when you open a lookup window in Dexterity debug Test Mode in Microsoft Dynamics GP 10.0.
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.reviewer: theley
---
# Error message when you try to open a lookup window in Dexterity debug Test Mode in Microsoft Dynamics GP 10.0: "Form Load Failed"

This article provides a solution to an error that occurs when you open a lookup window in Dexterity debug Test Mode in Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 942326

## Symptoms

Consider the following scenario. You open a lookup window in Dexterity in Microsoft Dynamics GP 10.0. When you open the lookup window, Dexterity is in the debug Test Mode. In this scenario, you receive the following error message:

> Unhandled Form Exception: Form Load Failed

This problem occurs when all the following conditions are true:

- You use Dexterity to create a customization.
- You are using Dexterity in the debug Test Mode to run the application dictionary inside the development environment.

## Cause

This problem occurs because the default Alternate/Modified Forms and Report settings point the lookup forms to the alternative versions in the Smartlist dictionary. These alternative forms are not available in the Test Mode.

In Microsoft Dynamics GP 10.0, there is a new role-based security model. In this new model, the security access for the default forms and reports is separated from the security access for customized forms and reports. Access control for the following windows is now controlled by the new Alternate/Modified Forms and Reports window:

- The Modified window
- The Alternate window
- The Modified Alternate window

## Resolution

To resolve this problem, follow these steps:

1. Click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then click **Alternate/Modified Forms and Reports**.

    If you are prompted, enter the password.

2. In the **ID** box, type a new ID for the debugging mode. For example, type **DEBUGUSER** in the **ID** box.

3. In the **Description** box, enter a description. For example, type **Debug User Mode** in the **Description** box.

4. Click **Save**.

    > [!NOTE]
    > Do not make any other changes. The ID that you create in steps 2 - 4 will point to the original forms and reports.
5. Click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then click **User Security**.

    If you are prompted, enter the password.

6. In the **User** field, click the user who you want to use.

7. In the **Company** field, click the company that you want to use.

8. In the **Alternate/Modified Forms and Reports ID** field, click the debug user mode that you created in step 2.

The old style lookup window is now available for the user who you selected in step 6 in Dexterity in the debug Test Mode.
