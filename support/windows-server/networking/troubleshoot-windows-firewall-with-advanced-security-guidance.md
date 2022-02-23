---
title: Guidance of troubleshooting Windows Firewall with Advanced Security
description: Introduces general guidance of troubleshooting scenarios related to Windows Firewall with Advanced Security.
ms.date: 03/03/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-firewall-with-advanced-security-wfas, csstroubleshoot
ms.technology: networking
---
# Windows Firewall with Advanced Security troubleshooting guidance

## Considerations for firewall rules

Only one firewall rule is used to determine if a network packet is allowed or dropped. If the network packet matches multiple rules, then the rule that is used is selected using the following precedence:

1. Rules that specify the action Allow if Secure and also the option Block Override
2. Rules that specify the action Block
3. Rules that specify the action Allow

Only currently active rules are displayed in the Monitoring node. Rules might not appear in the list if:

1. The rule is disabled.
2. If the default inbound or outbound firewall behavior is configured to allow traffic that is not blocked by a rule, then allow rules of the specified direction are not displayed.

By default, the firewall rules in the groups identified in the following list are enabled. Additional rules might be enabled when you install certain Windows Features or programs.

1. Core Networking – all profiles
2. Remote Assistance – DCOM and RA Server TCP rules for domain profile only, other rules for both domain and private profiles
3. Network Discovery – private profile only

## Enable audit events

use **auditpol.exe** to modify audit polices of the local computer. You can use the auditpol command-line tool to enable or disable the various categories and subcategories of events and then view the events in the Event Viewer snap-in.

1. To get the list of event categories recognized by the auditpol tool, type the following at the command prompt: **auditpol.exe /list /category**
2. To get the list of subcategories under a category (this example uses the category Policy Change), type the following at the command prompt: **auditpol.exe /list /category:"Policy Change"**
3. To set a category and a subcategory to enable, type the following at the command prompt: **auditpol.exe /set /category:"CategoryName" /SubCategory:"SubcategoryName"**

## Configure the firewall log file for a profile

1. In the console tree of the Windows Firewall with Advanced Security snap-in, click Windows Firewall with Advanced Security, and then click Properties in the Actions pane.
2. Click the tab of the profile for which you want to configure logging (Domain, Private, or Public), and then click Customize.
3. Specify a name and location.
4. Specify a log file size limit (Between 1 and 32767 Kbytes).
5. Click Yes for Log dropped packets.
6. Click Yes for Log successful connections and then click OK.

## Create network statistics and task list text files

1. At the command prompt, type **netstat -ano** > **netstat.txt**, and then press Enter.
2. At the command prompt, type **tasklist** > **tasklist.txt**, and then press Enter.  
   If you want to create a text file for services rather than programs, at the command prompt, type **tasklist /svc** > **tasklist.txt**.
3. Open the tasklist.txt and the netstat.txt files.
4. In the tasklist.txt file, write down the Process Identifier (PID) for the process you are troubleshooting. Compare the PID with that in the Netstat.txt file. Write down the protocol that is used. The information about the protocol used can be useful when reviewing the information in the firewall log file.

## Verifying that Key Firewall and IPsec Services are Working

For Windows Firewall with Advanced Security to operate correctly, the following services must be started:

- Base Filtering Engine
- Group Policy Client
- IKE and AuthIP IPsec Keying Modules
- IP Helper
- IPsec Policy Agent
- Network Location Awareness
- Network List Service
- Windows Firewall

## Common issues and solutions

- [Windows Firewall Is Blocking a Program](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc766312%28v=ws.10%29)
- [Windows Firewall Is Turned off Every Time I Start My Computer](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc749262%28v=ws.10%29)
- [Need to Disable Windows Firewall](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc766337%28v=ws.10%29)
- [Cannot Configure Windows Firewall with Advanced Security](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc721901%28v=ws.10%29)
- [Nobody Can Ping My Computer](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc749323%28v=ws.10%29)
- [Nobody Can Access My Local File and Printer Shares](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc749151%28v=ws.10%29)
- [Cannot Remotely Administer Windows Firewall](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc722447%28v=ws.10%29)
- [Troubleshooting Windows Firewall settings after a Windows upgrade](/windows/security/threat-protection/windows-firewall/firewall-settings-lost-on-upgrade)

## Reference

- [Events for Windows Firewall with Advanced Security in Event Viewer](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ff428140%28v=ws.10%29#to-view-events-for-windows-firewall-with-advanced-security-in-event-viewer)
- [Best practices for configuring Windows Defender Firewall](/windows/security/threat-protection/windows-firewall/best-practices-configuring)
- [Filter origin audit log improvements](/windows/security/threat-protection/windows-firewall/filter-origin-documentation)
- [Use netsh advfirewall firewall](/troubleshoot/windows-server/networking/netsh-advfirewall-firewall-control-firewall-behavior)
