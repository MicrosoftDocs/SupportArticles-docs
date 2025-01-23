---
title: Error is shown when hovering on Remote App-Desktop
description: Solves PAD rdp agent start up issues
ms.custom: sap:Desktop flows\UI or Browser automation issues
ms.date: 01/22/2025
ms.author: amitrou 
author: amitrou
---

# No element is highlighted or Error is shown when hovering on Remote App-Desktop

## Symptoms

When hovering over a Citrix/RDP window/app no element is highlighted or an Error Popup is show about enabling the agent.

## Causes

The communication with the remote agent components cannot happen.

## Resolution

1. Make sure the Power Automate Citrix/RDP plugin is registered. While the Citrix/RDP app/desktop is up, Run the the troubleshooter (From Power Automate Menus -> Help -> Troubleshooter) and select "UI Automation" button. It should show the diagnostics for the communication. If an error occurs in the Citrix/RDP section, you can expand it for further details and possible fix.
2. If the troubleshooter reports that the remote agent is **not running**:  
   - Make sure the agent is running on the other side (inside the  Citrix/RDP session). This can be checked while the Citrix/RDP app/desktop is up and check the tray icon for the agent icon. If the icon exists, hover over it to make sure it is still running. If it is still running, right click it to open the menu and select "Status". This should show the agent status and the possible reason for the error.

3. If you verified that the agent **is indeed not running**, then if the user is using Citrix, then they have to make sure that the agent is installed on every Citrix Server.

4. If the agent is running, then check the tray icon of the agent and check it's status as described above:
   - **"A device on the system is not functioning"**: The citrix plugin is not loaded on the host system. While the Citrix/RDP desktop/app is up, run the troubleshooter and check the Citrix/RDP errors on the UI Automation section.
   - **"Citrix Virtual Channel policy enabled"**: The "Virtual channel Allow list" policy on Citrix is enabled or Default. If it is not ***Disabled**, the agent cannot communicate. They need to contact their administrators and disable this policy. Leaving it "Default" will not work. Make sure the Citrix machines are restarted after policy is applied.
