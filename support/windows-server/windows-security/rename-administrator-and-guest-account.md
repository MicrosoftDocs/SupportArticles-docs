---
title: Rename administrator and guest accounts
description: Describes how to change the administrator account and guest account names by using Group Policy.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lanac
ms.custom: sap:account-lockouts, csstroubleshoot
---
# Rename the administrator and guest account in Windows Server 2003

This article describes how to change the administrator account and guest account names by using Group Policy.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 816109

## Summary

This step-by-step article describes how to change the administrator account and guest account names by using Group Policy in Microsoft Windows Server 2003. This may be useful if you want to change the name of the administrator or guest user accounts to minimize the chance of misuse of these accounts.

## Create a Group Policy Object

To create a Group Policy object (GPO) to change the administrator and guest account names:

1. Start the Active Directory Users and Computers snap-in. To do so, click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. In the console tree, right-click the domain or the organizational unit where you want to create the group policy, and then click
 **Properties**.
3. Click the **Group Policy** tab, and then click **New**.
4. Type the name that you want to use for this policy. For example, type *Rename Administrator and Guest accounts*, and then press ENTER.
5. Click **Close**.

## Rename the administrator and guest accounts

1. Start the Active Directory Users and Computers snap-in.
2. In the console tree, right-click your domain or the organizational unit that contains the Group Policy that you want, and then click **Properties**.
3. Click the **Group Policy** tab, click the Group Policy object that you want, and then click **Edit**. For example, click the **Rename Administrator and Guest accounts** Group Policy object, and then click **Edit**.
4. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then click **Security Options**.
5. In the right pane, double-click **Accounts: Rename administrator account**.
6. Click to select the **Define this policy setting** check box, and then type the new name that you want to use for the administrator account.
7. Click **OK**.
8. Double-click **Accounts: Rename guest account**.
9. Click to select the **Define this policy setting** check box, and then type the new name that you want to use for the guest account.
10. Click **OK**, and then quit the Group Policy Object Editor snap-in.
11. Quit the Active Directory Users and Computers snap-in.

## Troubleshoot

If you try to reverse the changes to the administrator or guest account names by clearing the **Define this policy setting** check box in the **Rename guest account** or **Rename administrator account** dialog boxes, you may not be able to log on to the domain by using the default account names. To resolve this issue, use Group Policy to restore the default account names, and then clear the **Define this policy setting** check box:

1. Start the Active Directory Users and Computers snap-in.
2. In the console tree, right-click your domain or the organizational unit that contains the Group Policy that you want, and then click **Properties**.
3. Click the **Group Policy** tab, click the Group Policy object that you want, and then click **Edit**.
4. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then click **Security Options**.
5. In the right pane, double-click **Accounts: Rename administrator account**.
6. Click to select the **Define this policy setting** check box, and then type *Administrator*. Click **OK**.
7. Double-click **Accounts: Rename guest account**.
8. Click to select the **Define this policy setting** check box, and then type *Guest*.
9. Click **OK**, and then quit the Group Policy Object Editor snap-in.
10. Quit the Active Directory Users and Computers snap-in.
11. Click **Start**, click **Run**, type *cmd* in the **Open** box, and then click **OK**.
12. At the command prompt, type the following commands, pressing ENTER after each command:
    - `gpupdate`
    - `exit`
13. Start the Active Directory Users and Computers snap-in.
14. In the console tree, right-click your domain or the organizational unit that contains the Group Policy that you want, and then click **Properties**.
15. Click the **Group Policy** tab, click the Group Policy object that you want, and then click **Edit**.
16. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then click **Security Options**.
17. In the right pane, double-click **Accounts: Rename administrator account**.
18. Click to clear the **Define this policy setting** check box, and then click **OK**.
19. Double-click **Accounts: Rename guest account**.
20. Click to clear the **Define this policy setting** check box, and then click **OK**.
21. Click **OK**, and then quit the Group Policy Object Editor snap-in.
22. Quit the Active Directory Users and Computers snap-in.
