---
title: Reset Internet Explorer proxy settings
description: This article describes the situation that the user must reset Internet Explorer's proxy settings.
ms.date: 06/09/2020
ms.reviewer: 
---
# How to reset your Internet Explorer proxy settings

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides solutions on how to reset internet Explorer proxy settings when malicious software changes the proxy settings.

_Original product version:_ &nbsp; Internet Explorer 9, Internet Explorer 10, Internet Explorer 11  
_Original KB number:_ &nbsp; 2289942

## Summary

Malicious software may change Internet Explorer proxy settings, and these changes can prevent you from accessing Windows Update or any Microsoft Security sites.

## Cause

Certain strains of malicious software can prohibit a computer from being able to access Windows Updates or Microsoft Security Sites. For example, an attempt to access a Microsoft site, such as the following sites, results in being redirected to another page:

- `https://www.update.microsoft.com`
- `https://www.microsoft.com/security_essentials/`

## Resolution

To work around this problem, follow these steps to reset your Internet Explorer proxy settings:

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see: [322756](https://support.microsoft.com/help/322756).

1. On Windows XP, click **Start**, or on Windows Vista or Windows 7, click :::image type="icon" source="media/how-to-reset-proxy-settings/start-icon.png":::, and then click **Run**. On Windows 8 or Windows 8.1, to access the Run command, press the Windows logo key + R. Or, swipe in from the right edge of the screen, and then tap **Search** (or if you are using a mouse, point to the upper-right corner of the screen, move the mouse pointer down, and then click **Search**). Type *Run* in the search box, and then tap or click **Run**.
2. In the **Run** text box, copy (CTRL+C) and paste (CTRL+V) or type the following:  
`reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings /v ProxyEnable /t REG_DWORD /d 0 /f`
3. Click **OK**.
4. On Windows XP, click **Start**, or on Windows Vista or Windows 7, click :::image type="icon" source="media/how-to-reset-proxy-settings/start-icon.png":::, and then click **Run**. On Windows 8 or Windows 8.1, to access the Run command, press the Windows logo key + R. Or, swipe in from the right edge of the screen, and then tap **Search** (or if you are using a mouse, point to the upper-right corner of the screen, move the mouse pointer down, and then click **Search**). Type Run in the search box, and then tap or click **Run**.
5. In the **Run** text box, copy (CTRL+C) and paste (CTRL+V) or type the following:  
`reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings /v ProxyServer /f`
6. Click **OK**.

## More information

For more information about how to protect your computer from viruses or other malicious software, see [How to prevent and remove viruses and other malware](https://support.microsoft.com/help/129972/how-to-prevent-and-remove-viruses-and-other-malware).

For more information about antivirus software vendors, see [List of antivirus software vendors](https://support.microsoft.com/help/49500/list-of-antivirus-software-vendors).
