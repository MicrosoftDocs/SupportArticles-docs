---
title: Can't display name of last logged-on user
description: Describes how to prevent the name of the last logged-on user from being displayed in the Log On to Windows dialog box.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, JAMIRC
ms.custom: sap:lock-screen-or-screensaver, csstroubleshoot
---
# How to prevent the name of the last logged-on user from being displayed in the Log On to Windows dialog box in Windows Server 2003  

This article describes how to prevent the name of the last logged-on user from being displayed in the **Log On to Windows** dialog box.

_Applies to:_ &nbsp; Windows 10 - all editions,  Windows Server 2012 R2  
_Original KB number:_ &nbsp; 324740

## Summary

By default, Windows displays the name of the last user who successfully logged on to the computer. This name is displayed in the **Log On to Windows** dialog box. Security administrators may prefer that the last logged-on user name not be displayed in the **Log On to Windows** dialog box. Although this configuration requires that users must type their user name (and password) each time that they sign in, it can help to prevent attempts by unauthorized users to gain access to the computer.

You can use Group Policy to prevent the name of the last logged-on user from being displayed in the **Log On to Windows** dialog box. The group policy can apply to the local computer, sites, domains, and organizational units (OU).

## Resolution

1. Select **Start**, select **Run**, type mmc in the **Open** box, and then select **OK**.
2. On the **File** menu, select **Add/Remove Snap-in**.
3. Select **Add**.
4. Select **Group Policy Object Editor**, and then select **Add**.
5. Select the target Group Policy object (GPO). The default GPO is Local Computer. Click **Browse** to select the GPO that you want, and then select **Finish**.
6. Select **Close**, and then select **OK**.
7. Expand the group policy object, expand **Computer Configuration**, expand **Windows Settings**, and then expand **Security Settings**.
8. Expand **Local Policies**, and then select **Security Options**.
9. In the right pane, double-click **Interactive logon: Do not display last user name**.
10. Click to select the **Define this policy setting** check box (if it's present), and then select **Enabled**.
11. Select **OK**.

## Troubleshooting

Microsoft Windows NT 4.0-based computers don't support Windows Server 2003 Group Policy.

## References

For more information about working with Group Policy in Windows Server 2003, see Group Policy Help. To do it, select **Help** on the **Action** menu in the Group Policy Object Editor snap-in, select the **Contents** tab, and then select **Group Policy**.
