---
title: Using the internal troubleshooter to comprehensively diagnose Citrix/RDP automation issues
description: This article guides the user to use the internal troubleshooter to diagnose issues related to Citrix/RDP automation
ms.reviewer: amitrou
ms.author: iopanag
author: iopanag
ms.custom: sap:Desktop flows\UI or browser automation
ms.date: 03/28/2025
---
# Using the internal troubleshooter to comprehensively diagnose Citrix/RDP automation issues

The internal RDP troubleshooter is a tool shipped with Power Automate to help diagnose issues related to Citrix/RDP automation when other methods to not help.

## When to use
When the normal Power Automate troubleshooter does not help or you need something more granular troubleshooting:

- You need step by step troubleshooting to pinpoint where the issue is.
- Need to forcefully check or re-register the Power Automate RDP Plugin.
- Get Information about the RPD/Citrix Window

## How to access the tool
The tool is inside the Power Automate installation folder. Depending on the installation type, the you may find it in different locations:
- On MSI installations (Power Automate installed used the setup executable) it is usually in **C:\Program Files (x86)\Power Automate Desktop\dotnet\PAD.RDP.TroubleShooter.exe**. If the user used a different installation directory, they should find it in the respective folder under the **dotnet\PAD.RDP.TroubleShooter.exe** subfolder.
- On Power Automate installed from the MS store, open the Windows **Task Manager** and locate the **PAD.Console.Host.exe** on the **Details** tab. Right click it and select **Open file location**. Then find the **PAD.RDP.TroubleShooter.exe**.

## The main window details

   :::image type="content" source="media/using-internal-troubleshooter/internal-troubleshooter.png" alt-text="Screenshot of the Power Automate internal RDPtroubleshooter with highlighted its elements with numbers.":::

> [!NOTE]
> The checkboxes in the window are read-only. These are automaticaly checked when performing certain tests. See the `How to use it to perform step-by-step troubleshooting` on how to perform the checks.

1. Click to get into Window Capturing mode. You can highlight a window while in this mode and Ctrl+Click will capture it. Use it to Capture a RDP/Citrix window/app.
2. Click this to refresh the information about the captured window.
3. If this is checked, then it means this specific window can be used for RDP/Citrix automation.
4. If this is checked, then it means the captured window has the PAD RDP/Citrix plugin loaded.
5. Click this to check if the Power Automate RDP/Citrix plugin is properly registered.
6. Click this to force register the RDP/Citrix for RDP/Citrix clients.
7. Click this to force un-register the RDP/Citrix for RDP/Citrix clients.
8. If this is checked, then the RDP/Citrix has the control channel open. This means that the agent is running on the remote session and has connected.
9. Click this to test if the connection with the remote agent is working.
10. Click this to command the agent to start the agent agent that is required to perform automations. This may prompted for agent syncing.
11. If this is checked, then it means that the automation agent is connected.
12. Click this to test the connection with the automation agent of the agent.

## How to use it to perform step-by-step troubleshooting

1. Capture the affected RDP/Citrix window with the **Get Window (1)** button. After clicking the button, hovering over windows will highlight them. Hover over the affected RDP/Citrix window and click it while holding down the CTRL key on the keyboard to capture it.
2. After capturing, the following checkboxes should all be checked (automaticaly) to be able to perform RDP/Citrix automation. Troubleshooting is getting each checkbox automatically checked one after another by performing specific things. After each step, click the **Refresh data (2)** button.
3. If the **Is RDP Handled (3)** is unchecked after the capture, then it means wrong window was captured or this specific client is not supported.
4. After ensuring the previous is check is passed, then verify the state of **Plugin loaded (4)**. If it is not checked, then use the buttons 5-6 to check whether the plugin is properly registered or re-register if needed. After that restart the RDP/Citrix client and check again.
5. After ensuring the previous is checked, verify the state of **Control channel open (8)**. If it is not checked, then it means the Agent is not running on the remote side or it has trouble connecting with the Power Automate. Verify that the agent is running or check it's tray icon (on the remote deskop if it is a desktop or on the host machine if it is a virtual app) to see what error it produces. See more about this [here](./rdp-no-highlight.md). After fixing this you can test the connection by clicking the **Test connection (9)**. If it succeeds, then you can continue next, otherwise check the error and check additional RPD/Troubleshooting Troubleshooting Guides. Usually the error is about incompatible agent and might require both Power Automate and Agent to be on the latest version.
6. After ensuring the previous is check is passed, click the **Start Automation Agent (10)** to start the automation agent. If a prompt is shown for syncing, sync the agent and start it again. If an error is shown, then check the error and check additional RPD/Troubleshooting Guides. Usually error might be about the user not having access to run the agent from the Local AppData folder.
7. Verify the state of **Automation channel open**. If it is checked, click the **Test connection (12)** to verify the connection. If it succeeds, then automation can work. If not, check the remote machines Event Viewer logs for potential crashes or get some debug logs ([How To](./collecting-debug-logs.md)).