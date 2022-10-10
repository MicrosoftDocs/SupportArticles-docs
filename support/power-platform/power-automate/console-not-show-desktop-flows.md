---
title: Power Automate for desktop console not showing any flows
description: Provides a resolution for the issue that the Power Automate for desktop console doesn't show any desktop flows.
ms.reviewer: pefelesk
ms.date: 9/21/2022
ms.subservice: power-automate-desktop-flows
---
# Power Automate for desktop console doesn't show any desktop flows

This article provides steps to make sure Microsoft Power Automate for desktop console can show the desktop flows as expected.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5003362

## Symptoms

The Power Automate for desktop console doesn't show any desktop flows in the **My flows** list.

## Verifying issue

1. In the Power Automate for desktop console, select the **Refresh** button to make sure that the desktop flows are still not shown.

2. Go to the [Power Automate Portal](https://flow.microsoft.com) and make sure that the desktop flows do exist in the **My flows** > **Desktop flows** section.

3. Make sure that the Proxy server is using automatic authentication with the user's Active Directory account (for example, Kerberos, Negotiate, or NTLM).

4. Make sure that you don't have to input your credentials each time you need to authenticate with the proxy server.

5. Verify that the Proxy server isn't a socks proxy server.

## Resolution

Right-click the Power Automate for desktop icon in the system tray and then exit Power Automate for desktop.

To solve this issue, take the following steps:

1. Make sure that you have administrator rights or someone who has such rights is available.
2. Navigate to the installation folder (_C:\Program Files (x86)\Power Automate Desktop_).
3. Back up the _PAD.Designer.Host.exe.config_ and _PAD.Console.Host.exe.config_ two files in order to recover them if something goes wrong.

4. For both files, edit each file with administrator rights, and at the end of the root xml node (\<configuration>), add the following child xml node:

    ```xml
     <system.net>
          <defaultProxy enabled="true" useDefaultCredentials="true"> 
          </defaultProxy> 
     </system.net>
    ```

5. Save the files.
6. Restart Power Automate for desktop.
