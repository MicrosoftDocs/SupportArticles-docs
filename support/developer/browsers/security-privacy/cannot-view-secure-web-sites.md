---
title: Cannot view secure Web sites in Internet Explorer 8
description: "This article provides several methods to resolve the problem of secure Web sites (https://) not displaying in Internet Explorer 8 and later versions of Internet Explorer."
ms.date: 03/08/2020
---
# You cannot view a secure Web site in Internet Explorer 8 and later versions

[!INCLUDE [](../../../includes/browsers-important.md)]

This article introduces many methods to solve the issue that you cannot view a secure web site in Internet Explorer 8 and later versions of Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 8 and later versions  
_Original KB number:_ &nbsp; 968089

## Symptoms

When you try to view secure Web site by using Microsoft Internet Explorer 8 or a later version of Internet Explorer, you cannot access the Web site.

> [!NOTE]
> Secure Web sites are generally accessed by using a URL that includes the `https://` protocol.

## Resolution 1: Delete browsing history

Internet Explorer could be using old information when you try to view the Web page. Try deleting your browsing history to see whether the problem is resolved. Follow these steps:

1. Click **Start**, and then click Internet Explorer.

2. Click **Tools**, and then click **Delete Browsing History**.

3. In Delete Browsing History, click **Delete All**.

4. Click to select the **Also delete files and settings stored by add-ons** check box, and then click **OK**.

5. Try to view the Web page again to see whether it works correctly.

If the Web page works correctly, you are finished with this article. If the Web page does not work correctly, try the next resolution.

## Resolution 2: Run Internet Explorer in No Add-ons mode

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

## Resolution 3: Make sure that the Date and Time settings are correct

Some secure sites require that the date and time match the date and time of the secure site. Make sure that the **Date and Time** settings are correct on the computer. To do this, follow these steps:

1. In Control Panel, open **Date and Time**. To do this, click **Start**, type date and time in the **Start Search** box, and then click **Date and Time** in the **Programs** list.

2. Click **Change date and time**.

3. In the **Date and Time Settings** dialog box, set the date and time to the correct values.

4. Click **OK** two times.

## Resolution 4: Reset Internet Explorer settings

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

## Resolution 5: Perform System Restore

1. Click **Start**, and then click **All Programs**.

2. Click **Accessories**, and then click **System Tools**.

3. Click **System Restore**. If you are prompted for an administrator password or confirmation, type the password or provide confirmation.

4. Try to view the Web page again to see whether it works correctly.
