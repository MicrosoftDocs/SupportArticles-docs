--- 
title: Troubleshoot Azure Application Insights Snapshot Debugger
description: This article presents troubleshooting steps and information to help developers enable and use Application Insights Snapshot Debugger.
ms.date: 6/22/2022
author: kelleyguiney22
ms.author: v-kegui
editor: v-jsitser
ms.reviewer: aaronmax
ms.service: azure-monitor
ms.subservice: application-insights
#Customer intent: As an Azure Application Insights user, I want to know how to troubleshoot the Azure Application Insights Snapshot Debugger so I can use it effectively.  
---

# Troubleshoot problems enabling Azure Application Insights Snapshot Debugger or viewing snapshots

This article provides troubleshooting information to resolve issues if you've enabled Application Insights Snapshot Debugger for your application but aren't seeing snapshots for exceptions.

There can be various reasons why snapshots aren't generated. You can start by running the [snapshot health check](#use-the-snapshot-health-check) to identify some of the possible common causes.

## Scenarios that aren't supported

Snapshot Collector isn't supported in the following scenarios:

|Scenario    | Side effects | Recommendation |
|------------|--------------|----------------|
|You're using the Snapshot Collector SDK in your application directly (.csproj) and you've enabled the `Interop` advanced option.| The local Application Insights SDK (including Snapshot Collector telemetry) will be lost, so no Snapshots will be available.<br /><br />Your application could crash at startup, resulting in this error message: `System.ArgumentException: telemetryProcessorType does not implement ITelemetryProcessor.`<br /><br />For more information about the `Interop` feature, see [Application Monitoring for Azure App Service and ASP.NET Core](/azure/azure-monitor/app/azure-web-apps-net-core?tabs=Windows%2Cwindows#troubleshooting). | If you're using the `Interop` advanced option, use the codeless Snapshot Collector injection (enabled through the [Azure portal](https://portal.azure.com)). |

## Make sure you're using the appropriate Snapshot Debugger endpoint

Currently the only regions that require endpoint modifications are [Azure Government](/azure/azure-government/compare-azure-government-global-azure#application-insights) and [Azure China](/azure/china/resources-developer-guide).

For App Service and applications using the Application Insights SDK, you have to update the connection string using the supported overrides for Snapshot Debugger as defined below:

|Connection string property    | US government cloud | China cloud |   
|---------------|---------------------|-------------|
|`SnapshotEndpoint`         | `https://snapshot.monitor.azure.us`    | `https://snapshot.monitor.azure.cn` |

For more information about other connection overrides, see the [Application Insights documentation](/azure/azure-monitor/app/sdk-connection-string?tabs=net#connection-string-with-explicit-endpoint-overrides).

For Function App, you have to update the `host.json` using the supported overrides below:

|Property    | US Government cloud | China cloud |   
|---------------|---------------------|-------------|
|`AgentEndpoint`         | `https://snapshot.monitor.azure.us`    | `https://snapshot.monitor.azure.cn` |

The following example shows the `host.json` updated with the US Government Cloud agent endpoint:

```json
{
  "version": "2.0",
  "logging": {
    "applicationInsights": {
      "samplingExcludedTypes": "Request",
      "samplingSettings": {
        "isEnabled": true
      },
      "snapshotConfiguration": {
        "isEnabled": true,
        "agentEndpoint": "https://snapshot.monitor.azure.us"
      }
    }
  }
}
```

## Use the snapshot health check

Several common problems can result in the Open Debug Snapshot not showing up. For example, using an outdated Snapshot Collector, reaching the daily upload limit, or the snapshot might just take a long time to upload. Use the Snapshot Health Check to troubleshoot common problems.

There's a link in the exception pane of the end-to-end trace view that takes you to the Snapshot Health Check.

:::image type="content" source="./media/snapshot-debugger-troubleshooting/enter-snapshot-health-check.png" alt-text="Screenshot of the exception pane of the end-to-end trace view that shows the link to the Snapshot Health Check near the bottom of the screenshot.":::

The interactive, chat-like interface looks for common problems and guides you to fix them.

:::image type="content" source="./media/snapshot-debugger-troubleshooting/healthcheck.png" alt-text="Screenshot of the interactive, chat-like interface for the Snapshot Health Check.":::

If the Snapshot Health Check doesn't solve the problem, refer to the following manual troubleshooting steps.

## Verify the instrumentation key

Make sure you're using the correct instrumentation key in your published application. Usually, the instrumentation key is read from the *ApplicationInsights.config* file. Verify that the value is the same as the instrumentation key for the Application Insights resource that you see in the portal.

> [!NOTE] 
> This article was recently updated to use the term *Azure Monitor logs* instead of *Log Analytics*. Log data is still stored in a Log Analytics workspace, and it's still collected and analyzed by the same Log Analytics service. We're updating the terminology to better reflect the role of [logs in Azure Monitor](/azure/azure-monitor/logs/data-platform-logs). See [Azure Monitor terminology changes](/azure/azure-monitor/terminology) for details.

## Check TLS/SSL client settings (ASP.NET)

If you have an ASP.NET application that's hosted in Azure App Service or in IIS on a virtual machine, your application could fail to connect to the Snapshot Debugger service due to a missing SSL security protocol.

[The Snapshot Debugger endpoint requires TLS version 1.2](/azure/azure-monitor/app/snapshot-debugger-upgrade). The set of SSL security protocols is one of the quirks enabled by the **\<httpRuntime>** element's **targetFramework** attribute in the **\<system.web>** section of the *web.config* file.

If the value of the **\<httpRuntime>** element's **targetFramework** attribute is `4.5.2` or lower, then TLS 1.2 isn't included by default.

> [!NOTE]
> The **\<httpRuntime>** element's **targetFramework** attribute value is independent of the target framework used when building your application.

To check the setting, open your *web.config* file and find the **\<system.web>** section. Make sure that the **targetFramework** for **\<httpRuntime>** is set to `4.6` or above.

   ```xml
   <system.web>
      ...
      <httpRuntime targetFramework="4.7.2" />
      ...
   </system.web>
   ```

> [!NOTE]
> - Modifying the **\<httpRuntime>** element's **targetFramework** attribute value changes the runtime quirks applied to your application, and can cause other subtle behavior changes. Be sure to test your application thoroughly after making this change. For a full list of compatibility changes, see [Retargeting changes](/dotnet/framework/migration-guide/application-compatibility#retargeting-changes).
>
> - If the **targetFramework** value is `4.7` or above, then Windows determines the available protocols. In Azure App Service, TLS 1.2 is available. However, if you're using your own virtual machine, you might need to enable TLS 1.2 in the OS.

## Preview versions of .NET Core

If you're using a preview version of .NET Core, or your application references Application Insights SDK directly or indirectly via a dependent assembly, follow the instructions for [Enable Snapshot Debugger for other environments](/azure/azure-monitor/app/snapshot-debugger-vm).

## Check the Diagnostic Services site extension status page

If Snapshot Debugger was enabled through the [Application Insights pane](/azure/azure-monitor/app/snapshot-debugger-app-service) in the portal, it was enabled by the Diagnostic Services site extension.

> [!NOTE]
> Codeless installation of Application Insights Snapshot Debugger follows the .NET Core support policy.
> For more information about supported runtimes, see [.NET Core Support Policy](https://dotnet.microsoft.com/platform/support/policy/dotnet-core).

You can check the Status Page of this extension by going to the following URL:
`https://{site-name}.scm.azurewebsites.net/DiagnosticServices`.

> [!NOTE]
> The domain of the Status Page link will vary depending on the cloud.
This domain will be the same as the Kudu management site for App Service.

This Status Page shows the installation state of the Profiler and Snapshot Collector agents. If there was an unexpected error, the Status Page will display it and will provide information about how to resolve it.

You can use the Kudu management site for App Service to get the base URL of the Status Page by following these steps:

1. Open your App Service application in the Azure portal.
2. Select **Advanced Tools**, or search for **Kudu**.
3. Select **Go**.
4. Once you are on the Kudu management site, in the URL, append `/DiagnosticServices`, and then press Enter.
 The final URL will have the following format: `https://<kudu-url>/DiagnosticServices`.

It will display a Status Page similar to the following page:

:::image type="content" source="./media/snapshot-debugger-troubleshooting/status-page.png" alt-text="Screenshot of the Status Page for the Diagnostic Services site extension." lightbox="./media/snapshot-debugger-troubleshooting/status-page.png":::

## Upgrade to the latest version of the NuGet package

Based on how Snapshot Debugger was enabled, see the following options:

* If Snapshot Debugger was enabled through the [Application Insights pane in the portal](/azure/azure-monitor/app/snapshot-debugger-app-service), then your application should already be running the latest NuGet package.

* If Snapshot Debugger was enabled by including the [Microsoft.ApplicationInsights.SnapshotCollector](https://www.nuget.org/packages/Microsoft.ApplicationInsights.SnapshotCollector) NuGet package, use Visual Studio's NuGet Package Manager to make sure you're using the latest version of `Microsoft.ApplicationInsights.SnapshotCollector`.

For the latest updates and bug fixes, see the [release notes](/azure/azure-monitor/app/snapshot-collector-release-notes).

## Check the uploader logs

After a snapshot is created, a minidump file (.dmp) is created on disk. A separate uploader process creates that minidump file and uploads it, along with any associated PDBs, to Application Insights Snapshot Debugger storage. After the minidump is uploaded successfully, it's deleted from disk. The log files for the uploader process are kept on disk. In an App Service environment, you can find these logs in *d:\Home\LogFiles*. To find these log files, use the Kudu management site for App Service by following these steps:

1. Open your App Service application in the Azure portal.
2. Select **Advanced Tools**, or search for **Kudu**.
3. Select **Go**.
4. In the **Debug console** drop-down list box, select **CMD**.
5. Select **LogFiles**.

You should see at least one file with a name that begins with *Uploader_* or *SnapshotUploader_* and a *.log* extension. Select the appropriate icon to download any log files or open them in a browser.

The file name includes a unique suffix that identifies the App Service instance. If your App Service instance is hosted on more than one machine, there are separate log files for each machine. When the uploader detects a new minidump file, it's recorded in the log file. Here's an example of a successful snapshot and upload:

```output
SnapshotUploader.exe Information: 0 : Received Fork request ID 139e411a23934dc0b9ea08a626db16c5 from process 6368 (Low pri)
    DateTime=2018-03-09T01:42:41.8571711Z
SnapshotUploader.exe Information: 0 : Creating minidump from Fork request ID 139e411a23934dc0b9ea08a626db16c5 from process 6368 (Low pri)
    DateTime=2018-03-09T01:42:41.8571711Z
SnapshotUploader.exe Information: 0 : Dump placeholder file created: 139e411a23934dc0b9ea08a626db16c5.dm_
    DateTime=2018-03-09T01:42:41.8728496Z
SnapshotUploader.exe Information: 0 : Dump available 139e411a23934dc0b9ea08a626db16c5.dmp
    DateTime=2018-03-09T01:42:45.7525022Z
SnapshotUploader.exe Information: 0 : Successfully wrote minidump to D:\local\Temp\Dumps\c12a605e73c44346a984e00000000000\139e411a23934dc0b9ea08a626db16c5.dmp
    DateTime=2018-03-09T01:42:45.7681360Z
SnapshotUploader.exe Information: 0 : Uploading D:\local\Temp\Dumps\c12a605e73c44346a984e00000000000\139e411a23934dc0b9ea08a626db16c5.dmp, 214.42 MB (uncompressed)
    DateTime=2018-03-09T01:42:45.7681360Z
SnapshotUploader.exe Information: 0 : Upload successful. Compressed size 86.56 MB
    DateTime=2018-03-09T01:42:59.6184651Z
SnapshotUploader.exe Information: 0 : Extracting PDB info from D:\local\Temp\Dumps\c12a605e73c44346a984e00000000000\139e411a23934dc0b9ea08a626db16c5.dmp.
    DateTime=2018-03-09T01:42:59.6184651Z
SnapshotUploader.exe Information: 0 : Matched 2 PDB(s) with local files.
    DateTime=2018-03-09T01:42:59.6809606Z
SnapshotUploader.exe Information: 0 : Stamp does not want any of our matched PDBs.
    DateTime=2018-03-09T01:42:59.8059929Z
SnapshotUploader.exe Information: 0 : Deleted D:\local\Temp\Dumps\c12a605e73c44346a984e00000000000\139e411a23934dc0b9ea08a626db16c5.dmp
    DateTime=2018-03-09T01:42:59.8530649Z
```

> [!NOTE]
> The example above is from version 1.2.0 of the `Microsoft.ApplicationInsights.SnapshotCollector` NuGet package. In earlier versions, the uploader process is called *MinidumpUploader.exe* and the log is less detailed.

In the previous example, the instrumentation key is `c12a605e73c44346a984e00000000000`. This value should match the instrumentation key for your application.
The minidump is associated with a snapshot with the ID `139e411a23934dc0b9ea08a626db16c5`. You can use this ID later to locate the associated exception record in Application Insights Analytics.

The uploader scans for new PDBs about once every 15 minutes. Here's an example:

```output
SnapshotUploader.exe Information: 0 : PDB rescan requested.
    DateTime=2018-03-09T01:47:19.4457768Z
SnapshotUploader.exe Information: 0 : Scanning D:\home\site\wwwroot for local PDBs.
    DateTime=2018-03-09T01:47:19.4457768Z
SnapshotUploader.exe Information: 0 : Local PDB scan complete. Found 2 PDB(s).
    DateTime=2018-03-09T01:47:19.4614027Z
SnapshotUploader.exe Information: 0 : Deleted PDB scan marker : D:\local\Temp\Dumps\c12a605e73c44346a984e00000000000\6368.pdbscan
    DateTime=2018-03-09T01:47:19.4614027Z
```

For applications that *aren't* hosted in App Service, the uploader logs are in the same folder as the minidumps: *%TEMP%\Dumps\\\<ikey>* (where *\<ikey>* is your instrumentation key).

## Troubleshooting cloud services

In Cloud Services, the default temporary folder could be too small to hold the minidump files, leading to lost snapshots.

The space needed depends on the total working set of your application and the number of concurrent snapshots.

The working set of a 32-bit ASP.NET web role is typically between 200 MB and 500 MB. Allow for at least two concurrent snapshots.

For example, if your application uses 1 GB of total working set, you should make sure that there's at least 2 GB of disk space to store snapshots.

Follow these steps to configure your Cloud Service role with a dedicated local resource for snapshots.

1. Add a new local resource to your Cloud Service by editing the Cloud Service definition (.csdef) file. The following example defines a resource called `SnapshotStore` with a size of 5 GB.

   ```xml
   <LocalResources>
     <LocalStorage name="SnapshotStore" cleanOnRoleRecycle="false" sizeInMB="5120" />
   </LocalResources>
   ```

2. Modify your role's startup code to add an environment variable that points to the `SnapshotStore` local resource. For Worker Roles, the code should be added to your role's `OnStart` method:

   ```csharp
   public override bool OnStart()
   {
       Environment.SetEnvironmentVariable("SNAPSHOTSTORE", RoleEnvironment.GetLocalResource("SnapshotStore").RootPath);
       return base.OnStart();
   }
   ```

   For Web Roles (ASP.NET), the code should be added to your web application's `Application_Start` method:

   ```csharp
   using Microsoft.WindowsAzure.ServiceRuntime;
   using System;

   namespace MyWebRoleApp
   {
       public class MyMvcApplication : System.Web.HttpApplication
       {
          protected void Application_Start()
          {
             Environment.SetEnvironmentVariable("SNAPSHOTSTORE", RoleEnvironment.GetLocalResource("SnapshotStore").RootPath);
             // TODO: The rest of your application startup code
          }
       }
   }
   ```

3. Update your role's *ApplicationInsights.config* file to override the temporary folder location used by `SnapshotCollector`:

   ```xml
   <TelemetryProcessors>
    <Add Type="Microsoft.ApplicationInsights.SnapshotCollector.SnapshotCollectorTelemetryProcessor, Microsoft.ApplicationInsights.SnapshotCollector">
      <!-- Use the SnapshotStore local resource for snapshots -->
      <TempFolder>%SNAPSHOTSTORE%</TempFolder>
      <!-- Other SnapshotCollector configuration options -->
    </Add>
   </TelemetryProcessors>
   ```

## Override the shadow copy folder

When the Snapshot Collector starts up, it tries to find a folder on disk that's suitable for running the snapshot uploader process. The chosen folder is known as the shadow copy folder.

The Snapshot Collector checks a few well-known locations, making sure it has permissions to copy the snapshot uploader binaries. The following environment variables are used:

- Fabric_Folder_App_Temp
- LOCALAPPDATA
- APPDATA
- TEMP

If a suitable folder can't be found, Snapshot Collector reports an error message that says "Couldn't find a suitable shadow copy folder."

If the copy fails, Snapshot Collector reports a `ShadowCopyFailed` error.

If the uploader can't be launched, Snapshot Collector reports an `UploaderCannotStartFromShadowCopy` error. The body of the message often contains `System.UnauthorizedAccessException`. This error usually occurs because the application is running under an account with reduced permissions. The account has permission to write to the shadow copy folder, but it doesn't have permission to execute code.

Since these errors usually happen during startup, they'll usually be followed by an `ExceptionDuringConnect` error that says "Uploader failed to start."

To work around these errors, you can specify the shadow copy folder manually through the `ShadowCopyFolder` configuration option. For example, using *ApplicationInsights.config*:

   ```xml
   <TelemetryProcessors>
    <Add Type="Microsoft.ApplicationInsights.SnapshotCollector.SnapshotCollectorTelemetryProcessor, Microsoft.ApplicationInsights.SnapshotCollector">
      <!-- Override the default shadow copy folder. -->
      <ShadowCopyFolder>D:\SnapshotUploader</ShadowCopyFolder>
      <!-- Other SnapshotCollector configuration options -->
    </Add>
   </TelemetryProcessors>
   ```

Or, if you're using *appsettings.json* with a .NET Core application:

   ```json
   {
     "ApplicationInsights": {
       "InstrumentationKey": "<your instrumentation key>"
     },
     "SnapshotCollectorConfiguration": {
       "ShadowCopyFolder": "D:\\SnapshotUploader"
     }
   }
   ```

## Use Application Insights search to find exceptions with snapshots

When a snapshot is created, the throwing exception is tagged with a snapshot ID. That snapshot ID is included as a custom property when the exception is reported to Application Insights. Using **Search** in Application Insights, you can find all records that contain the `ai.snapshot.id` custom property.

1. Browse to your Application Insights resource in the [Azure portal](https://portal.azure.com).
2. Select **Search**.
3. Enter *ai.snapshot.id* in the Search text box, and then press Enter.

   :::image type="content" source="./media/snapshot-debugger-troubleshooting/search-snapshot-portal.png" alt-text="Search for telemetry with a snapshot ID in the portal.":::

If this search returns no results, then no snapshots were reported to Application Insights in the selected time range.

To search for a specific snapshot ID from the Uploader logs, enter that ID in the **Search** box. If you can't find records for a snapshot that you know was uploaded, follow these steps:

1. Double-check that you're looking at the right Application Insights resource by verifying the instrumentation key.

2. Using the timestamp from the Uploader log, adjust the **Time range** filter of the search to cover that time range.

If you still don't see an exception with that snapshot ID, then the exception record wasn't reported to Application Insights. This situation can happen if your application crashed after it took the snapshot but before it reported the exception record. In this case, check the App Service logs under **Diagnose and solve problems** to see if there were unexpected restarts or unhandled exceptions.

## Edit network proxy or firewall rules

If your application connects to the Internet via a proxy or a firewall, you might need to update the rules to communicate with the Snapshot Debugger service.

The IPs used by Application Insights Snapshot Debugger are included in the Azure Monitor service tag. For more information, see [Virtual network service tags](/azure/virtual-network/service-tags-overview).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
