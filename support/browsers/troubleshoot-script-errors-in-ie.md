---
title: Script errors in Internet Explorer
description: A script error occurs in Internet Explorer, the webpage cannot be displayed correctly and you receive an error message.
ms.date: 06/09/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# How to troubleshoot script errors in Internet Explorer

This article helps you solve the problem that the webpage can't be displayed when a script error occurs in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 308260

## Summary

When you receive script errors, webpages may not be displayed or work correctly in Internet Explorer.

When script errors occur in Internet Explorer, you may receive following error messages:
> Problems with this Web page might prevent it from being displayed properly or functioning properly. In the future, you can display this message by double-clicking the warning icon displayed in the status bar.

If you click **Show Details**, you may see detailed information about the following errors:

```console
Line:<LineNumber>
Char:<CharacterNumber>
Error:<ErrorMessage>
Code: 0
URL: http://Webserver/page.htm
A Runtime Error has occurred.
Do you wish to Debug?
Line:<LineNumber>
Error:<ErrorMessage>
```

The following warning message may also appear in the Internet Explorer Status bar:
> Done, but with errors on page.

This problem occurs because the HTML source code for the webpage does not work correctly with client-side script such as Microsoft JScript or Microsoft Visual Basic script. This problem may occur for one or more of the following reasons:

- A problem exists in the HTML source code of the webpage.
- The web page is using newer technologies that are [not supported](https://developer.microsoft.com/microsoft-edge/status/) by Internet explorer.
- The web page is using client-side visual basic script - that is deprecated.
- Active scripting, ActiveX controls, or Java programs are blocked on your computer or on the network. Internet Explorer or another program, such as antivirus programs or firewalls, can be configured to block Active scripting, ActiveX controls, or Java programs.
- Antivirus software is configured to scan your **Temporary Internet Files** or **Downloaded Program Files** folders.
- Internet-related folders on your computer are corrupted.
- Your video card drivers are corrupted or outdated.

> [!NOTE]
> Server-side scripts such as Visual Basic scripts in Active Server Pages (ASP) run on a web server. Script errors that occur because of server-side script failures do not produce error messages in Internet Explorer, but they may create a webpage that does not display or work correctly. The troubleshooting information in this article applies to client-side script errors. Contact the administrator of the web server if you suspect that a problem affects a server-side script.

These methods listed in this article may help you troubleshoot the script errors that are caused by files or settings on your computer. For quick visual instructions, watch this video: [How to troubleshoot script errors in Internet Explorer](https://www.microsoft.com/videoplayer/embed/cb2ff237-18e5-4db7-b89c-e1399dbce4b5).

## Resolution

> [!NOTE]
> Microsoft encourages you update your system with the latest windows update available. For more information about Windows Update, see [FAQ](https://support.microsoft.com/help/12373/windows-update-faq).

### Step 1: Make sure that script errors occur on multiple webpages

If the only sign of this problem is the error message, and if the websites are working, you can probably ignore the error. Also, if the problem occurs on one or two webpages, the problem may be caused by those pages. If you decide to ignore the errors, you can disable script debugging. To do this, select the **Disable script debugging** (Internet Explorer) checkbox in the **Internet Options** > **Advanced** > **Browsing settings**.

> [!NOTE]
> If this problem occurs on more than one or two sites, do not disable script debugging.

### Step 2: Make sure that the problem is caused by files or settings on your computer

To narrow down the source of the problem, use another user account, another browser, or another computer to view the webpages that triggered the script error.

If the script error does not occur when you view the webpage through another user account, in another browser, or on another computer, the problem may be caused by files or settings on your computer. In this situation, follow the methods in this article to resolve this problem:

After you complete each method, try to open a webpage on which you previously received a scripting error. If you do not receive the error, the problem is resolved.  

#### Method 1: Verify that Active Scripting, ActiveX, and Java are not being blocked by Internet Explorer

Active scripting, ActiveX, and Java are all involved in shaping the way that information is displayed on a webpage. If these features are blocked on your computer, this may disrupt the display of the webpage. You can reset your Internet Explorer security settings to make sure these features are not blocked. To do this, follow these steps:

1. Start Internet Explorer.
2. On the **Tools** menu, click **Internet Options**. If you can't see the **Tools** menu, press Alt to display the menus.
3. In the **Internet Options** dialog box, click the **Security** tab.
4. Click **Default Level** > **OK**

    > [!NOTE]
    > ActiveX controls and Java programs are turned off in the High security level in Internet Explorer.

    ![Internet Options.](./media/troubleshoot-script-errors-in-ie/4013610.jpg)

#### Method 2: Remove all temporary Internet files

Every time that you open a browser to view a webpage, your computer stores a local copy of that webpage in a temporary file. If the size of the temporary Internet files folder becomes too large, some display problems may occur when you open webpages. Periodically clearing the folder might help to resolve the problem.

To remove all the temporary Internet-related files for Internet Explorer.

1. Start Internet Explorer.
2. On the **Tools** menu, click **Internet Options**. If you can't see the **Tools** menu, press Alt to display the menus.
3. Click the **General** tab.
4. Under **Browsing History**, click **Delete**.

    ![Internet Options.](./media/troubleshoot-script-errors-in-ie/4013611.jpg)

5. In the **Delete Browsing History** dialog box, click to select the following check boxes, and then click **Delete**:

    - **Temporary Internet Files**  
    - **Cookies**  
    - **History**

    ![Internet Options.](./media/troubleshoot-script-errors-in-ie/4013612.jpg)

6. Click **Close**, and then click **OK** to close the **Internet Options** dialog box.  

#### Method 3: Install the latest software updates for Windows

To stay up to date, select the **Start** button > **Settings** > **Update & Security** > **Windows Update**, and then select **Check for updates**.

### Advanced debugging

This section is intended for more advanced computer users. It includes three methods to help resolve the problem.

#### Method 1: Verify that active scripting, activeX, and java are not blocked by an antivirus program or by a firewall

Scripts, ActiveX controls, and Java programs help shape the way a webpage is displayed. If these features are blocked, this may disrupt the display of webpages.

To determine how to make sure that scripts, ActiveX controls, and Java programs are not blocked, see the documentation for the firewall or antivirus program that you use. Then, make any necessary changes.  

#### Method 2: Verify that your antivirus program is not set to scan the Temporary Internet Files or the Downloaded Program Files folders

If an antivirus program interprets a script as a virus, and prevents it from running, a script error may occur. To prevent this, make sure that the antivirus program is not scanning the Temporary Internet Files folder or the Downloaded Program Files folder.

To determine how to prevent the program from scanning these folders, see the documentation for the antivirus program that you use. Then, make any necessary changes.
For adding exclusions to Windows Security in Windows 10 environments review, **Add an exclusion to Windows Security**.  

#### Method 3: Turn off Smooth Scrolling

If you experience a video display problem, the Smooth Scrolling feature may cause a script to be timed incorrectly. This can generate a script error. To turn off the Smooth Scrolling feature in Internet Explorer, follow these steps:

1. Start Internet Explorer.
2. On the **Tools** menu, click **Internet Options**. If you can't see the **Tools** menu, press Alt to display the menus.
3. On the **Advanced** tab, click to clear the **Use Smooth Scrolling** check box.
4. Click **OK**, and then exit Internet Explorer.

> [!NOTE]
> If this resolves the problem, check whether there is an updated driver available for your video adapter. To obtain an updated driver, contact the manufacturer of your video adapter or of your computer.

## More information  

### Procedure to turn off notification about every script error in Internet Explorer

1. Start Internet Explorer.
2. On the **Tools** menu, click **Internet Options**. If you can't see the **Tools** menu, press Alt to display the menus.
3. On the **Advanced** tab, click to clear the **Display a notification about every script error** box, and then click **OK**.

    ![Internet Options.](./media/troubleshoot-script-errors-in-ie/4013614.jpg)

### Troubleshooting Script Errors when printing from Internet Explorer
  
If you try to print a webpage in Internet Explorer, you may receive a script error that resembles the following:

```console
An error has occurred in the script on this page.
Line:<LineNumber>
Char:<CharacterNumber>
Error:<ErrorMessage>
Code: 0
URL: res/ieframe.dll/preview.js.
```

Generally, outdated printer drivers can cause problems when you print from Internet Explorer. To resolve these problems, try updating to the latest printer driver for your printer.

To resolve this issue, follow the steps in [Fix printer problems in Windows 7 and Windows 8.1](https://windows.microsoft.com/windows/printer-problems-in-windows-help) to check your printer and update the printer driver.

> [!IMPORTANT]
> In some cases, an updated version of the driver may not be available through Windows Update. You may have to visit the manufacturer's website to locate and download the latest printer driver for your printer.

Additionally, if you can't print or preview a webpage in Internet Explorer, see [Unable to print or view the print preview of a webpage in Internet Explorer](https://support.microsoft.com/help/973479).

## References

Also, if you experience this issue in Internet Explorer 9, try the methods in [You receive a script error and are unable to print from Internet Explorer 9](https://support.microsoft.com/help/2652062/you-receive-a-script-error-and-are-unable-to-print-from-internet-explo).
