---
title: Machine moves to disconnected state after session sign-out
description: Provides troubleshooting tips for if the machine is showing disconnected in the portal after a user session is signed out
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 01/10/2025
---
# Desktop flows machine shows as disconnected after Windows session sign-out

This article provides a provides troubleshooting tips for if the your Power Automate desktop flows machine is showing disconnected in the Power Automate portal after a user session is signed out

## Symptoms

When you sign out of your Windows computer and you go to the Power Automate portal, you see the machine status as disconnected.

## Cause

This may be caused by your proxy server. Some proxy servers require a user to be signed in to allow connectivity.

## Resolution

You can try to update the usre with which the Power Automate service (UIFlowService) runs as. To do this, please see this documentation: https://learn.microsoft.com/en-us/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account
