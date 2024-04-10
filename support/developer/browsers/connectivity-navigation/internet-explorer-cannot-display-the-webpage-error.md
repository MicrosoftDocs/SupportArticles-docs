---
title: Internet Explorer cannot display the webpage
description: This article describes that Internet Explorer cannot open any webpage and provides troubleshooting solutions.
ms.date: 06/09/2020
ms.reviewer: 
---
# Internet Explorer cannot display the webpage error when you try to access a webpage

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you solve the problem that Internet Explorer can't display the webpage. If you're successfully connected to the Internet but can't view any webpages in Internet Explorer, use one of the following troubleshooting procedures, as appropriate for your operating system.

_Original product version:_ &nbsp; Internet Explorer, Windows 10  
_Original KB number:_ &nbsp; 956196

## Troubleshooting for Windows 8 and Windows 10

### Check Proxy and DNS settings

Proxy settings are used to tell Internet Explorer the network address of an intermediary server (known as a proxy server) that is used between the browser and the Internet on some networks. Changing proxy settings is something you only have to do if you are connecting to the Internet through a corporate network. By default, Internet Explorer automatically detects proxy settings. However, if this setting has been changed and you are not trying to connect to a corporate network, you may experience connection issues. To verify that Internet Explorer is automatically detecting your proxy settings, follow the steps below:

1. Swipe in from the right edge of the screen, tap **Start**, and then type *Internet options*.
(If you're using a mouse, point to the upper-right corner of the screen, move the mouse pointer down, click **Start**, and then type *Internet options*.)
2. Tap or click the **Connections** tab, and then tap or click the **LAN settings**.

    :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/connections-tab.png" alt-text="Screenshot of the Connections tab in Internet Properties. LAN settings is highlighted." border="false":::

3. Tap or click **Automatically detect settings** and verify that there is check mark in the box beside it.

    :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/automatically-detect-settings.png" alt-text="Screenshot of the LAN Settings window. Automatically detect settings option is checked." border="false":::

4. Tap or click **OK** to close the windows. Restart Internet Explorer and verify the issue is resolved.

### Reset Internet Explorer

To reset Internet Explorer to the default settings, follow these steps:

1. Start Internet Explorer, and then on the **Tools** menu, click **Internet Options**.
2. Click the **Advanced** tab, and then click **Reset**. (The screenshot for this step is listed below).

    :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/advanced-tab.png" alt-text="Screenshot of the Advanced tab in Internet Options." border="false":::

3. In the **Internet Explorer Default Settings** dialog box, click **Reset**.
4. In the **Reset Internet Explorer Settings** dialog box, click **Reset**. (The screenshot for this step is listed below).

    :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/reset-internet-explorer-settings.png" alt-text="Screenshot of Reset Internet Explorer Settings window." border="false":::

5. Click **Close**, and then click **OK** two times. (The screenshot for this step is listed below).

    :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/reset-internet-explorer-settings-checklist.png" alt-text="Screenshot of Reset Internet Explorer Settings output." border="false":::

6. Exit and then restart Internet Explorer. The changes take effect the next time that you start Internet Explorer.

### Delete your browser history

To delete the browsing history in Internet Explorer 11, follow these steps:

1. Start Internet Explorer from the desktop.
2. Press Alt to show the menu bar.
3. On the **Tools** menu, tap or click **Internet options**.
4. Under **Browsing history**, click **Delete**. (The screenshot for this step is listed below).

    :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/general-tab.png" alt-text="Screenshot of the General tab of Internet Options." border="false":::

5. Select all the **applicable** check boxes, and then tap or click **Delete**. (The screenshot for this step is listed below).

    :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/delete-browsing-history.png" alt-text="Screenshot of the Delete Browsing History page." border="false":::

6. Tap or click **Exit**, and then restart Internet Explorer.

### Disabling Enhanced Protected Mode

Enhanced Protected Mode is a new feature in Internet Explorer 10. It works by extending the existing Protected Mode functionality to help prevent attackers from installing software, accessing personal information, accessing information from corporate Intranets, and from modifying system settings. To do this, Enhanced Protected Mode must reduce some of the capabilities available to Internet Explorer. These restrictions may cause issues with your browsing experience when using Internet Explorer. By disabling Enhance Protected Mode, your performance in Internet Explorer may improve but could leave you at risk for possible attacks.

How to disable Enhanced Protected Mode:

1. Swipe in from the right edge of the screen, tap **Start**, and then type *Internet options*.
(If you're using a mouse, point to the upper-right corner of the screen, move the mouse pointer down, click **Start**, and then type **Internet options**.)
2. Tap or click **Settings** located under the search box to the right of the screen. Then, tap or click the **Internet Options** icon located under the search results.

     :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/internet-options.png" alt-text="Screenshot shows searching internet options under Settings." border="false":::

3. In the **Internet Options** windows, tap or click the **Advanced** tab. Locate the check box **Enable Enhanced Protected Mode**. Tap or click to **uncheck** the box.

    :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/enable-enhanced-protected-mode.png" alt-text="Screenshot of the Advance tab where Enable Enhanced Protected Mode option is cleared." border="false":::

4. Tap or click the **Apply** button, and then tap or click **OK**. Restart Internet Explorer and check to see if the issue is resolved.

### Disable add-ons in Internet Explorer

Internet Explorer 10 is designed to provide an add-on free experience, and it plays HTML5 and many Adobe Flash Player videos without having to install a separate add-on. Add-ons and toolbars work only in Internet Explorer for the desktop. To view a page that requires add-ons in Internet Explorer, swipe down or right-click to bring up the Address bar, tap or click the Page tools button, and then tap or click **View** on the desktop.

You can view, enable, and disable the list of add-ons that can be used by Internet Explorer for the desktop. Add-ons that you can manage include browser helper objects, ActiveX controls, toolbar extensions, explorer bars, browser extensions, search providers, accelerators, and tracking protection settings.

To manage add-ons:

1. Start Internet Explorer for the desktop.
2. On the **Tools menu**, tap or click **Manage add-ons**.
3. Under **Show**, tap or click **All Add-ons**, and then disable all of them by tapping or clicking each one, and then select **Disable**.
4. Tap or click **Close**.
5. Restart Internet Explorer and test it. If you can successfully access the Internet, the issue involves an installed add-on. Re-enable each add-on one at a time, and test to determine which add-on is causing the issue.

### Check whether a third-party service, program, or anti-virus is conflicting with Internet Explorer

Some third-party anti-virus programs may cause issues for Internet Explorer getting connected to the network. Remove any third party anti-virus from your system per the instructions given by the developers of those programs.

To determine whether a third-party program or service conflicts with Internet Explorer, follow these steps:

1. Tap or click the **Search charm**, type *config* in the search box, and then tap or click the displayed **System Configuration** icon.
2. Tap or click the **Services** tab and select the **Hide all Microsoft services** check box, and then click **Disable all**.
3. Tap or click the **Startup** tab.
4. Tap or click **Disable all** in the bottom-right corner, and then click **OK**.

You are prompted to restart your computer. After the restart, test Internet Explorer for an online connection. Depending on the result, go to the **The connection works** section or to the **The connection still does not work** section.

- The connection works

  If the connection works, a third-party service or program may be conflicting with Internet Explorer. To identify the conflicting service or program, follow these steps:

  1. Tap or click the **Search** charm, type *config* in the search box, and then tap or click the displayed **System Configuration** icon.
  2. Tap or click the **Services** tab, and then select the **Hide all Microsoft services** check box.
  3. Select half of the listed items, and then click **OK**.
  4. Restart the computer, and then test Internet Explorer.
  5. Repeat steps 1-4 until you identify the service that is conflicting with Internet Explorer. If you are not using the conflicting service, we recommend that you remove it, or configure the service so that it doesn't start when the computer starts. If you can't find a service that is causing the issue, open System Configuration again, click the Startup tab, and repeat steps 3-5.

- The connection still does not work

  If the connection still does not work, re-enable all programs, and then go to the **Temporarily disabling the firewall** section. To re-enable all programs, follow these steps:

  1. Tap or click the **Search** charm, type *config* in the search box, and then tap or click the displayed **System Configuration** icon.
  2. Tap or click the **Services** tab, and then enable all the programs.
  3. Tap or click the **Startup** tab, enable all the programs, and then click **OK**.
  4. Restart the computer.

### Updating older drivers and editing registry keys

- Checking Windows Updates for drivers

  Even if you already receive automatic updates, you can manually check for and install updated drivers in optional updates. Windows Update doesn't install optional updates automatically, but we notify you when there are some available, and then let you choose whether or not to install them. To check Windows Update for drivers:

  1. Open Windows Update in **Control Panel** by swiping in from the right edge of the screen, tapping **Search** (or, if you're using a mouse, pointing to the upper-right corner of the screen, moving the mouse pointer down, and then clicking **Search**), entering *Windows Update* in the search box, tapping or clicking **Settings**, and then tapping or clicking **Install optional updates**.
  2. Tap or click **Check for updates**, and then wait while Windows looks for the latest updates for your PC.
  3. If updates are found, tap or click **Install updates**.

  Read and accept the license terms, and then tap or click **Finish** if the update requires it. You might be asked for an admin password or to confirm your choice.

- Editing the TabProcGrowth key

  Improve Internet Explorer performance by enabling the TabProcGrowth key.

  1. Open Registry Editor by swiping in from the right edge of the screen, tapping **Search** (or, if you're using a mouse, pointing to the upper-right corner of the screen, moving the mouse pointer down, and then clicking **Search**), entering *regedit* in the search box, and then tapping or clicking **regedit.exe** in the search results.

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/regedit-exe.png" alt-text="Screenshot shows the search results for regedit.exe." border="false":::

  2. Navigate to `HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main`. No need to click on the dropdown for **Main**. The key we are looking for is located there. Tap or click on **Main**.
  3. Locate the key named **TabProcGrowth**. Right-click the key and tap or click **Modify**.
  4. The key value will be listed. If the key value is **1**, do not change it. If the value is *0*, change it to **1**, and then click **OK**.

### Restore or refresh your PC

To restore your PC by using System Restore

If you think that an app or driver that you recently installed has caused problems on your PC, you can restore it to an earlier point in time (a restore point). System Restore doesn't change your personal files, but it might remove recently installed apps and drivers.

1. Swipe in from the right edge of the screen, and then tap **Search**. (If you're using a mouse, point to the upper-right corner of the screen, move the mouse pointer down, and then click **Search**.) Enter *recovery* in the search box, tap or click **Settings**, and then tap or click **Recovery**.
2. Tap or click **Open System Restore**, and then follow the guidance. To refresh your PC

  Refreshing your PC reinstalls Windows and keeps your personal files, settings, and the apps that came with your PC and apps that you installed from Windows Store.

1. Swipe in from the right edge of the screen, tap **Settings**, and then tap **Change PC settings**. (If you're using a mouse, point to the upper-right corner of the screen, move the mouse pointer down, click **Settings**, and then click **Change PC settings**. )
2. Under PC settings, tap or click **General**.
3. Under Refresh your PC without affecting your files, tap or click **Get started**.
4. Follow the instructions on the screen.

## Troubleshooting for Windows 7

### Delete your browser history

- Internet Explorer 8, Internet Explorer 9, Internet Explorer 10, or Internet Explorer 11

  Follow the steps listed to delete the browsing history for Internet Explorer

  1. Start Internet Explorer.
  2. Press Alt to show the menu bar.
  3. On the **Tools** menu, click **Internet options**.
  4. Under **Browsing history**, click **Delete**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/delete-browsing-history-in-internet-options.png" alt-text="Screenshot of how to delete browsing history." border="false":::

  5. Select all the check boxes, and then tap or click **Delete**. (The screenshot for this step is listed below).

       :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/delete-browsing-history.png" alt-text="Screenshot of the Delete Browsing History page." border="false":::

  6. Tap or click **Exit**, and then restart Internet Explorer.

### Disable add-ons in Internet Explorer

- Internet Explorer 10 and Internet Explorer 11

  Internet Explorer 10 is designed to provide an add-on free experience, and will play HTML5 and many Adobe Flash Player videos without needing to install a separate add-on. Add-ons and toolbars will only work in Internet Explorer for the desktop. To view a page that requires add-ons in Internet Explorer, swipe down or right-click to bring up the Address bar, tap or click the **Page tools** button, and then tap or click **View** on the desktop.

  You can view, enable, and disable the list of add-ons that can be used by Internet Explorer for the desktop. Add-ons you can manage to include browser helper objects, ActiveX controls, toolbar extensions, explorer bars, browser extensions, search providers, Accelerators, and Tracking Protection settings.

  To manage add-ons

  1. Open Internet Explorer for the desktop.
  2. Tap or click the **Tools** button, and then tap or click **Manage add-ons**.
  3. Under **Show**, tap or click **All Add-ons**, and then disable all of them by tapping or clicking each one, and then selecting **Disable**.
  4. Tap or click **Close**.
  5. Restart Internet Explorer and test. If you can successfully access the internet, then the issue is with an installed add-on. Re-enable each add-on one at a time and test to verify what add-on is causing the issue.

- Internet Explorer 9

  Several add-ons are pre-installed in Internet Explorer, but many come from the Internet. Add-ons usually require that you give your permission before they're installed on your computer. However, some might be installed without your knowledge. This can happen if the add-on was part of another program that you installed.

  1. Open Internet Explorer.
  2. Click the **Tools** button, and then click **Manage add-ons**.
  3. Under **Show**, click **All add-ons**.
  4. Click an add-on, and then click **Disable**.
  5. Repeat step 4 for each add-on that you want to turn on or off. When you're finished, click **Close**.
  6. Restart Internet Explorer.

- Internet Explorer 8

  Add-ons, also known as ActiveX controls, browser extensions, browser helper objects, or toolbars, can improve your experience on a website by providing multimedia or interactive content, such as animations. However, some add-ons can cause your computer to stop responding or display content that you don't want, such as pop-up ads.

  If you suspect that browser add-ons are affecting your computer, you might want to disable all add-ons to see if that solves the problem.

  To disable all add-ons temporarily

  1. Click the **Start** button, and then click **All Programs**.
  2. Click **Accessories**, click **System Tools**, and then click **Internet Explorer** (No Add-ons).

  To disable add-ons in Add-on Manager

  1. Open Internet Explorer.
  2. Click the **Tools** button, and then click **Manage add-ons**.
  3. Under **Show**, click **All Add-ons**.
  4. Click the add-on you want to disable, and then click **Disable**.
  5. Repeat step 4 for every add-on you want to disable. When you're finished, click **Close**.

### Reset Internet Explorer

- Internet Explorer 8, Internet Explorer 9, Internet Explorer 10, or Internet Explorer 11

  To reset Internet Explorer settings to the default setting, follow these steps:

  1. Start Internet Explorer, click **Tools**, and then click **Internet Options**.
  2. Click the **Advanced** tab, and then click **Reset**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/advanced-tab.png" alt-text="Screenshot of the Advanced tab in Internet Options." border="false":::

  3. In the Internet Explorer Default Settings dialog box, click **Reset**.
  4. In the Reset Internet Explorer Settings dialog box, click **Reset**. (The screenshot for this step is listed below).

       :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/reset-internet-explorer-settings.png" alt-text="Screenshot of the Reset Internet Explorer Settings page." border="false":::

  5. Click **Close** and then click **OK** two times. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/reset-internet-explorer-settings-checklist.png" alt-text="Screenshot of the Reset Internet Explorer Settings page output." border="false":::

  6. Exit and then restart Internet Explorer. The changes take effect the next time that you open Internet Explorer.

### Check whether a third-party service or program is conflicting with Internet Explorer

To determine whether a third-party program or service conflicts with Internet Explorer, follow these steps:

1. Click **Start**, type *config* in the search box, and then click the displayed **System Configuration** icon.
2. Click the **Services** tab and check the box beside Hide all Microsoft services, and then click **Disable all**.
3. Next, click the **Startup** tab.
4. Click **Disable all** in the bottom right and then click **OK**. You will be prompted to reboot your computer. After the reboot, test Internet Explorer for connection. Depending on the result, go to the **The connection works** section or to the **The connection still does not work** section.

- The connection works

  If the connection works, a third-party service or program may be conflicting with Internet Explorer. To identify the conflicting service or program, follow these steps:

  1. Click **Start**, type *config* in the **Search programs and files** box, and then click **config** in the Programs list
  2. Click the **Services** tab and check the box beside **Hide all Microsoft services**.
  3. Select half of the listed items, and then click **OK**.
  4. Restart the computer, and then test Internet Explorer.
  5. Repeat steps 1 through 4 until you identify the service that is conflicting with Internet Explorer. If you are not using the conflicting service, we recommend that you remove it, or configure it so that it doesn't start when the computer starts. If you cannot find a service that is causing the issue then open System Configuration again, click the **Startup** tab and repeat steps 3 through 5.

- The connection still does not work

  If the connection still does not work, re-enable all programs, and then go to the **Temporarily disabling the firewall** section. To re-enable all programs, follow these steps:

  1. Click **Start**, type *config* in the **Search programs and files** box, and then click **config** in the Programs list.
  2. In the **System Configuration** dialog box, click the **Services** tab. Enable all items.
  3. Click the **Startup** tab, enable all the programs, and then click **OK**.
  4. Restart the computer.

### Install Windows Updates and disable the PreBinding feature

- Check Windows Updates

  Make sure you've installed the most current cumulative security update for Internet Explorer. To install the most current update, visit the following Microsoft Web site: [Windows Update: FAQ](https://windowsupdate.microsoft.com)

- Try disabling the PreBinding feature

  To modify the EnablePreBinding registry value, follow these steps:

  1. Open **Registry** Editor. To do this, type regedit in the **Start Search** box, and then select **regedit** in the **Programs** list.

      If you are prompted for an administrator password or for a confirmation, type the password, or select **Allow**.
  2. Locate and then select the following registry subkey:  
    `HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main`

  3. Locate the **EnablePreBinding** value, if the value doesn't exist, select the **Edit** menu, point to **New**, and then select **DWORD** Value.
  4. Type *EnablePreBinding*, and then press Enter.
  5. On the **Edit** menu, select **Modify**.
  6. Type *0*, and then select **OK**.

### Restore your PC to an earlier point in time

If you think an app or driver that you recently installed caused problems with your PC, you can restore it back to an earlier point in time, called a restore point. System Restore doesn't change your personal files, but it might remove recently installed apps and drivers.

To restore your PC using System Restore

Open System Restore by clicking the **Start** button. In the search box, type *System Restore*, and then, in the list of results, click **System Restore**. If you're prompted for an administrator password or confirmation, type the *password* or provide confirmation.

## Troubleshooting for Windows Vista

### Delete your browser history

- Internet Explorer 8 or Internet Explorer 9

  Follow the steps listed to delete the browsing history for Internet Explorer

  1. Start Internet Explorer.
  2. Press Alt to show the menu bar.
  3. On the **Tools** menu, click **Internet options**.
  4. Under **Browsing history**, click **Delete**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/delete-browsing-history-in-internet-options.png" alt-text="Screenshot of the General Tab in Internet options." border="false":::

  5. Select all the check boxes, and then tap or click **Delete**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/delete-browsing-history.png" alt-text="Screenshot of the Delete Browsing History page." border="false":::

  6. Tap or click **Exit**, and then restart Internet Explorer.

- Internet Explorer 7

  1. Start Internet Explorer.
  2. On the **Tools** menu, click **Delete Browsing History**.
  3. Select the check box next to the following items:
      - **Temporary Internet files**
      - **History**
      - **Form data**
      - **Cookies**
  4. Click **Delete**.
  5. Exit and then restart Internet Explorer, and then try to access the webpage.

### Disable add-ons in Internet Explorer

- Internet Explorer 9

  Several add-ons are pre-installed in Internet Explorer, but many come from the Internet. Add-ons usually require that you give your permission before they're installed on your computer. However, some might be installed without your knowledge. This can happen if the add-on was part of another program that you installed.

  1. Open Internet Explorer.
  2. Click the **Tools** button, and then click **Manage add-ons**.
  3. Under **Show**, click **All add-ons**.
  4. Click an add-on, and then click **Disable**.
  5. Repeat step 4 for each add-on that you want to turn on or off. When you're finished, click **Close**.
  6. Restart Internet Explorer.

- Internet Explorer 8

  Add-ons, also known as ActiveX controls, browser extensions, browser helper objects, or toolbars, can improve your experience on a website by providing multimedia or interactive content, such as animations. However, some add-ons can cause your computer to stop responding or display content that you don't want, such as pop-up ads.

  If you suspect that browser add-ons are affecting your computer, you might want to disable all add-ons to see if that solves the problem.

  To disable all add-ons temporarily

  1. Click the **Start** button, and then click **All Programs**.
  2. Click **Accessories**, click **System Tools**, and then click **Internet Explorer** (No Add-ons).
  
  To disable add-ons in Add-on Manager

  1. Open Internet Explorer.
  2. Click the **Tools** button, and then click **Manage add-ons**.
  3. Under **Show**, click **All Add-ons**.
  4. Click the add-on you want to disable, and then click **Disable**.
  5. Repeat step 4 for every add-on you want to disable. When you're finished, click **Close**.

- Internet Explorer 7

  Microsoft Internet Explorer add-ons are software components. When you visit a Web site, Internet Explorer add-ons may be downloaded automatically, or you may be prompted to download an add-on. For some add-ons, you might specifically visit a Web site to obtain the latest add-on for Internet Explorer. These components may be third-party ActiveX controls that extend browser functionality or that provide special user interface elements in Internet Explorer. You can control add-ons by using the Manage Add-ons feature.

  1. Open Internet Explorer.
  2. Click the **Tools** button, and then click **Manage add-ons**.
  3. Click an add-on, and then click **Disable**.
  4. Repeat step 4 for each add-on that you want to turn off. When you're finished, click **Close**.

### Reset Internet Explorer

- Internet Explorer 8 or Internet Explorer 9

  To reset Internet Explorer settings to the default setting, follow these steps:

  1. Start Internet Explorer, click **Tools**, and then click **Internet Options**.
  2. Click the **Advanced** tab, and then click **Reset**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/advanced-tab.png" alt-text="Screenshot of the Advanced tab in Internet Options." border="false":::

  3. In the Internet Explorer Default Settings dialog box, click **Reset**.
  4. In the Reset Internet Explorer Settings dialog box, click **Reset**. (The screenshot for this step is listed below).

       :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/reset-internet-explorer-settings.png" alt-text="Internet Explorer 8 Reset Internet Explorer settings page." border="false":::

  5. Click **Close** and then click **OK** two times. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/reset-internet-explorer-settings-checklist.png" alt-text="Internet Explorer 8 Reset Internet Explorer settings page output." border="false":::

  6. Exit and then restart Internet Explorer. The changes take effect the next time that you open Internet Explorer.

- Internet Explorer 7

  By resetting Internet Explorer settings, you return it to the state it was in when it was first installed on your computer. This is useful for troubleshooting problems that might be caused by settings that were changed after installation. When you restore Internet Explorer's default settings, some webpages that rely on previously stored cookies, form data, passwords, or previously installed browser add-ons might not work correctly. Resetting Internet Explorer to its default settings does not delete your favorites, feeds, and a few other personalized settings.

  To reset Internet Explorer settings manually
  1. Close any Internet Explorer or Windows Explorer windows that are currently open.
  2. Open Internet Explorer by clicking the **Start** button, and then clicking **Internet Explorer**.
  3. Click the **Tools** button, and then click **Internet Options**.
  4. Click the **Advanced** tab, and then click **Reset**.
  5. In the Reset Internet Explorer Settings dialog box, click **Reset**.
  6. When Internet Explorer finishes applying default settings, click **Close**, click **OK**, and then click **OK** again.
  7. Close Internet Explorer.

  Your changes will take effect the next time you open Internet Explorer.

### Check whether a third-party service or program is conflicting with Internet Explorer

To determine whether a third-party program or service conflicts with Internet Explorer, follow these steps:

1. Click **Start**, type *config* in the search box, and then click the displayed **System Configuration** icon.
2. Click the **Services** tab and check the box beside **Hide all Microsoft services**, and then click **Disable** all.
3. Next, click the Startup tab.
4. Click **Disable all** in the bottom right and then click **OK**. You will be prompted to reboot your computer. After the reboot, test Internet Explorer for connection. Depending on the result, go to the **The connection works** section or to the **The connection still does not work** section.

- The connection works

  If the connection works, a third-party service or program may be conflicting with Internet Explorer. To identify the conflicting service or program, follow these steps:

  1. Click **Start**, type *config* in the **Search programs and files** box, and then click **config** in the Programs list
  2. Click the **Services** tab and check the box beside **Hide all Microsoft services**.
  3. Select half of the listed items, and then click **OK**.
  4. Restart the computer, and then test Internet Explorer.
  5. Repeat steps 1 through 4 until you identify the service that is conflicting with Internet Explorer. If you are not using the conflicting service, we recommend that you remove it, or configure it so that it doesn't start when the computer starts. If you cannot find a service that is causing the issue then open System Configuration again, click the **Startup** tab and repeat steps 3 through 5.

- The connection still does not work

  If the connection still does not work, re-enable all programs, and then go to the **Temporarily disabling the firewall** section. To re-enable all programs, follow these steps:
  1. Click **Start**, type config in the Search programs and files box, and then click **config** in the Programs list.
  2. In the **System Configuration** dialog box, click the **Services** tab. Enable all items.
  3. Click the **Startup** tab, enable all the programs, and then click **OK**.
  4. Restart the computer.

### Restore your PC to an earlier point in time

If you think an app or driver that you recently installed caused problems with your PC, you can restore it back to an earlier point in time, called a restore point. System Restore doesn't change your personal files, but it might remove recently installed apps and drivers.

To restore your PC using System Restore

1. Click **Start**, type system restore in the Start Search box, and then click **System Restore** in the Programs list. If you are prompted for an administrator password or confirmation, type your *password* or click **Continue**.
2. In the **System Restore** dialog box, click **Choose a different restore point**, and then click **Next**.
3. In the list of restore points, click a restore point that was created before you began to experience the issue, and then click **Next**.
4. Click **Finish**.

## Troubleshooting for Windows XP

### Delete your browser history

- Internet Explorer 8

  Follow the steps listed to delete the browsing history for Internet Explorer

  1. Start Internet Explorer.
  2. Press Alt to show the menu bar.
  3. On the **Tools** menu, click Internet options.
  4. Under **Browsing history**, click **Delete**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/delete-browsing-history-in-internet-options.png" alt-text="Screenshot of deleting browsing history in Internet Options." border="false":::

  5. Select all the check boxes, and then tap or click **Delete**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/delete-browsing-history.png" alt-text="Screenshot of Deleting Browsing History page." border="false":::

  6. Tap or click **Exit**, and then restart Internet Explorer.

- Internet Explorer 7

  1. Start Internet Explorer.
  2. On the **Tools** menu, click **Delete Browsing History**.
  3. Select the check box next to the following items:
     - **Temporary Internet files**
     - **History**
     - **Form data**
     - **Cookies**
  4. Click **Delete**.
  5. Exit and then restart Internet Explorer, and then try to access the webpage.

- Internet Explorer 6

  1. Start Internet Explorer.
  2. On the **Tools** menu, click **Internet Options**.
  3. In the **Temporary Internet Files** section, click **Delete** files, and then select the **Delete all offline content text** box.
  4. Click **OK**.
  5. In the **History** section, click **Clear** history, and then click **Yes**.
  6. Exit and then restart Internet Explorer, and then try to access the webpage.

### Disable add-ons in Internet Explorer

- Internet Explorer 8

  Add-ons, also known as ActiveX controls, browser extensions, browser helper objects, or toolbars, can improve your experience on a website by providing multimedia or interactive content, such as animations. However, some add-ons can cause your computer to stop responding or display content that you don't want, such as pop-up ads.

  If you suspect that browser add-ons are affecting your computer, you might want to disable all add-ons to see if that solves the problem.

  To disable all add-ons temporarily
  1. Click the **Start** button, and then click **All Programs**.
  2. Click **Accessories**, click **System Tools**, and then click **Internet Explorer** (No Add-ons).

  To disable add-ons in Add-on Manager
  1. Open Internet Explorer.
  2. Click the **Tools** button, and then click **Manage add-ons**.
  3. Under **Show**, click **All Add-ons**.
  4. Click the add-on you want to disable, and then click **Disable**.
  5. Repeat step 4 for every add-on you want to disable. When you're finished, click **Close**.

- Internet Explorer 7

  Microsoft Internet Explorer add-ons are software components. When you visit a Web site, Internet Explorer add-ons may be downloaded automatically, or you may be prompted to download an add-on. For some add-ons, you might specifically visit a Web site to obtain the latest add-on for Internet Explorer. These components may be third-party ActiveX controls that extend browser functionality or that provide special user interface elements in Internet Explorer. You can control add-ons by using the Manage Add-ons feature.

  1. Open Internet Explorer.
  2. Click the **Tools** button, and then click **Manage add-ons**.
  3. Click an add-on, and then click **Disable**.
  4. Repeat step 4 for each add-on that you want to turn off. When you're finished, click **Close**.

### Reset Internet Explorer

- Internet Explorer 8

  To reset Internet Explorer settings to the default setting, follow these steps:

  1. Start Internet Explorer, click **Tools**, and then click **Internet Options**.
  2. Click the **Advanced** tab, and then click **Reset**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/advanced-tab.png" alt-text="Screenshot of the Advanced tab." border="false":::

  3. In the Internet Explorer Default Settings dialog box, click **Reset**.
  4. In the Reset Internet Explorer Settings dialog box, click **Reset**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/reset-internet-explorer-settings.png" alt-text="Internet Explorer 8 Reset Internet Explorer Settings." border="false":::

  5. Click **Close** and then click **OK** two times. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/reset-internet-explorer-settings-checklist.png" alt-text="Internet Explorer 8 Reset Internet Explorer Settings output." border="false":::

  6. Exit and then restart Internet Explorer. The changes take effect the next time that you open Internet Explorer.

- Internet Explorer 7

  By resetting Internet Explorer settings, you return it to the state it was in when it was first installed on your computer. This is useful for troubleshooting problems that might be caused by settings that were changed after installation. When you restore Internet Explorer's default settings, some webpages that rely on previously stored cookies, form data, passwords, or previously installed browser add-ons might not work correctly. Resetting Internet Explorer to its default settings does not delete your favorites, feeds, and a few other personalized settings.

  To reset Internet Explorer settings manually

  1. Close any Internet Explorer or Windows Explorer windows that are currently open.
  2. Open Internet Explorer by clicking the **Start** button, and then clicking **Internet Explorer**.
  3. Click the **Tools** button, and then click **Internet Options**.
  4. Click the **Advanced** tab, and then click **Reset**.
  5. In the Reset Internet Explorer Settings dialog box, click **Reset**.
  6. When Internet Explorer finishes applying default settings, click **Close**, click **OK**, and then click **OK** again.
  7. Close Internet Explorer.

  Your changes will take effect the next time you open Internet Explorer.

### Check whether a third-party service or program is conflicting with Internet Explorer

To determine whether a third-party program or service conflicts with Internet Explorer, follow these steps:

1. Click **Start**, click **Run**, type *config*, and then click **OK**.
2. Click the **Services** tab and check the box beside **Hide all Microsoft services**, and then click **Disable all**.
3. Next, click the **Startup** tab.
4. Click **Disable all** in the bottom right and then click **OK**. You will be prompted to reboot your computer. After the reboot, test Internet Explorer for connection. Depending on the result, go to the **The connection works** section or to the **The connection still does not work** section.

- The connection works

  If the connection works, a third-party service or program may be conflicting with Internet Explorer. To identify the conflicting service or program, follow these steps:

  1. Click **Start**, click **Run**, type **config**, and then click **OK**.
  2. Click the **Services** tab and check the box beside **Hide all Microsoft services**.
  3. Select half of the listed items, and then click **OK**.
  4. Restart the computer, and then test Internet Explorer.
  5. Repeat steps 1 through 4 until you identify the service that is conflicting with Internet Explorer. If you are not using the conflicting service, we recommend that you remove it, or configure it so that it doesn't start when the computer starts. If you cannot find a service that is causing the issue then open System Configuration again, click the Startup tab and repeat steps 3 through 5.

- The connection still does not work

  If the connection still does not work, re-enable all programs, and then go to the Temporarily disabling the firewall section. To re-enable all programs, follow these steps:

  1. Click **Start**, click **Run**, type *config*, and then click **OK**.
  2. In the **System Configuration** dialog box, click the **Services** tab. Enable all items.
  3. Click the **Startup** tab, enable all the programs, and then click **OK**.
  4. Restart the computer.

### Restore your PC to an earlier point in time

  If you think an app or driver that you recently installed caused problems with your PC, you can restore it back to an earlier point in time, called a restore point. System Restore doesn't change your personal files, but it might remove recently installed apps and drivers.

  To use System Restore to restore Windows XP to a previous state, follow these steps:

  1. Log on to Windows as an administrator.
  2. Click **Start**, point to **All Programs**, point to **Accessories**, point to **System Tools**, and then click **System Restore**. (The screenshot for this step is listed below).

        :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/system-restore-menu.png" alt-text="Screenshot shows System Restore menu." border="false":::

  3. On the **Welcome to System Restore** page, click to select the **Restore my computer to an earlier time** option, and then click **Next**. (The screenshot for this step is listed below).

        :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/welcome-to-system-restore.png" alt-text="Screenshot of Welcome to System Restore page." border="false":::

  4. On the **Select a Restore Point** page, click the most recent system restore point On this list, click a **restore point** list, and then click **Next**.

      > [!NOTE]
      > A System Restore message may appear that lists configuration changes that System Restore will make. Click **OK**. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/select-a-restore-point.png" alt-text="Screenshot of Select a Restore Point page.":::

  5. On the **Confirm Restore Point Selection** page, click **Next**. System Restore restores the previous Windows XP configuration, and then restarts the computer.
  6. Log on to the computer as an administrator. Then, click **OK** on the **System Restore Restoration Complete** page. (The screenshot for this step is listed below).

      :::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/restoration-complete.png" alt-text="Screenshot of the Restoration Complete page.":::

  If you successfully restored your computer to a previous state and the computer runs as expected, you are finished.

If the procedure that corresponds to your operating system does not resolve your issue, go to [Fix Wi-Fi connection issues in windows](https://support.microsoft.com/help/10741/windows-fix-network-connection-issues#network-problems=windows-7&v1h=win8tab1&v2h=win7tab1&v3h=winvistatab1&v4h=winxptab1). The guidance that's offered there will help you identify network connection issues and run automated troubleshooters to fix the issues.

After you click this link, verify that the steps that are provided correspond to your operating system. To do this, click the drop-down arrow, and then select your operating system. (The screenshot for this step is listed below).

:::image type="content" source="media/internet-explorer-cannot-display-the-webpage-error/select-your-operating-system.png" alt-text="Screenshot of selecting your operating system.":::
