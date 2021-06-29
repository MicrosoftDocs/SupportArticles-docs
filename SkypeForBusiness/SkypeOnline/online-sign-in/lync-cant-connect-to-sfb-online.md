---
title: Lync 2013 or Lync 2010 can't connect to Skype for Business Online Service
description: You can't connect to the Microsoft Skype for Business Online service when you're using Microsoft Lync 2013 or Microsoft Lync 2010. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
- Lync 2013
- Lync 2010
---

# Lync 2013 or Lync 2010 can't connect to the Skype for Business Online service because a proxy is blocking connections from MSOIDSVC.exe

## Problem

You may experience the following issues in Lync: 

- Lync 2013 or Lync 2010 can't connect to the Skype for Business Online (formerly Lync Online) service through a proxy that is configured by using a file://-based Proxy Auto-Configuration (PAC) file.   
- You can't connect to the Skype for Business Online service when you're using Lync 2013 or Lync 2010. When you view Network Monitor, traces show multiple TCP SYNC requests for login.microsoftonline.com.

    ![Screen shot of network monitor, showing multiple TCP sync request for login.microsoft.com ](./media/lync-cant-connect-to-sfb-online/network-monitor.jpg)   

## Solution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Method 1 (for end-users): Change the proxy settings in Internet Explorer

To resolve this issue, take one of the following actions in Internet Explorer: 

- Click to select the **Use automatic configuration script** option, and then configure an HTTP-based proxy PAC file.    
- Click to select the **Automatically Detect Settings** option, and then deploy Web Proxy Auto-Discovery (WPAD).   

To do this, follow these steps:

1. Start Internet Explorer.   
2. Click **Tools**, and then click **Internet options**.   
3. Click the **Connections** tab, and then click **LAN Settings**.   
4. In the Local Area Network (LAN) Settingsdialog box, click to select either **Automatically Detect Settings** or **Use automatic configuration script**, depending on your network configuration. 

    For more information about how to configure an HTTP-based proxy PAC file, go to the following Microsoft website: [Automatic Detection and Configuration of Browser Settings](https://technet.microsoft.com/library/dd361887.aspx)

    For more information about how to deploy WPAD, go to the following Microsoft website: [Configuring Web proxy clients to automatically detect a Forefront TMG server](/previous-versions/tn-archive/cc995139(v=technet.10))   
5. Click **OK**, and then click **OK** again.   

### Method 2 (for admins): Create an application entry for Msoidsvc.exe in TMG

To resolve this issue for Microsoft Forefront Threat Management Gateway (TMG), create an application entry for Msoidsvc.exe. To do this, follow these steps:

1. In the left pane, click Networking.   
2. Click the Network tab. Under the Tasks tab in the right pane, click Configure Forefront TMG Client Settings.   
3. In the Forefront TMG Client Settings dialog box, click New.   
4. In the Application Entry Setting dialog box, configure the following rules:

    |Application|Key|Value|
    |---|---|---|
    |msoidsvc|Disable|0|
    |msoidsvc|DisableEx|0|

> [!NOTE]
> The same application settings can be applied to other firewalls. Additionally, your firewall server may require a firewall client to be installed on the end-user's computer.

## More Information

This issue occurs when the Microsoft Online Services Sign In Assistant traffic doesn't go through the TMG firewall client, and a direct connection is attempted.

For example, this issue may occur in a scenario where all the following conditions are true:

- Proxy Server Automatic Discovery isn't enabled.   
- A proxy server isn't configured in Internet Explorer.   
- The **Automatically detect settings** option isn't enabled in Internet Explorer.

    > [!NOTE]
    > The only location that the Lync and Skype for Business clients use to detect network proxy configuration information is in the **LAN settings** option on the **Connections** tab in **Internet options**.   

For more information about the WinHTTP limitations of supporting a file-based proxy, see [WinHTTP AutoProxy Support](/windows/win32/winhttp/winhttp-autoproxy-support).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).