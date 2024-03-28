---
title: Log-off problems
description: Discusses log off problems in Windows XP, in Windows Server 2003, in Windows 2000, and in Windows NT 4.0.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:User Logon and Profiles\Service Account and Interactive User Logon Issues and Credential Providers, csstroubleshoot
---
# You experience log-off problems on a Windows XP-based, Windows Server 2003-based, Windows 2000-based, or Windows NT 4.0-based computer

This article contains a step-by-step method to help you resolve the log-off problems in Windows XP, in Windows Server 2003, in Windows 2000, and in Windows NT 4.0.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10  
_Original KB number:_ &nbsp; 837115

## Introduction

When you try to log off from your computer, you can't log off, or event messages that are logged in the Application log indicate that the user profile wasn't unloaded. This problem may occur if Microsoft Windows or third-party programs don't stop running when you try to log off from your computer. This article contains a step-by-step method to help you resolve this problem.

If you're viewing this Web content on the computer that has the problem, you can use the automatic detection and fix tool that this content contains. The tool will help make the troubleshooting process faster, more accurate, and much easier for you. If you're not on the computer that has the problem, print this Web content, and use it on the computer that has the problem.

## Symptoms

When you try to log off from a computer that is running Windows Server 2003, Windows XP, Windows 2000, or Windows NT 4.0, you may experience one or more of the following symptoms:

- The application event IDs 1000, 1500, 1517, 1524 are logged in the Application log. Viewing events in the Application log is the most accurate method to determine user profile unload errors. If you don't see these events in the Application log, you don't have user profile unload errors. For more information about the event messages in the Application log, see the [Event messages in the Application log](#event-messages-in-the-application-log) section.
- The cached profile isn't deleted when you use a roaming user profile that is configured to delete the locally cached copy of the profile when you log off. Symptoms of this error are recorded as event messages in the Application log.
- In Windows XP and in Windows Server 2003, you can log off, but you can't recover the memory that the user profile uses until the user profile can be unloaded. You can log off because the roaming user profile is reconciled by using a copy of the contents of the registry. Symptoms of this error are recorded as event messages in the Application log.
- When you try to log off in Windows 2000, the "Saving settings..." message is displayed for a long time, and Windows stops trying to log off. If you're using a roaming user profile on a network, Windows indicates that the user profile on the computer doesn't reconcile with the roaming user profile on the network. You cannot log on because the user profile did not log off. Symptoms of this error are recorded as event messages in the Application log.
- In Windows NT 4.0, you can't log off and the roaming user profile isn't reconciled.

- You reach the registry size limit (RSL).
- Backups may not start. There are no errors in the Application log from the backup program. However, if you see event ID 1524, the backup hasn't run.

## Use the Microsoft User Profile Hive Cleanup Service to reconcile user profiles

To resolve this problem, use the Microsoft User Profile Hive Cleanup Service (UPHClean). UPHClean monitors the computer while you log off, and then UPHClean unloads and reconciles user profiles so that you can log off. This method shows how to install and to run UPHClean.

> [!NOTE]
> UPHClean is supported under the following operating systems:
>
> - Windows XP
> - Windows Server 2003
> - Windows 2000 (all versions)  
>
> The current version of UPHClean (v1.6d) does not function under x64-based versions of Windows XP or of Windows Server 2003. A future version of UPHClean may be supported under those operating systems.

> [!IMPORTANT]
> This method requires you to browse away from the page that you are now viewing. By browsing away from this page, the content that you are now viewing will no longer be displayed. So, before you continue, you might find it helpful to create a shortcut to this Web page on your desktop so that you can easily return to this page by double-clicking the shortcut. To create a shortcut to this Web page on your desktop, follow these steps:
>
> 1. Right-click this page, and then click **Create Shortcut**.
> 2. In the **Internet Explorer** dialog box, click **Yes** to create a shortcut on your desktop.

This method is rated: Easy.

Estimated Time: 10 minutes or more, depending on your Internet connection speed.

To use the Microsoft User Profile Hive Cleanup Service (UPHClean), follow these steps:

1. Download UPHClean.
2. As soon as you've downloaded the UPHClean installer (UPHClean-Setup.msi), double-click the installer to begin the installation.
3. In the User Profile Hive Cleanup Service installation wizard, click **Next**.
4. In the License Agreement page, read the license agreement, select **I Agree**, and then click **Next**.
5. In the Select Installation Folder page, click **Next**.
6. In the Confirm Installation page, click **Next**.
7. When UPHClean is installed, click **Close**.
    > [!NOTE]
    > UPHClean runs as a service in Windows and will start automatically every time that Windows starts.
8. To confirm that UPHClean is installed and running, click **Start**, and then click **Run**.
9. In **Open** box, type the following text, and then click **OK**:

    *services.msc*
10. In Services, in the **Name** column, locate **User Profile Hive Cleanup**. In the **Status** column, confirm that the User Profile Hive Cleanup service is **Started**.

> [!IMPORTANT]
> Windows Vista and Windows Server 2008 include the functionality of UPHClean. Uninstall UPHClean before you upgrade to Windows Vista or to Windows Server 2008. For more information about how to uninstall UPHClean, see the [How to uninstall the User Profile Hive Cleanup service section.

> [!NOTE]
> If you receive an error when you install UPHClean, try the following:
>
> - Download UPHClean to your computer again. If you are trying to install UPHClean from a computer on your company's network, copy the UPHClean installer (UPHClean-Setup.msi) to your computer first. Then follow the steps in this section again to install UPHClean.
> - Install the latest run-time components for Visual C++ applications. Then follow the steps in this section again to install UPHClean. If you are using Windows NT 4.0, restart your computer after you install the latest run-time components for Visual C++ applications.

### Verification

To verify that this method worked, log off Windows. Windows should log off immediately. Open the Application log and determine if any event messages indicate that there were user profile errors. For more information about the event messages in the Application log, see the [Event messages in the Application log](#event-messages-in-the-application-log) section.

If this method worked: If you can log off Windows, and there are no event messages that indicate that there were user profile unloading errors, you've successfully corrected the problem.

If this method didn't work: If you can't log off Windows, or there are event messages that indicate that there were user profile unloading errors, this method didn't work. You might want to ask someone for help, or you might want to try Advanced Troubleshooting.

## Advanced Troubleshooting

If the resources listed in this article don't help you resolve the problem or if you experience symptoms that differ from those that are described in this article, search the Microsoft Knowledge Base for more information. To search the Microsoft Knowledge Base, visit the following Microsoft Web site:

 [https://support.microsoft.com](https://support.microsoft.com)

Then, type the text of the error message that you receive, or type a description of the problem, in the search field.

## Contact Support

If the problem isn't resolved, unfortunately this content is unable to help you any further. So, you might want to ask someone for help, or you might want to visit the following Microsoft Web site:

 [https://support.microsoft.com/contactus](https://support.microsoft.com/contactus)

## More information

### User profiles and user accounts

Your user profile is a collection of settings that make the computer look and work the way that you want it to look and to work. Your user profile contains your settings for desktop backgrounds, for screen savers, for pointer preferences, for sound settings, and for other features. User profiles make sure that your personal preferences are used when you log on to Windows.

A user profile differs from a user account that you use to log on to Windows. Each user account has at least one user profile associated with it.

A user account defines the actions a user can perform in Windows. On a stand-alone computer or on a computer that is a member of a workgroup, a user account establishes the permissions that are assigned to each user. On a computer that is part of a network domain, a user must be a member of at least one group. The permissions and the rights that are granted to a group are assigned to its members.

For information about user profile hives, visit the following Microsoft Web sites:

 [User profile hives](https://msdn.microsoft.com/library/aa918365.aspx)

 [Registry types](https://msdn.microsoft.com/library/aa910532.aspx)

### User Profile Hive Cleanup service

The User Profile Hive Cleanup service helps make sure that user sessions are completely ended when a user logs off. System processes and applications occasionally maintain connections to registry keys in the user profile after a user logs off. In those cases, the user session is prevented from completely ending. This can result in problems when you use roaming user profiles in a network environment or when locked profiles are used as implemented through the Shared Computer Toolkit for Windows XP.

In Windows 2000, you can benefit from the User Profile Hive Cleanup service if the Application log shows event ID 1000, and the message text indicates that the profile isn't unloading and that the error is "Access is denied." On Windows XP and on Windows Server 2003, event IDs 1517 and 1524 indicate the same problem.

The User Profile Hive Cleanup service monitors for users who have logged off and for whom registry hives are still loaded. When this occurs, the service determines which applications have handles that are opened to the hives and releases them. It logs the application name and what registry keys were left open. After this occurs, the system finishes unloading the profile.

### Event messages in the Application log

When you try to log off from a computer that is running Windows Server 2003, Windows XP, Windows 2000, or Windows NT 4.0, one of the following event messages in the Application log are a symptom of a user profile error.

> [!NOTE]
> An event message can result for many reasons. When you receive an event, confirm that it has the same description every time. This will help you determine whether the event is caused by a user profile error.

#### How to view the Application log

To view the Application log, do the following:

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type the following text, and then click **OK**.

    `eventvwr.msc`
3. In Event Viewer, click **Application**.

#### Windows Vista and Windows Server 2008

The functionality of UPHClean (v1.6) is included in the Windows Vista and Windows Server 2008 User Profile Service. The User Profile Service performs all the necessary work to prevent user profile log-off errors from occurring.

When the User Profile Service takes action to prevent a user profile from unloading, it logs event 1530.

#### Windows XP and Windows Server 2003

#### Windows 2000

#### Windows NT 4.0

#### How to uninstall the User Profile Hive Cleanup service

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type the following text, and then click **OK**.

    `appwiz.cpl`
3. In **Add/Remove Programs**, click **User Profile Hive Cleanup Service**, and then click **Remove**.
4. Click **Yes**.
