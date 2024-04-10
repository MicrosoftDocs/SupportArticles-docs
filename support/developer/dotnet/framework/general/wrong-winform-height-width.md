---
title: Form height and width changes with VS 2012
description: WinForms application developers may notice that the Height and Width of some Forms changes when running under the Visual Studio 2012 debugger. This article provides a resolution for this problem.
ms.date: 05/08/2020
ms.reviewer: kevinh
---
# Form height and width changes with Visual Studio 2012

This article helps you resolve the incorrect height and width of some forms when you debug WinForms applications in Visual Studio 2012.

_Original product version:_ &nbsp; Visual Studio Premium 2012  
_Original KB number:_ &nbsp; 2877623

## Symptoms

Developers debugging existing WinForms applications (targeting .NET 4.0 or an older version) or upgrading those applications to target .NET 4.5 (or a newer version) may notice changes in the Height and Width of some Forms.

*Example of original behavior:*

:::image type="content" source="./media/wrong-winform-height-width/original-form.png" alt-text="Screenshot shows the original behavior of some forms." border="false":::

*Example of new behavior*:

:::image type="content" source="./media/wrong-winform-height-width/new-form.png" alt-text="Screenshot shows the new behavior of some forms." border="false":::

## Cause

In order to take advantage of new Windows operating system features, a decision is made to change all Visual Studio processes to use Windows subsystem version 6.00. Also, new applications targeting .NET 4.5 or a newer version will target Windows subsystem version 6.00 (or greater) by default.

## Resolution

Developers who are impacted by incorrect Form Height and Width when executing under the Visual Studio debugger may work around the issue by turning off the Visual Studio Debugger Hosting Process (vshost). This may be accomplished by doing one of the following:

- Uncheck **Enable the Visual Studio hosting process** in the project's properties (select **Project Properties** > **Debug** tab)
- Set the environment variable `UseVSHostingProcess` to false before starting Visual Studio.

Developers who change their application to target .NET 4.5 or a newer version may need to either:

- Change their source code to account for the differences in Form Height and Width.
- Specify subsystem version 4.00 by adding `<SubsystemVersion>4.00</SubsystemVersion>` to their project file or by using the **/subystemversion: 4.00** compiler switch.

## More information

Disabling the Visual Studio hosting process may have a negative impact on the debugger startup performance.
