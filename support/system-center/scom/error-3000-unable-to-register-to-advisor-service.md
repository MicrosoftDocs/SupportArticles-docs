---
title: Unable to register to Advisor Service
description: Fixes an issue that prevents you from registering to the Advisor Service in System Center 2012 R2 Operations Manager.
ms.date: 04/15/2024
---
# Error 3000: Unable to register to Advisor Service in System Center 2012 R2 Operations Manager

This article helps you resolve error 3000 that prevents you from registering to the Advisor Service in System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 3094195

## Symptoms

When you try to configure System Center Operations Manager for Microsoft Operations Management Suite (formerly known as Operations Insight), you receive the following error message in the Operations Manager console:

> Error 3000: Unable to register to Advisor Service. Please contact the system administrator.

## Cause

This issue occurs for one of the following reasons:

- The management server's clock is out of sync with the current time by more than five minutes.
- Your internal proxy server or firewall is blocking communication with the Advisor Service endpoints.

## Resolution - If the clock is out of sync

To resolve this issue, change the clock time on your server to match the current time. To do this, open a command prompt as an administrator, run `w32tm /tz` to check the time zone, and then run `w32tm /resync` to synchronize the time.

## Resolution - If the proxy or the firewall is involved

Depending on the proxy configuration, you may be unable to register to the Advisor Service. Or, some communications from System Center Operations Manager to Advisor Service behind Operations Management Suite will later fail, and certain scenarios may not light up in the portal even when you do manage to register. In this section, we describe the kinds of communications and endpoints that you must permit for your management servers, the console, and direct agents so that Operations Management Suite will work correctly.

### Step 1: Request exception for the service endpoints

The following domains and URLs must be accessible through the firewall or proxy for the management server to access the Azure Operational Insights Web Services.

#### Management server

|URL|Ports|
|---|---|
|service.systemcenteradvisor.com|Port 443|
|scadvisor.accesscontrol.windows.net|Port 443|
|scadvisorservice.accesscontrol.windows.net|Port 443|
|\*.blob.core.windows.net\/\*|Port 443|
|data.systemcenteradvisor.com|Port 443|
|\*.ods.opinsights.azure.com|Port 443|
|\*.systemcenteradvisor.com|Port 443|
  
#### Large volume scenarios, intelligence packs, and Operations Manager agents

> [!NOTE]
> Some forthcoming intelligence packs, such as Security and Audit, report data directly (without queuing through the management server) to the cloud. This is true even if they report to Operations Manager and are configured by the Operations Manager management group. The following is the required destination for this kind of communication:

|URL|Ports|
|---|---|
|\*.ods.opinsights.azure.com|Port 443|
  
> [!NOTE]
> The proxy setting that's specified in step 2 in this section will be automatically propagated to Operations Manager agents.

#### Operations Manager console

The following domains and URLs must be accessible through the firewall in order to view the Advisor web portal and Operations Manager console (to perform registration to Azure Operational Insights).

|Resource|Ports|
|---|---|
|\*.systemcenteradvisor.com|Ports 80 and 443|
|\*.live.com|Ports 80 and 443|
|\*.microsoft.com|Ports 80 and 443|
|\*.microsoftonline.com|Ports 80 and 443|
|login.windows.net|Ports 80 and 443|
  
Also, make sure that the Internet Explorer proxy is set correctly on the computer that you try to sign in with. It's particularly valuable to test whether you can connect to an SSL-enabled website, such as [https://www.bing.com](https://www.bing.com/). If the HTTPS connection doesn't work from a browser, it probably won't work in the Operations Manager console and in the server modules that talk to the web services in the cloud.

### Step 2: Configure the proxy server in the Operations Manager console

1. Open the Operations Manager console.
2. In **Administration** view, select **Advisor Connection** under the **System Center Advisor** node.
3. Select **Configure Proxy Server**.
4. Select the check box to use a proxy server to access the Advisor Web Service. Specify the proxy address in the `http://proxyserver:port` format.

### Step 3: Specify credentials for Operations Manager if the proxy server requires authentication

If the proxy server requires authentication, follow these steps:

1. In the Operations Manager console, open **Administration** view.
2. Select **Profiles** under the **RunAs Configuration** node.
3. Double-click **System Center Advisor Run As Profile Proxy**.
4. Select **Add** to add a RunAs account. You can either create an account or use an existing one. This account must have sufficient permissions to pass through the proxy.
5. Set the account to be targeted at the **Operations Manager Management Servers** group.
6. Complete the steps in the wizard, and then save the changes.

#### Configure the proxy server on each Operations Manager management server for managed code

There's another setting in Operations Manager, and this is intended for general error reporting. However, because the same modules are used in multiple workflows, this proxy setting also ends up affecting Advisor Connector functionality when it's set. Therefore, assuming that you use a proxy, we recommend that you also set it to the same proxy server that you set in the other locations for each management server:

1. In the Operations Manager console, open **Administration** view.
2. Select **Device Management**, and then select the **Management Servers** node.
3. Right-click the management server, select **Properties**, and then set the proxy on the **Proxy Settings** tab. Do this for each management server.

## More information

You can troubleshoot time sync issues by enabling verbose tracing on the management server or Operations Manager console computer. For more information, see [How to use diagnostic tracing in System Center Operations Manager 2007 and in System Center Essentials](https://support.microsoft.com/help/942864). In a command prompt window, run the following command:

```console
StartTracing.cmd VER
```

Reproduce the issue, and then run the following commands:

```console
StopTracing.cmd
FormatTracing.cmd
```

After you're able to collect formatted traces, open the trace log file that's named TracingGuidsAdvisor.log, and then look for errors that resemble the following:

> [Microsoft.SystemCenter.Advisor.Common] [] [Error] :WebServiceCallHelper.CallWebService\<T>{webservicecallhelper_cs66}Message security was invalid for the connection with web service when performing Register Gateway [Exception] System.ServiceModel.Security.MessageSecurityException: The security timestamp is stale because its expiration time ('2015-08-28T17:56:34.018Z') is in the past. Current time is '2015-08-28T18:03:27.962Z' and allowed clock skew is '00:05:00'.
