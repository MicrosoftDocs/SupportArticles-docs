---
title: Troubleshooting ribbon issues in Power Apps
description: Provides a resolution for ribbon issues in Microsoft Power Apps.
ms.reviewer: krgoldie, srihas, tahoon
ms.date: 09/25/2023
---
# Troubleshooting ribbon issues in Power Apps

This guide helps you resolve issues that affect a ribbon command bar button in a Power Apps model-driven app or a customer engagement app (Dynamics 365 Sales, Customer Service, Field Service, or Marketing).

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4552163

## Use Command checker

Command checker is a tool for examining command (ribbon) definitions and troubleshooting common issues. It's built into every Power Apps model-driven app and Dynamics 365 app.

> [!NOTE]
> Command checker only works in a web browser. We're adding support to Android and iOS apps soon. As a workaround, check if the same issue occurs when the app is opened in an Android or iOS browser. If it does, you can use Command checker to investigate.

Use Command checker to diagnose common issues like:

- [A button on the command bar is hidden when it should be visible](ribbon-issues-button-hidden.md)
- [A button on the command bar is visible when it should be hidden](ribbon-issues-button-visible.md)
- [A button on the command bar isn't working correctly](ribbon-issues-button-not-working-correctly.md)
- [A button on the command bar has wrong labels](ribbon-issues-button-wrong-label.md)

> [!IMPORTANT]
> These issues are often caused by missing or incorrect ribbon metadata. Typically, this situation can be resolved by regenerating all ribbon metadata. Command checker has a feature that enables you to [trigger the regeneration of all ribbon metadata](regenerate-ribbon-metadata.md). Only system administrators, system customizers, and makers have the permissions to regenerate metadata.

### Enable Command checker

To enable Command checker, append the `&ribbondebug=true` parameter to the URL of the app. For example: `https://yourorgname.crm.dynamics.com/main.aspx?appid=<ID>&ribbondebug=true`.

:::image type="content" source="media/ribbon-issues/enable-command-checker.png" alt-text="Screenshot shows the parameter is appended to a Dynamics 365 application URL." lightbox="media/ribbon-issues/enable-command-checker.png":::

### Inspect a command

Once Command checker is enabled, you'll find a new button named **Command Checker** :::image type="icon" source="media/ribbon-issues/command-checker-button-icon.png" border="false"::: in [various command bars](/power-apps/maker/model-driven-apps/command-designer-overview#command-bar-locations) (global, main form, main grid, and subgrid). You may have to expand the menu bar to see this button.

> [!NOTE]
> Command checker isn't available for commands in [Quick actions](/power-apps/maker/model-driven-apps/command-designer-overview#command-bar-locations).

1. Find the command bar that has the command you want to investigate.
2. Select the **Command Checker** button. The Command checker panel opens.
3. Select the command you want to examine in the list of commands. Commands that aren't visible are displayed in italics and end with **(hidden)**.

## Reference

[Command checker for model-driven app ribbons](https://powerapps.microsoft.com/blog/introducing-command-checker-for-model-app-ribbons/)
