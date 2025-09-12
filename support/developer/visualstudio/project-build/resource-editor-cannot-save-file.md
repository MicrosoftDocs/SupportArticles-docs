---
title: Visual Studio 2012 can't save file
description: This article describes the problem that VS 2012 can't save file while using Resource Editor, and provides a solution.
ms.date: 04/23/2020
ms.reviewer: ScotBren, NSuhas
ms.custom: sap:Project - Build System\Project Settings
---
# Visual Studio 2012 can't save file while you use Resource Editor

This article helps you resolve the problem where Microsoft Visual Studio 2012 can't save file while you edit a Visual C++ project.

_Original product version:_ &nbsp; Visual Studio Premium 2012, Visual Studio Ultimate 2012  
_Original KB number:_ &nbsp; 2839032

## Symptoms

You're using Visual Studio 2012, where you're editing a Visual C++ project and making changes to a dialog in the Resource Editor. An unexpected message box appears with the error message:

> Cannot save file.

:::image type="content" source="./media/resource-editor-cannot-save-file/error-message.png" alt-text="Screenshot of the Can't save file error dialog." border="false":::

## Cause

There's an issue with how the **AutoRecover** feature is interacting with the Resource Editor. When the **AutoRecover** interval expires, if the resource isn't saved, **AutoRecover** tries to it.

> [!NOTE]
> The default interval is every 5 minutes.

During saving the resource file, it tries to save a file named *resource.hm*. The *resource.hm* is used when you're using Context-Sensitive Help, an option when generating a native UI project. When you enable it, it creates help IDs that get written to the help ID header file, *resource.hm*. There won't be any *resource.hm* unless you enable the **Help ID** property for one or more of your resources.

## Resolution

1. Avoid **AutoRecover** save of edited resources.

    1. Disable the **AutoRecover** option in **Tools** > **Options** > **Environment** > **AutoRecover**, by unselecting the **Save AutoRecover information every:** checkbox:

        :::image type="content" source="./media/resource-editor-cannot-save-file/uncheck-save-autorecover-information-every-option.png" alt-text="Screenshot of the Options window to clear the Save Auto Recover information every checkbox." border="false":::

    1. Save your edited resources within the specified interval to avoid the triggering of Auto-Save. You may increase the interval, but this interval also increases the risk of losing unsaved work.

2. Don't use context-sensitive help.

    1. If you aren't using context help ID, then turning that off for every control would be the easiest solution. Turning it off from the resource editor would be safest. In the resource editor, check for all the controls and one of the properties will be **Help ID**. Set it to **False** for every control where it's **True**.

        :::image type="content" source="./media/resource-editor-cannot-save-file/set-help-id-to-false.png" alt-text="Screenshot of the Properties window under the Resource View tab with Help ID highlighted." :::

    2. Instead you could edit the .rc file directly. For instance, removing the last parameter here for every control with a **Help ID** would turn off the feature:

        > DEFPUSHBUTTON "OK",IDOK,103,31,50,14,WS_GROUP,0,HIDOK
