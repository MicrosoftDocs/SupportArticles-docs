---
title: Launch Browser fails when is opening with different system user
description: Solves the Failed to assume control error when Launch or Attach browser is failing due to different system user.
ms.custom: sap:Desktop flows\UI or browser automation
ms.reviewer: amitrou
ms.author: amitrou
author: amitrou
ms.date: 03/17/2025
---
# Launch Browser fails when is opening with different system user

This article provides a workaround for the "Failed to assume control of Microsoft Edge/Chrome/Firefox" error that occurs when a Launch Browser action fails to run in Power Automate for desktop.

## Symptoms

When running a launch/attach browser action and the browser was launched with a different system user than PAD then one of the following errors appears:

- "Failed to assume control of Microsoft Edge"
- "Failed to assume control of Chrome"
- "Failed to assume control of Firefox"

## Applies to

- PAD v2.38 or higher

## Modes

- ✅ Unattended
- ✅ Attended

## Actions

- Launch new Firefox
- Launch new Chrome
- Launch new Microsoft Edge

## Workaround

Launch the browser with the same system user you use to launch PAD.

## Resolution

Due to the security nature of this issue, it will not be reverted back.
