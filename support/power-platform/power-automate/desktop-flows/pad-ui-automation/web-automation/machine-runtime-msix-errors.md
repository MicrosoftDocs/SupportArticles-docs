---
title: Web Automation actions fail when Machine Runtime and MSIX PAD versions are not synced
description: Solves web automation errors when Machine Runtime and MSIX PAD versions are different
ms.custom: sap:Desktop flows\UI or Browser automation issues
ms.date: 01/20/2025
ms.author: amitrou 
author: amitrou
---

# Web Automation actions fail when Machine Runtime and MSIX PAD versions are not synced

## Symptoms

In PAD MSIX installation, when any Web Automation action under the Browser Automation group of actions, is triggered from a cloud flow, the action is failing with the following error:

 **"Negotiation failed".**

### Applies to

- MSIX PAD (Store Version) >= 2.37
- MSIX and MSI are both installed in the same machine.

### Modes

- ✅ Unattended
- ✅ Attended

#### Actions

Any web automation action under the the Browser Automation group.

## Detection

1. Install MSIX PAD latest
2. Install Machine Runtime from installer a version prior (eg. non QFE)
3. Create a flow on PAD to automate a web page with Extension based browser
4. Save the flow
5. Run it from cloud

## Root Cause

In case the PAD MSIX installation has different version than that of machine runtime, the Message Host running from browser is the one from MSIX installation which is a different version from the one Machine runtime expects.

 This case makes the flow fail with "Negotiation failed" error.

## Workaround

Both Machine Runtime and MSIX version should be the same.
