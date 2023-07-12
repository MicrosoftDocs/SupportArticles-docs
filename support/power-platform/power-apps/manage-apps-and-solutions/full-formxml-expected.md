---
title: Full formXml is expected to create a form
description: Describes an issue where the message full formXml is expected to create a form is displayed during solution import.
ms.reviewer: squassina
ms.topic: troubleshooting
ms.date: 06/18/2021
author: squassina
ms.author: risquass
---
# Full formXml is expected to create a form

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

Microsoft.Crm.CrmInvalidOperationException: full formXml is expected to create a form *formid* message is displayed during solution import.

## Cause

This error can occur when the form you are importing doesn’t exist in the target environment and the form is imported for the first time. The solution you are importing has only form changes (diff) in the form XML when it should have the full form XML. A solution should only import a diff form XML when the form is already present in the environment and you’re importing the changes. To verify, open your solution’s customizations.xml file and search for the FormXml node using the form ID that appears in the error message. If the form XML contains an attribute named `solutionaction`, then the form XML is a diff.

## Workaround

To work around this scenario the form XML must be a full form XML (shouldn't contain the `solutionaction` attribute located in customizations.xml file) and can be obtained from the instance this form was originally created in as unmanaged.
