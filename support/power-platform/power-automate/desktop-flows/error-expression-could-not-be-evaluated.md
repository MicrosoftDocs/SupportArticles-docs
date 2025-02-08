---
title: Expression Couldn't be Evaluated Error When Using Encrypted Text
description: Provides a resolution for the Expression couldn't be evaluated error when using direct encrypted text in Power Automate for desktop.
ms.reviewer: iomavrid
author: yiannismavridis
ms.author: iomavrid
ms.date: 02/08/2025
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# "Expression couldn't be evaluated" error when using encrypted text

This article provides a resolution to the "Expression couldn't be evaluated" error that occurs when you use direct encrypted text in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  

## Symptoms

When you run a desktop flow on a different machine, you receive the following error message:

> Failed with error: Expression couldn't be evaluated

This issue occurs when the desktop flow includes an action that uses a direct input option. For example,

- The **Direct password input** option:

  :::image type="content" source="media/error-expression-could-not-be-evaluated/direct-password-input.png" alt-text="Screenshot that shows the Direct password input option in a desktop flow action.":::

- The **Direct encrypted text input** option:

  :::image type="content" source="media/error-expression-could-not-be-evaluated/direct-encrypted-text-input.png" alt-text="Screenshot that shows the Direct encrypted text input option in a desktop flow action.":::

## Cause

The error occurs because the direct input is encrypted using the local machine's [Data Protection API (DPAPI)](/dotnet/standard/security/how-to-use-data-protection). This means the input can't be decrypted when the flow is run on another machine.

This limitation is highlighted when you hover over the info icon if any of the direct input options is selected.

:::image type="content" source="media/error-expression-could-not-be-evaluated/encrypted-tooltip.png" alt-text="Screenshot that shows the tooltip that provides additional information about the limitations of using direct encrypted text or password input.":::

## Resolution

To run the flow on a different machine, modify the flow to use [sensitive variables](/power-automate/desktop-flows/manage-variables#sensitive-variables/power-automate/desktop-flows/manage-variables#sensitive-variables).

1. Open the desktop flow in Power Automate for desktop.
1. Locate the action that uses direct password input or direct encrypted text input.
1. Replace the direct input with a sensitive variable:
   1. Select the **Password input as variable** or **Input as text, variable or expression** option to use a variable as a password input or text input.
   1. Choose a variable that's marked as sensitive.
1. Save the modified flow and test it on a different machine to ensure that the error is resolved.

## More information

[Use passwords in certain actions within desktop workflows](/power-automate/desktop-flows/how-to/use-passwords)
