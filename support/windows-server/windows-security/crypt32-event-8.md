---
title: Crypt32 event 8 is continuously reported
description: On those products referenced in the Applies To section of this article, Crypt32 event ID 8 may be continuously recorded in the Application event log. This occurs because Windows is attempting to verify the digital signature of third-party security software that has been designed to meet the requirements for integrating with the Windows Security app introduced in Windows Vista. This behavior is expected, and can be ignored.
ms.date: 04/08/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
---
# Crypt32 8 events continuously reported in Windows

This article provides help to solve an issue where Crypt32 event 8 is continuously reported in the Application log.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2253680

## Symptoms

The following event is recorded in the Application log:

> Event Type: Error  
Event Source: Crypt32  
Event Category: None  
Event ID: 8  
Date: \<DateTime>  
Time: \<DateTime>  
User: N/A  
Computer: SERVER1  
Description:  
Failed auto update retrieval of third-party root list sequence number from: `http://www.download.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootseq.txt` with error: The server name or address could not be resolved.  

The following similar event may also be recorded:

> Event Type: Error  
Event Source: Crypt32  
Event Category: None  
Event ID: 8  
Date: \<DateTime>  
Time: \<DateTime>  
User: N/A  
Computer: SERVER1  
Description:  
Failed auto update retrieval of third-party root list sequence number from: `http://www.download.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootseq.txt` with error: This network connection does not exist.  

These events may be recorded at continuously, at regular intervals (for example, every 10 minutes) or they may only be recorded when you start a particular application.

Also, the computer on which the events are recorded doesn't have connectivity to the Windows Update web site because of router or proxy configuration.

These events are recorded despite the fact that no applications or services installed on the computer fail to start, or encounter any operational errors.

## Cause

This behavior is expected under the following conditions:

- The computer is unable to access the Windows Update web site due to router or proxy configuration.
- An application has been installed that has been designed to interact with the Windows Security app on Windows Vista or higher. Example applications include third-party virus software, malware scanners, or firewall products.

## Resolution

There are three options for handling these events.

1. Disregard these events. They are benign and can be safely ignored.
2. Modify router or proxy configuration to allow computers recording these events to connect to Windows Update.
3. Disable Automatic Root Updates on computers recording these events. 
   1. In Control Panel, double-click Add/Remove Programs.
   2. Click Add/Remove Windows Components.
   3. Click to clear the Update Root Certificates check box, and then continue with the Windows Components Wizard.

## More information

Microsoft requires that any software registers and interacts with the Windows Security app that's signed with a digital certificate that chains up to an internal Microsoft code signing root certification authority (CA). This CA is called the Microsoft Code Verification Root CA (MSCV). Microsoft has cross-certified the MSCV with multiple third-party code-signing CAs allowing these vendors to continue issuing valid code-signing certificates to their customers.

The MSCV certificate is embedded in the kernel, but it is not available as part of the Automatic Trusted Root Update service. Whenever the digital signature on one of these applications is checked, the chain of the vendor's code signing certificate is built up to both the root CA of the third-party that issued the code signing certificate and, by virtue of the cross-CA certificate issued by Microsoft, also to the MSCV. In short, two chains are built and the validity of both are verified.

The MSCV certificate is not embedded in the kernel so Windows determines that that CA is not trusted. If Automatic Trusted Root Updates are enabled, then Windows will attempt to contact Windows Update to determine if the MSCV certificate is published by Microsoft as part of the Trusted Root Program. The MSCV is not available through that program, so this lookup fails.

Windows quickly determines that the MSCV isn't trusted and that chain is eliminated. This leaves the other chain that leads to a third-party root CA, which is probably valid, allowing the application's signature to be successfully validated. Thus, there are no errors or failures associated with the application.

If Windows can successfully contact Windows Update, then no events are recorded in the Application log. Failure to locate an arbitrary untrusted root CA certificate on Windows Update is a handled failure and requires no special reporting. If Automatic Trusted Root Updates are enabled, but Windows is unable to contact the Windows Update site, then that is an error that requires reporting through the events and errors documented above.

These events aren't recorded on Windows Vista or higher because the MSCV certificate is embedded in the Windows kernel. The MSCV is therefore inherently trusted and there's no need to look for the certificate on Windows Update.
