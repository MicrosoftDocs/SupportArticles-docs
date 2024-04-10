---
title: Behind dialog box appears SmartCard PIN
description: This article introduces the problem that the interface of the modal dialog box and the SmartCard PIN prompt in the web page can't interact.
ms.date: 06/09/2020
ms.reviewer: apinho
---
# SmartCard PIN prompt appears behind modal dialog box in Internet Explorer 9 and later versions

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a solution to fix the problem that the password can't be typed when the smart card pin is prompted by changing the registry.

_Original product version:_ &nbsp; Internet Explorer 9 and later versions  
_Original KB number:_ &nbsp; 2701897

## Symptoms

Consider the following scenario:

- You are using Internet Explorer 9 and later versions.
- You have a webpage that launches a modal dialog box.
- From this modal dialog box, a SmartCard PIN prompt is shown for the user to type in their password.
In these conditions, the SmartCard prompt appears behind the modal dialog box and no user interaction is possible at this point.

## Workaround

To work around this issue, disable Hang Resistance in Internet Explorer by creating the following registry key:

```console
HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\  
Type: REG_DWORD  
Name: HangRecovery  
Value: 0`
```
