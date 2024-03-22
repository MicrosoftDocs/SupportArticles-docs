---
title: Troubleshoot role instance startup failure in Azure Cloud Services
description: Troubleshoot role instance startup failure (RoleInstanceStartupTimeoutError error) in Azure Cloud Services (extended support).
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
ms.reviewer: jaygong, v-leedennis
ms.date: 09/26/2022
keywords: role instance, startup task, startup task script, Startup.cmd, RoleEntryPoint class
---

# Troubleshoot Azure Cloud Services (extended support) role instances that don't start

This article discusses how to troubleshoot startup failures in Azure Cloud Services (extended support) role instances.

## Troubleshooting checklist

Choose from the following options to diagnose issues that occur in role instances.

### Option 1: Turn off custom errors

To view complete error information, open the *Web.config* file for the web role, set the custom error mode to `Off`, and then redeploy the service:

1. In Visual Studio, open the solution.
1. In Solution Explorer, open the *Web.config* file.
1. In the `system.web` section, add the following XML code:

   ```xml
   <customErrors mode="Off" />
   ```

1. Save the file.
1. Repackage and redeploy the service.

After the service is redeployed, error messages that you might receive about the service will include the names of missing assemblies or DLLs.

### Option 2: Use PowerShell to view the role instance status

To get information about the runtime state of the role instance, run the [Get-AzCloudServiceRoleInstanceView](/powershell/module/az.cloudservice/get-azcloudserviceroleinstanceview) cmdlet:

```azurepowershell
$roleInstanceView = @{
    CloudServiceName = "<cloud-service-name>"
    ResourceGroupName = "<resource-group-name>"
    RoleInstanceName = "WebRole1_IN_0"
}
Get-AzCloudServiceRoleInstanceView @roleInstanceView
```

The state of the role instance is listed in the first column, as shown in the following example output:

```output
Statuses            PlatformFaultDomain PlatformUpdateDomain
--------            ------------------- --------------------
{RoleStateStarting} 0                   0
```

### Option 3: Use the Azure portal to view the role instance status

To view status information about a role instance in the Azure portal, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Cloud services (extended support)**.

1. In the list of cloud services, select the name of your cloud service.

1. In the menu pane, look under **Settings**, and then select **Roles and Instances**.

1. Select the name of the role instance.

1. In the role instance pane, note the state of the role instance in the **Status** field.

### Option 4: Use Remote Desktop to view error information

To access the role and view complete error information, use the Remote Desktop Protocol (RDP) by following these steps:

1. [Add the Remote Desktop extension for Azure Cloud Services (extended support)](/azure/cloud-services-extended-support/enable-rdp).

1. In the [Azure portal](https://portal.azure.com), when the cloud service instance shows a **Ready** status, use Remote Desktop to sign in to the cloud service. For more information, see [Connect to role instances by using Remote Desktop](/azure/cloud-services-extended-support/enable-rdp#connect-to-role-instances-with-remote-desktop-enabled).

1. Sign in to the virtual machine (VM) by using the credentials that you used to set up Remote Desktop.

1. Open a **Command Prompt** window.

1. Run the [ipconfig](/windows-server/administration/windows-commands/ipconfig) command. Copy the returned value for the IPv4 address.

1. Open a web browser.

1. In the address bar, paste the IPv4 address, and then append a slash and the name of the web application default file. For example, `http://<ipv4-address>/default.aspx`.

If you go to the website now, you'll see error messages that contain more information. Here's an example:

> **Server Error in '/' Application.**
>
> *Could not load file or assembly 'Microsoft.WindowsAzure.StorageClient, Version=1.1.0.0, Culture=neutral, PublicKeyToken=\<16-digit-hexadecimal-string>' or one of its dependencies. The system cannot find the file specified.*
>
> **Description:** An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.
>
> **Exception Details:** System.IO.FileNotFoundException
  
### Option 5: Use the Compute Emulator

You can use the Azure Compute Emulator to diagnose and troubleshoot issues of missing dependencies and *Web.config* errors. For best results when you use this method to diagnose issues, use a computer or VM that has a clean installation of Windows.

To diagnose issues by using the Azure Compute Emulator:

1. Install the [Azure SDK](https://azure.microsoft.com/downloads/).
1. On the development computer, build the cloud service project.
1. In File Explorer, in the cloud service project, go to the *bin\\debug* folder.
1. Copy the *.csx* folder and the *.cscfg* file to the computer that you're using to debug issues.
1. On the clean computer, open an Azure SDK **Command Prompt** window.
1. At the command prompt, run the following `csrun` command:

   ```console
   csrun.exe /devstore:start
   ```

1. Run the following command:

   ```console
   run csrun <path-to-.csx-folder> <path-to-.cscfg-file> /launchBrowser
   ```

   When the role starts, the web browser displays detailed error information.

If more diagnosis is required, you can use standard Windows troubleshooting tools.

### Option 6: Use IntelliTrace

> [!NOTE]
> You can't use IntelliTrace in Visual Studio 2022. IntelliTrace is still available if you're using Visual Studio 2019, 2017, or 2015.

For worker and web roles that use .NET Framework 4, you can use [IntelliTrace](/visualstudio/debugger/intellitrace). IntelliTrace is available in Visual Studio Enterprise.

To deploy your cloud service while IntelliTrace is turned on:

1. Verify that [Azure SDK](https://azure.microsoft.com/downloads/) 1.3 or a later version is installed.
1. In Visual Studio, deploy the solution. When you set up the deployment, select the **Enable IntelliTrace for .NET 4 roles** checkbox.
1. After the role instance starts, open Server Explorer.
1. Expand the **Azure\Cloud Services** node.
1. To list the role instances, expand the deployment. Then, right-click a role instance.
1. Select **View IntelliTrace logs**.
1. In **IntelliTrace Summary**, go to **Exception Data** and expand that node.
1. In the list of exceptions, look for a row that contains a **Type** column value of **System.IO.FileNotFoundException**. The corresponding **Message** column value should resemble the following text:

   > Could not load file or assembly 'Microsoft.WindowsAzure.StorageClient, Version=1.1.0.0, Culture=neutral, PublicKeyToken=\<16-digit-hexadecimal-string>' or one of its dependencies. The system cannot find the file specified.

## Cause 1: Cloud service operation fails because of RoleInstanceStartupTimeoutError

One or more of the role instances in Azure Cloud Services (extended support) might be slow to start. Or, your role instance might be recycling or stuck in a busy state and not start as expected. In this situation, the `RoleInstanceStartupTimeoutError` role application error message appears.

The role application contains two parts that might cause role recycling:

- Startup tasks
- [Role code (Implementation of RoleEntryPoint)](/azure/cloud-services/cloud-services-role-lifecycle-dotnet)

If the role stops, the platform as a service (PaaS) agent restarts the role.

To determine whether the issue is caused by a startup task, follow these steps:

1. Try to [use Remote Desktop](#option-4-use-remote-desktop-to-view-error-information) to connect to the problematic role instance.

1. After you connect to the role instance, select **Start**, and then search for and select **Task Manager**.

1. To see a list of processes, select the **Details** tab in **Task Manager**.

1. Check whether there are processes for *WaIISHost.exe* (for a WebRole) or *WaWorkerHost.exe* (for a WorkerRole). If both these processes are missing, a startup task is probably failing.

Were you able to verify that the issue is caused by a startup task? If so, you can apply the following solution. However, the solution is available only if the startup task is a [simple or foreground task](/azure/cloud-services/cloud-services-startup-tasks#description-of-task-attributes). The solution doesn't apply for background startup tasks. Those are run asynchronously in parallel with the startup of the role.

### Solution: Debug the startup task script

To troubleshoot a startup task failure, debug the script that runs during VM startup. This startup task script is the *Startup.cmd* file. To help investigate the issues in the script, you can choose from the following options:

* View the *C:\\Resources\\WaHostBootstrapper.log* log file. This file is the log for the *WaHostBootstrapper.exe* process. This process is responsible for startup tasks. It's described in the [workflow of Windows Azure classic VM architecture](/azure/cloud-services/cloud-services-workflow-process). Then, search for any error or exception that involves running *Startup.cmd*. Verify especially whether the exit code is **0**. If it isn't, the startup task finished but has errors. If there aren't logs that are related to the exit code for the script, the startup task is still running.

* If the startup task script can't be run freely in the production environment because of the expected business impact, customize the logging mechanism at the command line. For example, you can redirect the output of key information in a script command to a file. One way to do this is to append `> "%TEMP%\StartupLog.txt"` to the end of the command.

* At the command line, manually run the startup task script. The locations of this script for the WebRole or WorkerRole roles are shown in the following table.

  | Role       | Script location                 |
  |------------|---------------------------------|
  | WebRole    | *E:\\approot\\bin\\Startup.cmd* |
  | WorkerRole | *E:\\approot\\Startup.cmd*      |

## Cause 2: DLLs or assemblies are missing

Unresponsive role instances and role instances that cycle between states might be caused by missing DLLs or assemblies.

Here are some symptoms of missing DLLs or assemblies:

* Your role instance cycles through the **Initializing**, **Busy**, and **Stopping** states.

* Your role instance has moved to the **Ready** state, but the page isn't visible in your web application.

If a website is deployed in a web role and but is missing a DLL, it might display the following server runtime error message.

> **Server Error in '/' Application.**
>
> *Runtime Error*
>
> **Description:** An application error occurred on the server. The current custom error settings for this application prevent the details of the application error from being viewed remotely (for security reasons). It could, however, be viewed by browsers running on the local server machine.
>
> **Details:** To enable the details of this specific error message to be viewable on remote machine, please create a `<customErrors>` tag with a "*web.config*" configuration file located in the root directory of the current web application. This `<customErrors>` tag should then have its "`mode`" attribute set to "`Off`".

### Solution: Resolve missing DLLs and assemblies

To resolve errors of missing DLLs and assemblies:

1. In Visual Studio, open the solution.

1. In Solution Explorer, open the *References* folder.

1. Select the assembly that's identified in the error message.

1. In **Properties**, set the **Copy Local** property to **True**.

1. Redeploy the cloud service.

After you verify that errors no longer appear, redeploy the service. When you set up the deployment, don't select the **Enable IntelliTrace for .NET 4 roles** checkbox.

## Next steps

* Learn how to [troubleshoot cloud service role issues by using Azure PaaS computer diagnostics data](/archive/blogs/kwill/windows-azure-paas-compute-diagnostics-data).

## More information

For information about the initial configuration, execution, and examples of startup tasks in the classic Cloud Service, see the following articles:

* [How to configure and run startup tasks for an Azure Cloud Service (classic)](/azure/cloud-services/cloud-services-startup-tasks)
* [Common Cloud Service (classic) startup tasks](/azure/cloud-services/cloud-services-startup-tasks-common)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
