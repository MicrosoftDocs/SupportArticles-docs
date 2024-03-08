---
title: Troubleshoot OMS onboarding issues
description: Describes how to troubleshoot onboarding issues in integrated Operations Manager attach mode clients and Direct Agent access in Operations Management Suite (OMS).
ms.date: 03/08/2024
---
# Troubleshoot Operations Management Suite onboarding issues

This article contains a series of steps, procedures, and troubleshooting tips for both integrated Operations Manager attach mode clients and Direct Agent access in Microsoft Operations Management Suite (OMS).

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 3126513

## Operations Manager registration error

There are two error messages that you might encounter when you register an Operations Manager (OpsMgr) management group.

### Error 2200

When you try to connect an Operations Manager management group to OMS, you receive the following error message:

> Error 2200: Unable to register to the Advisor Service. Please contact the system administrator.

This issue may be caused by one of the following conditions:

- The OMS workspace was not created before trying to integrate with Operations Manager. To fix this issue, go to the Microsoft.com\OMS site and create a workspace first. Then, try onboarding through the same account.
- After you installed the latest required update rollups, the necessary management packs were not imported into your OpsMgr management group. To fix this issue, open the Operations Management console, go to **Administration** view, and then select the option to import management packs. Next, go to `%SystemDrive%\Program Files\System Center 2012 SP1\Operations Manager\Server\Management Packs for Update Rollups`, and then import the management packs in this folder. As soon as the operation is complete, restart the console, and then try onboarding again.

### Error 3000

When you try to connect an OpsMgr management group to OMS, you receive the following error message:

> Error 3000: Unable to register to the Advisor Service. Please contact the system administrator.

This issue may be caused by one of the following conditions:

- The server clock may be out of sync with the current time by more than 5 minutes. You can fix this issue by changing the clock time on the server to match the current time. To do this, open a command prompt as an administrator, run `w32tm /tz` to check the time zone, and then run `w32tm /resync` to sync the time.

  > [!NOTE]
  > Even when your clock says it's synchronized (that is, synchronized with your company's time server), it might still be out of sync with the one of the virtual machines in Azure. Because the allowable time skew is only 5 minutes, this is frequently an issue. Verify that you are synchronizing with a reliable time server on the Internet. You can further troubleshoot this type of issue by enabling verbose tracing on the management server or the computer running the consoler. For more information about tracing in Operations Manager, see [How to use diagnostic tracing in System Center Operations Manager 2007 and in System Center Essentials](https://support.microsoft.com/help/942864).

  Essentially, you will need to run the following command:

  ```console
  StartTracing.cmd VER
  - reproduce the issue –
  StopTracing.cmd
  FormatTracing.cmd
  ```

  In the output trace files, you should find an exception indicating that the token was rejected because it was not yet valid or expired.

- An internal proxy server or firewall may be blocking communication to the Advisor service endpoints. The following section includes detailed information about how to troubleshoot these problems.

## Proxy registration or configuration steps

When an internal proxy server or firewall is blocking communication to the Advisor service endpoints, registration may fail. Or, after registration completes, OpsMgr communication fails. This section describes the type of communications and endpoints that must be allowed on your management servers, console, and direct agents for communication for Operational Insights to work.

### Step 1: Configure the proxy and firewall in local environment

See [Network](/azure/azure-monitor/platform/om-agents#network) to check the current proxy and firewall configuration requirements.

If you are using a Log Analytics workspace that has been upgraded to the new search query language, you may also have the problem described below:

**Question: After upgrade, I get an error trying to run queries and am also seeing errors in my views.**

Your browser requires access to the following addresses to run Log Analytics queries after upgrade. If your browser is accessing the Azure portal through a firewall, you must enable access to these addresses.

|URL|IP|Ports|
|---|---|---|
|portal.loganalytics.io|Dynamic|80,443|
|api.loganalytics.io|Dynamic|80,443|
|docs.loganalytics.io|Dynamic|80,443|
  
### Step 2: Configure the proxy server in the OpsMgr console

1. Open the OpsMgr console.
2. Go to the **Administration** view.
3. Under the **System Center Advisor** node, select **Advisor Connection**.
4. Select **Configure Proxy Server**.

   :::image type="content" source="media/troubleshoot-oms-onboarding-issues/configure-proxy-server.png" alt-text="Screenshot of the Configure Proxy Server option in OpsMgr console." border="false":::

5. Select the check box to use a proxy server to access the Advisor Web Service.
6. Specify the proxy address in the `<http://proxyserver:port>` format:

   :::image type="content" source="media/troubleshoot-oms-onboarding-issues/proxy-address.png" alt-text="Setting up the proxy address in the Advisor Settings Wizard." border="false":::

### Step 3: Specify credentials for OpsMgr if the proxy server requires authentication

If the proxy server requires authentication, you can specify one for an OpsMgr **RunAs** account and associate it with **System Center Advisor Run As Profile Proxy**:

1. In the OpsMgr Console, go to **Administration** view.
2. Under the **RunAs Configuration** node, select **Profiles**.
3. Double-click to open **System Center Advisor Run As Profile Proxy**:

   :::image type="content" source="media/troubleshoot-oms-onboarding-issues/open-proxy.png" alt-text="Open the System Center Advisor Run As Profile Proxy in Profiles under RunAs Configuration.":::

4. Select **Add** to add a **RunAs Account**. You can either create one or use an existing account. This account must have sufficient permissions to pass through the proxy.
5. Set the account to be targeted at the **Operations Manager Management Servers** group.
6. Complete the wizard and save the changes:

   :::image type="content" source="media/troubleshoot-oms-onboarding-issues/wizard.png" alt-text="Set the RunAs account to the Operations Manager Management Servers group." border="false":::

### Step 4: Configure the proxy server on each OpsMgr management server for managed code

There is an additional setting in Operations Manager that's intended for general error reporting. However, when that setting is enabled, the proxy setting may also end up affecting Advisor connector's functionality. This occurs because the same modules may be used in multiple workflows. Therefore. Microsoft recommends that you set the proxy server to the same proxy for each and every management server. To do this, follow these steps:

1. In the OpsMgr console, go to **Administration** view.
2. Select **Device Management**, and then select the **Management Servers** node.
3. Right-click, select **Properties** for each management server (one at the time), and then set the proxy on the **Proxy Settings** tab:

   :::image type="content" source="media/troubleshoot-oms-onboarding-issues/proxy-settings.png" alt-text="Set the proxy on the Proxy Settings tab.":::

## Verify the deployment after registration

### Step 1: Verify that the right management packs are downloaded to your Operations Manager environment

Depending on which Solutions (formerly known as Intelligence Packs) that you have enabled in the Operational Insights portal, you will see some or all of the management packs in the following screenshot. Search for keyword **Advisor** or **Solution** in their names, and make sure that the solutions that you've enabled have corresponding management packs installed.

:::image type="content" source="media/troubleshoot-oms-onboarding-issues/advisor.png" alt-text="Screenshot of the management packs that you installed." border="false":::

You can also check for these management packs through PowerShell by using the following commands:

```powershell
get-scommanagementpack | where {$_.DisplayName -match 'Advisor'} | select Name,DisplayName,Version,KeyToken
```

```powershell
get-scommanagementpack | where {$_.DisplayName -match 'Advisor'} | select Name,DisplayName,Version,KeyToken | Out-GridView
```

> [!NOTE]
> If you are troubleshooting the Capacity Solution, check how many management packs you have that have a name that contains **capacity**. There are two management packs that have the same display name but different internal IDs that come in the same management pack bundle. If one of the two does not get imported (often because of missing VMM dependencies), the other management pack may not be imported either.

You should see the following management packs related to capacity:

- Microsoft System Center Advisor Capacity Intelligence Pack
- Microsoft System Center Advisor Capacity Intelligence Pack
- Microsoft System Center Advisor Capacity Storage Data

If you only see one or two of these, remove them and wait 5 to 10 minutes for Operations Manager to download and import them again. If this fails, check the event logs for errors during this period.

### Step 2: Validate that the right solutions are downloaded to your Direct Agent

With Direct Agents, you should see the Solution collection policy being cached under the `C:\Program Files\Microsoft Monitoring Agent\Agent\Health Service State\Management Packs` path:

:::image type="content" source="media/troubleshoot-oms-onboarding-issues/solution-collection-policy.png" alt-text="Screenshot of the solution collection policies that are cached.":::

### Step 3: Validate that data is being sent up to the Advisor service (or at least that a send is tried)

1. Open Performance Monitor.
2. Select **Health Service Management Groups**.
3. Add all the counters that start with **HTTP**:

   :::image type="content" source="media/troubleshoot-oms-onboarding-issues/adding-counters.png" alt-text="Adding all the counters that start with H T T P.":::

4. If the configuration is correct, you should see activity for these counters as events, and other data is uploaded (based on the solutions loaded in the portal and the configured log collection policy). These counters do not necessarily have to be continuously busy. However, if you see little or no activity, it might be that you have not added many solutions, or that you have a lightweight collection policy.

   :::image type="content" source="media/troubleshoot-oms-onboarding-issues/activity.png" alt-text="Screenshot of activity for counters as events." border="false":::

### Step 4: Check for errors in the management server or Direct Agent event logs

As a final step, if all of the preceding steps fail, check whether you have any errors in the **Event Viewer** > **Application and Services** > **Operations Manager** event log. Filter by **Event Sources: Advisor, Health Service Modules, HealthService, and Service Connector** (this last one applies to Direct Agent only). You can copy these events and post them [in the Feedback forum](https://aka.ms/opinsightsfeedback) so that we on the product team can offer you additional help. Most of these events are also found on Direct Agent, and the steps for troubleshooting are similar. The only part that differs between an integrated OpsMgr environment and one using Direct Agents is the registration process:

- When connected to Operations Manager, you have a wizard with browser integration that lets you pick your workspace as a user or admin. Then, OpsMgr takes care of exchanging certificates and uses those for management pack download and data transfer to Operational Insights.
- When you're using Direct Agents, you just copy and paste the workspace ID and key, and those are used to verify that it's really you who are registering those agents and that you own that workspace. After you're authenticated, certificates are exchanged under the hood by the service in a manner similar to when OpsMgr is integrated.

Most of these events apply to both types of reporting infrastructure. Open **Event Viewer** > **Application and Services** > **Operations Manager** and filter by **Event Sources: Advisor, Health Service Modules, HealthService, and Service Connector** (this last one applies to Direct Agent only).

:::image type="content" source="media/troubleshoot-oms-onboarding-issues/event-sources.png" alt-text="Use the Event Sources filter to check errors." border="false":::

A few of the events that you might see when things aren't working correctly are included in the following table:

| EventID| Source| Meaning| Resolution |
|---|---|---|---|
|2138|Health Service Modules|Proxy requires authentication|Follow step 3 and step 1 above.|
|2137|Health Service Modules|Cannot read the authentication certificate|Rerunning the Advisor registration wizard will fix certificates and RunAs accounts.|
|2132|Health Service Modules|Not Authorized|Could be an issue with the certificate or registration to the service. Try rerunning the Advisor registration wizard as that will fix certificates and RunAs accounts. Additionally, verify that the proxy has been set to allow exclusions per step 1 above, and verify authentication per step 3. Also verify that the user has access through the proxy.|
|2129|Health Service Modules|Failed connection or failed SSL negotiation|There could be some incorrect TCP settings on the server. Check [this post](https://www.linkedin.com/in/jacobbenson?p=511) from the community for more information.|
|2127|Health Service Modules|Failure sending data received error code|If it only happens once in a while this could just be a random anomaly that can be ignored. Monitor to understand how often it happens. If it happens often (every 10 minutes or so throughout the day), it's a problem. Check your network configuration and proxy settings, and then rerun the registration wizard. If it only happens sporadically (such as a couple of times per day), everything should be fine, as data will be queued and retransmitted.<br/><br/>Some of the HTTP error codes have some special meanings. For example, the first time that a MMA Direct Agent or management server tries to send data to our service, it will get a 500 error with an inner 404 error code. 404 means not found, which indicates that the storage area we'll use for this new workspace of yours isn't ready yet (it's still being provisioned). On next retry, this will be ready and flow will start working as expected.<br/><br/>A 403 error might indicate a permission or credentials issue. There is more information on the 403 error below in the [Direct Agent specific information](#direct-agent-specific-information) section.|
|2128|Health Service Modules|DNS name resolution failed|Your server can't resolve our Internet address that is used when sending data. This might be DNS resolver settings on your computer, incorrect proxy settings, or maybe a temporary issue with DNS at your provider. Like the previous event, depending on whether it happens constantly or only once in a while, it could be an issue or not.|
|2130|Health Service Modules|Time out|Like the previous event, depending on whether it happens constantly or only once in a while, it could be an issue or not.|
|4511|HealthService|Cannot load module `System.PublishDataToEndPoint` - file not found|Initialization of a module of type `System.PublishDataToEndPoint` (CLSID _{D407D659-65E4-4476-BF40-924E56841465}_) failed with error **The system cannot find the file specified**.<br/><br/>This error indicates you have old DLLs on your machine that don't contain the required modules. The fix is to update your management servers to the latest Update Rollup package.|
|4502|HealthService|Module crashed|If you see this for workflows with names such as `CollectInstanceSpace` or `CollectTypeSpace`, it might mean the server is having issues sending data. Depending on how often it happens, it may be an issue or not. If it happens more than every hour it is definitely an issue, however if it only fails once or twice per day it will be fine and should be able to recover. Depending on how the module actually fails (the description will have more details) this could be an on-premises issue (such as to collect to DB) or an issue sending to the cloud. Verify your network and proxy settings and if it still fails, try restarting the Health Service.|
|4501|HealthService|Module `System.PublishDataToEndPoint` crashed|A module of type `System.PublishDataToEndPoint` reported an error 87L that was running as part of rule `Microsoft.SystemCenter.CollectAlertChangeDataToCloud` running for instance **Operations Manager Management Group** with ID:_{6B1D1BE8-EBB4-B425-08DC-2385C5930B04}_ in management group **SCOMTEST**.<br/><br/>You should not see this with this exact workflow, module, and error anymore. It used to be a bug but it is now fixed. It was being tracked [here](https://feedback.azure.com/forums/267889-azure-operational-insights/suggestions/6714689-alert-management-intelligence-pack-not-sending-ale).|
|4002|Service Connector|The service returned HTTP status code 403 in response to a query. Check with the service administrator for the health of the service. The query will be retried later.|You can get a 403 error during the agent's initial registration phase and you'll see a URL similar to the following:<br/><br/>https://\<YourWorkspaceID>.oms.opinsights.azure.com/ AgentService.svc/AgentTopologyRequest<br/><br/>Error code 403 means **forbidden**. This is typically a mistyped Workspace ID or key, or the clock is not synced (just like for [error 3000](#error-3000)). See more [here](https://social.msdn.microsoft.com/forums/azure/732bf3b2-f709-4067-830c-4bae214e3438/the-service-returned-http-status-code-403-in-response-to-a-query?forum=opinsights).|
  
### Step 5: Look for your agents to send their data and have it indexed in the portal

Check in the Operational Insights portal to see whether your computers are reporting. From the **Overview** page, navigate to the large blue **SETTINGS** tile. It will be either the first or last tile depending on your configuration. In **SETTINGS**, select the **CONNECTED SOURCES** tab. Each column on this page represents a different data source type attached to OI (servers attached directly, Operations Manager management groups, and Azure storage accounts). Select the blue **X servers/mgmt groups/storage accounts connected** and it will bring you to a search with more detail. On this page, you'll also see a list of individual management groups connected. Selecting one of these management groups will also bring you to search and show you a list of the servers connected to this management group.

> [!NOTE]
> If a data source is listed as reporting on this page it does not necessarily mean we have collected any data from the source. In this case it's possible that drilling into search from this page will show inconsistent results (for example, you will see a data source listed in **CONNNECTED SOURCES** but it won't be in search). Once data collection has started, either from an IP address or from log collection, the results in search will be consistent.

:::image type="content" source="media/troubleshoot-oms-onboarding-issues/connected-sources.png" alt-text="Screenshot of data sources that are listed in the connected sources.":::

The Advisor engineering team is committed to resolving all your onboarding issues so contact us if you run into any issues. We are here to help.

## Other Operations Manager known issues and workarounds

### The search button in the **Add a Computer/Group** dialog box is missing

Some customers have reported that the **Search** button in the **Computer Search** dialog box is missing. We are currently investigating this. As a temporary workaround, select the **Filter by (optional)** edit box, and then press the Tab key to get to the invisible search button. Then, you can activate the button by pressing the \<Spacebar> or \<Enter> key.

:::image type="content" source="media/troubleshoot-oms-onboarding-issues/search-button-missing.png" alt-text="The Search button is missing from the Computer Search dialog box.":::

### IIS log collection issues

The following article contains specific information about how to best configure IIS logging for use with Operational Insights, as well as some other known issues:

[IIS Log Format Requirements in Azure Operational Insights](https://techcommunity.microsoft.com/t5/system-center-blog/iis-log-format-requirements-in-azure-operational-insights/ba-p/349804)

Some of the information in this article also applies to Direct Agent, but it primarily targets Operations Manager. It also includes additional information about IIS with Direct Agent.

### Connectivity issues may occur when the Baltimore CyberTrust Root certificate is not installed

Connectivity issues may occur on client computers when the following conditions are true:

- The client computers use Microsoft Intune and have the automatic root certificate mechanism disabled.
- The Baltimore CyberTrust Root certificate is not installed.

To resolve this problem when the automatic root certificate update mechanism is disabled on a client computer, install the latest root certificates to make sure that the client computer is up to date and secure. You can use the Microsoft Update Catalog to find the latest root certificate updates. You can search for **root update** and then download the latest root update package. Root update packages are cumulative. Therefore, you have to install only the latest package to receive all root certificates in the program.

For more information about this issue, see [Connectivity issues may occur when the Baltimore CyberTrust root certificate is not installed](../../mem/intune/fix-connectivity-issues.md).

### How to restrict the use of certain cryptographic algorithms and protocols in schannel.dll

There may be situations that require you to restrict the use of certain cryptographic algorithms and protocols in the schannel.dll file. For more information about how to do this, see [How to restrict the use of certain cryptographic algorithms and protocols in Schannel.dll](https://support.microsoft.com/help/245030).

### SQL Server and Active Directory (AD) assessment

SQL Server and AD assessment require .NET Framework 4 to run on each agent to be assessed. Analysis runs on the SQL Server machines and on the domain controllers (for AD). SQL Server assessment supports the Standard, Developer, and Enterprise editions of SQL Server (all currently supported versions).

### Malware assessment

Windows 7 and Windows Server 2008 R2 have the issues described and tracked [here](https://feedback.azure.com/forums/267889-azure-operational-insights/suggestions/6519211-windows-server-2008-r2-sp1-servers-are-shown-as-n).

You can see what anti-malware products are enabled by following [this thread](https://feedback.azure.com/forums/347535-azure-security-center/suggestions/6519202-support-other-antivirus-products-in-malware-assess).

### Direct agent specific information

Most of the errors in the table above under [Step 4](#step-4-check-for-errors-in-the-management-server-or-direct-agent-event-logs) about management servers also apply to Direct Agent. In Direct Agent, each agent is responsible for talking to Operational Insights on its own, as opposed to when integrated with Operations Manager where it is the management server that sends data on behalf of the agents reporting to it, thus acting as a gateway.

With Direct Agent, the most common issue is error code 403 that means **forbidden**. This is typically a mistyped workspaceId or key.

Other things that we are currently tracking for Direct Agent include the following:

- The Capacity Management Intelligence Pack doesn't work with Direct Agent. It only works with Operations Manager and also needs Operations Manager to be integrated with Virtual Machine Manager. For more information, see [Integrate VMM with Operations Manager for monitoring and reporting](/system-center/vmm/monitors-ops-manager).

- The Alert Management Intelligence Pack does not work with Direct Agent. It requires Operations Manager to synchronize alerts to the cloud.

- Malware Assessment works with the exception of the issue noted above for Windows Server 2008 R2.

Update Assessment, Change Tracking as well as the Log Management Solutions for collecting Windows events and IIS logs works for both Operations Manager and Direct Agent already.

If you need further information on how to install the agent, including scripted and unattended methods, check [Connect Windows computers to Azure Monitor](/azure/azure-monitor/platform/agent-windows).

If need, Direct Agent supports passing through proxy and there is a PowerShell script in the documentation above that can be used to configure which proxy server and credentials to use on the agent. It's an application-specific setting so no process other than MMA's needs to be able to know how to reach the Internet.

If your virtual machine is in Azure, you can one-click install and enable the agent from the Azure portal:

[Easily enable Operational Insights for Azure virtual machines](https://azure.microsoft.com/updates/easily-enable-operational-insights-for-azure-virtual-machines/)

Also, be aware that there is currently only a 64-bit version of the agent. Feedback for a potential 32-bit agent is being tracked [here](https://feedback.azure.com/forums/267889-azure-operational-insights/suggestions/6744349-support-for-windows-2003-and-2008-servers-32-bit).

### Windows Azure diagnostics information

Log management through Azure portal integration allows you to also collect Windows events from Windows Azure Diagnostics (WAD) Storage. This works for Cloud Services roles and IaaS VMs configured to write to WAD.

- Collecting IIS logs from WAD works for cloud services and for IaaS VMs but not currently for Azure web sites. This is tracked [here](https://feedback.azure.com/forums/267889-azure-monitor-log-analytics/suggestions/16357393-collect-azure-web-apps-iis-logs-and-application-lo).

- Check out and vote the other ideas about what to collect for this category in our [forum](https://feedback.azure.com/forums/267889-azure-operational-insights/category/88086-log-management-and-log-collection-policy).

- Here is [a good paper](https://download.microsoft.com/download/b/6/c/b6c0a98b-d34a-417c-826e-3ea28cdfc9dd/azuresecurityandauditlogmanagement_11132014.pdf) on how to configure your Microsoft Azure roles and VMs to write to Windows Azure Diagnostics storage.
