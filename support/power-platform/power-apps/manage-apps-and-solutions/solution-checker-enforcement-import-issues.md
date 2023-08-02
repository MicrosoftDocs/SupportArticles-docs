---
title: Solution checker enforcement in Managed Environments (preview) blocks or warns on import
description: Describes an issue in which importing solutions fails due to solution checker enforcement and provides resolutions and workarounds.
ms.reviewer: matp
ms.date: 07/10/2023
author: jeparson
ms.author: jeparson
---

# Solution checker enforcement in Managed Environments (preview) blocks or warns on import

_Applies to:_ &nbsp; Power Platform, Solutions

> [!IMPORTANT]
> This article is pre-release documentation and is subject to change.

## Background

[Solution checker enforcement in Managed Environments (preview)](/power-platform/admin/managed-environment-solution-checker) allows admins to require valid solution checker results before a solution can be imported. The feature requires solution checker to be run before the solution is imported. It doesn't run solution checker on demand during the import process. You can run solution checker using the Power Apps maker portal, PAC CLI, Azure DevOps (ADO) build tasks, or the web API.

## Symptoms

When you try to [import a solution](/powerapps/maker/data-platform/import-update-export-solutions), you receive one of the following error or warning messages:

> Error: Solution is blocked from importing due to missing Solution Checker results. Run Solution Checker and ensure there are no critical violations in this solution before retrying.

> Error: Solution is blocked from importing due to critical violations. Fix these violations and run Solution Checker before retrying.

> Error: An error occurred while trying to run solution checker enforcement on the importing solution. Try importing the solution again. If this problem persists, contact your system administrator.

> Warning: There are no validation results for this solution. You can block unvalidated solutions by enabling Solution Checker enforcement in Managed Environments settings page.

> Warning: There are critical violations in this solution. You can block solutions with critical violations by enabling Solution Checker enforcement in Managed Environments settings page.

## Cause

This issue occurs because [solution checker enforcement in Managed Environments (preview)](/power-platform/admin/managed-environment-solution-checker) is enabled in either **Warn** or **Block** mode. Either the solution wasn't run through the checker, or critical violations are present in the results.

## Resolution

Solution checker must be run on the solution before it can be imported. There are some special considerations to keep in mind:

- Solution checker must be run with the solution checker ruleset. The easiest ways to do this are:
  - Run solution checker in [Power Apps](/power-apps/maker/data-platform/use-powerapps-checker) where the solution checker ruleset is used.
  - Use [pac solution check](/power-platform/developer/cli/reference/solution#pac-solution-check) where the solution checker ruleset is used by default.
  - If explicitly passing a ruleset ID, use `0AD12346-E108-40B8-A956-9A8F95EA18C9`, which represents the solution checker ruleset.
- Solution checker must be run within a 90-day window of the import.
- When invoking solution checker, don't pass any file exclusions or rule overrides. These may be supported for solution checker enforcement in the future.
