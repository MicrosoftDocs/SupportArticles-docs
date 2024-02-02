---
title: Applying Group Policy troubleshooting guidance
description: Provides guidance to troubleshoot Group Policy.
ms.date: 04/28/2023
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
ms.subservice: group-policy
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
localization_priority: medium
ms.reviewer: kaushika
---
# Applying Group Policy troubleshooting guidance

<p class="alert is-flex is-primary"><span class="has-padding-left-medium has-padding-top-extra-small"><a class="button is-primary" href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806366" target='_blank'><b>Try our Virtual Agent</b></a></span><span class="has-padding-small"> - It can help you quickly identify and fix common Active Directory replication issues</span>

This guide provides you with the fundamental concepts used to troubleshoot Group Policy. You'll learn:

- How to locate new troubleshooting information.
- How to use the Event Viewer to filter specific Group Policy information.
- How to read and interpret event data.
- Correct methods for locating the point of failure.

## Troubleshooting checklist

1. Start by reading Group Policy events recorded in the system event log.

    - Warning events provide further information for you to follow to ensure the Group Policy service remains healthy.
    - Error events provide you with information that describes the failure and probable causes.
    - Use the **More Information** link included in the event message.
    - Use the **Details** tab to view error codes and descriptions.

2. Use the Group Policy operational log.

    - Identify the activity ID of the instance of Group Policy processing you're troubleshooting.
    - Create a custom view of the operational log.
    - Divide the log into phases: pre-processing, processing, and post-processing.
    - Consolidate each starting event with its corresponding ending event. Investigate all warning and error events.
    - Isolate and troubleshoot the dependent component.
    - Use the Group Policy update command (GPUPDATE) to refresh Group Policy. Repeat these steps to determine if the warning or error still exists.

> [!IMPORTANT]
> Refreshing Group Policy changes the Activity ID in your custom view. Make sure to update your custom view with the most current Activity ID when troubleshooting.

### Determine the instance of Group Policy processing

Before you view the Group Policy operational log, you must first determine the instance of Group Policy processing that failed.

To determine an instance of Group Policy processing, follow these steps:

1. Open the Event Viewer.
2. Under **Event Viewer (Local)**, select **Windows Logs** > **System**.
3. Double-click the Group Policy warning or error event you want to troubleshoot.
4. Select the **Details** tab, and then check **Friendly view**. Select **System** to expand the **System** node.
5. Find the **ActivityID** in the **System** node details. You use this value (without the opening and closing braces) in your query. Copy this value to Notepad so it's available to you later, and select **Close**.

### Create a custom view of a Group Policy instance

A computer often has more than one instance of Group Policy processing. Computers dedicated to running Terminal Services usually have more than one instance of Group Policy processing and operate simultaneously. Therefore, it's important to filter the Group Policy operational event log to show only events for the instance you're troubleshooting.

Use the following procedure to create a custom view of a Group Policy instance. You do this by using an Event Viewer query. This query creates a filtered view of the Group Policy operational log for a specific instance of Group Policy processing.

To create a custom view of a Group Policy instance, follow these steps:

1. Open the Event Viewer.
2. Right-click **Custom Views**, and then select **Create Custom View**.
3. Select the **XML** tab, and then check the **Edit query manually** check box. The Event Viewer displays a dialog box explaining that manually editing a query prevents you from modifying the query using the **Filter** tab. Select **Yes**.
4. Copy the Event Viewer query (provided at the end of this step) to the clipboard. Paste the query into the **Query** box.

   `<QueryList><Query Id="0" Path="Application"><Select Path="Microsoft-Windows-GroupPolicy/Operational">*[System/Correlation/@ActivityID='{INSERT ACTIVITY ID HERE}']</Select></Query></QueryList>`

5. Copy the **ActivityID** you previously saved from the [Determine the instance of Group Policy processing](#determine-the-instance-of-group-policy-processing) section to the clipboard. In the **Query** box, highlight "INSERT ACTIVITY ID HERE" and then press Ctrl+V to paste the **ActivityID** over the text.

   > [!NOTE]
   > Be sure not to paste over the leading and trailing braces ({ }). You must include these braces for your query to work properly.

6. In the **Save Filter to Custom View** dialog box, type a name and description meaningful to the view you created. Select **OK**.
7. The name of the saved view appears under **Custom Views**. Select the name of the saved view to display its events in the Event Viewer.

> [!IMPORTANT]
> The Group Policy service assigns a unique **ActivityID** for each instance of policy processing. For example, the Group Policy service assigns a unique **ActivityID** when user policy processing occurs during user logon. When Group Policy refreshes, the Group Policy service assigns another unique **ActivityID** to the instance of Group Policy responsible for refreshing user policy.

Make sure the group policy has all the settings you're looking for and it's correctly linked. Below are the tabs that you have to go through. If all of them look good, go to the problematic client machine.

1. Open an elevated command prompt and run the following command.

   ```console
   gpresult /h gp.html
   ```

2. Verify the `gpresult` output you have captured and look for the GPO you're having issues with. It will give an error about why the GPO isn't getting applied.
3. If you have an error in the `gpresult` output, we can troubleshoot the issue based on it. Otherwise, go to the next step.
4. Open the Event Viewer and browse to application and system event logs. The application event log will give you the details on why the group policy update fails positively.
5. Open the operational event log for more detailed information. There are events with the list of applied GPOs and a list of denied GPOs with the reason.

Most of the GPO issues can be resolved by using these basic logs.

### Group Policy log files

You can enable verbose logging and examine the resulting log files. Verbose logging can reduce performance and consume significant disk space, so as a best practice, enable verbose logging only when necessary.

#### Enable Group Policy Service (GPSvc) logging

On the client where the GPO problem occurs, follow these steps to enable Group Policy Service debug logging.

1. Open Registry Editor.
2. Locate and then select the following registry subkey:

   `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion`

3. On the **Edit** menu, select **New** > **Key**.
4. Type *Diagnostics*, and then press Enter.
5. Right-click the **Diagnostics** subkey, select **New** > **DWORD (32-bit) Value**.
6. Type *GPSvcDebugLevel*, and then press Enter.
7. Right-click **GPSvcDebugLevel**, and then select **Modify**.
8. In the **Value data** box, type *30002* (Hexadecimal), and then select **OK**.
9. Exit Registry Editor.
10. In a command prompt window, run the `gpupdate /force` command, and then press Enter.

Then, view the *Gpsvc.log* file in the following folder: *%windir%\\debug\\usermode*

> [!NOTE]
> If the *usermode* folder does not exist, create it under *%windir%\\debug*.
> If the *usermode* folder does not exist under *%WINDIR%\\debug\\*, the *gpsvc.log* file will not be created.

## Common issues and solutions

### Event ID 1129

Event ID 1129 is logged when the Group Policy fails to apply due to network connectivity issues.

In this case, the connectivity to Lightweight Directory Access Protocol (LDAP) port 389 is blocked on DC. The `gpupdate` command fails with the following error:

When checking the event log, you may find the following event description:

```output
The processing of Group Policy failed because of lack of network connectivity to a domain controller. This may be a transient condition. A success message would be generated once the machine gets connected to the domain controller and Group Policy has successfully processed. If you do not see a success Message for several hours, then contact your administrator.
```

In this case, enable the gpsvc debug log. In the gpsvc log, you may find the output "GetLdapHandle: Failed to connect \<DC\> with 81".

Enable a network trace to verify:

- There's a ldap query done at the site level.
- The query returns two entries for that site that hold the ldap service role.
- For one of them, we can see a name resolution is being done.
- Because the name resolution is successful, it tries to do an ldap bind but fails at TCP handshake as port 389 is blocked.
- If there's no answer from the DC for our TCP handshake on port 389, the next steps are to involve the customer network team and provide them with this information.
- Make sure that in such scenarios, you make use of all the logs specified in the action plan mentioned above, correlate them, and they'll lead you to the root cause or at least narrow down the issue.

### Event ID 1002

Here's the description of Event ID 1002:

```output
The processing of Group Policy failed because of a system allocation failure. Please ensure the computer is not running low on resources (memory, available disk space). Group Policy processing will be attempted at the next refresh cycle.
```

This error event is usually resolved when the computer returns from a low-resource state. Possible resolutions include:

1. Ensure the computer isn't low on memory or available disk space.
2. Restart the computer if it has been operating for an extended period.

### Event ID 1006

Here's the description of Event ID 1006:

```output
The processing of Group Policy failed. Windows could not authenticate to the Active Directory service on a domain controller. (LDAP Bind function call failed). Look in the Details tab for error code and description.
```

This error event is usually resolved after correcting binding to the directory. The Group Policy service logs an error code, which appears on the **Details** tab of the error message in Event Viewer. The error code (displayed as a decimal) and error description fields further identify the reason for the failure. Evaluate the error code with the list below:

- Error code 5 (Access is denied)

   This error code might indicate that the user doesn't have permission to access Active Directory.

- Error code 49 (Invalid credentials)

   This error code might indicate that the user's password has expired while the user is still logged on the computer. To correct credentials that aren't valid:

   1. Change the user's password.
   2. Lock/unlock the workstation.
   3. Check if there are any system services running as the user account.
   4. Verify the password in the service configuration is correct for the user account.

- Error code is 258 (Timeout)

   This error code might indicate that the DNS configuration is incorrect. To correct timeout issues, use the `nslookup` tool to confirm _ldap._tcp.\<domain-dns-name\> records are registered and point to correct servers (where \<domain-dns-name\> is the fully qualified domain name of your Active Directory domain).

   > [!NOTE]
   > These steps may have varying results if your network constrains or blocks Internet Control Message Protocol (ICMP) packets.

### Event ID 1030

Here's the description of Event ID 1030:

```output
The processing of Group Policy failed. Windows attempted to retrieve new Group Policy settings for this user or computer. Look in the Details tab for error code and description. Windows will automatically retry this operation at the next refresh cycle. Computers joined to the domain must have proper name resolution and network connectivity to a domain controller for discovery of new Group Policy objects and settings. An event will be logged when Group Policy is successful.
```

Check if the LDAP ports are open. If not, then make sure the ports are open on the firewall and locally on the client and the domain controller.

#### How to determine port block

- Use portqueryUI tool to determine which ports are blocked. For more information, see [How to use PortQry to troubleshoot Active Directory connectivity issues](../networking/use-portqry-verify-active-directory-tcp-ip-connectivity.md).
- Use [telnet](../../windows-client/networking/use-telnet-to-test-port-3389-functionality.md) for port 389 to check connectivity on the ldap port.
- How to [configure domain and trust ports](../identity/config-firewall-for-ad-domains-and-trusts.md).
- Configuring the [default outbound firewall behavior](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee215186%28v=ws.10%29).
- Configure [firewall port requirements for Group Policy](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj572986%28v=ws.11%29).

#### Make sure DNS name resolution where the client is unable to resolve a host name

- If a client can't resolve a host name, then it's best to verify the Host name resolution sequence listed above that the client should be using. If the name doesn't exist in any of the resources that the client uses, then you must decide which resource to add it. If the name exists in one of the resources, such as a DNS server or a Windows Internet Name Service (WINS) server, and the client isn't resolving the name correctly, focus your attention on troubleshooting that specific resource.
- Also, confirm that the client is trying to resolve a host name and not a NetBIOS name. Many applications have multiple methods that they can utilize to resolve names. This is especially true of mail and database applications. The application may be configured to connect to resources using NetBIOS. Depending on the client configuration, the client may bypass host name resolution. From there, it will be necessary to either change the connection type to TCP/IP sockets or troubleshoot the problem as a NetBIOS issue.

#### Group Policy Container permission

Use the following [Get-GPPermission PowerShell cmdlet](/powershell/module/grouppolicy/get-gppermission) to get the permission level for all security principals on the specified GPO:

```powershell
Get-GPPermission -Name "TestGPO" -All
```

### Event ID 1058

Here's the description of Event ID 1058:

```output
The processing of Group Policy failed. Windows attempted to read the file %9 from a domain controller and was not successful. Group Policy settings may not be applied until this event is resolved. This issue may be transient and could be caused by one or more of the following:
1. Name Resolution/Network Connectivity to the current domain controller.
2. File Replication Service Latency (a file created on another domain controller has not replicated to the current domain controller).
3. The Distributed File System (DFS) client has been disabled.
```

Correct connectivity to the Group Policy template. The Group Policy service logs the name of the domain controller and the error code, which appears on the **Details** tab of the error message in Event Viewer. The error code (displayed as a decimal) and error description fields further identify the reason for the failure. Evaluate the error code with the list below:

- Error code 3 (The system cannot find the path specified)

   This error code usually indicates that the client computer cannot find the path specified in the event. To test client connectivity to the domain controller's sysvol:

   1. Identify the domain controller used by the computer. The domain controller name is logged in the details of the error event.
   2. Identify if the failure happens during the user or computer processing. For user policy processing, the **User** field of the event will show a valid user name; for computer policy processing, the **User** field will show "SYSTEM".
   3. Compose full network path to the **gpt.ini** as *\\\\<dcName\>\\SYSVOL\\<domain\>\Policies\\<guid\>\\gpt.ini* where \<dcName\> is the name of the domain controller, \<domain\> is the name of the domain, and \<guid\> is the GUID of the policy folder. All the information appears in the event.
   4. Verify that you can read *gpt.ini* by using the full network path obtained in the previous step. To do this, open a command prompt window and type *\<file_path\>*, where \<file_path\> is the path constructed in the previous step, and press Enter.

      > [!NOTE]
      > You must run this command as the user or computer whose credentials previously failed.

- Error code 5 (Access is denied)

   This error code usually indicates that the user or computer doesn't have the appropriate permissions to access the path specified in the event. On the domain controller, ensure the user and computer have appropriate permission to read the path specified in the event. To test computer and user credentials:

   1. Log off and restart the computer.
   2. Log on the computer with the domain credentials previously used.

- Error code 53 (The network path wasn't found)

   This error code usually indicates that the computer cannot resolve the name in the provided network path. To test network path name resolution:

   1. Identify the domain controller used by the computer. The name of the domain controller is logged in the details of the error event.
   2. Try to connect to the netlogon share on the domain controller using the path *\\\\\<dcName\>\\netlogon* where \<dcName\> is the name of the domain controller in the error event.

### Event ID 1053

Here's the description of Event ID 1053:

```output
The processing of Group Policy failed. Windows could not resolve the user name. This could be caused by one or more of the following:
1. Name Resolution failure on the current domain controller.
2. Active Directory Replication Latency (an account created on another domain controller has not replicated to the current domain controller).
```

The Group Policy service logs the name of the domain controller and the error code. This information appears on the **Details** tab of the error message in Event Viewer. The error code (displayed as a decimal) and error description fields further identify the reason for the failure. Evaluate the error code with the list below:

- Error code 5 (Access is denied): This error code might indicate that the user's password expired while the user was still logged on the computer. If the user recently changed their password, the issue might disappear after allowing time for Active Directory replication to succeed.

   1. Change the user password.
   2. Lock/unlock the workstation.
   3. Check if there are any system services running as the user account.
   4. Verify that the password in the service configuration is correct for the user account.

- Error code 14 (Not enough storage is available to complete this operation)

   This error code might indicate that Windows doesn't have enough memory to complete the task. Investigate the system event log for any other memory-specific issues.

- Error code 525 (The specified user doesn't exist)

   This error code might indicate incorrect permissions on the organizational unit. The user requires read access to the organizational unit that contains the user object. Similarly, computers require read access to the organizational unit that contains the computer object.

- Error code 1355 (The specified domain either doesn't exist or couldn't be contacted)

   This error code might indicate a fault or improper configuration with name resolution (DNS). Use `nslookup` to confirm you can resolve the addresses of the domain controllers in the user domain.

- Error code 1727 (The remote procedure call failed and didn't execute)

   This error code might indicate that firewall rules are preventing communication with a domain controller. If you have third-party firewall software installed, check the configuration of the firewall or try temporarily disabling it and verifying that Group Policy processes successfully.

### Event ID 1097

Here's the description of Event ID 1097:

```output
The processing of Group Policy failed. Windows could not determine the computer account to enforce Group Policy settings. This may be transient. Group Policy settings, including computer configuration, will not be enforced for this computer.
```

Domain computers authenticate to the domain, as do domain users. Windows requires the computer to log on before it can apply Group Policy to the computer. Possible resolutions include:

- Verify that the time on the computer is synchronized with the time on the domain controller.
- Account for time zone misconfigurations if the computer is configured in a time zone different from the domain controller.
- A time difference greater than five minutes between the computer and the domain controller may lead to the computer failing to authenticate with the domain. Force time synchronization against time service using the `w32tm /resync` command.
- Restart the computer.

### Event ID 4016 and Event ID 5016

During the periodic Group Policy refresh, the service uses the information it collected in the pre-processing phase to apply each policy setting. The service accomplishes this by passing the previously collected information to each of the system and nonsystem client-side extensions. This phase begins by recording a client-side extension (CSE) processing event.

|Event ID  |Event type  |Explanation  |
|---------|---------|---------|
|4016     |Informational         |The Group Policy service logs this event each time a Group Policy client-side extension begins its processing.         |
|5016     |Success         |The Group Policy service logs this event when a Group Policy client-side extension completes its processing successfully.         |

When you go to the **Details** tab under Event ID 5016, you may find the following return status:

```output
ErrorCode 2147483658 <-> 0x8000000a       -2147483638               E_PENDING                    "The data necessary to complete this operation is not yet available"
```

> [!NOTE]
> The return value "-2147483638 (E_PENDING)" is expected and by design during audit client-side extension processing. It indicates that an asynchronous thread was started successfully by the Group Policy engine to process the audit extension information. It also means that the return value will be logged even if the new audit settings are effective or applied on the clients.

#### Determine the advanced Audit client side extension (AuditCSE) processing

After you receive the return value 2147483658 from Event ID 5016, you can examine the verbose level events of AuditCSE processing under the **Security-Audit-Configuration-Client** > **Operational** event log. This information is useful to observe the processing of Advanced Audit group policy settings and thus detect any failures/errors.



1. Audit Client Side Extension (Auditcse.dll) will process the Audit client side extensions.
2. It has its own logging under **Security-Audit-Configuration-Client** > **Operational log**.

Follow these steps to review the **Security-Audit-Configuration-Client** > **Operational** event log for troubleshooting Audit group policy settings:

1. Open **Event viewer**.
2. Under **Event Viewer (local)**, select **Applications and Services Logs** > **Microsoft** > **Windows** > **Security-Audit-Configuration-Client** > **Operational**.
3. Double-click the **Warning** or **Error** events to troubleshoot. Also review the **Details** tab for these events for any **Error** value.
4. Else, review the **Informational** event to capture the complete processing of Audit extension.

## Gather key information before you contact Microsoft Support

Before you complete your support request, we recommend that you use the Windows Live Dump feature to save a snapshot of kernel memory on the affected computer. To do this, follow these steps:

1. Capture Group Policy Service verbose logging by running the following commands:

   ```console
   md %windir%\debug\usermode

   reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Diagnostics" /v GPSvcDebugLevel /t REG_DWORD /d "0x00030002"
   ```

2. Refresh local and AD-based Group Policy settings by using the `gpupdate /force` command.

   > [!TIP]
   >
   > Use one of the below commands if you troubleshoot a particular user or computer missing settings:
   >
   > - `Gpupdate /force /target:computer`
   > - `Gpupdate /force /target:user`

3. Save the Resultant Set of Policy (RSoP) report to an HTML file by running the following command:

   ```console
   gpresult /h %Temp%\GPResult.htm
   ```

4. Save the RSoP summary data to a txt file by running the following command:

   ```console
   gpresult /r >%Temp%\GPResult.txt
   ```

5. Export the GPExtensions registry keys by running the following command:

   ```console
   reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions" %Temp%\GPExtensions.reg
   ```

6. Export the system, application, and Group Policy operational event viewer logs by running the following commands:

   ```console
   wevtutil.exe export-log Application %Temp%\Application.evtx /overwrite:true

   wevtutil.exe export-log System %Temp%\System.evtx /overwrite:true

   wevtutil.exe export-log Microsoft-Windows-GroupPolicy/Operational %Temp%\GroupPolicy.evtx /overwrite:true
   ```

7. Capture the following files:

   - *%Temp%\\Application.evtx*
   - *%Temp%\\System.evtx*
   - *%Temp%\\GroupPolicy.evtx*
   - *%Temp%\\GPExtensions.reg*
   - *%Temp%\\GPResult.txt*
   - *%Temp%\\GPResult.html*
   - *%windir%\\debug\\usermode\\gpsvc.log*

8. When finished, you can stop Group Policy Service logging by running the following command:

   ```console
   reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Diagnostics" /v GPSvcDebugLevel /t REG_DWORD /d "0x00000000" /f
   ```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
