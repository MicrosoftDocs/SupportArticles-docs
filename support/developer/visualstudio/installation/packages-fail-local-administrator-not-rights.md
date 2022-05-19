---
title: SQL packages may fail in the local administrator account
description: Describes an issue where SQL packages may fail when the local administrator account doesn't have certain rights.
ms.date: 05/20/2022
ms.author: v-sidong
---

# SQL packages may fail when the local administrator account doesn't have certain rights

_Original product version:_ &nbsp;Visual Studio 2015  
_Original KB number:_ &nbsp;3039361

## Symptoms

When you install Visual Studio on a locked-down desktop, this operation may trigger errors for the SQL packages.

## Cause

These errors occur because the domain administrator removed certain rights from the local administrators account to tighten desktop security.

## More information

[SQL Server installation fails after default user rights are removed](/troubleshoot/sql/install/installation-fails-if-remove-user-right)
