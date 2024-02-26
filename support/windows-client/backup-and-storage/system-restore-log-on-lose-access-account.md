---
title: How to use System Restore to log on
description: Describes how to recover when a password is corrupted or when a user account is lost.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:system-restore-or-resetting-your-computer, csstroubleshoot
---
# How to use System Restore to log on when you lose access to an account

This article provides some information about how to use System Restore to log on when you lose access to an account.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 940765

>[!NOTE]
Support for Windows Vista without any service packs installed ended on April 13, 2010. To continue receiving security updates for Windows, make sure you're running Windows Vista with Service Pack 2 (SP2). For more information, visit this Microsoft web page: [Support is ending for some versions of Windows](https://windows.microsoft.com/windows/help/end-support-windows-xp-sp2-windows-vista-without-service-packs)  

## Introduction

This article describes how to use the System Restore feature to log on to Windows 7 or Windows Vista when you lose access to an account.

## More information

If you cannot log on to Windows 7 or Windows Vista, you can use the Windows Vista System Restore feature, or the Windows 7 System Restore feature.

You may be unable to log on to Windows Vista or Windows 7 in the following scenarios:  

- Scenario 1: You recently set a new password for the protected administrator account. However, you don't remember the password.
- Scenario 2: You type the correct logon password. However, Windows Vista or Windows 7 does not accept the password because the system is corrupted.
- Scenario 3: You delete a protected administrator account. Now, you can't log on to another administrator account.
- Scenario 4: You change a protected administrator account to a standard user account. Now, you can't log on to another administrator account.  

To use System Restore to log on to Windows Vista or Windows 7 when you lose access to an account, follow these steps.

> [!NOTE]
> To do this, there must be a System Restore point at which the logon was successful.

1. Insert the Windows Vista or Windows 7 DVD, and then restart the computer.
2. When you receive the following message, press any key: Press any key to boot from CD or DVD.

3. Set the following preferences, and then click **Next:
   - **Language to install**  
   - **Time and currency format**  
   - **Keyboard or input method**  
4. Click **Repair your computer**, select the operating system that you want to repair, and then click **Next**.
5. Click **System Restore**, and then click **Next**.
6. Click the restore point that you want to use, and then click **Next**.

   > [!NOTE]
   > Click a restore point that will return the computer to a state where the logon is successful. After you use the System Restore feature, reinstall any programs or updates that may be removed. You will not lose any personal documents. However, you may have to reinstall programs. You may also have to reset some personal settings.
7. Confirm the disks that you want to restore, and then click **Next**.
8. Click **Finish**, and then click **Yes** for the prompt box.
9. When the System Restore process is complete, click **Restart** to restart the computer.
10. After the computer restarts, click **Close** to confirm that the System Restore process has finished successfully.
11. Use an appropriate method to log on. For example, log on by using an older password, or log on by using another computer account. After you log on, you must follow additional steps, depending on the scenario that you experience.

### Additional steps for scenario 1

1. After you log on, change the password for the protected administrator account.
2. After you change the password, restart the computer. Make sure that you can log on by using the new password.

### Additional steps for scenario 2

1. After you log on, make sure that each user account can log on by using the appropriate credentials.
2. Change the password for the user account that cannot log on.

### Additional steps for scenario 3

1. After you log on, use the User Accounts item in Control Panel to create a new protected administrator account.
2. Log on by using the new protected administrator account. Then, delete the older protected administrator account that was restored.

   > [!NOTE]
   > For safety reasons, do not use the restored protected administrator account.

### Additional steps for scenario 4

1. After you log on, use the User Accounts item in Control Panel to create a new protected administrator account.
2. Log on by using the new protected administrator account.
3. Change the old protected administrator account to a standard user account.
