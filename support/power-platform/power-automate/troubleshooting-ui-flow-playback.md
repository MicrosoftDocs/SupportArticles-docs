---
title: Troubleshooting UI Flow Playback
description: Describes how to troubleshoot UI flow Playback.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Troubleshooting UI flow Playback

This article describes how to troubleshoot UI flow Playback.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555949

## Symptoms

Fail to run a UI flow.

## Verifying issue

- Check [Known issues and Solutions](/power-automate/desktop-flows/create-desktop#known-issues-and-solutions)

## Solving steps

If the scenario isn't mentioned above, you can try if the following steps help to resolve the issue:

- Make sure not to touch keyboard or mouse during playback.
- Make sure the keyboard is the same as recording during playback. [Troubleshoot UI flow Playback - KeyboardIdMismatch](https://support.microsoft.com/help/4555907)
- Check if the Application has been launched correctly during playback. [Troubleshoot UI flow Playback - Unable To Launch Application](https://support.microsoft.com/help/4555721)
- Check recording to see if same actions are done twice.

    1. Find your UI flow in Power Automate portal, and edit your UI flow steps.

        :::image type="content" source="./media/troubleshooting-ui-flow-playback/edit-your-ui-flow.png" alt-text="UI flow list page.":::

    2. Extend script and select the step (in following picture, select **LeftClick2**), you can check the screenshot to see if there's any duplicate recording.

        :::image type="content" source="./media/troubleshooting-ui-flow-playback/record-edit-steps.png" alt-text="Edit steps.":::
  
    3. For UIA Element Not Found issue, it might be caused by various reasons, try to enable coordinate based playback. [Issue with UI flows - UIAElementNotFound](https://support.microsoft.com/help/4555804)

## Tips and tricks

Playback

- Don't use the keyboard and mouse during playback.
- Try to adjust your app has the same initial state as the recording time.
- Use the same keyboard and locale setting as recording time.
- If you're using coordinate offset fallback
  - Current coordinate-based fallback is conservative and ensures the control is the same as what was recorded, including the size.
  - Use the same resolution and scale setting as recording time.
  - Maximize the app size to minimize disruption.

Recording

- Ensure the same keyboard layouts you're using to record will be the same as for playback.
- Use shortcuts instead of selecting. For instance, copy paste with ctrl + c & ctrl + v instead of right-click copy.
- Use **enter static text** if you're working with strings for better readability.
- When you insert text into a field already have text inside, you should select ctrl+A and backspace to clear up the field first.
- Playback uses accessibility by default, it can fallback to coordinate as well if you turn it on.
  - Use a standard resolution, and scale setting that across your recording and playback devices.
  - Maximize the application window that you're recording.
  - Finish the recording in one monitor if possible.
