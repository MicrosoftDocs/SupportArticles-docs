---
title: Word template option missing in Report destination window
description: Word template option missing in Report destination window when printing in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Word template option missing in Report destination window when printing in Microsoft Dynamics GP

This article provides a resolution for the issue that the word template option is missing in the Report destination window when printing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4502006

## Symptoms

When printing, the **Template** option is missing in the Report destination window. For Report type, only standard is listed.

## Cause

They can be several causes. See below troubleshooting steps in Resolution section. Refer to the original [Blog article](https://community.dynamics.com/blogs/post/?postid=65ce8906-8d71-481c-9318-96e5bdd7f838) for same information with screen prints.

## Resolution

Review the below troubleshooting steps, in no particular order:

1. Under **Reports** > **Template configuration**:

    1. Expand the **Enable All templates for all companies** and specify which specific templates you want enabled.
    2. Also, make sure the **Enable Report Templates** checkbox is marked at the bottom.

2. Make sure you have the **Dexterity Shared components** installed (and also the correct version for your Microsoft Dynamics GP installation.)

   (You can even try uninstalling and reinstalling the Dexitry shared components under Add/Remove programs.)

3. Check where the **Dynamics.exe** and **Dynamics.exe.config** are pulling from, and are not renamed:

    1. Right-click your Microsoft Dynamics GP shortcut and select **PROPERTIES**.
    2. Make sure the Dynamics.exe file is not renamed in the folder listed for the shortcut for the Target or Start infields in the GP Properties windows.

    > [!NOTE]
    > When using Citrix and utilizing a shared folder for dictionaries, make sure the Dynamics.exe.config file is listed there as well.

4. Verify the `ReportTemplatesEnables` of globals is set to **true**.

    1. Open the **Dex.ini** file in the Microsoft Dynamics GP code folder and add this tag. Save and restart GP.

        ```console
        ScriptDebugger=True
        ```

    2. In Microsoft Dynamics GP, select **DEBUG** in the menu and select **WATCH**.
    3. Enter *RerpotTempaletsEnabled of Globals* and **true**.

       (If it is **false**, make sure the Dynamics.exe.config in the GP code folder is there and not renamed.)

5. Another option is to **reinstall Microsoft Dynamics GP**.
6. Also **disable Windows firewall and/or Antivirus** softwardeto rule these out.

> [!NOTE]
> You may need to create an exception for the path to your GP code folder, and the %TEMP% folder to not be scanned during certain hours or to allow certain actions if your Antivirus is the cause.
