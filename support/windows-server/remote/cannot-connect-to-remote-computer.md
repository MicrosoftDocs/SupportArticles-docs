---
title: Can't connect to remote computer
description: Describes a workaround for an issue in which you cannot connect to a remote computer or start a remote application when you use TS Web Access or Remote Web Workspace. Occurs because of an ActiveX control issue.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:rdweb, csstroubleshoot
ms.technology: windows-server-rds
---
# You cannot connect to a remote computer or start a remote application when you use Terminal Services Web Access or Remote Web Workspace on a Windows XP SP3-based or Windows Small Business Server 2003 SP1-based computer

This article provides workarounds for an issue where you can't connect to a remote computer or start a remote application when you use TS Web Access or Remote Web Workspace.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 951607

## Symptoms

On a Windows XP Service Pack 3 (SP3)-based or Windows Small Business Server 2003 Service Pack 1 (SP1)-based computer, you experience the following symptoms:

- When you try to connect to a remote computer through Remote Desktop Web Connection (TSWeb), the **Connect** button is disabled. The TSWeb page may also contain the following warning message:

    > Remote Desktop Web Connection ActiveX control is not installed. A connection cannot be made without a working installed version of the control.

    > [!NOTE]
    > When you try to install the Remote Desktop Connection 6.0 client, you receive a message that states that it is already installed on the computer.

- When you use the Remote Web Workspace (RWW) Web site to connect to a remote computer, you notice that you cannot download the Remote Desktop Connection ActiveX control. Or, you receive the following error message:
    > Invalid server name.

    > [!NOTE]
    > Remote Web Workspace is a feature that is available in Microsoft Windows Small Business Server (Windows SBS).

- When you use the Terminal Services Web Access (TSWA) Web site to connect to a remote computer or to start a remote application, you receive the following error message: This Web site requires the Terminal Services Client, which does not appear to be installed on this System. Install the latest client and ensure that you have the most recent Windows Updates before continuing.

- When you access your Remote Access Computers page by using Windows Home Server, you may receive the following error message: Add-on Disabled This Webpage is requesting an add-on that is disabled. To enable the add-on click here.
Additionally, when you try to connect to your Windows Home Server or to a home computer, you may receive the following error message:

    > This feature requires that your Windows Home Server's website address `https://my.homeserver.com` be added to the Trusted Sites zone in Internet Explorer. To add your Windows Home Server's website address open Internet Explorer's Internet Options dialog box, click on the Security tab. Select "Trusted sites" and click on the Sites button. Add the website address `https://my.homeserver.com` with the Add button and then press Close.

    > [!NOTE]
    > After you add the home server URL to the trusted sites list, you receive the same error message and you still cannot connect.

- When you access your Windows Home Server by using Website Remote Access, you may receive the following error message:

    > Add-on Disabled This Webpage is requesting an add-on that is disabled. To enable the add-on click here.

    Additionally, when you try to connect to your Windows Home Server, you may receive the following error message:To connect to your home server or home computer remotely, the Microsoft Terminal Services Client Control add-on, or Microsoft RDP add-on must be installed and enabled for your web browser. If you declined to install the add-on, refresh the page and install it when prompted. Otherwise, please enable this add-on using the Manage add-ons icon in the Web browser status bar, or refer to your Web browser's documentation on how to enable this add-on.

## Cause

This issue occurs if the ActiveX control for the Remote Desktop Connection client is not enabled on the Web browser. By default, the ActiveX control is disabled after you install Windows XP Service Pack 3 (SP3) or Windows Small Business Server 2003 SP1.

## Workaround

To work around this issue, follow these steps:

1. Start Internet Explorer.
2. Visit the Web site that is causing this problem.

3. If you are using Windows Internet Explorer 7, follow these steps:

   1. On the **Tools** menu, point to **Manage Add-ons**, and then click **Enable or Disable Add-ons**. The **Manage Add-ons** dialog box appears.
   2. In the list of add-ins, search for the Microsoft Terminal Services Client Control ActiveX control or for the Microsoft RDP client Control ActiveX control. If you cannot find the control, see the steps in "If the control is not displayed in the list of add-ons" at the end of this section.
   3. Click the control, click **Enable**, and then click **OK** to close the Manage Add-ons dialog box.

    If you are using Internet Explorer 6, follow these steps:

   1. On the **Tools** menu, click **Manage Add-ons**. The **Manage Add-ons** dialog box appears.
   2. In the list of add-ins, search for the Microsoft Terminal Services Client Control ActiveX control or for the Microsoft RDP client Control ActiveX control. If you cannot find the control, see the steps in "If the control is not displayed in the list of add-ons" at the end of this section.
   3. Click the control, click **Enable**, and then click **OK** to close the **Manage Add-ons** dialog box.

4. Add the site to your Trusted Sites in Internet Explorer.
5. Restart Internet Explorer.
6. Try to connect to the remote computer. Or, try to start the remote application.

### If the control is not displayed in the list of add-ons

Sometimes the Microsoft Terminal Services Client Control ActiveX control will not be displayed in the list of add-ons.

To fix this problem, you can try the following steps to attempt to display the control by resetting Internet Explorer back to a default configuration.

1. Start Internet Explorer.
2. Click **File**, and then click **Import and Export**.
3. Follow the steps in the wizard to export your Favorites.
4. Click **Tools**, and then click **Internet Options**.
5. Click **Advanced**, and then click **Reset**.

Once Internet Explorer has been reset to a default configuration, try to connect to the remote computer or start the remote application. If it does not work, then follow the steps in the workaround to enable the Microsoft Terminal Service Client Control ActiveX control. If the control is still not listed, you can modify the registry to remove a key, if it exists.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

Remove the following registry keys, if they exist:

 `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{7584C670-2274-4EFB-B00B-D6AABA6D3850}`  `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{971127BB-259F-48C2-BD75-5F97A3331551}`  `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{9059F30F-4EB1-4BD2-9FDC-36F43A218F4A}`  `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{4EB89FF4-7F78-4A0F-8B8D-2BF02E94E4B2}`  `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{4EDCB26C-D24C-4e72-AF07-B576699AC0DE}`  `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Ext\Settings\{7390F3D8-0439-4C05-91E3-CF5CB290C3D0}`  

Once the registry keys are removed, exit and restart Internet Explorer, and try to connect to the remote computer or start the remote application again.

If this does not resolve the issue, you can re-register the mstscax.dll file. To do this, follow these steps:

1. Exit Internet Explorer.
2. Click **Start**, click **Run**, and the type or copy and paste the following text in the **Open** box, and click **OK**: *%windir%\\system32\\regsvr32 mstscax.dll*

3. At the confirmation prompt, click **OK**.
4. Restart Internet Explorer, and try to connect to the remote computer or start the remote application.

## More information

In Windows XP Service Pack 2 (SP2), you had to install the Msrdp.ocx file to enable the Terminal Services ActiveX control. Windows XP Service Pack 3 (SP3) already includes this ActiveX control and installs it by using the Mstscax.dll file. By default, this ActiveX control is disabled in Windows XP Service Pack 3 (SP3).
