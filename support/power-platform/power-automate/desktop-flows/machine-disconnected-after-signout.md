---
title: Machine moves to disconnected state after session sign-out
description: Provides troubleshooting tips for if the machine is showing disconnected in the portal after a user session is signed out
ms.date: 01/10/2025
---
# Desktop flows machine shows as disconnected after Windows session sign-out

This article provides a provides troubleshooting tips for when the Power Automate desktop flows machine shows as disconnected in the Power Automate portal after a user session is signed out.

## Symptoms

When you sign out of your Windows computer and you go to the Power Automate portal, you see the machine status as disconnected.

## Cause

This may be caused by internal machine or network settings which disallow connectivity when all sessions are signed out, or a proxy server which requires user authentication.

## Resolution

You can try to update the account the Power Automate service (UIFlowService) runs as. To do this, please see [how to change the on premises service account](https://learn.microsoft.com/en-us/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account).

If this does not work, please work with your IT administrator to understand why network connectivity from session 0 does not continue to function after all users sessions have signed out.
