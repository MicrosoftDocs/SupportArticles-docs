---
title: Can't capture SAP GuiTree objects
description: Explains that Power Automate for desktop doesn't support capturing SAP GuiTree objects and provides workarounds using UI automation or SAP scripting.
ms.reviewer: ststavri
ms.author: iomimtso
ms.custom: sap:Desktop flows\SAP automation
ms.date: 11/18/2025
---

# Can't capture SAP GuiTree objects

This article provides workarounds when Power Automate for desktop can't capture SAP GuiTree objects.

## Symptoms

Power Automate for desktop doesn't support capturing SAP GuiTree objects with the SAP automation actions.

## Workaround - Use UI automation

Use UI automation actions to interact with those elements. Capture the controls with the UI element picker, and then use UI automation actions in your desktop flow.

## Workaround - Use SAP scripting

Enable and use SAP embedded scripting for elements the SAP automation actions can't capture. For configuration steps, see [Configure SAP GUI scripting](https://learn.microsoft.com/en-us/power-automate/guidance/rpa-sap-playbook/vbscript-based-sap-gui-automation-overview).

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]


