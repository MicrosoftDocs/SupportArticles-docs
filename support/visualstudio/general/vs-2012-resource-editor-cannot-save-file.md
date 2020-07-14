---
title: Visual Studio 2012 can't save file
description: This article describes the problem that VS 2012 can't save file while using Resource Editor, and provides a solution.
ms.date: 04/23/2020
ms.prod-support-area-path:
ms.reviewer: ScotBren, NSuhas
---
# Visual Studio 2012 can't save file while you use Resource Editor

This article helps you resolve the problem that Microsoft Visual Studio 2012 can't save file while you edit a Visual C++ project and make changes to a dialog in the Resource Editor.

_Original product version:_ &nbsp; Visual Studio Premium 2012, Visual Studio Ultimate 2012  
_Original KB number:_ &nbsp; 2839032

## Symptoms

You're using Visual Studio 2012, where you're editing a Visual C++ project and making changes to a dialog in the Resource Editor. An unexpected message box appears with the error message:

:::image type="content" source="./media/vs-2012-resource-editor-cannot-save-file/error-message.png" alt-text="Can't save file error" border="false":::

## Cause

There's an issue with how the **AutoRecover** feature is interacting with the Resource Editor. When the resource being edited hasn't been saved when the **AutoRecover** interval expires (the default is every 5 minutes), **AutoRecover** tries to save the resource files. During this, it tries to save a file named *resource.hm*. *Resource.hm* is used when you're using Context-Sensitive Help, an option when generating a native UI project. When you have it enabled, it creates help IDs that get written to the help ID header file, *resource.hm*. There won't be any *resource.hm* unless you enable the **Help ID** property for one or more of your resources.

## Resolution

1. Avoid **AutoRecover** save of edited resources.

    1. Disable the **AutoRecover** option in **Tools** > **Options** > **Environment** > **AutoRecover**, by un-checking the **Save AutoRecover information every:** checkbox:

        :::image type="content" source="./media/vs-2012-resource-editor-cannot-save-file/uncheck-save-autorecover-information-every-option.png" alt-text="unselected Save AutoRecover information every checkbox" border="false":::

    1. Save your edited resources within the specified interval to avoid the triggering of Auto-Save. You may increase the interval, but this also increases the risk of losing unsaved work.

2. Don't use context-sensitive help.

    1. If you aren't using context help ID, then turning that off for every control would be the easiest solution. Turning it off from the resource editor would be safest. In the resource editor, check for all the controls and one of the properties will be **Help ID**. Set it to **False** for every control where it's **True**.

        :::image type="content" source="./media/vs-2012-resource-editor-cannot-save-file/set-help-id-to-false.png" alt-text="Control properties Help ID" :::

    2. Alternatively you could edit the .rc file directly. For instance, removing the last parameter here for every control with a **Help ID** would turn off the feature:

        > DEFPUSHBUTTON "OK",IDOK,103,31,50,14,WS_GROUP,0,HIDOK
