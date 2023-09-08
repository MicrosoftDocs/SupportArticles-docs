---
title: SQL Server fails to start with error 17182 
description: Provides a resolution for the problem that occurs when server is configured to use SSL.
ms.date: 01/14/2021
ms.custom: sap:Security Issues 
---
# SQL Server fails to start with when server is configured to use SSL

This article provides a resolution for the error 17182 (TDSSNIClient initialization failed with error 0xd, status code 0x38) that occurs when server is configured to use SSL.

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2023869

## Symptoms

Consider the following scenario:

- You have an instance of SQL Server 2005 or a later version that is hosted on a system that is running either Windows Server 2008 or a later version of the operating system.

- You have configured SSL encryption for your SQL Server by manually entering the Thumbprint of a certificate into the Certificate value under the following registry key:

  `HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\<instance>\MSSQLServer\SuperSocketNetLib`

In this scenario, your SQL Server may fail to start and the following messages are logged in the SQL Server Errorlog:

> \<Datetime> Server      Error: 17182, Severity: 16, State: 1.  
\<Datetime> Server      TDSSNIClient initialization failed with error 0xd, status code 0x38.  
\<Datetime> Server      Error: 17182, Severity: 16, State: 1.
\<Datetime> Server      TDSSNIClient initialization failed with error 0xd, status code 0x1.  
\<Datetime> Server      Error: 17826, Severity: 18, State: 3.  
\<Datetime> Server      Could not start the network library because of an internal error in the network library. To determine the cause, review the errors immediately preceding this one in the error log.  
\<Datetime> Server      Error: 17120, Severity: 16, State: 1.  
\<Datetime> Server      SQL Server could not spawn FRunCM thread. Check the SQL Server error log and the Windows event logs for information about possible related problems. 

## Cause

A common root cause for these symptoms is an invisible character that may have been inadvertently added to the certificate's Thumbprint value, when it gets copied out of the Certificates snap-in's rich-edit control in MMC.

## Resolution

You can use either of the following resolutions:

- Avoid copying leading characters from the Certificates snap-in in MMC, when you copy the Thumbprint value of a certificate.
- Use the Certutil tool instead of the certificates snap-in in MMC to export the certificate to a text file and then copy the Thumbprint value of the required certificate from the text file. The usage is shown below:

    To view the content of computer's Current User certificate store type the following at the command prompt:

    `certutil -store -user my`

    To view the content of computer's Local Computer certificate store type the following at the command prompt:

    `certutil -store my`

You can direct the output of the above command to a text file using the following at an administrative command prompt on Vista based operating systems:

`certutil -store my > cert.txt`

The thumbprint can be located in the line that starts with Cert Hash(sha1)

For example: Cert Hash(sha1): e7 02 4b 42 c4 04 fd 44 8c ec 21 f1 91 76 5c b7 c3 ad 1d 55

You can then copy this value (without spaces - for the above example it will be e7024b42c404fd448cec21f191765cb7c3ad1d55) to the Certificate value under the following registry key:

`HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\<instance>\MSSQLServer\SuperSocketNetLib`

## More information

A status code **0x38** in error message 17182 means that SQL Server experienced an error during the initialization of SSL. See [SQL Protocols](/archive/blogs/sql_protocols/) for more details.  

The return code **0xd** denotes OS error 0xd (13) which translates to "The data is invalid"
The above error **17182 "TDSSNIClient initialization failed with error 0xd, status code 0x38**" occurs specifically because of the fact that the string under **Certificate** value can't be properly converted back to a valid thumbprint of the certificate.

This GUI issue with Certificates snap-in doesn't occur on older versions of Windows (for example, Windows XP, Windows Server 2003), as they don't use a rich edit control in the Certificates snap-in

To check whether you're running into the issue documented in this article you can use the following procedure:

1. Open regedit and navigate to the following registry key and export the key to SSLKey.reg file:

    `HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\<instance>\MSSQLServer\SuperSocketNetLib`

1. Open the SSLKey.reg file from Step 1 using Notepad and using the **Save As** dialog box in the **File** menu, click **ANSI** in the **Encoding** list, and then click **Save**.

1. If you get the warning below, proceed to Step 3 by clicking **OK**.

   > [!WARNING]
   > This file contains characters in Unicode format which will be lost if you save this file as an ANSI encoded text file. To keep the Unicode information, click **Cancel** below and then select one of the Unicode options from the Encoding drop down list. Continue?

1. Close the SSLKey.reg file and reopen it using Notepad.

1. If you now see a questions mark or any other invalid character in the thumbprint of your certificate, it's an indication that you're probably running into the issue documented in this article:

   An example entry may look similar to the following:

   > [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.1\MSSQLServer\SuperSocketNetLib]  
   "Certificate"="?b009d02038431da332f095b4ea6a126f4f5c7d18"
