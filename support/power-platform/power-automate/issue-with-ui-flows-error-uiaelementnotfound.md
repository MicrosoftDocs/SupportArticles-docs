---
title: Issue with UI flows error UIAElementNotFound
description: Provides a resolution to solve the UIAElementNotFound error during UI flows running.
ms.reviewer: priyase
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: power-automate-flows
---
# Issue with UI flows UIAElementNotFound error

This article provides steps to solve the **UIAElementNotFound** error that occurs when running UI flows.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555804

## Symptoms

When trying to run UI flows, you may see this error:

> UIAElementNotFound.

:::image type="content" source="media/issue-with-ui-flows-error-uiaelementnotfound/error-message.png" alt-text="Screenshot of the error message when running the U I flows." border="false":::

## Verifying issue

This error occurs if your UI flows has the property **Use coordinates** set to **true** and UI flows is unable to locate the element using coordinates and the display resolution and scale on your playback machine does not match the scale and resolution of the machine on which the UI flows was recorded. The issue can be verified by following these steps:

1. Select and expand the Launch \<Application Name> step in your UI flow.
1. Select the **Show more** link.

    :::image type="content" source="media/issue-with-ui-flows-error-uiaelementnotfound/show-more.png" alt-text="Screenshot to select the Show more link in the Launch Instrumented WinForms window.":::

1. Verify that the properties Screen width, Screen height, Screen scale matches the display settings in your PC (shown in next step).

    :::image type="content" source="media/issue-with-ui-flows-error-uiaelementnotfound/properties.png" alt-text="Screenshot to check that the Screen width, Screen height, Screen scale match the display settings in your PC.":::

1. Display Settings in your PC [View display settings in Windows 10](https://support.microsoft.com/windows/view-display-settings-in-windows-10-37f0e05e-98a9-474c-317a-e85422daa8bb)

    :::image type="content" source="media/issue-with-ui-flows-error-uiaelementnotfound/display-setting.png" alt-text="Screenshot to check the Display Settings in your PC.":::

## Solving steps

1. If your UI flows has the property **Use coordinates** set to **true**, it is required that the screen resolution & scale while recording should be the same as the screen resolution & scale during playback.
2. Keep the app maximized while recording to get an optimum performance.
