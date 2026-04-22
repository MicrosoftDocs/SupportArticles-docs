---
title: Connection to network document lost when computer resumes from standby mode
description: Describes the errors in Word, Excel, and PowerPoint when trying to resume working in Word, Excel or PowerPoint.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:User and Domain Management\Manage my users, groups and resources 
  - CI 10042
  - CSSTroubleshoot
ms.reviewer: huixuanhuang, mayadav; andrewtruong
appliesto: 
  - Microsoft Word
  - Microsoft Excel
  - Microsoft PowerPoint
search.appverid: MET150
ms.date: 03/26/2026
---
# Connection to network document lost when computer resumes from standby mode

## Summary

This article discusses errors that you might see in Microsoft Word, Microsoft Excel, or Microsoft PowerPoint about not being able to save a file that's on a network location. Also, it provides resolution options to fix the issue.

## Symptoms

You use Word, Excel, or PowerPoint in Microsoft 365 apps for Windows to access a file that’s located on a network share. After some time, your computer enters standby mode. After the computer resumes, you receive one of the following error messages, depending on the app that you’re using.

Error message in Word:

> Word cannot establish a network connection with this document after the system resumed from suspend mode. Save the document into a different file to keep any changes.

Error message in Excel:

> The file '\<file name\>' may have been changed by another user since you last saved it. In that case, what do you want to do?

> - Save a copy

>- Overwrite changes

Error message in PowerPoint:

> The file you were working with was modified during suspend mode, and the original version is no longer available. \<file path\> and \<file name\>.ppt must be re-saved.

Additionally, after the computer resumes and the network connection is available, you can’t update and save the file to the network share. You can only save it as a new file to keep the current content.

## Resolution

Configure the `NetworkAvailableTimeInSeconds` registry entry to set how long (in seconds) Microsoft 365 will wait for the network to resume. You might have to test several values to determine the appropriate time value.

Follow these steps:

1. Select **Start**, type "regedit" in the Search box, and then select **Open**.
1. Locate and then select the following registry subkey:
`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Internet`
1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
1. Type "NetworkAvailableTimeInSeconds", and then press **Enter**.
1. Right-click **NetworkAvailableTimeInSeconds**, and then select **Modify**.
1. In the **Value data** box, select **Decimal**, enter a number value, and then select **OK**.
1. Exit Registry Editor.

If the issue persists after you configure the `NetworkAvailableTimeInSeconds` registry subkey, collect additional diagnostic information to adjust the resume-wait logic. This adjustment should account for network errors that are specific to your environment.  
  
To collect the additional information, enable verbose logging, and then configure the network error codes. Refer to the following sections.

### Enable verbose logging

To turn on verbose diagnostic logging, follow these steps:

1. Select **Start**, type "regedit" in the Search box, and then select **Open**.
1. Locate and select the following registry subkey:
`HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Logging`.
1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
1. Enter "EnableLogging", and press **Enter**.
1. Right-click **EnableLogging**, and select **Modify**.
1. In the **Value data** box, type "1", and then select **OK**.

   **Note** This registry subkey creates a log file in the following folder:
C:\Users\\{username}\AppData\Local\Temp.

The log file has the following file name format:
{Machine Name}-{TimeStamp}.log.

1. Repeat steps 2-6 to add the following additional registry entries under `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Logging`.
For these registry entries, type the value that’s listed in the Data (Decimal) column from the following table in the **Value data** box.

| Name | Type | Data (Decimal) |
| ---| --- | --- |
| MsoEtwTracingEnabled | REG_DWORD | 1 |
| DefaultMinimumSeverity | REG_DWORD | 100 |

1. Exit Registry Editor.
1. Reproduce the problem.
1. Locate and open the log file that’s created (see the note in step 6 for the log location).

### Configure network error codes

You have to configure the **ResumeErrorCodes** registry key to adapt it to network errors that are specific to your environment. To make this change, analyze the log file that’s collected after you enable verbose logging. Follow these steps:

1. Open the log file, search for the **HrBindShellPistm** entry, and note the associated error name. For example, Error name: ERROR_BAD_NETPATH.
1. Use the table in the Common Network Errors section to look up the error name from step 1, and note the corresponding **ResumeErrorCodes** value. The value can be in decimal or hexadecimal format.  

   In some cases, multiple error names might be associated with the `HrBindShellPistm` entry. In this scenario, append the **ResumeErrorCodes** value for each error code serially.  

   For example: If both the error name **ERROR_FILE_NOT_FOUND** (code: 02 00 07 80) and error name **ERROR_PATH_NOT_FOUND** (code 03 00 07 80) appear in step 1, the combined **ResumeErrorCodes** value is `02 00 07 80 03 00 07 80`.

1. Select **Start**, enter "regedit" in the Search box, and then select **Open**.
1. Locate and select the following registry subkey: **HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Internet**.
1. On the **Edit** menu, point to **New**, and then select **Binary Value**.
1. Enter "ResumeErrorCodes", and then press **Enter**.
1. Right-click **ResumeErrorCodes**, and then select **Modify**.
1. In the **Value data** box, enter the value that you recorded in step 2, and then select **OK**.
1. Exit Registry Editor.
1. Check whether the problem is fixed.

#### Common network errors

| Error name | Decimal | Hexadecimal | ResumeErrorCodes value |
| --- | --- | --- | ---|
| ERROR_FILE_NOT_FOUND | -2147024894 | 0x80070002 | 02 00 07 80 |
| ERROR_PATH_NOT_FOUND | -2147024893 | 0x80070003 | 03 00 07 80 |
| ERROR_SHARING_VIOLATION | -2147024864 | 0x80070020 | 20 00 07 80 |
| ERROR_BAD_NETPATH | -2147024843 | 0x80070035 | 35 00 07 80 |
| ERROR_NETWORK_BUSY | -2147024842 | 0x80070036 | 36 00 07 80 |
| ERROR_NETNAME_DELETED | -2147024832 | 0x80070040 | 40 00 07 80 |
| ERROR_BAD_NET_NAME | 67 | 0x80070043 | 43 00 07 80 |
| ERROR_DEVICE_NOT_CONNECTED | 1167 | 0x8007048F | 8F 04 07 80 |
| ERROR_NETWORK_UNREACHABLE| 1231| 0x800704CF | CF 04 07 80 |
| ERROR_CANT_ACCESS_FILE| 1920 | 0x80070780 | 80 07 07 80 |
| ERROR_FILE_OFFLINE | 4350 | 0x800710FE | FE 10 07 80 |

The list in the table isn't exhaustive. If you encounter an error code that’s not listed, use the following instructions to manually convert any error code to the corresponding `ResumeErrorCodes` value.

#### Convert an error code to a ResumeErrorCodes value

Error codes can appear in decimal (signed integer) or hexadecimal (0x-prefixed) form. Both numbers represent the same underlying 32-bit value. The conversion process is identical after you have the hexadecimal representation.

Follow these steps:

1. Convert the error code to its 32-bit hexadecimal form.

 - If the error code is already in hexadecimal form (for example, 0x80070002), use it as is.
 - If the error code is in decimal (positive or negative) form, run the following command in Windows PowerShell to convert it to a 32-bit hexadecimal value:  

```powershell
'{0:X8}' -f (0x80070000 -bor decimal)
```

For example:

- -2147024894 in decimal converts to 0x80070002 in hexadecimal.
- 1167 in decimal converts to 0x8007048F in hexadecimal.

1. Break the hexadecimal value into bytes in little-endian order.

Starting from the least-significant byte, rewrite the 32-bit value one byte at a time to get the corresponding `ResumeErrorCodes` value:

For example:

- The `ResumeErrorCodes` value for 0x80070002 is 02 00 07 80.
- The `ResumeErrorCodes` value for 0x8007048F is 8F 04 07 80.
