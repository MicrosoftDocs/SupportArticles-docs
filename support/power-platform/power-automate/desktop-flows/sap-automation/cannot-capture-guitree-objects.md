---
title: Can't capture SAP GuiTree objects in Power Automate for desktop
description: Power Automate for desktop doesn't capture SAP GuiTree objects. Use UI automation or enable SAP GUI scripting as workarounds.
ms.reviewer: ststavri
ms.author: iomimtso
ms.custom: sap:Desktop flows\SAP automation
ms.date: 11/18/2025
---

# Can't capture SAP GuiTree objects in Power Automate for desktop

Power Automate for desktop doesn't currently support capturing SAP GuiTree objects. Support for capturing SAP GuiTree objects is planned for a future release. Until this feature is added, if your desktop flow must interact with these controls, use one of the workarounds in this article.

## Symptoms

Power Automate for desktop doesn't capture SAP GuiTree objects when using SAP automation actions.

## Workaround 1: Use UI automation

Use UI automation actions to interact with the controls. Capture the controls by using the UI element picker, then use UI automation actions in your desktop flow.

## Workaround 2: Use SAP GUI scripting

Use SAP GUI scripting to automate controls that the SAP automation actions don't capture. For configuration steps, see [Configure SAP GUI scripting](/power-automate/guidance/rpa-sap-playbook/vbscript-based-sap-gui-automation-overview).

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
