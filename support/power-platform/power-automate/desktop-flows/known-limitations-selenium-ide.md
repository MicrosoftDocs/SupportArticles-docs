---
title: Known limitations of Selenium IDE
description: Describes the known limitations of Selenium IDE.
ms.reviewer: ashvinis, gtrantzas
ms.date: 02/24/2023
ms.subservice: power-automate-desktop-flows
---
# Known limitations of Selenium IDE

> [!IMPORTANT]
>
> - Selenium IDE is deprecated and no longer works as of February 28, 2023.
> - Windows recorder (V1) is deprecated and no longer works.
> - Migrate your flows created with these solutions to Power Automate for desktop or delete them.

This article describes the known limitations of Selenium IDE.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555954

## Unsupported Commands

These Selenium IDE commands aren't supported:

- run
- answer on next prompt
- choose cancel on next confirmation
- choose cancel on next prompt
- choose ok on next confirmation
- debugger
- click at
- double-click at
- echo
- mouse out
- mouse up at
- mouse down at

## Right Click

Mouse right click isn't supported.

## Temporary user profile for playback

Selenium IDE recordings are made with the current User Profile, but playback is done using a temporary User Profile. Which means that some websites that need authentication won't ask for credentials during record session, but the authentication steps will be needed during playback. To address it, the user needs to manually edit the script to insert the commands required for the sign-in process.

## One test only supported

One test in each Selenium IDE project is supported by web UI flow.

## For Each command

Extra Selenium IDE flow input will be generated if you use for each command. It's a known issue. You can input any value into the extra field. It doesn't impact the playback.

## Frame Index

Selenium IDE flow might fail to run through the flow if there are some lazy-loaded frames. The recording might playback successfully while testing through the Selenium IDE and might fail while running through the Power Automate infrastructure. Selenium IDE identifies frames by the order they were loaded rather than the actual element order in the document. Playback at runtime selects the frame with the element order index, and it might not match with the Selenium IDE recording index, and the playback can fail. Use a better CSS selector for identifying the frame and parent frame.

## Local Playback vs. Playback through Power Automate infrastructure

Local Playback through Selenium IDE might not behave as intended in some scenarios because of discrepancies between Selenium IDE and Webdriver. However, playback at runtime through Power Automate infrastructure might behave correctly.
