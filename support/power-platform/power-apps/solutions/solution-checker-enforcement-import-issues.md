---
title: Solution checker enforcement in Managed Environments blocks or warns on import
description: Describes an issue in which importing solutions fails due to solution checker enforcement and provides resolutions and workarounds.
ms.reviewer: matp
ms.date: 10/17/2023
author: jeparson
ms.author: jeparson
---
# Solution checker enforcement in Managed Environments blocks or warns on import

_Applies to:_ &nbsp; Power Platform, Solutions

## Background

[Solution checker enforcement in Managed Environments](/power-platform/admin/managed-environment-solution-checker) allows admins to require valid solution checker results before a solution can be imported.

## Symptoms

When you try to [import a solution](/powerapps/maker/data-platform/import-update-export-solutions), you receive one of the following error or warning messages:

> Error: Solution is blocked from importing due to critical violations. Fix these violations and run Solution Checker before retrying.

> Warning: There are critical violations in this solution. You can block solutions with critical violations by enabling Solution Checker enforcement in Managed Environments settings page.

## Cause

The error or warning message occurs because [solution checker enforcement in Managed Environments](/power-platform/admin/managed-environment-solution-checker) is enabled in either **Warn** or **Block** mode, and critical violations are present in the results.

## Resolution

The critical violations in the solution must be fixed before importing the solution.

If a results link is present in the message, you can use the link to download a [SARIF file](/power-platform/alm/checker-api/overview#report-format) to see the results. The [rules documentation](/power-apps/maker/data-platform/use-powerapps-checker#best-practice-rules-used-by-solution-checker) lists each rule with a link for more information and how to fix.

If the results link isn't present in the message, you can run solution checker separately to see the results. Here are some special considerations:

- Solution checker must be run with the solution checker ruleset. The easiest ways to do this are:
  - Run solution checker in [Power Apps](/power-apps/maker/data-platform/use-powerapps-checker) where the solution checker ruleset is used.
  - Use [pac solution check](/power-platform/developer/cli/reference/solution#pac-solution-check) where the solution checker ruleset is used by default.
  - If explicitly passing a ruleset ID, use `0AD12346-E108-40B8-A956-9A8F95EA18C9`, which represents the solution checker ruleset.
- When invoking solution checker, don't pass any file exclusions or rule overrides. These may be supported for solution checker enforcement in the future.
