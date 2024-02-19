---
title: Handle issues with apps that are crashing with UI automation of Power Automate for desktop
description: Provides a resolution for cases that the execution of UI automation with Power Automate for desktop causes the desktop application that is being interacted with to crash.
ms.reviewer: nimoutzo
ms.date: 02/19/2024
ms.subservice: power-automate-desktop-flows
---

# Handle issues with a desktop application that crashes due to the execution of UI automation of Power Automate for desktop

This article provides a resolution to the crashing issues in applications that Power Automate for desktop interacts with using UI automation.

## Prerequisites

- Power Automate for desktop version 2.42 or later has been installed in your machine.

## Symptoms

- When user launches the Power Automate for deskttop recorder or the UI element picker and tries to hover over a UI element in a specific desktop application, the desktop application crashes.
- When a UI automation action is being executed and interacts with a UI element in a specific desktop application, the desktop application crashes.

## Resolution

Create a new configuration file in Power Automate for desktop installation folders.

## Before creating the configuration file

Before creating the configuration file, it's crucial to make sure that Power Automate for desktop and all its components aren't running. To do this, open Task Manager, go to the **Details** tab, and sort the processes by name. Check that no process related to Power Automate is currently active.

## How to create the configuration file

1. In File Explorer, go to the `%LOCALAPPDATA%\Microsoft\Power Automate Desktop` folder.
2. Check if a folder named **Configurations** exists. If not, create it.
3. Create a new file with name *UIAutomation.config* inside the **Configurations** folder.
4. Copy the below XML code inside the file. Add the key and value pairs you need, inside the `appSettings` section as shown in the following example.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
      <appSettings>
          <!-- Please add here the key values for the configuration. See examples below:

          <add key="UIA3.DisableFocusEvent" value="true" />

          <add key="UIA3.DisableWindowStateEvent" value="true" />

           -->
      </appSettings>
</configuration>
```

5. Save the file.
6. Open Power Automate for desktop.

## Key values editing

Each XML configuration item follows these rules:
- Configurations that can help when an application crashes when automated with Power Automate:
  - `UIA3.DisableFocusEvent`: Makes Power Automate for desktop to stop watching for element focus changes on the desktop. Disabling this can help when an application crashes when automated with Power Automate.
    - Possible Values:
      - `true`: Disables the focus event
      - `false`(Default): Does not disable the focus event
  - `UIA3.DisableWindowStateEvent`: Makes Power Automate for desktop to stop watching for window state changes on the desktop. Window states changes including when a window is minimized/maximized etc. Disabling this can help when an application crashes when automated with Power Automate.
      - Possible Values:
          - `true`: Disables the window state change event
          - `false`(Default): Does not disable the window state change event

## Sample XML configuration file

```xml
<?xml version="1.0" encoding="utf-8" ?>
    <configuration>
        <appSettings>
			<add key="UIA3.DisableFocusEvent" value="true" />
			<add key="UIA3.DisableWindowStateEvent" value="true" />
       </appSettings>
    </configuration>
```
