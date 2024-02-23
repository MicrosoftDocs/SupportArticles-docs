---
title: How to enable transport logging in Outlook
description: Explains how to enable logging of the communications that occur between Outlook and various types of e-mail servers in plain text format. Lists the location of the log file on different operating systems.
author: cloud-writer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Office Outlook 2007
  - Office Outlook 2003
ms.date: 10/30/2023
---

# How to enable transport logging in Outlook

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

## Summary

Microsoft Outlook supports the logging of the communications that occur between Outlook and various types of email servers. These logs can be helpful when you troubleshoot problems that affect the transfer of messages between Outlook and the email server. 

Outlook can log the communications among Microsoft Exchange, Post Office Protocol version 3 (POP3), Simple Mail Transport Protocol (SMTP), Internet Messaging Access Protocol (IMAP), and Outlook.com servers. 

## More Information

Warning Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk. 

### How to enable logging
 
To have us enable the mail logging option for you, go to the "Here's an easy fix" section. If you prefer to enable the mail logging option yourself, go to the "Let me fix it myself" section.

#### Enable logging
 
To enable logging, follow the steps for your version of Outlook. 

#### Microsoft Outlook 2019, Microsoft Outlook 2016, Microsoft Outlook 2013, Microsoft Outlook 2010, and Outlook for Microsoft 365

1. On the **File** tab, click **Options**.    
2. In the **Outlook Options** dialog box, click **Advanced**.    
3. In the **Other** section, select the **Enable troubleshooting logging (requires restarting Outlook)** check box, and then click **OK**.    
4. Exit and then restart Outlook.    
 
#### Microsoft Outlook 2007 and earlier versions

1. On the **Tools** menu, click **Options**.    
2. Click the **Other** tab.    
3. Click the Advanced Options button.    
4. Select the **Enable mail logging (troubleshooting)** check box.    
5. Click **OK** to save the setting, and then return to the main **Options** screen.    
6. Click **OK**.    
7. Exit and then restart Outlook.    
 
#### Outlook Connector in Outlook 2010

##### Enable logging
 
To enable logging for Outlook Connector version 14 in Outlook 2010, configure the following registry data. 
 
- Subkey: HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Options\Mail    
- DWORD: EnableLogging    
- Value: 1    
- Subkey: HKEY_CURRENT_USER\Software\Microsoft\Microsoft Office Outlook Connector    
- DWORD: TracingLevel    
- Value: 3    
 
##### Disable logging
 
To disable logging for Outlook Connector version 14 in Outlook 2010, configure the following registry data. 
 
- Subkey: HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Outlook\Options\Mail    
- DWORD: EnableLogging    
- Value: 0    
 
 
- Subkey: HKEY_CURRENT_USER\Software\Microsoft\Microsoft Office Outlook Connector    
- DWORD: TracingLevel    
- Value: 0    
 
#### Logging results
 
When you enable logging, the following registry data is configured.

Subkey: **HKEY_CURRENT_USER\Software\Microsoft\Office\1x.0\Outlook\Options\Mail**

DWORD: EnableLogging
 
Values: 1 = logging enabled, 0 = logging disabled

> [!NOTE]
> In the subkey, <1x.0> represents the program version number ("16.0" = Outlook 2019, Outlook 2016 or Outlook for Microsoft 365, "15.0" = Outlook 2013, "14.0" = Outlook 2010, "12.0" = Outlook 2007).

After you enable logging, all communications that occur between Outlook and the email server are written to a log file.

> [!IMPORTANT]
> You must disable logging after the logs capture the failed communication to the server. If you do not disable logging, the logs continue to grow indefinitely.

#### Log file locations
 
The log files are formatted as plain text. To find the log files, look in the following locations, depending upon your version of Outlook and also your version of Windows, if you are running Outlook 2007 or an earlier version. 

#### Microsoft Outlook 2019, Outlook 2016, Outlook 2013, Outlook 2010 and Outlook for Microsoft 365

##### POP3, SMTP, MAPI logs
 
The POP3, SMTP, and MAPI transport types are written to a single log file in the following location: 

%temp%\Outlook Logging\Opmlog.log

> [!NOTE]
> The Opmlog.log file also contains some information that is related to the Outlook Connector. 

##### IMAP logs
 
The IMAP transport type is written to the following location: 

%temp%\Outlook Logging\IMAP-usernamedomainname-date-time.log

For example: IMAP-user1wingtiptoyscom-03_23_2010-12_49_31_798.log 

##### Outlook Connector v. 14 log
 
The Outlook Connector version 14 log file is written to the following location: 

%temp%\OLC Logging\OLC-smtp_address-date-time.log

For example: OLC-guidopica@contoso.com-03_23_2010-16_13_10_803.log 

#### For Outlook 2007 and earlier versions

##### POP3, SMTP, MAPI logs
 
The POP3, SMTP, and MAPI transport types are written to a single log file in the following locations. 
 
- Windows XP and Windows 2000 C:\Documents and Settings\logon name\Local Settings\temp\OPMLOG.LOG     
- Windows 98, Windows 98 Second Edition, and Windows Millennium Edition (Me) C:\Windows\temp\OPMLOG.LOG     
 
##### IMAP logs
 The IMAP transport type is written to a log file in the following locations. 
 
- Windows 2000 
  
    C:\Documents and Settings\logon name\Local Settings\temp\Outlook Logging\<NameOfIMAPServer>\IMAP0.LOG, IMAP1.LOG, and so on     
- Windows 98, Windows 98 Second Edition, and Windows Me 

    C:\Windows\temp\Outlook Logging\<NameOfIMAPServer>\IMAP0.LOG, IMAP1.LOG, and so on     
 
##### Outlook.com logs
 
The Outlook.com log file is written to the following locations. 
 
- Windows 2000 
- 
    C:\Documents and Settings\logon name\Local Settings\temp\Outlook Logging\Hotmail\Hotmail0.LOG, Hotmail1.LOG, and so on     
- Windows 98, Windows 98 Second Edition, and Windows Me 

    C:\Windows\temp\Outlook Logging\Hotmail\Hotmail0.LOG, Hotmail1.LOG, and so     
 
**Notes**
 
- IMAP and Outlook.com accounts generate one log for each Send or Receive action that you perform on these accounts. (The log files are named Hotmail0.LOG, Hotmail1.LOG, etc.)    
- If you have multiple Outlook.com accounts configured, the folders in which the logs are stored are named Hotmail, Hotmail 1, Hotmail 2, and so on.    
- You may have to close Outlook so that the logs can be written to the log files.
