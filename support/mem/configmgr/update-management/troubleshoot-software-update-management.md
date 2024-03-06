---
title: Troubleshoot software update management
description: Helps you troubleshoot the software update management process in Configuration Manager.
ms.date: 12/05/2023
ms.custom: sap:Software Update Management and Compliance
ms.reviewer: kaushika
---
# Troubleshoot software update management in Configuration Manager

This article helps you troubleshoot the software update management process in Configuration Manager. It includes client software update scanning, synchronization issues, and detection problems with specific updates.

_Original product version:_ &nbsp; Configuration Manager (current branch), System Center 2012 R2 Configuration Manager, System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 4505440

## Scope your issue

This guide assumes that a software update point has already been installed and configured. For more information about configuring software updates in Configuration Manager, see [Prepare for software updates management](/mem/configmgr/sum/get-started/prepare-for-software-updates-management).

Before you start troubleshooting, it's important to emphasize that, the better you understand the problem you're experiencing, the quicker and easier it will be for you to fix it. Whether you're tasked with fixing a problem that you are experiencing, or a problem reported to you by someone in your organization, take a moment and answer the following questions:

1. What specifically isn't working and/or what is your goal?
2. What is the frequency or pattern for the issue? Is the problem still happening?
3. How did you become aware that the problem exists?
4. Has it ever worked? If so, when did it stop? Was anything changed in the environment right before it stopped working?
5. What percentage of clients are affected?
6. What has been done already (if anything) to try to fix it?
7. Know the exact version of the client and the version of the server. Are these systems up to date?
8. What do affected clients have in common? For example, same subnet, AD site, domain, physical location, site, site system.

Knowing and understanding the answers to these questions will put you on the best path for a quick and easy resolution to whatever problem you're experiencing.

If you know the specific area within the software update management process that you'd like to troubleshoot, select it below. Start with client software update scanning if unsure and we'll walk through the entire process from beginning to end.

- [Client software update scanning](#client-software-update-scanning)
- [WSUS to Microsoft Update synchronization](#wsus-to-microsoft-update-synchronization)
- [Installation, supersedence, or detection issues with specific updates](#installation-supersedence-or-detection-issues-with-specific-updates)

## Client software update scanning

The client scan process is outlined in the following steps. Confirm each step to properly establish where the issue is.

### Step 1: The client sends a WSUS location request to the management point

The first thing the client does is set the WSUS server that will be its update source for software update scans. That process is detailed below.

1. When the Configuration Manager client needs to process a software update scan, Scan Agent creates a scan request based on the available policy as noted in ScanAgent.log:

    ```output
    CScanAgent::ScanByUpdates- Policy available for UpdateSourceID={SourceID}  
    ContentVersion=38  
    CScanAgent::ScanByUpdates- Added Policy to final ScanRequest List UpdateSourceID={SourceID}, Policy-ContentVersion=38, Required-ContentVersion=38
    ```

2. Scan Agent now sends a WSUS location request to Location Services as noted in ScanAgent.log:

   ```output
   Inside CScanAgent::ProcessScanRequest()  
   CScanJobManager::Scan- entered  
   ScanJob({JobID}): CScanJob::Initialize- entered  
   ScanJob({JobID}): CScanJob::Scan- entered  
   ScanJob({JobID}): CScanJob::RequestLocations- entered  
   - - - - - -Requesting WSUS Server Locations from LS for {WSUSLocationID} version 38  
   - - - - - -Location Request ID = {LocationRequestID}  
   CScanAgentCache::PersistInstanceInCache- Persisted Instance CCM_ScanJobInstance  
   ScanJob({JobID}): - - - - - -Locations requested for ScanJobID={JobID} (LocationRequestID={LocationRequestID}), will process the scan request once locations are available.
    ```

    > [!TIP]
    > Each scan job is stored in WMI in the `CCM_ScanJobInstance` class:
    >
    > Namespace: `root\CCM\ScanAgent` Class: `CCM_ScanJobInstance`

3. Location Services creates a location request and sends it to the management point. The package ID for a WSUS location request is the update source unique ID. In LocationServices.log:

    ```output
    CCCMWSUSLocation::GetLocationsAsyncEx  
    Attempting to persist WSUS location request for ContentID='{ContentID}' and ContentVersion='38'  
    Persisted WSUS location request LocationServices  
    Attempting to send WSUS Location Request for ContentID='{ContentID}'
    WSUSLocationRequest : <WSUSLocationRequest SchemaVersion="1.00"><Content ID="{ContentID}" Version="38"/><AssignedSite SiteCode="PS1"/><ClientLocationInfo OnInternet="0"><ADSite Name="CM12-R2PS1"/><Forest Name="CONTOSO.COM"/><Domain Name="CONTOSO.COM"/><IPAddresses><IPAddress SubnetAddress="192.168.2.0" Address="192.168.2.62"/></IPAddresses></ClientLocationInfo></WSUSLocationRequest>  
    Created and Sent Location Request '{LocationRequestID}' for package {ContentID}
    ```

4. CCM Messaging sends the location request message to the management point. In CcmMessaging.log:

    ```output
    Sending async message '{Message}' to outgoing queue 'mp:[http]mp_locationmanager'  
    Sending outgoing message '{Message}'. Flags 0x200, sender account empty
    ```

5. The management point parses this request and calls the `MP_GetWSUSServerLocations` stored procedure to get the WSUS locations from the database. In MP_Location.log:

    ```output
    MP LM: Message Body : \<WSUSLocationRequest SchemaVersion="1.00"><Content ID="{ContentID}" Version="38"/><AssignedSite SiteCode="PS1"/><ClientLocationInfo OnInternet="0"><ADSite Name="CM12-R2PS1"/><Forest Name="CONTOSO.COM"/><Domain Name="CONTOSO.COM"/><IPAddresses><IPAddress SubnetAddress="192.168.2.0" Address="192.168.2.62"/></IPAddresses></ClientLocationInfo></WSUSLocationRequest> MP_LocationManager  
    MP LM: calling MP_GetWSUSServerLocations
    ```

    In SQL Server Profiler:

    ```output
    exec MP_GetMPSitesFromAssignedSite N'PS1'  
    exec MP_GetSiteInfoUnified N'<ClientLocationInfo OnInternet="0"><ADSite Name="CM12-R2-PS1"/><Forest Name="CONTOSO.COM"/><Domain Name="CONTOSO.COM"/><IPAddresses><IPAddress SubnetAddress="192.168.2.0" Address="192.168.2.62"/></IPAddresses></ClientLocationInfo>'  
    exec MP_GetWSUSServerLocations N'{WSUSServerLocationsID}',N'38',N'PS1',N'PS1',N'0',N'CONTOSO.COM'
    ```

6. After getting the results from the stored procedure, the management point sends a response to the client. In MP_Location.log:

    ```output
    MP LM: Reply message body: <WSUSLocationReply SchemaVersion="1.00"><Sites><Site><MPSite SiteCode="PS1"/><LocationRecords><LocationRecord WSUSURL="http://PS1SITE.CONTOSO.COM:8530" ServerName="PS1SITE.CONTOSO.COM" Version="38"/><LocationRecord WSUSURL="https://PS1SYS.CONTOSO.COM:8531" ServerName="PS1SYS.CONTOSO.COM" Version="38"/></LocationRecords></Site></Sites></WSUSLocationReply>
    ```

7. CCM Messaging receives the response and sends it back to Location Services. In CcmMessaging.log:

    ```output
    Message '{Message1}' got reply '{Message2}' to local endpoint queue 'LS_ReplyLocations'  
    OutgoingMessage(Queue='mp_[http]mp_locationmanager', ID={*Message1*}):  
    Delivered successfully to host 'PS1SYS.CONTOSO.COM'.  
    Message '{Message2}' delivered to endpoint 'LS_ReplyLocations'
    ```

8. Location Services parses the response and sends the location back to Scan Agent. In LocationServices.log:

    ```output
    Processing Location reply message LocationServices  
    WSUSLocationReply : <WSUSLocationReply SchemaVersion="1.00"><Sites><Site><MPSite SiteCode="PS1"/><LocationRecords><LocationRecord WSUSURL="http://PS1SITE.CONTOSO.COM:8530" ServerName="PS1SITE.CONTOSO.COM" Version="38"/><LocationRecord WSUSURL="https://PS1SYS.CONTOSO.COM:8531" ServerName="PS1SYS.CONTOSO.COM" Version="38"/></LocationRecords></Site></Sites></WSUSLocationReply>  
    Calling back with the following WSUS locations  
    WSUS Path='http://PS1SITE.CONTOSO.COM:8530', Server='PS1SITE.CONTOSO.COM', Version='38'  
    WSUS Path='https://PS1SYS.CONTOSO.COM:8531', Server='PS1SYS.CONTOSO.COM', Version='38'  
    Calling back with locations for WSUS request {WSUSLocationID}
    ```

9. Scan Agent now has the policy and the update source location with the appropriate content version. In ScanAgent.log:

    ```output
    *****WSUSLocationUpdate received for location request guid={LocationGUID}  
    ScanJob({JobID}): CScanJob::OnLocationUpdate- Received  
    Location=<http://PS1SITE.CONTOSO.COM:8530>, Version=38  
    ScanJob({JobID}): CScanJob::Execute- Adding UpdateSource={SourceID}, ContentType=2, ContentLocation=<http://PS1SITE.CONTOSO.COM:8530>, ContentVersion=38
    ```

10. Scan Agent notifies WUAHandler to add the update source. WUAHandler adds the update source to the registry. It initiates a Group Policy refresh if the client is in domain to see whether Group Policy overrides the update server that's added. The following entries are logged in WUAHandler.log showing a new Update Source being added:

    ```output
    Its a WSUS Update Source type ({WSUSUpdateSource}), adding it  
    Its a completely new WSUS Update Source  
    Enabling WUA Managed server policy to use server: <http://PS1SITE.CONTOSO.COM:8530>
    Policy refresh forced  
    Waiting for 2 mins for Group Policy to notify of WUA policy change  
    Waiting for 30 secs for policy to take effect on WU Agent.  
    Added Update Source ({UpdateSource}) of content type: 2
    ```

    During this time, the Windows Update Agent sees a WSUS configuration change. In WindowsUpdate.log:

    ```output
    * WSUS server: <http://PS1SITE.CONTOSO.COM:8530> (Changed)  
    * WSUS status server: <http://PS1SITE.CONTOSO.COM:8530> (Changed)  
    Sus server changed through policy.
    ```

    The following registry keys are checked and set:

    |Registry subkey|Value name|Type|Data|
    |---|---|---|---|
    |`HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate`|`WUServer`|REG_SZ|The full WSUS server URL including the port. For example, *<`http://PS1Site.Contoso.com:8530`>*|
    |`HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate`|WUStatusServer|REG_SZ|The full WSUS server URL including the port. For example, *<`http://PS1Site.Contoso.com:8530`>*|
    |`HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU`|`UseWUServer`|REG_DWORD|0x1|

    For an existing client, we could expect to see the following message in WUAHandler.log to denote when content version has incremented:

    ```output
    Its a WSUS Update Source type ({WSUSUpdateSource}), adding it.  
    WSUS update source already exists, it has increased version to 38.
    ```

11. After the update source is successfully added, Scan Agent raises a state message and starts the scan. In ScanAgent.log:

    ```output
    ScanJob({JobID}): Raised UpdateSource ({UpdateSource}) state message successfully. StateId = 2  
    ScanJob({JobID}): CScanJob::Execute - successfully requested Scan, ScanType=1
    ```

#### Troubleshoot issues in step 1

|Issues|What to check|
|---|---|
|ScanAgent.log shows no policy available for an update source and no WUAHandler.log exists or no current activity within WUAHandler.log|Check the [Enable software updates on clients](/mem/configmgr/core/clients/deploy/about-client-settings#enable-software-updates-on-clients) setting.|
|Scan Agent or Location Services doesn't receive the WSUS server location|<ul><li><p>Is a software update point (SUP) role installed for the site?</p><p>If not, install and configure a software update point and monitor SUPSetup.log for progress. For more information, see [Install and configure a software update point](/mem/configmgr/sum/get-started/install-a-software-update-point).</p></li><li><p>If a SUP role is installed, is it configured and synchronizing?</p><p>Check WCM.log, WSUSCtrl.log, and WSyncMgr.log for errors.</p><ul><li>`select * from WSUSServerLocations`</li><li>`select * from Update_SyncStatus`</li></ul></li></ul>|
|Client receives the WSUS location but fails to configure the WSUS registry keys|<p>Did Group Policy refresh respond within the 2-minute timeout per WUAHandler.log? If so, does WUAHandler denote **Group policy settings were overwritten by a higher authority (Domain Controller)**?</p><p>For more information, see [Group Policy overrides the correct WSUS configuration information](troubleshoot-software-update-scan-failures.md#group-policy-overrides-the-correct-wsus-configuration-information).</p>|

For more information about software update scan failures troubleshooting, see [Troubleshoot software update scan failures](troubleshoot-software-update-scan-failures.md).

### Step 2: Scan Agent requests the scan and WUAHandler starts the scan

After the client has identified and set the WSUS server that will be its update source for software update scans, Scan Agent requests the scan from WUAHandler that uses the Windows Update Agent API to request a software update scan from the Windows Update Agent. A scan may result from:

- A scheduled or manual software update scan
- A scheduled or manual software updated deployment re-evaluation
- A deployment that becomes active

The scan triggers an evaluation. In ScanAgent.log:

```output
ScanJob({JobID}): CScanJob::Execute - successfully requested Scan, ScanType=1
```

Scan results will include superseded updates only when they're superseded by service packs and definition updates. In WUAHandler.log:

```output
Search Criteria is (DeploymentAction=* AND Type='Software') OR (DeploymentAction=* AND Type='Driver')  
Running single-call scan of updates.  
Async searching of updates using WUAgent started.
```

> [!TIP]
> Review WUAHandler.log after a software update scan to see if any new entries occur. If no new entries occur, it indicates that no SUP is returned by the management point.

#### Troubleshoot issues in step 2

Many issues with software update scan can be caused by one of the following reasons:

- Missing or corrupted files or registry keys.
- Component registration issues.

To fix such issues, see [Scan failures due to missing or corrupted components](troubleshoot-software-update-scan-failures.md#scan-failures-due-to-missing-or-corrupted-components).

There's a known issue that a 32-bit Windows 7 ConfigMgr 2012 R2 client requesting an update scan fails to return scan results to Configuration Manager. It causes the client to report incorrect compliance status and the updates fail to install when Configuration Manager requests the update cycle. However, if you use the Windows Update control panel applet, the updates usually install fine. When you're experiencing this problem, you receive a message similar to the following one in WindowsUpdate.log:

```output
WARNING: ISusInternal::GetUpdateMetadata2 failed, hr=8007000E
```

It's a memory allocation issue, 64-bit Windows 7 computers won't see this error since their address space is effectively unlimited. However, they'll exhibit high memory and high CPU usage, possibly affecting performance. X86 clients will also exhibit high memory usage (usually around 1.2 GB to 1.4 GB).

To fix this issue, apply [Windows Update Client for Windows 7: June 2015](https://support.microsoft.com/help/3050265).

When troubleshooting scan failures, check the WUAHandler.log and WindowsUpdate.log files. WUAHandler simply reports what Windows Update Agent reported. So, the error in WUAHandler would be the same error that was reported by the Windows Update Agent itself. More information about the error can be found in WindowsUpdate.log. To understand how to read WindowsUpdate.log, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

Your best source of information will come from the logs and the error codes they contain. For more information about the error codes, see [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors).

### Step 3: Windows Update Agent (WUA) starts the scan against the WSUS computer

Windows Update Agent starts a scan after receiving a request from the Configuration Manager client (CcmExec). If these registry values are correctly set to a WSUS computer that's a valid SUP for the site through a local policy, you should see a COM API search request from the Configuration Manager client (ClientId = CcmExec). In WindowsUpdate.log:

```output
COMAPI -- START -- COMAPI: Search [ClientId = CcmExec]  
COMAPI <<-- SUBMITTED -- COMAPI: Search [ClientId = CcmExec] PT + ServiceId = {ServiceID}, Server URL = <http://PS1.CONTOSO.COM:8530/ClientWebService/client.asmx>  
Agent ** START ** Agent: Finding updates [CallerId = CcmExec]  
Agent * Include potentially superseded updates  
Agent * Online = Yes; Ignore download priority = Yes  
Agent * Criteria = "(DeploymentAction=* AND Type='Software') OR (DeploymentAction=* AND Type='Driver')"  
Agent * ServiceID = {ServiceID} Managed  
Agent * Search Scope = {Machine}

PT + ServiceId = {ServiceID}, Server URL = <http://PS1.CONTOSO.COM:8530/ClientWebService/client.asmx>  
Agent * Added update {4AE85C00-0EAA-4BE0-B81B-DBD7053D5FAE}.104 to search result  
Agent * Added update {57260DFE-227C-45E3-9FFC-2FC77A67F95A}.104 to search result  
Agent * Found 163 updates and 70 categories in search; evaluated appl. rules of 622 out of 1150 deployed entities  
Agent ** END ** Agent: Finding updates [CallerId = CcmExec]  
COMAPI >>-- RESUMED -- COMAPI: Search [ClientId = CcmExec]  
COMAPI - Updates found = 163  
COMAPI -- END -- COMAPI: Search [ClientId = CcmExec]
```

#### Troubleshoot issues in step 3

During a scan, the Windows Update Agent needs to communicate with the `ClientWebService` and `SimpleAuthWebService` virtual directories on the WSUS computer to perform a scan. If the client can't communicate with the WSUS computer, the scan will fail. This issue can happen for many reasons, including:

- **Proxy related issues**

  To fix these issues, see [Scan failures due to proxy-related issues](troubleshoot-software-update-scan-failures.md#scan-failures-due-to-proxy-related-issues).

  For more information about proxy servers, see the following articles:

  - [How the Windows Update client determines which proxy server to use to connect to the Windows Update Web site](https://support.microsoft.com/help/900935)
  - [DNS and DHCP Support for Web Proxy and Firewall Client Autodiscovery](/previous-versions/tn-archive/cc302584(v=technet.10))

- **HTTP timeout errors**

  To troubleshoot HTTP timeout errors, first review the Internet Information Services (IIS) logs on the WSUS computer to confirm that the errors are actually being returned from WSUS. If the WSUS computer isn't returning the error, the issue is likely with an intermediate firewall or proxy.

  If the WSUS computer is returning the error, verify connectivity with the WSUS computer. Here are the steps:

  1. To confirm that the client is connecting to the correct WSUS server, find the URL of the WSUS computer used by the Windows Update Agent client. This URL can be found by checking the `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate` registry subkey or by viewing the WindowsUpdate.log file.

     Common reasons that the WSUS assignment may be incorrect include:

     - Group Policy conflicts
     - The addition of a SUP to a secondary site after initial client installation

     > [!NOTE]
     > Active Directory Group Policy may override the local WSUS policy.

     The software updates feature automatically configures a local Group Policy setting for the Configuration Manager client so that it's configured with the software update point source location and port number. Both the server name and port number are required for the client to find the software update point.

     If an Active Directory Group Policy setting is applied to computers for software update point client installation, it overrides the local Group Policy setting. If the value of the setting defined in the Active Directory Group Policy is different from the one set by Configuration Manager, the scan will fail on the client because it can't locate the correct WSUS computer. In this situation, WUAHandler.log will show the following message:

     > Group policy settings were overwritten by a higher authority (Domain Controller) to: Server <`http://server`> and Policy ENABLED

     The software update point for client installation and software updates must be the same server. And it must be specified in the Active Directory Group Policy setting with the correct name format and port information. For example, it would be *<`http://server1.contoso.com:80`>* if the software update point was using the default website.

  2. If the server URL is correct, access the server using a URL similar to the following one to verify connectivity between the client and the WSUS computer:

        <`http://SUPSERVER.CONTOSO.COM:8530/Selfupdate/wuident.cab`>

        To check whether the client can access the `ClientWebService` virtual directory, try accessing a URL similar to this one:

        <`http://SUPSERVER.CONTOSO.COM:8530/ClientWebService/wusserverversion.xml`>

        To check whether the client can access the `SimpleAuthWebService`, try accessing a URL similar to this one:

        <`http://SUPSERVER.CONTOSO.COM:8530/SimpleAuthWebService/SimpleAuth.asmx`>

        If any of these URLs fail, some of the possible reasons include:

        - Name resolution issues on the client. Verify that you can resolve the FQDN of the WSUS computer.
        - [Proxy configuration issues](troubleshoot-software-update-scan-failures.md#scan-failures-due-to-proxy-related-issues).
        - Other network-related connectivity issues.
        - Port configuration problems, so it's a good idea to verify that the port settings are correct. WSUS can be configured to use any of the following ports: 80, 443 or 8530, 8531.

          For clients to communicate with the WSUS computer, the appropriate ports must be allowed on the firewall on the WSUS computer. Port settings are configured when the software update point site system role is created. These port settings must be the same as the port settings used by the WSUS website. Otherwise, WSUS Synchronization Manager will fail to connect to WSUS running on the software update point to request synchronization. The following procedures provide information about how to verify the port settings used by WSUS and the software update point.

          1. Determine the WSUS port settings used in IIS 7.0 and later versions.
          2. Determine the WSUS port settings in IIS 6.0.
          3. Configure ports for the software update point.
          4. Verify port connectivity

                To check port connectivity from the client, run the following command:

                ```console
                telnet SUPSERVER.CONTOSO.COM <portnumber>
                ```

                For example, run the following command if the port is 8530:

                ```console
                telnet SUPSERVER.CONTOSO.COM 8530
                ```

                If the port isn't accessible, telnet will return an error that resembles the following one:

                > Could not open connection to the host, on port \<_PortNumber_>

                This error suggests that the firewall rules aren't configured to allow communication for the WSUS computer. This error can also suggest that an intermediate network device is blocking that port. To verify, try the same test from a client on the same local subnet. If it works, the computers are configured correctly. However, a router or firewall between segments is blocking the port and causing the failure.

        - IIS availability problems.

          1. On the WSUS computer, open **Internet Information Services (IIS) Manager**.
          2. Expand **Sites**, right-click the website for the WSUS computer, and then click **Edit Bindings**.
          3. In the **Site Bindings** dialog box, the HTTP and HTTPS port values are displayed in the **Port** column.
          4. On the WSUS server, open **Internet Information Services (IIS) Manager**.
          5. Expand **Web Sites**, right-click the website for the WSUS computer, then click **Properties**.
          6. Click the **Web Site** tab. The HTTP port setting is displayed in **TCP port** and the HTTPS port setting is displayed in **SSL port**.
          7. In the Configuration Manager console, go to **Administration** > **Site Configuration** > **Servers and Site System Roles**, then click the \<_SiteSystemName_> right-hand pane.
          8. In the bottom pane, right-click **Software Update Point** and then click **Properties**.
          9. Go to the **General** tab, specify or verify the WSUS configuration port numbers.

- **Authentication errors**

  It's typically indicated when the scan fails with authentication errors 0x80244017 (HTTP Status 401) or 0x80244018 (HTTP Status 403).

  First, confirm the correct WinHTTP proxy settings using the following commands:

  - On Windows Vista or later versions: `netsh winhttp show proxy`
  - On Windows XP: `proxycfg.exe`

  If the proxy settings are correct, verify connectivity with the WSUS computer by completing the steps in **HTTP timeout errors**. Also review the IIS logs on the WSUS computer to confirm that the HTTP errors are being returned from WSUS. If the WSUS computer isn't returning the error, the issue is likely with an intermediate firewall or proxy.

- **Certificate problems**

  Certificate problems are indicated by error code 0x80072F0C that means "A certificate is required to complete client authentication". To fix this issue, see [Scan fails with error 0x80072f0c](troubleshoot-software-update-scan-failures.md#scan-fails-with-error-0x80072f0c).

### Step 4: WUAHandler receives results from Windows Update Agent and marks the scan as complete

The following are logged in WUAHandler.log:

```output
Async searching completed.  
Finished searching for everything in single call.
```

#### Troubleshoot issues in step 4

Problems here should be addressed the same way as scan failures in [step 3](#step-3-windows-update-agent-wua-starts-the-scan-against-the-wsus-computer).

As mentioned earlier in this guide, when troubleshooting scan failures, check the WUAHandler.log and WindowsUpdate.log files. WUAHandler simply reports what Windows Update Agent reported. So the error in WUAHandler would be the same error that was reported by the Windows Update Agent itself. More information about the error could be found in WindowsUpdate.log. To understand how to read WindowsUpdate.log, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

There are many reasons why a software update scan might fail. It could be caused by one of the issues mentioned earlier, or a communication or firewall issue between the client and the software update point computer. Your best source of information will come from the logs and the error codes they contain. For more information about the error codes, see [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors).  

### Step 5: WUAHandler parses the scan results

WUAHandler then parses the results, which include the applicability state for each update. As part of this process, superseded updates are pruned out. The applicability state is checked for all updates that align to the criteria submitted by CCMExec to the Windows Update Agent. The important thing to understand here is that you should see applicability results for updates whether those updates are in a deployment or not.

The following entries are logged in WUAHandler.log:

```output
> Pruning: update id (70f4f236-0248-4e84-b472-292913576fa1) is superseded by (726b7201-862a-4fde-9b12-f36b38323a6f).  
> ...  
> Update (Installed): Security Update for Windows 7 for x64-based Systems (KB2584146) (4ae85c00-0eaa-4be0-b81b-dbd7053d5fae, 104)  
> Update (Missing): Security Update for Windows 7 for x64-based Systems (KB2862152) (505fda07-b4f3-45fb-83d9-8642554e2773, 200)  
> ...  
> Successfully completed scan.
```

#### Troubleshoot issues in step 5

Problems can be addressed the same way as scan failures in [step 3](#step-3-windows-update-agent-wua-starts-the-scan-against-the-wsus-computer).

As mentioned earlier in this guide, when troubleshooting scan failures, check the WUAHandler.log and WindowsUpdate.log files. WUAHandler simply reports what Windows Update Agent reported. So the error in WUAHandler would be the same error that was reported by the Windows Update Agent itself. More information about the error could be found in WindowsUpdate.log. To understand how to read WindowsUpdate.log, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

Generally speaking, there are many reasons why a software update scan might fail. It could be caused by one of the issues mentioned earlier, or by a communication or firewall issue between the client and the software update point computer. Your best source of information will come from the logs and the error codes they contain. As a reference, see [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors).

### Step 6: Update store records the status and raises a state message for each update in WMI

Once the scan results are available, these results are stored in the updates store. Update store records the current state of each update and creates a state message for each update. These state messages are forwarded to the site server in bulk at the end of the status message reporting cycle (which is minutes, by default). We only send a state message under the following circumstances:

- A previous state message has never been sent for an update (log entry: **hasn't been reported before, creating new instance**).
- The applicability state for an update has changed since the last state message was submitted.

UpdatesStore.log showing state for missing update (KB2862152) being recorded and a state message being raised:

```output
Processing update status from update (505fda07-b4f3-45fb-83d9-8642554e2773) with ProductID = 0fa1201d-4330-4fa8-8ae9b877473b6441  
Update status from update (505fda07-b4f3-45fb-83d9-8642554e2773) hasn't been reported before, creating new instance.  
Successfully raised state message for update (505fda07-b4f3-45fb-83d9-8642554e2773) with state (Missing).  
Successfully added WMI instance of update status (505fda07-b4f3-45fb-83d9-8642554e2773).
```

StateMessage.log showing state messaged being recorded with **State ID 2** (missing):

```output
Adding message with TopicType 500 and TopicId 505fda07-b4f3-45fb-83d9-8642554e2773 to WMI  
State message(State ID : 2) with TopicType 500 and TopicId 505fda07-b4f3-45fb-83d9-8642554e2773 has been recorded for SYSTEM
```

> [!TIP]
> For each update, an instance of the `CCM_UpdateStatus` class is created or updated, and it stores the current status of the update. The `CCM_UpdateStatus` class is located in the `ROOT\CCM\SoftwareUpdates\UpdatesStore` namespace.

#### Troubleshoot issues in step 6

Problems here should be addressed the same way as scan failures in [step 3](#step-3-windows-update-agent-wua-starts-the-scan-against-the-wsus-computer).

As mentioned earlier in this guide, when troubleshooting scan failures, check the WUAHandler.log and WindowsUpdate.log files. WUAHandler simply reports what Windows Update Agent reported. So the error in WUAHandler would be the same error that was reported by the Windows Update Agent itself. More information about the error could be found in WindowsUpdate.log. To understand how to read WindowsUpdate.log, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

Generally speaking, there are many reasons why a software update scan might fail. It could be caused by one of the issues mentioned earlier, or by a communication or firewall issue between the client and the software update point computer. Your best source of information will come from the logs and the error codes they contain. As a reference, see [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors).  

### Step 7: State messages are sent to the management point

When WUAHandler successfully receives the results from the Windows Update Agent, it marks the scan as complete and logs the following message in WUAHandler.log:

```output
Async searching completed. WUAHandler  
Finished searching for everything in single call
```

#### Troubleshoot issues in step 7

Problems here should be addressed the same way as scan failures in [step 3](#step-3-windows-update-agent-wua-starts-the-scan-against-the-wsus-computer), although failures at this stage will likely be surfaced in the WindowsUpdate.log file specifically. To understand how to read WindowsUpdate.log, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

Generally speaking, there are many reasons why a software update scan might fail. It could be caused by one of the issues mentioned earlier, or by a communication or firewall issue between the client and the software update point computer. Your best source of information will come from the logs and the error codes they contain. As a reference, see [Windows Update common errors and mitigation](/windows/deployment/update/windows-update-errors).

## WSUS to Microsoft Update synchronization

WSUS synchronizing with Microsoft Update is outlined in the following steps. Confirm each step to properly establish where the issue is.

### Step 1: Synchronization starts through a scheduled or manual request

When a synchronization is triggered, we expect to see the following messages within the WSUS server's SoftwareDistribution.log:

**For manual sync:**

```output
Changew3wp.6AdminDataAccess.StartSubscriptionManuallySynchronization manually started  
Info WsusService.27EventLogEventReporter.ReportEvent  
EventId=382,Type=Information,Category=Synchronization,Message=A manual synchronization was started.
```

**For scheduled synch:**

```output
InfoWsusService.10EventLogEventReporter.ReportEvent  
EventId=381,Type=Information,Category=Synchronization,Message=A scheduled synchronization was started.
```

#### Troubleshoot a manual sync in step 1

1. Confirm that the WSUS service is running. If a manual synchronization has started but stays at 0%, it's because that the WSUS service (**Update Services** on WSUS 3.x; **WSUSService** on Windows Server 2012 and later versions) is in a stopped state.

2. Reset the WSUS console MMC cache by following these steps:

   1. Close the WSUS console.
   2. Stop the WSUS service (**Update Services** on WSUS 3.x; **WSUS Service** on Windows Server 2012 and later versions).
   3. Browse to `%appdata%\Microsoft\mmc`.
   4. Rename **wsus** to **wsus_bak**.
   5. Start the WSUS service.
   6. Open the WSUS console and try another manual synchronization.

#### Troubleshoot a scheduled sync in step 1

1. Try a manual synchronization from the WSUS console.
2. If a manual synchronization works fine, check the scheduled synchronization settings.  

### Step 2: WSUS spawns a connection to Microsoft Update (MU)

After a synchronization starts, the WSUS server attempts to make an HTTP connection through WinHTTP. Consider the following factors when troubleshooting the connection:

WSUS <=winhttp=> Network entities <=> Internet

- Does a network entity (proxy, firewall, security filter, and so on) exist between the WSUS host machine and the Internet?
- If a proxy exists and the WSUS server is required to use the proxy, is the proxy configured within the proper WSUS settings?

#### Troubleshoot a manual sync in step 2

1. Confirm that the WSUS service is running. If a manual synchronization has started but it stays at 0%, it's because the WSUS service (**Update Services** on WSUS 3.x; **WSUS Service** on Windows Server 2012 and later versions) is in a stopped state.

2. Reset the WSUS console MMC cache by completing the following steps:

   1. Close the WSUS console.
   2. Stop the WSUS service (**Update Services** on WSUS 3.x; **WSUS Service** on Windows Server 2012 and later versions).
   3. Browse to `%appdata%\Microsoft\mmc`.
   4. Rename **wsus** to **wsus_bak**.
   5. Start the WSUS service.
   6. Open the WSUS console and try another manual synchronization.

#### Troubleshoot a scheduled sync in step 2

1. Try a manual synchronization from the WSUS console.
2. If a manual synchronization works fine, check the scheduled synchronization settings.

### Step 3: The WSUS computer receives product and classification information from Microsoft Update and any subscribed metadata

After WSUS receives product and classification information and any subscribed metadata from Microsoft Update, the WSUS synchronization is complete.

## Installation, supersedence, or detection issues with specific updates

Deployment issues that occur with specific updates can be broken into the areas below. When you begin troubleshooting, consider the following components associated with these areas.

|Areas|Installation|Supersedence|Detection|
|---|---|---|---|
|Components|<ul><li>WUA</li><li>Update Installer (Component-Based Servicing (CBS), MSI)</li><li>CCMExec</li></ul>|Update metadata|<ul><li>WUA</li><li>Update metadata</li><li>Update Installer (CBS, MSI)</li></ul>|
  
### Installation issues

What is the installer (CBS, MSI, other)?

#### CBS

For updates that apply to Windows Vista and later versions, CBS is used to handle the installation.

1. Gather the CBS log (`%Windir%\Logs\Cbs\Cbs.log`) and perform an initial review to gain insight into the cause of the failure. Troubleshooting installation-based issues through CBS logs is beyond the scope of this guide. For more information, see [Fix Windows corruption errors by using the DISM or System Update Readiness tool](https://support.microsoft.com/help/947821).
1. Does the update install successfully as a logged on user? If so, does it fail only when it's installed under the System context? In this case, focus on troubleshooting the manual installation failure under the System context.

#### MSI (Windows Installer)

For non-Windows software updates, MSI is used to handle the installation.

1. Gather and review the default MSI logs for the update. Check the associated KB article for the update for any known issues or FAQ.
2. [Enable Windows Installer logging](https://support.microsoft.com/help/223300) and reproduce the failure.

    When reviewing the resulting logs, check for return value 3 within the log and the lines preceding that entry for insight into the failure.

3. Check whether the same update fails to install manually under the local system context. To do so, use the same installation switches that failed during the software update deployment.

    If it fails, test the installation as the logged on user with the same installation switches. Check if it's an issue with installing under local system. If it works, you can then focus the issue on how to properly install the update using the local system context. It may require checking for administrative deployment guidance within the KB for the update or online.

### Supersedence issues

Attempt to isolate the issue that relates to supersedence by using the following questions:

1. For questions about how to control when Configuration Manager expires an update, see [Supersedence rules](/mem/configmgr/sum/get-started/install-a-software-update-point#supersedence-rules).
2. If an update has been expired by Configuration Manager, Microsoft recommends that the latest superseding update be deployed. If you still need to deploy the expired updates, they can be deployed outside a software update deployment through software distribution or application management.
3. For questions related specifically to the supersedence logic of an update, first review the KB article for the update for further information. You can also review supersedence within the Microsoft Update Catalog, WSUS console, or the Configuration Manager console.  

### Detection issues

#### Determine compliance state per update on a client

1. Review the update KB article for known issues with the update.
2. Run the **Software Updates Scan Cycle** action on the Configuration Manager client.
3. Review UpdatesStore.log and WindowsUpdate.log.

#### Troubleshoot update applicability

1. Check if any prerequisites are missing using the KB article for the update. For example, does the update require the application or OS being patched to a specific service pack level?
2. Confirm that the Unique Update ID of the update in question matches what is deployed. For example, is the update in question a 32-bit update but is targeted to a 64-bit host?

## More information

For more information about how to configure software updates in Configuration Manager, see the following articles:

- [Plan for software updates in Configuration Manager](/mem/configmgr/sum/plan-design/plan-for-software-updates)
- [How to Configure a Software Update Point to Use Network Load Balancing (NLB) Cluster](/previous-versions/system-center/system-center-2012-R2/hh237369(v=technet.10))
- [How to Enable CRL Checking for Software Updates](/previous-versions/system-center/system-center-2012-R2/hh508767(v=technet.10))

You can also post a question in our Configuration Manager support forum for security, updates, and compliance [here](https://social.technet.microsoft.com/Forums/en-US/home?forum=ConfigMgrCompliance).

Visit [our blog](https://techcommunity.microsoft.com/t5/Configuration-Manager-Blog/bg-p/ConfigurationManagerBlog) for all the latest news, information, and tech tips on Configuration Manager.
