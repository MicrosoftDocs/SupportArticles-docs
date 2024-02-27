---
title: Outlook crashes when creating a new profile
description: Provides a resolution to solve the crash issue when you try to create a new profile in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook 2016 crashes when creating a new profile

_Original KB number:_ &nbsp; 3119083

## Symptoms

When you try to create a new Microsoft Outlook 2016 profile, Outlook crashes. Additionally, in the Application log, you may find one or more of the following crash signatures in event ID 1000:

| Application name| Application version| Module name| Module version| Offset |
|---|---|---|---|---|
|rundll32.exe|10.0.10586.0|olmapi32.dll|16.0.4291.1000|0x0016D79B|
|rundll32.exe|10.0.10586.0|olmapi32.dll|16.0.6001.1038|0x0016EB2E|
|rundll32.exe|10.0.10240.16384|olmapi32.dll|16.0.4266.1001|0x0016D8F4|
|rundll32.exe_Shell32.dll|10.0.10586.0|olmapi32.dll|16.0.4291.1000|0x00000000001DA07D|
|rundll32.exe_Shell32.dll|10.0.10586.0|olmapi32.dll|16.0.4291.1000|0x00000000001D8DD1|
|outlook.exe|16.0.4266.1001|olmapi32.dll|16.0.4266.1001|0x0016D8F4|
|outlook.exe|16.0.6001.1038|olmapi32.dll|16.0.6001.1038|0x0016EB2E|
|outlook.exe|16.0.4300.1000|olmapi32.dll|16.0.4291.1000|0x0016D79B|
|outlook.exe|16.0.4288.1000|olmapi32.dll|16.0.4288.1000|0x00169596|
|outlook.exe|16.0.4266.1001|olmapi32.dll|16.0.4266.1001|0x00000000001D9071|
|outlook.exe|16.0.4288.1000|olmapi32.dll|16.0.4288.1000|0x00000000001DA66D|

## Cause

This issue can occur in the following scenario:

- You run Outlook 2016 on Windows 10.
- You have a proxy server configured in Internet Explorer.
- You have **Folder Redirection** enabled.
- You are missing the `ProxySettingsPerUser` registry data.

## Resolution

To resolve this issue, follow these steps to add the missing registry data.

1. Exit Outlook.
2. Start Registry Editor. To do this, press Windows Key+R to open a **Run** dialog box. Type *regedit.exe* and then press **OK**.
3. In Registry Editor, locate and then select the following subkey in the registry:

   `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\`

4. On the **Edit** menu, select **New**, and then select **DWORD (32-bit) Value**.
5. Type the following as the name of the new value, and then press Enter.

   `ProxySettingsPerUser`

6. Double-click the `ProxySettingsPerUser` value, and then enter one of the following values in the **Value Data** text box, as appropriate for your computer, and then select **OK**.

   1 - Proxy applied per user  
   2 - Proxy applied for all users on the computer

7. Exit Registry Editor.

If you continue to experience this issue after following the steps above, follow these steps:

1. In Internet Explorer, select the **Tools** button ![Tools button](./media/outlook-crashes-when-creating-a-new-profile/tools-button.png), and then select **Internet Options**.
2. On the **Connections** tab, select LAN settings.
3. Remove the check for **Automatically detect settings**.
4. Select **OK** two times.

This setting can also be configured by using the following registry data:

Path: `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings`  
DWORD: AutoDetect  
Value: 0

## More information

To determine whether Internet Explorer is configured to use a Proxy Server, follow these steps.

1. Open Internet Explorer.
2. Select the **Tools** button :::image type="icon" source="./media/outlook-crashes-when-creating-a-new-profile/tools-button.png" border="false":::, and then select **Internet Options**.
3. On the **Connections** tab, select your connection (if there are multiple connections), and then select **Settings**.
4. If you have a Proxy Server configured, the **Use a proxy server for this connection** setting will be enabled, as shows in the following screenshot.

   :::image type="content" source="media/outlook-crashes-when-creating-a-new-profile/use-a-proxy-server-for-this-connection.png" alt-text="Screenshot of Internet Explorer Proxy Settings." border="false":::
