---
title: Local page adding to favorites fails
description: Describes why a local page cannot be pinned or added as a favorite site in Internet Explorer 11. Provides a workaround.
ms.date: 04/24/2020
---
# You cannot pin a local webpage in Internet Explorer 11

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about a webpage cannot be pinned sites in Internet Explorer 11 or added to favorites sites, because the webpage contains meta tags that refer to local images.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 2900068

## Symptoms

You cannot add a local webpage to your **Favorites** sites or pinned sites in Internet Explorer 11 for Windows 8.1 if the webpage refers to a local image as its full bleed logo.

## Cause

Internet Explorer supports the pinning of websites to the **Start** screen as small, medium, wide, and large tiles. Sites can define which logos to support on the tile sizes by specifying these images in the following meta tags:

- `msapplication-square150x150logo`
- `msapplication-square70x70logo`
- `msapplication-square310x310logo`
- `msapplication-wide310x150logo`

However, if the webpage contains meta tags that refer to local images, the webpage cannot be pinned or added to your **Favorites** sites from Internet Explorer 11.

## Workaround

To work around this issue, remove these meta tags so that the local website can be pinned or added to your **Favorites** sites.
