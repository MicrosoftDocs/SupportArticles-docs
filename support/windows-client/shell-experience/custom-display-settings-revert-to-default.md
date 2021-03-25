---
title: Custom display settings revert to the default
description: Describes the issue in which custom display settings may revert to default display settings. This issue occurs when some device drivers are reinstalled to service the underlying components during installation of a Windows Vista service pack.
ms.date: 09/23/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: DPI and Display Issues
ms.technology: windows-client-shell-experience
---
# Custom display settings may revert to default display settings after you install a Windows Vista Service Pack on a computer that uses multiple monitors

This article provides a solution to an issue where custom display settings revert to default display settings. This issue occurs after you install a Windows Vista Service Pack on a computer that uses multiple monitors.

_Original product version:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 949742

## Symptoms

You install a Windows Vista Service Pack on a computer that uses multiple monitors. Then, the custom display settings may revert to default display settings. The custom display settings that revert may include the following settings:

- Default monitor choice setting
- Monitor position setting in a multi-monitor configuration
- Monitor display size setting
- Monitor update setting (monitor refresh rate) and video adapter update setting (video adapter refresh rate)

## Cause

This issue occurs because certain device drivers are reinstalled to correctly service the underlying components during an installation of a Windows Vista service pack. Therefore, certain customized display settings may be reset to their operational default settings.

## Resolution

To resolve this issue, reset the custom display settings on the computer by following these steps:

1. Click **Start**, type *personalization* in the **Start Search** box, and then click **Personalization** in the **Programs** list.
2. Under **Personalize appearance and sounds**, click **Display Settings**.
3. Reset the custom display settings that you want, and then click **OK**.
