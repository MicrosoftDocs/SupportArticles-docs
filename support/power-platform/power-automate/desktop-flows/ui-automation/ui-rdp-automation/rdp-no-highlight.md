---
title: No Element Highlighted or Error When Hovering over UI or Web Element
description: Solves an issue that occurs when you hover the mouse cursor over a UI or web element of an application or webpage in Power Automate for desktop.
ms.reviewer: amitrou
ms.author: nimoutzo
author: NikosMoutzourakis
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 04/23/2025
---
# UI element isn't highlighted or an error occurs when hovering over a UI or web element

This article helps you resolve issues you might encounter when using the UI element picker in virtual desktops, such as Citrix or Microsoft Remote Desktop Protocol (RDP) environments.

## Symptoms

When you hover the mouse cursor over a UI or web element of an application or webpage inside a Citrix or RDP window with the [UI element picker](/power-automate/desktop-flows/ui-elements#ui-elements-types) enabled, you might see:

1. The element isn't highlighted.
2. An error message about enabling the [Power Automate agent for virtual desktops](/power-automate/desktop-flows/virtual-desktops#install-the-power-automate-agent-for-virtual-desktops).

   > Enable UI automation in virtual desktop  
   > To automate using UI elements on virtual desktops, ensure the Power Automate agent for virtual desktops is installed and running on the remote machine.

   :::image type="content" source="media/rdp-no-highlight/agent-not-running.png" alt-text="Screenshot of the Enable UI automation in virtual desktop error.":::

## Cause

The communication with the remote agent components doesn't work.

## Resolution

1. Ensure the Power Automate Citrix or RDP plugin is registered.

   1. While the virtual desktop platform (Citrix Desktop, Citrix Virtual Apps, Remote Desktop app, or a remote desktop with Windows RDP communication) is active, run the [troubleshooter](/power-automate/desktop-flows/troubleshooter) by navigating to **Help** > **Troubleshooter** in Power Automate.

      > [!TIP]
      > The troubleshooter can be manually opened via the console and the flow designer, through the dedicated menu under **Help** > **Troubleshooter**. It can also be opened via the process file **PAD.Troubleshooter.exe**, which can be found in the installation folder of Power Automate for desktop.

   1. Run **Troubleshoot UI/Web automation issues** to view the diagnostics for the communication. If an error appears in the Citrix or RDP section, expand it for more details and solutions.

   1. If the error details indicate "Access is denied," policies on the remote machine prohibit running a specific agent component from the user profile folder. Contact your administrator to allow the executables to run from these directories.

      :::image type="content" source="media/rdp-no-highlight/rdp-access-denied.png" alt-text="Screenshot of the Power Automate troubleshooter that shows the Access is denied error details.":::

2. If the troubleshooter indicates that the remote agent isn't running, check if the agent is running in the Citrix or RDP session.

   Check the tray icon for the agent icon when the virtual desktop platform is active. If the icon exists, hover over it to confirm it's still running. If it is, right-click the tray icon to open the menu and select **Status**. The agent's status and the reason for the error will be displayed.

   :::image type="content" source="media/rdp-no-highlight/agent-disconnected-icon.png" alt-text="Screenshot of the agent icon showing the Power Automate agent for virtual desktops is disconnected.":::

3. If the agent is confirmed not running and Citrix is in use, ensure that the agent is installed on every Citrix server.

4. If the agent is running, check the following conditions based on the agent's tray icon status:

   - **A device on the system is not functioning**: The Citrix plugin isn't loaded on the host system.

     To troubleshoot the issue, run the [troubleshooter](/power-automate/desktop-flows/troubleshooter) while the virtual desktop platform is active and check for errors in the **UI Automation** section.

   - **Citrix Virtual Channel policy enabled**: The **Virtual channel allow list** policy on Citrix is set to **Enabled** or **Default**.

     The default setting for this policy is **Enabled** or **Default**. However, if this policy isn't disabled, the Power Automate agent can't communicate with Power Automate for desktop. To resolve communication issues, work with your Citrix administrator to set the policy to **Disabled** and ensure Citrix machines are restarted after applying the policy.

   - **Citrix VDA version < 2407**: The **Virtual channel allow list** policy on Citrix is set to **Enabled** or **Default**.

     The default setting for this policy is **Enabled** or **Default**. However, if this policy isn't disabled, the Power Automate agent can't communicate with Power Automate for desktop. To resolve communication issues, work with your Citrix administrator to set the policy to **Disabled** and ensure Citrix machines are restarted after applying the policy.

   - **Citrix VDA Version >= 2407**: The older **Virtual channel allow list** policy can remain at **Default**, but a different policy must be set.

     Set the **Virtual channel allow list for DVC** policy with the following values:

      - `C:\Program Files (x86)\Power Automate agent for virtual desktops\PAD.RDP.ControlAgent.exe,Microsoft.Flow.RPA.Desktop.UIAutomation.RDP.DVC.Plugin,PAD\CONTROL`

      - `C:\Users\*\AppData\Local\Microsoft\Power Automate Desktop\RDP Automation Agents\*\PAD.RDP.AutomationAgent.exe,Microsoft.Flow.RPA.Desktop.UIAutomation.RDP.DVC.Plugin,PAD\UIA`

      Ensure Citrix machines are restarted after applying the policy.

## More information

[Automate on virtual desktops](/power-automate/desktop-flows/virtual-desktops)

[!INCLUDE [Third-party disclaimer](../../../../../includes/third-party-disclaimer.md)]
