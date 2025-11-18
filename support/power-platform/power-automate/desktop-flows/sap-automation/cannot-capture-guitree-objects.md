---
title: Can't capture SAP GuiTree objects in Power Automate for desktop
description: Power Automate for desktop doesn't capture SAP GuiTree objects. Use UI automation or enable SAP GUI scripting as workarounds.
ms.reviewer: ststavri
ms.author: iomimtso
ms.custom: sap:Desktop flows\SAP automation
ms.date: 11/18/2025
---

# Can't capture SAP GuiTree objects in Power Automate for desktop

Power Automate for desktop doesn't capture SAP GuiTree objects. If your desktop flow must interact with these controls, use one of the workarounds below.

## Symptoms

- Power Automate for desktop can't capture SAP GuiTree objects with the SAP automation actions.

## Workaround - Use UI automation

Use UI automation actions to interact with the controls. Capture them with the UI element picker, then use UI automation actions in your desktop flow.

## Workaround - Use SAP GUI scripting

Enable and use SAP GUI scripting to automate elements that the SAP automation actions can't capture. For configuration steps, see [Configure SAP GUI scripting](https://learn.microsoft.com/en-us/power-automate/guidance/rpa-sap-playbook/vbscript-based-sap-gui-automation-overview).

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]


