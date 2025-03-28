---
title: Elements are highlighted but on runtime clicks are not happening on Citrix Virtual apps
description: Solves an issue that occurs when hovering over elements in Citrix Virtual apps works but on runtime clicks do not work
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 03/28/2025
---
# Elements are highlighted but on runtime clicks are not happening on Citrix Virtual apps

This article helps you resolve an issue you may encounter when trying to click an element in Citrix Virtual apps.

## Symptoms

When you hover the mouse cursor over a UI or web element of an application or webpage inside a Citrix virtual app with [UI element picker](/power-automate/desktop-flows/ui-elements#ui-elements-types) the elements are highlighted and captured, however when used in an action, the interaction is not happening and no error is shown. Test selector works fine.

## Cause

The Citrix Workspace HI DPI settings are interfering with PAD interactions. Mostly affected setups with multiple monitors.

## Resolution

1. Disable Citrix Workspace HIDPI option. From the tray icon right click on the Citrix Workspace icon.
2. Click on 'Advanced Preferences'.
3. Click on 'High DPI' link.
4. On the options shown, select the 'Let the operating system scale the resolution'.
5. Click 'Save' and close the remaining Citrix workspace preferences windows.
6. Close any Citrix Desktops or Virtual apps and start them again.
7. If needed change the Desktop scaling of the machine running PAD to 100%. For unattended machines follow these instructions: [Set screen resolution on unattended mode - Power Automate](/power-automate/desktop-flows/how-to/set-screen-resolution-unattended-mode)