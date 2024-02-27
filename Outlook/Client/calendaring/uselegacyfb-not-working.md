---
title: UseLegacyFB does not work as expected
description: Describes the issue where you cannot use the UseLegacyFB registry value in Outlook 2010 or Outlook 2013. The UseLegacyFB registry value is not supported by Outlook 2010 or Outlook 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, gregmans, tsimon, laurentc, amkanade, doakm, randyto, gbratton, bobcool, sercast
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# The UseLegacyFB registry value does not work as expected in Outlook 2010 and Outlook 2013

_Original KB number:_ &nbsp; 982698

## Symptoms

If you add the `UseLegacyFB` registry value to the Windows registry to try to force Microsoft Outlook 2010 or Outlook 2013 to behave like Office Outlook 2007, the value is ignored by Outlook.

## Cause

The `UseLegacyFB` registry value is not used by Outlook 2010 or Outlook 2013. By default, if your mailbox is located on a Microsoft Exchange 2007 or Exchange 2010 server, Outlook 2007, Outlook 2010, and Outlook 2013 use the Exchange Availability Service to locate free/busy information. This is a change from Outlook 2003 and earlier versions of Outlook that use public folder free/busy information.

> [!NOTE]
> Public folder free/busy was removed from Outlook 2013. For more information about changes in Outlook 2013, see [Changes in Office 2013](/previous-versions/office/office-2013-resource-kit/cc178954(v=office.15)).

In Office Outlook 2007, you can use the following registry data to force Outlook 2007 to use public folder free/busy information instead of the Availability Service.

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Outlook\Options\Calendar`  
Name: UseLegacyFB

Type: DWORD  
Value: 1

In some scenarios where you are troubleshooting Availability Service problems, you might want to force Outlook 2007 to use public folder free/busy information by adding this registry data to the client. In these same situations, you cannot force Outlook 2010 or Outlook 2013 to use public folder free/busy information because the `UseLegacyFB` registry value is ignored.

## Resolution

If you are troubleshooting Availability Service issues in Outlook 2010 or Outlook 2013, you can enable Availability Service logging. To do this, follow these steps:

1. Start Outlook.
2. On the **File** tab, select **Options**.
3. In the **Outlook Options** dialog box, select **Advanced**.
4. In the **Other** section, select the **Enable troubleshooting logging (requires restarting Outlook)** check box, and then select **OK**.

   :::image type="content" source="media/uselegacyfb-not-working/enable-troubleshooting-logging-requires-restarting-outlook.png" alt-text="Screenshot of the Advanced tab on Outlook Options." border="false":::

5. Restart Outlook

When Outlook uses the Availability Service to retrieve free/busy information, log files are generated in the following folders:

### Outlook 2010

%temp%\OLKAS

The file name of the log files uses the following format:

**yyyymmdd**-**hhmmssss**-AS.log

For example, a log file that is generated on March 30, 2010 at 2:14:20.0029 P.M. will be named:

20100330-1411200029-AS.log

Open this log file in a text editor such as Notepad to examine the logging information.

### Outlook 2013

%temp%\Outlook Logging

The file name of the log files uses the following format:

Outlook-*########*.etl

> [!NOTE]
> To help protect customer data, the advanced trace log files are binary files that cannot be read without a conversion process. You can upload the log files to a secure location provided by Microsoft Customer Support Services. A support engineer from Microsoft can download and convert the log file for analysis. For more information about advanced trace log files, see [How to enable global and advanced logging for Microsoft Outlook](https://support.microsoft.com/help/2862843).
