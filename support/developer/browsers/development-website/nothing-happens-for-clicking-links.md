---
title: Nothing happens when you click a link in Internet Explorer
description: Describes how to troubleshoot the problem when hyperlinks do not work in Internet Explorer.
ms.date: 06/08/2020
ms.reviewer: 
---
# Nothing happens when you click a link in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you resolve the problem that the webpage can't be opened when you click a hyperlink in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 175775

## Symptoms

When you click a hyperlink on a webpage or in an email message, nothing happens. Internet Explorer does not open the webpage.

> [!NOTE]
> This information applies to Internet Explorer 9, Internet Explorer 8, and Internet Explorer 7.

## Cause

This can happen for one or more of the following reasons:

- The setting where you choose what web browser that you want to use is corrupted. This can cause Windows to misinterpret which browser is set as the default browser on your computer.
- After software was installed, settings were changed, which can cause links to webpages to work incorrectly.
- A previously installed browser or add-in might be interfering with other software on your computer.
- Registry keys were changed or became corrupted.

## Resolution

This section is intended for a beginning to intermediate computer user. If these methods do not resolve the problem, you can try the methods in the [Advanced troubleshooting](#advanced-troubleshooting) section. To resolve the problem, use the following methods in the order in which they are presented.

### Method 1: Check your default web browser setting

In Microsoft Windows, you can select which web browser that you want to use. To make Internet Explorer your default web browser, follow these steps:

1. To open Internet Explorer, click **Start**, and then click **Internet Explorer**.
2. If you are prompted to confirm that you want Internet Explorer to be your default browser, click **Yes**.
3. On the **Tools** menu, then click **Internet Options**.
4. Click the **Programs** > **Make default** > **OK**, and then close Internet Explorer.

> [!NOTE]
> Your changes will take effect the next time that you start Internet Explorer.

Check whether the problem is resolved. If the problem is resolved, you are finished with this article. If the problem is not resolved, try the next method.

### Method 2: Change the file types that Internet Explorer opens by default

For Windows 7 and Windows Vista.

1. Close all Internet Explorer windows.
2. Click **Start**, and then click **Control Panel**.
3. Click **Programs**, and then click **Set your default programs**.
4. On the **Programs** menu, click **Internet Explorer**, and then click **Choose defaults for this program**.
5. Make sure that the check boxes for `.htm`, `.html`, and `urls` are selected, and then click **Save**.
6. Click OK.

> [!NOTE]
> Your changes will take effect the next time that you start Internet Explorer.

For Windows XP

1. To open Windows Explorer, right-click **Start**, and then click **My Computer**.
2. On the **Tools** menu, click **Folder Options**, and then click the **File Types** tab.
3. Locate and select the HTM file type.
4. Make sure that Internet Explorer is selected as the **Opens with program**. If Internet Explorer is not selected, click **Change**, select **Internet Explorer** as the **recommended program**, and then click **OK**.
5. Repeat steps 3 and 4 for the following file types:

    - `HTML`
    - `ITS`
    - `MHT`
    - `MTHML`
    - `XML`
    - `XSL`

Check whether the problem is resolved. If the problem is resolved, you are finished with this article. If the problem is not resolved, go to the next method.

### Method 3: Use the Internet Explorer No Add-ons mode

Although browser add-ins can improve your online experience, they can occasionally interfere or conflict with other software on your computer. However, be aware that some webpages, or Internet Explorer itself, might not be displayed correctly if an add-in is disabled. First, start Internet Explorer with add-ins temporarily disabled to see whether the problem is resolved. (Add-ins will be disabled only until you restart Internet Explorer in the usual manner). To do this, follow these steps:

- Click **Start**, type *Internet Explorer* in the **Search** box, and then click **Internet Explorer (No Add-ons)**.

  > [!NOTE]
  > For Windows XP, click **Start** , right-click the **Internet Explorer** icon, and then click **Browse without add-ons**.

If Internet Explorer **No Add-ons** mode resolves the problem, follow these steps to identify the browser add-in that is causing the problem:

1. To start Internet Explorer, click **Start**, and then click **Internet Explorer**.
2. Click the **Tools** button, and then click **Manage add-ons**.
3. Click an **add-in** in the Name list, and then click **Disable**. Test Internet Explorer.
4. Repeat step 3 until you identify the add-in that is causing the problem.

Check whether the problem is resolved. If the problem is resolved, you are finished with this article. If the problem is not resolved, try the next method.

### Method 4: Reset Internet Explorer settings

If the problem is caused by damaged or incompatible Internet Explorer settings or add-ins, you can usually resolve the problem by resetting Internet Explorer settings to the default settings.

When you reset the Internet Explorer settings, all previous settings are lost and cannot be recovered. When you restore the Internet Explorer default settings, some webpages that rely on stored cookies, form data, passwords, or previously installed browser add-ins might not work correctly. However, resetting Internet Explorer to the default settings does not delete your favorites, feeds, and several other personal settings.

To reset Internet Explorer Settings, follow these steps:

1. Close all Internet Explorer windows.
2. Click **Start**, type *inetcpl.cpl* in the Search box and then click **inetcpl.cpl** on the Programs list.
The Internet Options dialog box appears.

    > [!NOTE]
    > for Windows XP, click **Start**, click **Run**, type *inetcpl.cpl* in the Open box, and then click **OK**.

3. Click the **Advanced tab**.
4. Under **Reset Internet Explorer Settings**, click **Reset**. Then, click **Reset** again.
5. When Internet Explorer finishes resetting, click **Close** in the Reset Internet Explorer Settings dialog box.
6. Start Internet Explorer again. Your changes will take effect the next time that you open Internet Explorer.

### Method 5: Re-register the necessary Internet Explorer DLL files

> [!NOTE]
> This information applies to Windows XP

To Re-register the DLL files, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, right-click **cmd**, and then select **Run as administrator**. If you are prompted for an **administrator password or confirmation**, type the *password* or provide confirmation.
2. Type *regsvr32 urlmon.dll* in the Open box, and then click **OK**.
3. Click **OK** when you receive the confirmation.
4. Repeat steps 2 and 3 for the following commands:

    - `regsvr32 mshtml.dll`
    - `regsvr32 shdocvw.dll`
    - `regsvr32 browseui.dll`
    - `regsvr32 msjava.dll`

Check whether the problem is resolved. If the problem is resolved, you are finished with this article. If the problem is not fixed, go to the next section.

## Advanced troubleshooting

This section is intended for more advanced computer users.

### Method 1: Create a new user account

For more information about user profiles, see [About User Profiles](/previous-versions/windows/desktop/legacy/bb776892(v=vs.85)).

For method details, go to the following Microsoft websites:

- [Fix a corrupted user profile in Windows](https://support.microsoft.com/help/14039/windows-fix-corrupted-user-profile).
- [Create a user account in Windows](https://support.microsoft.com/help/13951/windows-create-user-account)

### Method 2: Use System Restore

System Restore uses **restore points** to return your system files and settings to an earlier point in time without affecting your personal files. Restore points are created automatically every week and just before significant system events, such as the installation of a program, a device, or a driver.

Before you start System Restore, save any open files and close all programs. After you confirm your restore point, System Restore restarts your computer. To perform a System Restore, follow these steps:

For Windows 7 and Windows Vista

1. Click **Start**, click **All Programs**, click **Accessories**, click **System Tools**, and then click **System Restore**. If you are prompted for an **administrator password or confirmation**, type the *password* or provide confirmation.
2. Click **Next** on the System Restore page.
3. Select the **system restore date** or **description** that you want.

    > [!NOTE]
    > If you don't see the specific date that you are looking for, select Show more dates , and then select the date that you want.

4. In the confirmation window, click **Finish**. Your computer will restart. When the process is complete, you will receive a confirmation message.

For Windows XP

1. Log on to Windows by using an account that has administrative permissions.
2. Click **Start**, click **All Programs**, click **Accessories**, click **System Tools**, and then click **System Restore**.
3. On the Welcome to System Restore page, select the **Restore my computer to an earlier time** option, and then click **Next**.
4. On the **Select a Restore point** page, click the **most recent system restore point** on This List, click **a restore point list**, and then click **Next**.
5. On the **Confirm Restore Point Selection** page, click **Next**. System Restore restores the previous windows XP configuration and then restarts the computer.
6. Log on to the computer as an Administrator. Then, click **OK** on the system Restore Restoration Complete page. Your computer will restart. When the process is complete, you will receive a confirmation message.

If you use System Restore but the problem still occurs, or other problems occur, you can undo the restore operation. After you undo the operation, you can try using a different restore point. To undo a System Restore operation, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, click **System Tools**, and then click **System Restore**.
2. Click **Undo System Restore**, and then click **Next**.
3. Review your choices, and then click **Finish**.

Your computer will restart. When the process is complete, you will receive a confirmation.

## Additional Resources

Check whether the problem is resolved. If the problem is resolved, you are finished with this article. If the problem is not resolved, you can also use Microsoft Customer Support Services to find other solutions. Microsoft Support services include the following methods:

- [Search the Microsoft Knowledge Base](https://www.microsoft.com/search/result.aspx?q=): Find technical support information and self-help tools for Microsoft products.
- [Solution Centers](https://www.microsoft.com/solution-providers/home): View product-specific, frequently asked questions, and support highlights.
- [Microsoft Community](https://answers.microsoft.com/#tab=1): Contact counterparts, peers, and Microsoft Most Valuable Professionals (MVPs).
- [Other support options](https://support.microsoft.com/contactus/): Ask a question, contact Microsoft Customer Support Services, or provide feedback.
