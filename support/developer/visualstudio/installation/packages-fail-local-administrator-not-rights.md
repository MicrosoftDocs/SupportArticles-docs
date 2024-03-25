---
title: SQL packages may fail in the local administrator account
description: Describes an issue where SQL packages may fail when the local administrator account doesn't have certain rights when installing Visual Studio 2015.
ms.date: 05/25/2022
ms.reviewer: v-sidong
---

# SQL packages may fail when the local administrator account doesn't have certain rights

_Original product version:_ &nbsp;Visual Studio 2015  
_Original KB number:_ &nbsp;3039361

## Symptoms

When you install Visual Studio 2015 on a locked-down desktop, this operation may trigger errors for the SQL packages.

## Cause

These errors may occur if the domain administrator removed certain rights from the local administrators account to tighten desktop security.

## More information

For more information about how to diagnose and address these errors, see [SQL Server installation fails after default user rights are removed](../../../sql/database-engine/install/windows/installation-fails-if-remove-user-right.md).
