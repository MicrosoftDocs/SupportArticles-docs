---
title: Cannot view secure Web sites in Internet Explorer 8
description: This article provides several methods to resolve the problem of secure Web sites (https://) not displaying in Internet Explorer 8.
ms.date: 03/08/2020
ms.prod-support-area-path: Internet Explorer
---
# You cannot view a secure Web site in Internet Explorer 8

This article introduces many methods to solve the issue that you cannot view a secure web site in Internet Explorer 8.

_Original product version:_ &nbsp; Internet Explorer 8  
_Original KB number:_ &nbsp; 968089

## Symptoms

When you try to view secure Web site by using Microsoft Internet Explorer 8, you cannot access the Web site.

> [!NOTE]
> Secure Web sites are generally accessed by using a URL that includes the `https://` protocol.

## Resolution: Enable Compatibility View in Internet Explorer

The Web site might not be fully compatible with Internet Explorer 8 and might not be displayed correctly. You can enable Compatibility View for the Web site to see whether that resolves the problem.

### Method 1: Enable Compatibility View for a Web site

To enable Compatibility View for a specific Web site that is not displayed correctly or that is not working correctly, follow these steps:

1. Click **Start**, and then click Internet Explorer.

2. Enter the address of the Web site that is not displayed correctly or that does not work correctly, and press ENTER.

3. Click the Compatibility View icon that is located to the right of the address bar.

   > [!NOTE]
   > Compatibility view is not required, and the Compatibility View commands will not be available, if the Web site was designed for earlier versions of Internet Explorer.

4. After you enable Compatibility View, the Web site will automatically refresh, and you may see a message that states that the Web site is running in Compatibility View.

If the Web site displays and works correctly, you are finished. However, you may have to repeat this method for each Web site that has this problem. If you want to do this for all Web sites, see Method 2.

When you use this method to fix a Web site display problem, Internet Explorer saves your Compatibility View setting for that Web site. Every time that you visit that site, Compatibility View will be used. To stop a Web site from running in Compatibility View, click the Compatibility View icon when you view the Web site.

You can also add or remove specific Web sites from Compatibility View without actually visiting each Web site. To do this, click **Tools**, and then click **Compatibility View Settings**. Add or remove Web sites in this window.

If the Web site is not displayed correctly or is not working, you are experiencing a different problem. Try the other resolutions in this section.

### Method 2: Enable Compatibility View for all Web sites

Consider the following scenario. Most Web sites that you frequently visit are not displayed correctly or are not working correctly. You have tried Method 1 on some of these Web sites, and that method worked. In this case, you may want to enable Compatibility View for all Web sites. To do this, follow these steps:

1. Click **Start**, and then click Internet Explorer.

2. On the **Tools** menu, click **Compatibility View Settings**.

   > [!NOTE]
   > If Compatibility View Settings is not available, your network administrator may have used a Group Policy setting to configure the options for you. Contact your administrator or the help desk.

3. Click to select the **Display all websites in Compatibility View** check box, and then click **Close**.

4. Visit several Web sites that did not display correctly or that did not work correctly to make sure the problem is resolved.

## Resolution: Delete browsing history

Internet Explorer could be using old information when you try to view the Web page. Try deleting your browsing history to see whether the problem is resolved. Follow these steps:

1. Click **Start**, and then click Internet Explorer.

2. Click **Tools**, and then click **Delete Browsing History**.

3. In Delete Browsing History, click **Delete All**.

4. Click to select the **Also delete files and settings stored by add-ons** check box, and then click **OK**.

5. Try to view the Web page again to see whether it works correctly.

If the Web page works correctly, you are finished with this article. If the Web page does not work correctly, try the next resolution.

## Resolution: Run Internet Explorer in No Add-ons mode

Although browser add-ons can enhance your online experience, they can occasionally interfere or conflict with other software on your computer. Try starting Internet Explorer without add-ons to see whether the problem is resolved. Follow these steps:

1. Click **Start**, and then click Internet Explorer.

2. Click Internet Explorer (No Add-ons). Internet Explorer opens without add-ons, toolbars, or plug-ins.

3. Try to view the Web page again to see whether it works correctly.

If disabling all add-ons resolves the problem, you might want to use Add-on Manager to disable all add-ons and then turn on add-ons only as you need them. This will let you determine which add-on is causing the problem.

1. Click **Start**, and then click Internet Explorer.

2. Click **Tools**, and then click **Internet Options**.

3. Click the **Programs** tab, and then click **Manage add-ons**.

4. Click an add-on in the Name list, and then click **Disable**.

5. Try to view the Web page again to see whether it works correctly.

6. If the Web page works correctly, you know that the add-on caused the problem. If you still cannot view the Web page, the add-on did not cause the problem, and you can enable it again.

7. Repeat steps 4 through 6 until you identify the add-on that is causing the problem. After you disable it, you are finished with this article.

If no add-on is causing the problem, try the next resolution.

## Resolution: Make sure that the Date and Time settings are correct

Some secure sites require that the date and time match the date and time of the secure site. Make sure that the Date and Time settings are correct on the computer. To do this, follow these steps:

1. In Control Panel, open **Date and Time**. To do this, click **Start**, type date and time in the **Start Search** box, and then click **Date and Time** in the **Programs** list.

2. Click **Change date and time**.

3. In the **Date and Time Settings** dialog box, set the date and time to the correct values.

4. Click **OK** two times.

## Resolution: Reset Internet Explorer settings

Try resetting Internet Explorer back to its default settings. This removes all changes that were made to Internet Explorer since it was installed, but it does not delete your favorites or feeds. Follow these steps:

1. Close all Internet Explorer and Windows Explorer windows.

2. Click **Start**, and then click Internet Explorer.

3. Click **Tools**, and then click **Internet Options**.

4. Click the **Advanced** tab, and then click **Reset**.

5. In the **Reset Internet Explorer Settings** dialog box, click **Reset**.

6. When Internet Explorer finishes restoring the default settings, click **Close**, and then click **OK** two times.

7. Close Internet Explorer, and reopen it for the changes to take effect.

8. Try to view the Web page again to see whether it works correctly.

If the Web page works correctly, you are finished with this article. If the Web page does not work correctly, try the next resolution.

## Resolution: Perform System Restore

1. Click **Start**, and then click **All Programs**.

2. Click **Accessories**, and then click **System Tools**.

3. Click **System Restore**. If you are prompted for an administrator password or confirmation, type the password or provide confirmation.

4. Try to view the Web page again to see whether it works correctly.

If the Web page works correctly, you are finished with this article. If the Web page does not work correctly, see the [More Information](#more-information) section.

## More Information

For more information for advanced users, see [Windows Internet Explorer 8 release notes](https://docs.microsoft.com/previous-versions/dd441788(v=msdn.10)).
