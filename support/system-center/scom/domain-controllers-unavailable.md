---
title: Domain controllers are unavailable or Not Monitored
description: Fixes an issue that causes domain controllers to appear unavailable (dimmed) in the System Center Operation Manager console.
ms.date: 04/15/2024
---
# Domain controllers are unavailable in the Operations Manager console when no client agent is installed

This article helps you fix an issue where some domain controllers are unavailable or in a **Not Monitored** state in the Operations Manager console.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager, System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 3068465

## Symptoms

In the System Center Operations Manager admin console, some domain controllers are unavailable (appear dimmed) or in a **Not Monitored** state.

## Cause

This behavior may occur if the Management Pack for Active Directory is installed and if the domain controllers in question don't have the Operations Manager client agent installed. Active Directory Topology Discovery tries to discover all domain controllers regardless of whether the agent is installed.

## Resolution

To resolve this issue, install the Operations Manager client agent on the domain controllers, or enable agent-only discovery in Operations Manager.

To enable agent-only discovery in Operations Manager, follow these steps:

1. Open the Operations Manager console, and then select **Authoring**.
2. Expand **Management Pack Objects**, and then select **Object Discoveries**.
3. Select **Scope** on the console toolbar.
4. In the **Scope Management Pack Objects** dialog box, select **View all targets**, select the **Active Directory Forest** check box, and then click **OK**. The UI displays the **AD Topology Discovery** object.
5. Right-click **AD Topology Discovery**, select **Overrides**, select **Override the Object Discovery**, and then select **For all objects of class: Root Management Server**.
6. Select the **Override** box that corresponds to **Discovery Agent Only** in the **Parameter Name** column.
7. Change the **Override Value** to **True**, and then select the box in the **Enforced** column.

    > [!IMPORTANT]
    >
    > - If Windows PowerShell is installed in a location other than the default location, select the **Override** box that corresponds to the `PowershellInstallPath` parameter, and then edit the **Override Setting** option to point to the correct PowerShell location. Remember to enclose the path in double quotation marks.
    > - If Operations Manager is installed in a location other than the default location, select the **OpsMgrInstallPath** check box, and then edit the **Override Setting** option to point to the correct Operations Manager location. Remember to enclose the path in double quotation marks.

8. Run the command `Remove-SCOMDisabledClassInstance`, and then press **Y** when you're prompted.
