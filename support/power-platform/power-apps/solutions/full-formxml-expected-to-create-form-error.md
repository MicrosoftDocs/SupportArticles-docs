---
title: Full formXml is expected to create a form error
description: Provides a workaround for the Full formXml is expected to create a form error that occurs when you import a solution.
ms.reviewer: matp
ms.date: 07/26/2023
author: nhelgren
ms.author: nhelgren
---
# "Full formXml is expected to create a form" error when importing a solution

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you import a solution, you receive the following error message:

> Microsoft.Crm.CrmInvalidOperationException: full formXml is expected to create a form *<Form ID>*.

## Cause

This error occurs when the form you're importing doesn't exist in the target environment, and the form is imported for the first time. The solution you're importing has only form changes (diff) in the form XML when it should have a full FormXml. A solution should only import a diff form XML when the form is already present in the environment and you're importing the changes. To verify, open your solution's *customizations.xml* file and search for the `FormXml` node using the form ID that appears in the error message. If the FormXml contains an attribute named `solutionaction`, the form XML is a diff.

## Workaround

To work around this issue, the form XML must be a full FormXml (shouldn't contain the `solutionaction` attribute located in the *customizations.xml* file), and can be obtained from the instance in which this form was originally created as an unmanaged form.
