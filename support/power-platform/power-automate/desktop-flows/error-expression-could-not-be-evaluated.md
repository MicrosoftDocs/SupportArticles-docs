---
title: Error "Expression couldn't be evaluated" while using encrypted text
description: Provides a resolution for the error 'Expression couldn't be evaluated', when using direct encrypted text in Power Automate for desktop.
ms.reviewer: yiannismavridis
ms.date: 02/05/2025
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Error "Expression couldn't be evaluated" while using encrypted text

This article provides a resolution to the error 'Expression couldn't be evaluated', when using direct encrypted text in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  

## Symptoms

* Running a flow results in the error message "Failed with error: Expression couldn't be evaluated" when running in a different machine.
* The desktop flow uses an action that has direct password input or direct encrypted text input.

## Cause

The direct input is encrypted using the local machine's DPAPI. This means that the input is not able to be decrypted when running the flow in a different machine.

This scenario is documented when placing the cursor over the info icon if any of the direct input options is selected:

## Resolution

To run the flow in a different machine, modify the flow to use sensitive variables.
