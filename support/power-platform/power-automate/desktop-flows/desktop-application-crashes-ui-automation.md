---
title: Desktop application crashes due to the UI automation of Power Automate for desktop
description: Provides a workaround for an issue where the execution of a UI automation action using Power Automate for desktop causes the desktop application being interacted with to crash.
ms.reviewer: nimoutzo
ms.date: 03/20/2024
ms.custom: sap:Desktop flows\UI or Browser automation issues
---
# A desktop application crashes due to the execution of UI automation of Power Automate for desktop

This article provides a workaround for the issue that might cause certain desktop applications to crash during execution of a UI automation action using Power Automate for desktop.

## Prerequisites

- Power Automate for desktop version 2.42 or later has been installed on your machine.

## Symptoms

- When you launch the Power Automate for desktop recorder or the UI element picker, and try to hover over a UI element in a specific desktop application, the desktop application crashes.
- When a UI automation action is being executed and interacting with a UI element in a specific desktop application, the desktop application crashes.

## Workaround

In the Power Automate for desktop installation folder, create a new configuration file with key and value pairs that disable monitoring of element focus changes and window state changes on the desktop.

### Before creating the configuration file

Before creating the configuration file, make sure that Power Automate for desktop and all its components aren't running. To do this, open **Task Manager**, go to the **Details** tab, and sort the processes by name. Confirm that no process related to Power Automate is currently active.

### How to create the configuration file

1. In **File Explorer**, go to the `%LOCALAPPDATA%\Microsoft\Power Automate Desktop` folder.
2. Check if a folder named *Configurations* exists. If not, create it.
3. Create a new file with the name *UIAutomation.config* in the *Configurations* folder.
4. Copy the following XML code into the file. Add the key and value pairs to the `appSettings` section as shown in the following example. For more information about the rules followed by each XML configuration item, see [Key values editing](#key-values-editing).

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

### Key values editing

- `UIA3.DisableFocusEvent`: Makes Power Automate for desktop stop monitoring element focus changes on the desktop. Disabling the focus-changed event can help resolve the application crash issues.
  - Possible values:
    - `true`: The focus event is disabled.
    - `false`(default): The focus event remains enabled.
- `UIA3.DisableWindowStateEvent`: Makes Power Automate for desktop stop monitoring window state changes on the desktop. The window state changes could be things like minimizing or maximizing the window. Disabling the window state change event can help resolve the application crash issues.
  - Possible values:
    - `true`: The window state change event is disabled.
    - `false`(default): The window state change event remains enabled.

### Sample XML configuration file

```xml
<?xml version="1.0" encoding="utf-8" ?>
    <configuration>
        <appSettings>
			<add key="UIA3.DisableFocusEvent" value="true" />
			<add key="UIA3.DisableWindowStateEvent" value="true" />
       </appSettings>
    </configuration>
```
