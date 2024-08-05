---
title: Guidance for troubleshooting Windows Firewall with Advanced Security
description: Introduces general guidance for troubleshooting scenarios related to Windows Firewall with Advanced Security.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\Windows Firewall with Advanced Security (WFAS), csstroubleshoot
---
# Windows Firewall with Advanced Security troubleshooting guidance

This article is designed to help you troubleshoot issues that are related to Windows Firewall with Advanced Security.

## Troubleshooting checklist

### Considerations for firewall rules

Only one firewall rule is used to determine if a network packet is allowed or dropped. If the network packet matches multiple rules, the rule that is used is selected using the following precedence:

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

### Enable audit events

Use **auditpol.exe** to modify audit polices of the local computer. You can use the `auditpol` command-line tool to enable or disable the various categories and subcategories of events and then view the events in the Event Viewer snap-in.

- To get the list of event categories recognized by the auditpol tool, run the following command at the command prompt:

  ```console
  auditpol.exe /list /category
  ```

- To get the list of subcategories under a category (this example uses the category Policy Change), run the following command at the command prompt: 

  ``` console
  auditpol.exe /list /category:"Policy Change"
  ```

- To set a category and a subcategory to enable, type the following at the command prompt: 

  ```console
  auditpol.exe /set /category:"CategoryName" /SubCategory:"SubcategoryName"
  ```

### Configure the firewall log file for a profile

1. In the console tree of the Windows Firewall with Advanced Security snap-in, select **Windows Firewall with Advanced Security**, and then select **Properties** in the **Actions** pane.
2. Select the tab of the profile for which you want to configure logging (Domain, Private, or Public), and then select **Customize**.
3. Specify a name and location.
4. Specify a log file size limit (Between 1 and 32767 Kbytes).
5. Select **Yes** for Log dropped packets.
6. Select **Yes** for Log successful connections and then select OK.

### Create network statistics and task list text files

1. At the command prompt, type `netstat -ano > netstat.txt`, and then press Enter.
2. At the command prompt, type `tasklist > tasklist.txt`, and then press Enter.  
   If you want to create a text file for services rather than programs, at the command prompt, type `tasklist /svc > tasklist.txt`.
3. Open the tasklist.txt and the netstat.txt files.
4. In the tasklist.txt file, write down the Process Identifier (PID) for the process you are troubleshooting. Compare the PID with that in the Netstat.txt file. Write down the protocol that is used. The information about the protocol used can be useful when reviewing the information in the firewall log file.

### Verifying firewall and IPsec services are working

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

## Data collection

Before contacting Microsoft support, you can gather information about your issue.

### Prerequisites

1. TSS must be run by accounts with administrator privileges on the local system, and EULA must be accepted (once EULA is accepted, TSS won't prompt again).
2. We recommend the local machine `RemoteSigned` PowerShell execution policy.

> [!NOTE]
> If the current PowerShell execution policy doesn't allow running TSS, take the following actions:
>
> - Set the `RemoteSigned` execution policy for the process level by running the cmdlet `PS C:\> Set-ExecutionPolicy -scope Process -ExecutionPolicy RemoteSigned`.
> - To verify if the change takes effect, run the cmdlet `PS C:\> Get-ExecutionPolicy -List`.
> - Because the process level permissions only apply to the current PowerShell session, once the given PowerShell window in which TSS runs is closed, the assigned permission for the process level will also go back to the previously configured state.

### Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes and unzip it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
3. Start the traces by using the following cmdlet:

    ```powershell
    TSS.ps1 -Scenario NET_WFP
    ```

4. Accept the EULA if the traces are run for the first time on the computer.
5. Allow recording (PSR or video).
6. Reproduce the issue before entering *Y*.

     > [!NOTE]
     > If you collect logs on both the client and the server, wait for this message on both nodes before reproducing the issue.

7. Enter *Y* to finish the log collection after the issue is reproduced.

The traces will be stored in a zip file in the *C:\\MS_DATA* folder, which can be uploaded to the workspace for analysis.

## Reference

- [Events for Windows Firewall with Advanced Security in Event Viewer](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/ff428140%28v=ws.10%29#to-view-events-for-windows-firewall-with-advanced-security-in-event-viewer)
- [Best practices for configuring Windows Defender Firewall](/windows/security/threat-protection/windows-firewall/best-practices-configuring)
- [Filter origin audit log improvements](/windows/security/threat-protection/windows-firewall/filter-origin-documentation)
- [Use netsh advfirewall firewall](netsh-advfirewall-firewall-control-firewall-behavior.md)
