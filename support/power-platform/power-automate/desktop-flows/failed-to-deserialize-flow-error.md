---
title: Failed to deserialize Flow error
description: Provides a resolution for the Failed to deserialize Flow error that occurs in Power Automate for desktop.
ms.reviewer: pefelesk
ms.date: 09/21/2022
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# "Failed to deserialize Flow" error in Power Automate for desktop

This article provides a resolution for the "Failed to deserialize Flow" error that occurs when you edit or run desktop flows in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5008560

## Symptoms

In Microsoft Power Automate for desktop version 2.14, when you edit or run desktop flows, you receive the following error message:

> Failed to deserialize Flow.

## Cause

This issue occurs because the desktop flow contains disabled actions that have been copied or pasted.

Affected actions are:

- If Image
- If window
- If window contains
- If webpage contains
- Wait for image
- Wait for window
- Wait for window content
- Wait for webpage content

There's an issue when deserializing the pasted script, and a **DISABLE** statement gets inserted which causes the flow to fail to deserialize.

## Resolution

A new version of Power Automate for desktop that resolves this issue was released on November 17, 2021. To solve this issue, you need to update Power Automate for desktop to version 2.14.217.21314 or later.
