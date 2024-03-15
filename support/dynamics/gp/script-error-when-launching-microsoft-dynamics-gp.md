---
title: An error has occurred in the script on this page error when launching
description: When you try to start Microsoft Dynamics GP, the error - An error has occurred in the script on this page occurs. Provides a resolution.
ms.reviewer: theley, sarahcud
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "An error has occurred in the script on this page" script error when launching Microsoft Dynamics GP

This article provides a resolution for the issue that you can't start Microsoft Dynamics GP due to the **An error has occurred in the script on this page** error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2702223

## Symptoms

When attempting to launch Microsoft Dynamics GP, refresh the home page or access a navigation list on the home page, an error shows similar to this:

> An error has occurred in the script on this page
>
> Line: XXX
>
> Char: X
>
> Error: Object doesn't support this property or method
>
> Code: X
>
> URL: file: ///C:/Documents%20and%20Settings/xxxxxxx/Local%Settings/Temp/tmpx.tmp

## Cause

This type of error can be caused as a result of multiple reasons, listed under Resolution below.

## Resolution

1. Permissions, we recommend that all Microsoft Dynamics GP users have at a minimum read/write/modify, if not Full Control permissions, to the following:

    1. The Microsoft Dynamics GP code folder itself. By default, this will be C:\Program Files\Microsoft Dynamics\GP201x.
    2. Any shared network folders that contain modified forms and/or reports dictionary files for Microsoft Dynamics GP.
    3. The user's own TEMP directory.

2. Missing UserData folder

    1. On the user's machine, select **Start**, select **Run**, type in the following and click Enter:

       %appdata%\Microsoft\Internet Explorer

    2. The UserData folder is a system folder so you may not see it appear. How you can verify whether it exists or not is to attempt to create a new UserData folder, which should give you a message that this folder already exists.
    3. If the UserData folder doesn't exist, create it in this location.

3. Users Temporary Internet Files

    1. On the machine that the user is using with Microsoft Dynamics GP, select **Start**, select **Control Panel** and then select **Internet Options** (you can also access this in Internet Explorer).
    2. In the Internet Options window, select the **General** tab.
    3. Under Browsing History, select the **Delete...** button.
    4. Select **Temporary Internet Files**, **Cookies**, and **History** options and then select the **Delete** button.
    5. Also under the Browsing History section, select the **Settings** button and verify that the **Every Time I visit the Web Page** option is selected.
    6. Select **OK** to close out of all windows after saving any changes.

4. Missing or corrupt Office Web Components.

    > [!NOTE]
    > If you have already installed the Office Web Components, try to run a repair on the installs. This will resolve any issues with the installs.

    If you use the 2007 or 2010 Office programs, you must install the Office Web Components for Office 2003.

    The Office Web Components for Office 2007 are a service pack for the Office Web Components for Office 2003. You must install Office Web Components for Office 2003 before you install this service pack.

5. UAC

    1. If running Dynamics GP on a newer operating system, such as Windows 7 or Windows Server 2008, select **Control Panel**, then select **User Accounts**.
    2. Select Change User Account Control settings.
    3. If not already set this way, change the setting to be Never notify and select **OK**. This will require a reboot of the machine for the changes to take place.
    4. Once the machine is rebooted, launch Microsoft Dynamics GP again and verify whether the script errors remain.
