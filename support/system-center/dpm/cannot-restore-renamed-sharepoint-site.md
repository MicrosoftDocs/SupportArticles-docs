---
title: DPM 2010 can't restore a renamed SharePoint site
description: Fixes an issue where Data Protection Manager 2010 can't restore a SharePoint site after the site is renamed.
ms.date: 07/27/2020
---
# Data Protection Manager 2010 can't restore a SharePoint site after the site is renamed

This article helps you fix an issue where Data Protection Manager 2010 can't restore a SharePoint site after the site is renamed.

_Original product version:_ &nbsp; System Center Data Protection Manager 2010  
_Original KB number:_ &nbsp; 2763004

## Symptoms

If System Center Data Protection Manager 2010 (DPM 2010) backs up a SharePoint 2010 site and then the site has its name changed, DPM 2010 will be unable to recover the site. The renamed site will be treated as a list instead of a site.

## Cause

This is a known issue in System Center Data Protection Manager 2010.

## Resolution

This issue is resolved in [Hotfix Rollup Package 7 for System Center Data Protection Manager 2010](https://support.microsoft.com/help/2751231).
