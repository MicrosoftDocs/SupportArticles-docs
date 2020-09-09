---
title: The Advanced Client no longer works
description: Describes a problem that occurs if a Group Policy Object is configured to set the startup mode of the SMS Agent Host service to Automatic.
ms.date: 08/20/2020
ms.prod-support-area-path:
ms.prod: configuration-manager
ms.reviewer: v-jomcc
---
# The Advanced Client in SMS 2003 and Configuration Manager 2007 no longer works after deploying Windows XP SP2

This article helps you fix an issue in which the Advanced Client no longer works if a Group Policy Object (GPO) is configured to set the startup mode of the SMS Agent Host service to **Automatic**.

_Original product version:_ &nbsp; Systems Management Server 2003, System Center Configuration Manager 2007  
_Original KB number:_ &nbsp; 919592

> [!IMPORTANT]
> This article contains information that shows you how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment. If you implement this workaround, take any appropriate additional steps to help protect your system.

## Symptoms

After you deploy Microsoft Windows XP Service Pack 2 (SP2) to client computers that are running the Advanced Client in Microsoft Systems Management Server (SMS) 2003 or in System Center Configuration Manager 2007, you experience the following symptoms:

- The Advanced Client no longer functions correctly on the client computer. In this situation, the Advanced Client no longer retrieves SMS policies. If you try to start an action in the Advanced Client on the client computer, you receive the following error message:

  > The action could not be initiated.

- When you view the SMS log files, information that resembles the following information is displayed:

    In the %WINDIR%\System32\CCM\Logs\CcmExec.log file on the client computer

    > Error calling CoResumeClassObjects.CcmExec\<date> \<time>3304 (0x0CE8)  
    > Phase 1 initialization failed (0x80004015).CcmExec\<date> \<time>3304 (0x0CE8)  
    > Phase 1 initialization failed (0x80004015).CcmExec\<date> \<time>3304 (0x0CE8)

    In the %WINDIR%\System32\CCM\Logs\execmgr.log file on the client computer

    > Command line = "\\\\\<server>\\\<share>$\\\<folder>\update\update.exe" /q /f /forcerestart,  
    > Working Directory = \\\\\<server>\\\<share>$\\\<folder>\execmgr\<date> \<time>3292 (0x0CDC)  
    > Created Process for the passed command lineexecmgr\<date> \<time>3292 (0x0CDC)  
    > Raising event:  
    > [SMS_CodePage(437), SMS_LocaleID(1033)]  
    > instance of SoftDistProgramStartedEvent  
    > {  
    > AdvertisementId = "\<ID>";  
    > ClientID = "GUID:\<GUID>";  
    > CommandLine = "\\"\\\\\\\\\<server>\\\\\<share>$\\\\\<folder>\\\\update\\\\update.exe\\" /q /f /forcerestart";  
    > DateTime = "\<date and time>.572000+000";  
    > MachineName = "\<computername>";  
    > PackageName = "\<packagename>";  
    > ProcessID = 228;  
    > ProgramName = "Automated upgrade from XP or XPSP1";  
    > SiteCode = "\<siteCode>";  
    > ThreadID = 3292;  
    > UserContext = "NT AUTHORITY\\\SYSTEM";  
    > WorkingDirectory = "\\\\\\\\\<server>\\\\\<share>$\\\\\<folder>\\\\";  
    > };  
    > execmgr\<date> \<time>3292 (0x0CDC)  
    > Raised Program Started Event for Ad:\<ID>, Package:\<package>, Program: Automated upgrade from XP or XPSP1execmgr\<date> \<time>3292 (0x0CDC)  
    > The user has logged off.execmgr\<date> \<time>2656 (0x0A60)  
    > Program Automated upgrade from XP or XPSP1 is running when user loggs offexecmgr\<date> \<time>2656 (0x0A60)  
    > Execution Manager timer has been fired.execmgr\<date> \<time>1348 (0x0544)  
    > Policy is updated for Program: MS04-028 - JPEG Update for XP, Package: \<package>, Advert: \<ID>execmgr\<date> \<time>1408 (0x0580)  
    > Program exit code 3010execmgr\<date> \<time>2904 (0x0B58)  
    > Looking for MIF file to get program statusexecmgr\<date> \<time>2904 (0x0B58)  
    > Script for Package:\<package>, Program: Automated upgrade from XP or XPSP1 succeeded with exit code 3010execmgr\<date> \<time>2904 (0x0B58)  
    > Raising event:  
    > [SMS_CodePage(437), SMS_LocaleID(1033)]  
    > instance of SoftDistProgramPrelimSuccessEvent  
    > {  
    > AdvertisementId = "\<ID>";  
    > ClientID = "GUID:\<GUID>";  
    > DateTime = "\<date> \<time>.781000+000";  
    > ExitCode = "3010";  
    > MachineName = "\<computername>";  
    > PackageName = "\<package>";  
    > ProcessID = 228;  
    > ProgramName = "Automated upgrade from XP or XPSP1";  
    > SiteCode = "\<siteCode>";  
    > ThreadID = 2904;  
    > };  
    > execmgr\<date> \<time>2904 (0x0B58)  
    > Raised Program Prelim Success Event for Ad:\<ID>, Package:\<package>, Program: Automated upgrade from XP or XPSP1execmgr\<date> \<time>2904 (0x0B58)  
    > Execution is complete for program Automated upgrade from XP or XPSP1. The exit code is 3010, the execution status is SuccessRebootRequiredexecmgr\<date> \<time>2904 (0x0B58)  
    > Rebooting the computer - InitiateSystemShutdownEx failed 1115execmgr\<date> \<time>2904 (0x0B58)

    In the *drive*:\SMS_CCM\Logs\SMSCliUi.log file on the SMS server

    > Current Assigned Site: \<siteCode>smscliui\<date> \<time>3320 (0x0CF8)  
    > Unable to get CacheInfo. Error: 0X80070005smscliui\<date> \<time>3320 (0x0CF8)  
    > SMS Site code has not been changed.smscliui\<date> \<time>3320 (0x0CF8)  
    > Current Assigned Site: \<siteCode>smscliui\<date> \<time>3660 (0x0E4C)  
    > Unable to get CacheInfo. Error: 0X80070005smscliui\<date> \<time>3660 (0x0E4C)  
    > Failed to instantiate CLSID_CCMClientAction class, error: 0x80070005smscliui\<date> \<time>3660 (0x0E4C)

## Cause

This problem occurs if a GPO is configured to set the SMS Agent Host service (CcmExec.exe) startup mode to **Automatic**.

> [!NOTE]
> By default, the SMS Agent Host service is not configured by using Group Policy.

## Resolution 1: Don't define the SMS Agent Host service in Group Policy

Modify the GPO to no longer define the startup mode for the SMS Agent Host service. To do this, follow these steps:

1. Log on to a domain controller, and then start the Active Directory Users and Computers tool. To do this, click **Start** > **Run**, type `dsa.msc` in the **Open** box, and then click **OK**.

2. Right-click the container in which the GPO was created, and then select **Properties**. For example, right-click the domain container or right-click an organizational unit, and then select **Properties**.

3. Select the **Group Policy** tab, select the GPO in which the **SMS Agent Host** service is defined, and then select **Edit**.

4. In the Group Policy Object Editor tool, expand **Computer Configuration** > **Windows Settings** > **Security Settings**, and then select **System Services**.

5. In the right pane, double-click **SMS Agent Host**, click to clear the **Define this policy setting** check box, and then click **OK**.

6. Exit the Group Policy Object Editor tool, and then click **OK**.

7. Restart the Windows XP SP2-based client computers.

## Resolution 2: Assign the NetworkService account Full Control permissions to the SMS Agent Host object

> [!WARNING]
> This workaround may make your computer or your network more vulnerable to attack by malicious users or by malicious software such as viruses. We don't recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk.

You can keep the SMS Agent Host service automatic startup Group Policy if you assign the NetworkService account Full Control permissions to the SMS Agent Host object in Group Policy. To do this, follow these steps:

1. Log on to a domain controller, and then start the Active Directory Users and Computers tool. To do this, click **Start** > **Run**, type `dsa.msc` in the **Open** box, and then click **OK**.

2. Right-click the container in which the GPO was created, and then select **Properties**. For example, right-click the domain container or right-click an organizational unit, and then select **Properties**.

3. Select the **Group Policy** tab, select the GPO in which the **SMS Agent Host** service is defined, and then select **Edit**.

4. In the Group Policy Object Editor tool, expand **Computer Configuration** > **Windows Settings** > **Security Settings**, and then select **System Services**.

5. In the right pane, double-click **SMS Agent Host**, and then select **Edit Security**.

6. In the **Security for SMS Agent Host** dialog box, select **Add**.

7. Type NetworkService in the **Enter the object names to select** box, click **Check Names**, and then click **OK**.

8. In the **Permissions for NetworkService** box, select the **Full Control** check box in the **Allow** column, and then click **OK**.

9. In the **SMS Agent Host Properties** dialog box, click **OK**.

10. Exit the Group Policy Object Editor tool, and then click **OK**.
