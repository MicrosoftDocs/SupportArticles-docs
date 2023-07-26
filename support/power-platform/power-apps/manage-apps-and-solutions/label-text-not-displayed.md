---
title: Label text isn't displayed in other languages
description: Provides a workaround for an issue where label text isn't shown in other languages after you import a solution.
ms.reviewer: matp
ms.date: 07/26/2023
author: nhelgren
ms.author: nhelgren
---
# Label text isn't displayed in other languages

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

After you import a solution, the label text isn't displayed in other languages.

## Cause

This issue can occur when you import a solution that contains translations before you enable the language in the target environment.

## Workaround

To work around this issue, [enable the language](/power-platform/admin/enable-languages#enable-the-language) in the target environment and import the solution again.
