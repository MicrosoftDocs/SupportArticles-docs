---
title: How to troubleshoot applications failing to stream from an App-V management server
description: Describes how to troubleshoot virtualized applications in Microsoft Application Virtualization (App-V) that fail to stream from the management server.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jeffpatt
ms.custom: sap:management-server-issues, csstroubleshoot
---
# How to troubleshoot applications failing to stream from an App-V management server

This article describes how to troubleshoot virtualized applications in Microsoft Application Virtualization (App-V) that fail to stream from the management server.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2615139

## Symptoms

When an application fails to stream on an App-V client, the application will fail to launch with the following error:

> The Application Virtualization Client could not launch *application name*.

The error message will also include an error description and code like the examples below:

> No connection could be made because the target machine actively refused it.  
Error code: xxxxxxx-xxxxxx2A-0000274D  
>
> The package requested could not be found in the system data store or the files associated with this package could not be found on the server. Report the following error code to your System Administrator.  
Error code: xxxxxxx-xxxxxx0A-20000194  
>
> No such host is known.  
Error Code: xxxxxxx-xxxxxx2A-00002AF9  
>
> The specified Application Virtualization Server could not be accessed.  
Try again in a few minutes. If the problem persists, report the following error code to your System Administrator.  
Error Code: xxxxxxx-xxxxxx0A-10000002

In the Sftlog.txt file, the following error will be logged:

> [08/24/2011 15:32:56:618 JGSW ERR] {hap=5:app=Appname:tid=16C:usr=Administrator}
The Application Virtualization Client could not connect to stream URL 'rtsp://appv-svr:554/Application/Application.sft' (rc 19D07F2A-0000274D, original rc 19D07F2A-0000274D).

> [!NOTE]
> The error code in the Sftlog.txt will vary.

The first step in troubleshooting an application failing to stream is to determine if the issue is isolated to a single application or all applications.

Once the scope of the applications affected is determined, perform the steps below that are appropriate for your scenario.

## Troubleshoot a single application that fails to stream  

1. Review the Sftlog.txt file on the App-V client.

    On the App-V client, review the Sftlog.txt file on the App-V client. This log file may include additional information that wasn't included in the error message.

    The default location for the Sftlog.txt is: %systemdrive%\\ProgramData\\Microsoft\\Application Virtualization Client.

2. Review the application .osd file on the App-V Management Server.

    1. On the App-V Management Server, open the application .osd file and scroll down to the following line:

        \<CODEBASE HREF="rtsp://servername:554/ApplicationDirectory/Application.sft">

    2. Verify the protocol, sever name, port and path to the SFT file are correct.

        Default ports for each protocol type:
        - RTSP=554
        - RTSPS=322
        - HTTP=80
        - HTTPS=443

    3. If changes were made to the application .osd file, save the changes and then open the Application Virtualization Client MMC snap-in on the App-V client and refresh the Publishing Server.

    4. Launch the application on the App-V client to see if the error continues to occur.

    > [!NOTE]
    > If the application OSD file is using the %SFT_SOFTGRIDSERVER% environment variable for the server name, verify the environment variable is configured on the App-V client.

3. Delete the application from the cache on the App-V client.

    1. On the App-V client, open the Application Virtualization Client snap-in that's located under Administrative Tools.
    2. Click **Applications**.
    3. Right-click the application that is failing to stream and click **Delete**.
    4. Click **Yes** when you receive the confirmation dialog box.
    5. Once the application is deleted, refresh the publishing server to republish the application.

    To refresh the publishing server, perform one of the following methods:

    - Method 1
        1. Open the Application Virtualization Client snap-in.
        2. Click **Publishing Servers**.
        3. Right-click the publishing server and choose **Refresh Server**.
    - Method 2
        1. Right-click the App-V icon in the notification area and choose **Refresh Applications**.
        2. Launch the application on the App-V client to see if the error continues to occur.

## Troubleshoot all applications failing to stream  

1. Review the Sftlog.txt file on the App-V client.

    On the App-V client, review the Sftlog.txt file on the App-V client. This log file may include additional information that wasn't included in the error message.

    The default location for the Sftlog.txt is %systemdrive%\\ProgramData\\Microsoft\\Application Virtualization Client.

2. Verify the App-V client can access the content directory.

    On the App-V client, click **Start**, in the **Search** or **Run** line, type the UNC path of the content share (For example: \\\\appv-svr\\content) and then press ENTER.

    If the client fails to connect to the content share, verify the UNC path is correct and verify the NTFS and Share permissions on the content directory are correct by performing the steps below.

    On the server hosting the content directory, verify the following NTFS and Share permissions are configured on the content directory:

    - App-V Users = Read
    - App-V Administrators = Read and Write
    - Network Service = Read and Write

    The default location for the content directory is: %systemdrive%\\Program Files (x86)\\Microsoft System Center App Virt Management Server\\App Virt Management Server\\content.

3. Verify the path to the content directory on the App-V Management Server. To verify this, perform the following steps on the App-V Management Server:

    1. In Administrative Tools, open the Application Virtualization Management Console.
    2. Right-click the server name and then click **System Options**.
    3. Verify the **Default Content Path** is pointing to the content directory location.
        > [!NOTE]
        > The content location should be referenced by UNC path (For example: \\\\appv-svr\\content).
    4. Click **OK** to close the **System Options** window.
    5. Close the Application Virtualization Management Console.
    6. Open Regedit.
    7. Navigate to the following key:
        - 32-bit systems: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SoftGrid\4.5\Server`
        - 64-bit systems: `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\SoftGrid\4.5\Server`
    8. Verify the SOFTGRID_CONTENT_DIR registry value is pointing to the content directory location.
        > [!NOTE]
        > The content location should be referenced by UNC path if the content share is a DFS share (For example: \\\\appv-svr\\content).
    9. If the SOFTGRID_CONTENT_DIR registry value was modified, restart the Application Virtualization Management Server service or restart the server.

4. Verify the Application Virtualization Management Server service is started on the App-V Management Server. To verify this, perform the following steps on the App-V Management Server:

    1. In Administrative Tools, open the Services MMC snap-in.
    2. Locate the Application Virtualization Management Server service.
    3. Verify that the service is Started.
    4. If the service is not started, right-click Application Virtualization Management Server, and then click **Start**.
    5. If the service fails to start, search the Microsoft Knowledge Base for the error message that is reported.

5. Verify the App-V client can telnet to the App-V Management Server and port. To verify this, perform the following steps on the App-V client:

    1. At a command prompt, type `telnet ServerName Port`, and then press ENTER.

        For example, type the `telnet appv-svr 554` command and then press ENTER.

    2. If the connection succeeds, the window is blank. Press ENTER two times and you will receive the following message:

        > RTSP/1.0 400 Bad Request  
        Server: Microsoft Application Virtualization Server/x.x.x.xxxxx [Win32; Windows NT x.x]  
        Date: xxx, xx xxx xxxx xx:xx:xx xxx

        If the connection is unsuccessful, you will receive the following message:

        > Could not open connection to the host, on port 554: Connect failed

        If the Application Virtualization Management Server service is started but the client cannot telnet to the server, verify that port traffic between the client and the server is not restricted by a firewall or by other software. For more information, contact the network administrator.

6. Review the application .osd files on the App-V Management Server.

    1. On the App-V Management Server, open the application .osd file and scroll down to the following line:

        \<CODEBASE HREF="rtsp://servername:554/ApplicationDirectory/Application.sft">
    2. Verify that the protocol, sever name, port and path to the SFT file are correct.

        Default ports for each protocol type:

        - RTSP= 554
        - RTSPS=322
        - HTTP=80
        - HTTPS=443
    3. If changes were made to the application .osd file, save the changes and then open the Application Virtualization Client MMC snap-in on the App-V client and refresh the Publishing Server.

    4. Repeat steps 1-3 for all applications that fail to stream.

    > [!NOTE]
    > If the application OSD file is using the %SFT_SOFTGRIDSERVER% environment variable for the server name, verify the environment variable is configured on the App-V Client.

7. Clear the cache on the App-V client.

    If steps 2-6 have confirmed that the App-V client can communicate with the App-V Management Server and the settings are configured properly, it's possible that the application is failing to stream due to a corrupted cache file on the App-V client.

    > [!NOTE]
    > Clearing the cache on the App-V client will delete all application data from the cache file. This may cause application load times to increase the first time an application is launched after the cache is cleared.

    To clear the cache on the App-V client, perform the following steps:

    1. Open Regedit.
    2. Navigate to the following key:
        - 32-bit systems: `HKEY_LOCAL_MACHINE\Software\Microsoft\Softgrid\4.5\Client\AppFS`
        - 64-bit systems: `HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\SoftGrid\4.5\Client\AppFS`
    3. Double-click the value name State and change the value data to 0.
    4. Restart the App-V client computer.

## Additional resources

For more information about Hyper-V, see [Hyper-V](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/mt169373(v=ws.11)).

Common error codes when an application fails to stream:

- 44-00001004
- 0a-00000193
- 0a-10000001
- 0a-0000e02b
- 0a-200001f4
- 64-00000003
- 2A-80090322
- 08-10000003
- 0a-0000E005
- 0A-0000E0A3
- 0A-40000191
- 2A-0000274D
- 0A-20000194
- 2A-00002AF9
- 0A-10000002
