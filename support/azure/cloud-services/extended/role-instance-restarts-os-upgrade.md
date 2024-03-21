---
title: Role instance restarts from Azure VM OS upgrades
description: Learn about service impacts and other common issues related to role instance restarts caused by Windows upgrades on an Azure virtual machine.
ms.date: 09/26/2022
editor: v-jsitser
ms.reviewer: v-maallu, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
#Customer intent: As an Azure Cloud Services administrator, I want know about service impacts and other common issues that relate to role instance restarts that are caused by Windows upgrades on a virtual machine so that I can plan for upgrades and keep my cloud service available without excessive downtime.
---

# Role instance restarts caused by Azure VM operating system upgrades

This article discusses the effects of Microsoft Azure virtual machine (VM) operating system (OS) upgrades on restarting role instances. It contains details about OS and guest agent upgrade schedules, service impacts and requirements, notification, detection, and how to solve common issues.

## Upgrade schedules

On approximately a monthly basis, Microsoft releases a new guest OS version for Azure platform as a service (PaaS) VMs. The exact schedule varies, and the historic trend can be seen at the [Azure Guest OS releases and SDK compatibility matrix][matrix]. During this rollout, the [Azure Fabric Controller](/azure/security/fundamentals/isolation-choices#the-azure-fabric-controller) does two passes (a host OS pass and a guest OS pass) through all the datacenters. A periodic update of the Azure guest agent also runs inside your VM.

The following sections provide more details about the two upgrade passes and the guest agent upgrade.

#### Pass 1: Host OS

The first pass upgrades the host OS. The host OS restarts role instances, and the fabric controller makes sure that only instances from one upgrade domain at a time are restarted. During this restart, your role instances go through the standard shutdown process. Then, the `RoleEnvironment.OnStop` event is run to give you a chance to gracefully shut down the instance.

The host OS update can take several days for the fabric to coordinate the upgrades across all the different hosted services and upgrade domains within a datacenter. Typically, different instances of your deployment are updated several hours apart.

For more information about the host OS upgrade process, see the [Azure host updates: Why, when, and how](/archive/blogs/markrussinovich/windows-azure-host-updates-why-when-and-how) Azure blog article.

#### Pass 2: Guest OS

After the host OS finishes upgrading across the datacenter, the guest OS is upgraded for services that are configured to use automatic guest OS versions. This upgrade continues by using standard upgrade domain rules for your service. Your VM is restarted, and the Windows partition (the D drive) is reimaged by using the upgraded OS.

The guest OS update process is much faster than the host OS update. This is because the fabric has to coordinate only the update within your hosted service and your upgrade domains. The duration of the guest OS update process for your service depends largely on the following factors:

- The number of role instances
- The number of upgrade domains
- How much time your service takes to shut down (`Stopping` and `OnStop` events)
- How much time your service takes to start up (startup tasks and the `OnStart` event)

#### Guest agent

The Azure guest agent is updated on approximately a monthly basis. When the guest agent is updated, the following actions occur:

- The host process that runs your role (typically WaWorkerHost or WaWebHost) is gracefully shut down.
- The guest agent updates itself.
- The host process starts again.

For more information about the guest agent process and how it interacts with your service, see [Workflow of Windows Azure classic VM architecture][architecture].

## Service impacts and requirements

The following list describes the impacts to and requirements for your cloud service:

- If any of your roles has only one instance, your service might experience downtime. You should have at least two instances of each role because the service level agreement (SLA) requires an uptime of 99.95 percent.
- Expect your role instances to restart for the host OS update approximately one time every month. If you have automatic guest OS updates, expect your instances to restart again. Typically, the restarts are several hours apart. However, this time frame can change depending on the makeup of the different services that exist within a datacenter.
- Your role has to adhere to the rules that govern host OS updates. In particular, role instances should reach the `Ready` state within 30 minutes of starting the startup tasks. For more information about this limitation, see [How an upgrade proceeds](/azure/cloud-services/cloud-services-update-azure-service#how-an-upgrade-proceeds).
- The host OS upgrade causes a restart of your role instance, and the guest OS upgrade causes the equivalent of a reimage of your instance. Because of these events, your role instances must be able to handle the following procedures:

  - Restart
  - Reimage
  - Recycle

## Notification

Currently, the Azure platform doesn't offer proactive notifications when an OS upgrade is occurring. Your role instances will receive a `RoleEnvironment.Stopping` event before they're shut down. You can use that event to gracefully end any work that the role instance is doing or to notify an administrator that an instance is shutting down.

You can subscribe to the [Azure OS Updates RSS feed](https://azurecomcdn.azureedge.net/updates/feed). This feed should be updated the same day that the OS updates start being rolled out to the datacenter. The feed typically doesn't give advanced proactive notification, but it helps you identify when the updates are occurring. The update process can take several days to complete. Therefore, you might have to wait one or more days between when the RSS feed is updated and your hosted service begins updating.

The [Azure Guest OS release list][matrix], and the list of OS versions that are available for selection in the Azure portal, are both typically updated after the guest OS rollout is completed. You shouldn't use the latest entry in these lists as an indication of when the OS updates are in progress.

## Detection

Currently, there's no direct way to detect a host OS upgrade. However, you can see the evidence of the restart within the logs on the VM. To do this, take one of the following actions:

- In the Event Viewer app, search the System event logs for event source USER32, event ID 1074. This event contains the following message:

  > The process *D:\\Packages\\GuestAgent\\WaAppAgent.exe* (RD00155D50206D) has initiated the shutdown of computer RD00155D50206D on behalf of user **NT AUTHORITY\SYSTEM** for the following reason: Legacy API shutdown

  This message indicates that the Azure fabric guest agent (*WaAppAgent.exe*) initiated a shutdown of the VM.

- In a text editor, search an old [app agent runtime log](./windows-azure-paas-compute-diagnostic-data.md#app-agent-runtime-logs) file (*AppAgentRuntime.log.old*) for a `_Context_Start` message in which the `Context` is equal to `StopContainer()`. For more information about how to examine context entries in the app agent runtime log, see [Troubleshooting scenario 6 – Role recycling after running for some time](/archive/blogs/kwill/troubleshooting-scenario-6-role-recycling-after-running-for-some-time) in the Azure blog archive.

## Common issues and solutions

The following sections discuss some common issues that involve role instance restarts and how you can resolve them. For more information about the processes that are running and the location of log files that you can use for troubleshooting, see [Workflow of Windows Azure classic VM architecture][architecture].

### Issue 1: Startup tasks or code fails to run the second time after a host OS restart

Startup tasks or the code in the `OnStart` or `Run` function might fail the second time after a host OS restart. The restart is supposed to invoke your startup tasks to run again. This failure prevents the role instance from reaching the `Ready` state.

What if you're doing something in a startup task, and then you run a command that returns an error after it runs the second time? In this case, your startup task will fail and cause your role instance to start recycling. For example, if you use the [APPCMD set config](/iis/get-started/getting-started-with-iis/getting-started-with-appcmdexe#editing-configuration-properties) command to add a configuration section in Internet Information Services (IIS), the command fails on its second run. The command generates the error message, "New add object missing required attributes. Cannot add duplicate collection entry of type..." Then, the role instance begins recycling.

#### Solution 1: Connect to the VM and debug the startup or code failure remotely

To troubleshoot this kind of failure, use Remote Desktop Protocol (RDP) to connect to the VM remotely. Examine the event logs for errors, and check in the *WaHostBootstrapper.log* file for startup task failures. During your typical development and testing process, you should proactively initiate a restart of your role instances from the Azure portal. This step helps you test your service to make sure that it works correctly in this scenario.

A common fix for startup task failures is to add an `exit /b 0` command to the end of your startup task script. This [exit](/windows-server/administration/windows-commands/exit) command ends the script by using an exit code that indicates success. For more information about why this command is necessary, see [How to configure and run startup tasks for an Azure Cloud Service (classic)](/azure/cloud-services/cloud-services-startup-tasks).

### Issue 2: Startup task or code doesn't run after the Windows partition is reimaged

The Windows partition (D drive) is typically where program installations and registry changes are stored. During the guest OS portion of an update, the Windows partition is reimaged. This might cause these installations and changes to be lost. If the startup code mistakenly assumes that certain registry changes still exist after the Windows partition is reimaged, the role instance might not work correctly. This failure prevents the role instance from reaching the `Ready` state.

For example, the startup task might make a registry change. Then, it stores a record of that change on the C or E drive to make sure that the registry change doesn't run a second time. However, the registry change on the D drive will be lost because of the reimaging, and the startup task won't restore that registry change because the task doesn't think it's necessary. The missing registry change can eventually cause the rest of the startup task to fail.

#### Solution 2: Test the reimaging of role instances from the Azure portal

During your typical development and testing process, you should proactively initiate a reimage of your role instances from the Azure portal. This step helps you test your service and make sure that it works correctly in this scenario.

### Issue 3: Startup code takes more than 30 minutes to finish

If your startup code takes more than 30 minutes to finish, you might have more than one role instance that's out-of-service at the same time. This scenario most commonly occurs when a startup task takes one of these actions:

- Installs a program or feature
- Downloads cache data
- Downloads website information

#### Solution 3: Review service impacts and requirements

Review the [Service impacts and requirements](#service-impacts-and-requirements) section to know what to expect and how you can prevent or mitigate any startup delays.

### Issue 4: Azure doesn't restart the host or guest OS after an update

On rare occasions, Azure might not restart the host or guest OS after an update. In this scenario, you probably will see a "Waiting for Host" message in the portal that doesn't change after 30 minutes or more.

#### Solution 4a: Fix the startup code

If you're able to use the Remote Desktop Protocol (RDP) to connect to the role instance, there might be a failure in the startup code that you can fix. For more information about how to fix the startup code, see [Solution 1: Connect to the VM and debug the startup or code failure remotely](#solution-1-connect-to-the-vm-and-debug-the-startup-or-code-failure-remotely).

#### Solution 4b: Delete the deployment

If you can't use RDP to connect to the role instance, probably the only way to recover the instance is to delete the deployment.

### Issue 5: One or more role instances are unavailable during the OS upgrade

If any role instances are unavailable during the OS upgrade, this can cause a reduction in service capacity. For example, suppose you have two instances of a web role, and both instances typically run at 75 percent CPU usage. If one instance is restarted during the upgrade, traffic is redirected to the remaining instance. That instance can't handle the extra load. This causes a reduction in service availability.

#### Solution 5: Keep enough excess capacity in your service

Make sure that your service has sufficient excess capacity to absorb a certain percentage of role instances being unavailable. To calculate the amount of excess capacity that you have to make available, divide the number one by the number of upgrade domains. For example, if you have two upgrade domains, you need 1/2 = 50 percent excess capacity to handle an upgrade domain becoming unavailable. If you have five upgrade domains, you need 1/5 = 20 percent excess capacity to handle the loss of availability in one of the five upgrade domains.

### Issue 6: Clients experience outages or time-outs because your website takes too long to warm up

Does your website takes several minutes to warm up? (For example, website warmup might consist of standard IIS or ASP.NET precompilation and module loading, or it might be warming up a cache or other app-specific tasks.) In this case, your clients might experience an outage or random time-outs.

After a role instance restarts, and your `OnStart` code completes its run, your role instance is restored to the load balancer rotation. The role instance will then begin receiving incoming requests. If your website is still warming up, all those incoming requests will queue up and time out. Suppose you have only two instances of your web role. In this case, the `IN_0` instance will receive 100 percent of the incoming requests while the `IN_1` instance is being restarted for the guest OS update. However, the `IN_0` instance is still warming up. This scenario can cause a complete outage of your service until your website is finished warming up on both instances.

#### Solution 6: Stop a role instance from receiving incoming requests until warmup is finished

We recommend that you keep the `OnStart` event handling code for your role instance from finishing until the website completes its warmup. To implement this event process, you can use the following example code:

```csharp
public class WebRole : RoleEntryPoint {
    public override bool OnStart () {
        // For information about handling configuration changes, see the article
        // "Customize the Lifecycle of a Web or Worker role in .NET" at
        // https://learn.microsoft.com/azure/cloud-services/cloud-services-role-lifecycle-dotnet.
        IPHostEntry ipEntry = Dns.GetHostEntry (Dns.GetHostName ());
        string ip = null;
        foreach (IPAddress ipaddress in ipEntry.AddressList) {
            if (ipaddress.AddressFamily.ToString () == "InterNetwork") {
                ip = ipaddress.ToString ();
            }
        }
        string urlToPing = "https://" + ip;
        HttpWebRequest req = HttpWebRequest.Create (urlToPing) as HttpWebRequest;
        WebResponse resp = req.GetResponse ();
        return base.OnStart ();
    }
}
```

## More information

- [Role instance restarts from Azure VM OS upgrades FAQ](./role-instance-restarts-faq.yml)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[architecture]: /azure/cloud-services/cloud-services-workflow-process
[matrix]: /azure/cloud-services/cloud-services-guestos-update-matrix
