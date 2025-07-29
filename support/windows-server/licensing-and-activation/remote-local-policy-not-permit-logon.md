---
title: Local Policy of This System Doesn't Permit to Logon Interactively
description: Provides a resolution to a remote desktop connection error "The local policy of this system does not permit you to logon interactively."
ms.date: 07/25/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:windows activation\windows activation issues
- pcy:WinComm Devices Deploy
---
# Remote desktop connection "The local policy of this system does not permit you to logon interactively"

## Symptoms

If you aren't an administrator and try to use the Remote Desktop Connection tool, you may receive the following error message:

> The local policy of this system does not permit you to logon interactively.

## Cause

This issue occurs because the user account isn't a member of the local Remote Desktop Users group.

## Resolution

To have us resolve this issue for you, go to the [Fix it for me](#fix-it-for-me) section. If you prefer to fix this problem yourself, go to the [Let me fix it myself](#let-me-fix-it-myself) section.

### Fix it for me

To fix this problem automatically, select the **Fix it** button or link. Select **Run** in the **File Download** dialog box, and follow the steps in the Fix it wizard.

> [!Note]
>
> - Type the user account in the **Users** box during the installation of the Fix it solution.
> - To add a domain user account to the local Remote Desktop Users group, use the following format: **Domain\Username**.
> - To add a local user account to the local Remote Desktop Users group, use the following format: **Username** or **.\Username**.
> - To add multiple user accounts to the local Remote Desktop Users group,use the semicolon(;) character as the separator.For example: **Username1;Username2**.
> - This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.
> - If you are not using the computer that has the problem, save the Fix it solution to a flash drive or a CD and then run it on the computer that has the problem.

Then, go to the "Did this fix the problem?" section.

### Let me fix it myself

To resolve this issue, add allowed users to the Remote Desktop Users list:

1. Select **Start**, point to **Settings**, and then select **Control Panel**.
2. Double-click **System**, and then on the **Remote** tab, select **Select Remote Users**.
3. Select **Add type** in the user account name, and then select **OK**.

    If you're adding more than one user name, use a semicolon to separate the names.

> [!Note]
> Adding users to the Remote Desktop Group requires that you are logged on through an administrator account.

Also, make sure that the Remote Desktop Users group has sufficient permissions to log on through Terminal Services. To do this, follow these steps:

1. Select **Start** > **Run**, type **secpol.msc**, and then select **OK**.
2. Expand **Local Policies**, and then select **User Rights Assignment**.
3. In the right pane, double-click **Allow logon through Terminal Services**. Make sure that the Remote Desktop Users group is listed.
4. Select **OK**.
5. In the right pane, double-click **Deny logon through Terminal Services**. Make sure that the Remote Desktop Users group isn't listed, and then select **OK**.
6. Close the **Local Security Settings** snap-in.

### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/contactus).

We would appreciate your feedback. To provide feedback or to report any issues with this solution, leave a comment on the "Fix it for me" blog or send us an
email.
