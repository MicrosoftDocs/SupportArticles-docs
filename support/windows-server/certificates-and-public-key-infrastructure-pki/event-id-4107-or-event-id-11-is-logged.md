---
title: Event ID 4107 or ID 11 is logged
description: Fixes a problem in which Event ID 4107 or Event ID 11 is logged in the Application log.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, egomes
ms.custom: sap:certificate-root-update-program, csstroubleshoot
---
# Event ID 4107 or Event ID 11 is logged in the Application log

This article provides steps to solve the event 4107 and event 11 that are logged in the Application log.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2328240

## Symptoms

The following error messages are logged in the Application log:

```output
Log Name: Application  
Source: Microsoft-Windows-CAPI2  
Date: DateTime  
Event ID: 4107  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: ComputerName  
Description:  
Failed extract of third-party root list from auto update cab at: <http://www.download.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootstl.cab> with error: A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file.
```

```output
Log Name: Application  
Source: Microsoft-Windows-CAPI2  
Date: DateTime  
Event ID: 11  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: ComputerName  
Description:  
Failed extract of third-party root list from auto update cab at: <http://www.download.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootstl.cab> with error: A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file.
```

## Cause

This error occurs because the Microsoft Certificate Trust List Publisher certificate expired. A copy of the CTL with an expired signing certificate exists in the CryptnetUrlCache folder.

## Resolution

To resolve the problem, follow these steps:

1. Open a command prompt. Select **Start**, select **All Programs**, select **Accessories**, and then select **Command Prompt**.

1. At the command prompt, type the following command, and then press ENTER:

    ```console
    certutil -urlcache * delete
    ```

    > [!NOTE]
    > The `certutil` command must be run for every user on the workstation. Each user must log in and follow steps 1 and 2 above.

1. If the expired certificate is cached in one of the local system profiles, you must delete the contents of some directories by using Windows Explorer. To do it, follow these steps:

   1. Start Windows Explorer. Select **Start**, select **All Programs**, select **Accessories**, and then select **Windows Explorer**.

        > [!NOTE]
        > You must enable hidden folders to view the directories whose contents you must delete. To enable hidden files and folders, follow these steps:
        >
        > 1. Select **Organize**, and then select Folder and search options.
        > 2. Select the **View** tab.
        > 3. Select the **Show hidden files and folders** check box.
        > 4. Clear the **Hide extensions for known file types** check box.
        > 5. Clear the **Hide protected operating system files** check box.
        > 6. Select **Yes** to dismiss the warning, and then select **OK** to apply the changes and to close the dialog box.

   1. Delete the contents of the directories that are listed here. (%windir% is the Windows directory.)

        > [!NOTE]
        > You may receive a message that states that you do not have permission to access the folder. If you receive this message, select **Continue**.

        `LocalService`:  
        %windir%\ServiceProfiles\LocalService\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content  
        %windir%\ServiceProfiles\LocalService\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData  

        `NetworkService`:  
        %windir%\ServiceProfiles\NetworkService\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content  
        %windir%\ServiceProfiles\NetworkService\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData

        `LocalSystem`:  
        %windir%\System32\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content  
        %windir%\System32\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache\MetaData

## More information

Event ID 4107 can also be logged with **The data is invalid** error instead of the following error:  

> A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file

This error **Data is invalid** indicates the object returned from the network wasn't a valid cab file. So Windows couldn't parse it correctly. Instances of such an error can occur when the network retrieval attempt for the cab file fails to go through a proxy. If the proxy returns some data or message instead of a standard HTTP error code, Windows will try to parse the message received from the proxy, expecting it to be the cab. This situation will fail with the **data is invalid** error.

To address this error, you need to remove the invalid entry in the cache by clearing the cache following the steps in the [Resolution](#resolution) section.
