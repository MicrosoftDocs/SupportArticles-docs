---
title: Windows Server printer redirection isn't working
description: Discusses an issue in which the printer redirection isn't working and no event IDs occur.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:printing-includes-redirection, csstroubleshoot
---
# Windows Server printer redirection isn't working

This article provides a solution to an issue in which the printer redirection isn't working and no event IDs occur.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2003646

## Symptoms

Printer redirection isn't working. Drive redirection works. No event IDs are seen.

## Cause

The spooler security descriptor must contain the "AU" (Authenticated User) ACL (Access Control List) which allows any authenticated user to open the spooler service for reading operations.

In this case, that ACL was missing from the spooler security descriptor.

## Resolution

Run the following command to show the current security descriptors on the print spooler:

```console
C:\sc sdshow spooler 
```

An unaltered SD (security descriptor) for print spooler should look like this:

> D:(A;;CCLCSWLOCRRC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWRPWPDTLOCRRC;;;SY)

The important ACL in this case is the one for authenticated user (AU), since TS runs as a network service it relies on this ACL to be present in order to successfully open the spooler service. Adding the following ACL back fixed the problem.

> (A;;CCLCSWLOCRRC;;;AU)

The following method can be implemented to add the missing ACL.  

Run the following command:

```console
c:\>sc sdshow spooler >temp.txt  
```

You would see all the ACLs except for the "(A;;CCLCSWLOCRRC;;;AU)" ACL when you open the text file.  

The following is an example: (you may see a different output depending on the permissions set on the spooler)  

> D:(A;;CCLCSWLOCRRC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWRPWPDTLOCRRC;;;SY)

You could then copy the above output in a notepad as follows:

> sc sdset spooler D: (A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWLOCRRC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWRPWPDTLOCRRC;;;SY)  

> [!NOTE]
> Ensure that you're appending the "sc sdset spooler D: (A;;CCLCSWLOCRRC;;;AU)" section of above command to the output you see in your case.  

Copy and paste this command in the command prompt. (Ensure that "(A;;CCLCSWLOCRRC;;;AU)" appears in the beginning. Otherwise, this might not work.)

By running the above command, you retain the old ACLs and also add the missing ACL that is the one for authenticated user (AU).  

## More information

Following is a list of some more things that can be looked into in a "Printer Redirection not working" issue:

1. If the client machines are running Windows XP, ensure that .NET Framework 3.5 SP1 is installed and at least RDC 6.1 is being used.
2. Even if RDC 6.1 or above is used, the user must install a supported version of .NET Framework separately. Microsoft .NET Framework 3.5 (which includes .NET Framework 3.0 SP1) can be downloaded from the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=21).
3. If you connect over RD Gateway, ensure that the policy that disables printer redirection is turned off.
4. If your server is also a domain controller, refer to [Install Remote Desktop Session Host role service in Windows Server without Connection Broker role service](install-rds-host-role-service-without-connection-broker.md).
5. Group Policy must be correctly set to enable Easy Print on the Server. The policy location is "Computer Configuration > Administrative templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > Printer Redirection". The setting "Use Remote Desktop Easy Print printer driver first" must be set to "Enabled" for Easy Print redirection, and it has to be "Disabled" for Legacy Print. For "Not configured", Easy Print is chosen by default.
6. Make sure that the **Printers** check box in the client (mstsc.exe) window on the **Local Resources** tab is checked. The corresponding setting in the associated RDP file is "redirectprinters:i:1".

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
