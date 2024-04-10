---
title: User receives WebUI Oops error message in StorSimple
description: Describes an issue that User receives WebUI Oops error message in StorSimple.
ms.date: 11/01/2023
author: genlin
ms.author: genli
ms.service: azure-common-issues-support
ms.reviewer: 
---
# StorSimple: User receives WebUI "Oops" error message

_Original product version:_ &nbsp; StorSimple 5000/7000 Series, StorSimple Data Manager  
_Original KB number:_ &nbsp; 3024802

## Symptoms

When a user tries to log on to the WebUI or access certain pages in the WebUI in a StorSimple environment, the user receives an "Oops" error message.

## Cause

This issue occurs when the WebUI is frozen and needs to be restarted.

## Resolution

The web service has to be restarted. Use one of the following methods, depending on the software version of the StorSimple device.

If the StorSimple device is running software **earlier than version 2.1.1.454**, follow these steps:

1. Confirm that you can access the WebUI by using https (for example, enter "https://10.1.1.1" instead of "http://10.1.1.1").

    If you can access the WebUI by using https but not http, follow these steps:

    1. Log in to the StorSimple CLI by using ssh or a direct serial connection to the controller.
    2. Run the http off command, and then run http on .
    3. Log on to the WebUI, and then confirm that you no longer receive the error message.

2. If you receive the error message by using both http and https, or if the error persists after you run the http off and http on commands, open a support case at [StorSimple Support 5000 - 7000 Series](/previous-versions//mt179343(v=technet.10)). The StorSimple team will help you resolve the issue.
  
If the StorSimple device is running **version 2.1.1.454 or later**, follow these steps:

1. Log in to the StorSimple CLI by using ssh or a direct serial connection to the controller.
1. Run the web restart command:

    :::image type="content" source="media/storsimple-user-receives-webui/web-restart-command.png" alt-text="Screenshot shows the output of the web restart command.":::

1. Log on to the WebUI, and then confirm that you no longer receive the error message. If the error persists, open a support case at [StorSimple Support 5000 - 7000 Series](/previous-versions//mt179343(v=technet.10)).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
