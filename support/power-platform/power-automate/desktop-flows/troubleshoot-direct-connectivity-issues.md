---
title: Direct connectivity issues in Power Automate for desktop
description: Provides more information about how to solve the direct connectivity issues in Power Automate for desktop.
ms.reviewer: guco, madiazor, johndund, qliu
ms.date: 01/22/2025
ms.custom: sap:Desktop flows
---
# Direct connectivity issues in Power Automate for desktop

This article provides more information about how to resolve the direct connectivity issues in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5016345

## Symptoms

When attempting to run your desktop flows from a cloud flow or manage your desktop flow machines, you might encounter one of the following issues:

#### Scenario 1

- Your previously registered machines appear offline when they're booted up and connected to the network.
- Runs fail with either of these error messages:

  > ConnectionNotEstablished - None of the connected listeners accepted the connections within the allowed timeout. Check that your machine is online.

  > NoListenerConnected - The endpoint was not found. There are no listeners connected for the endpoint. Check that your machine is online.

#### Scenario 2

- Desktop flows run on a registered machine as long as a user session is running (attended runs) or even for some minutes after the last user signs out (unattended runs).
- The connection to the machine is lost after some minutes (for example, 15 minutes).
- The connection is re-established once a user signs back in to the machine.

#### Scenario 3

When you sign out of your Windows computer, the machine status in the Power Automate portal shows as disconnected.

## Cause

Direct to machine connectivity uses [Azure WCF relays](/azure/azure-relay/relay-what-is-it#wcf-relay) to allow the Microsoft cloud to connect to on-premises machines and schedule desktop flow runs. The Power Automate Windows service that runs on-premises opens a relay listener that connects to the Azure cloud by opening web sockets.

The most common cause of relay connectivity issues is the machine losing connection to the network. This can be caused by your machine not being powered on or losing network when no user is signed in to the machine.

The Power Automate service runs under its own Windows account (NT Service\UIFlowService by default) which must have access to the network and be able to connect to _*.servicebus.windows.net_ (for more information, see [network requirements](/power-automate/ip-address-configuration#desktop-flows-services-required-for-runtime).)

> [!NOTE]
> If you use an Azure virtual machine (VM) to run Power Automate for desktop, make sure the Microsoft.ServiceBus endpoint is turned off at the subnet level where the Azure VM is located. This is a known limitation. For more information, see [Azure Relay doesn't support network service endpoints](/azure/azure-relay/network-security).

If the machine and Power Automate service have reliable access to the network, the next likeliest source of issues is the on-premises network blocking or interfering with Azure relay connections.

A common culprit in both scenarios is a network proxy or a firewall that restricts outbound traffic. 

In particular, authenticated proxies that use the credentials of the connected Windows user, given that the Power Automate service runs under its own dedicated account.

You can refer to [Proxy setup](https://support.microsoft.com/topic/power-automate-for-desktop-proxy-setup-8a79d690-1c02-416f-8af1-f057df5fe9b7) if you determine that you need to override the default proxy settings used by the Power Automate service. You may also need to [change the on-premises service account](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account).

Azure Relay requires to have all the relay gateways used by the primary and secondary namespaces allowed by the proxy and firewall configurations.

## How to investigate

1. To help you investigate these issues, make sure to engage your network administrators who will have the knowledge required to understand what is happening.

2. Understand the topology of the network: what network devices does the traffic hop through before being handed off to the public internet: NAT, firewalls, proxies and so on. Get logs from these devices during impacted runs, and logs from the outermost network device attesting that the traffic to _*.servicebus.windows.net_ is handed off to the public internet.

3. If your network traffic runs though a proxy, attempt to mitigate the issue by [changing the on-premises account](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account) with which the Power Automate service (UIFlowService) runs.

4. Get WCF logs from the Power Automate service (UIFlowService). For more information, see the [Enable WCF tracing](#enable-wcf-tracing) section below.

5. Make sure your network configuration allows web socket traffic and long-running connections: a common pattern is proxies or other network devices killing connections after a set time.
6. Make sure firewall allows connections to Azure Relay gateways by following below steps:
#### Step 1: identify the Azure relay namespaces

Two Azure relay namespaces can be used for the connecting a machine to the Power Automate cloud services.

To identify the namespaces used by a machine:

1. Launch the "Power Automate machine runtime" application and sign-in
2. Locate the "Diagnose connectivity issues for runtime" section and click on "Launch diagnostic tool"
3. Wait for the diagnostics to end
4. Click on "Generate the report"
5. Open the generated xls file
6. Local the Data column and copy the 2 URLs corresponding to PrimaryRelay and SecondaryRelay
7. Extract the namespace part from each PrimaryRelay and SecondaryRelay URL https://<namespace>/guid_guid 

#### Step 2:  Configure the firewall with the DNS names required for both the primary and secondary  relays

Configure your firewalls with the DNS names of all the Relay gateways, which can be found by running this script .

This script will resolve the fully qualified domain names of all the gateways to which you need to establish a connection.

Change any rules that previously used the IP addresses to use the namespace DNS names for port 443.

#### Step 3: manual connectivity test can be done

WCF tracing can be enabled on the machine in case of cloud connectivity issue. Direct connectivity issues in Power Automate for desktop - Power Automate | Microsoft Learn 

The log should contain exceptions related to connectivity for a specific DNS or IP address or point to missing proxy configuration.

The connection between the machine and the endpoint can be tested by running a TCP ping:

1. Open PowerShell and run the below command
2. Test-netconnection <ipaddress or dnsname> -port 443
   
The result will be displayed as the output of TcpTestSucceeded.

If not succeeding, this is likely that the firewall does not allow the connection. Thus engage your network team to understand if any proxy or firewall could prevent access. There could be several firewalls and proxies between the machine and the Azure Relay services, thus make sure to check each of the subnet configurations.

## What information to include when opening a support ticket

- Your network topology: what are the devices that traffic goes through. (see the step 2 in the section above)
- Whether the Power Automate service (UIFlowService) on your machine is running as the default account (NT Service\UIFlowService) or if it has been changed to run as a different account.
- Logs from your network devices showing that the traffic is indeed handed off to the public internet. Include times of the issues and the time zones used by the logs.
- WCF traces from the impacted machines. (see the [Enable WCF tracing](#enable-wcf-tracing) section below)
- Desktop flow run IDs of impacted runs.
- Local logs from the impacted machine: they can be extracted using the Power Automate machine runtime app's troubleshooting pane.

## Enable WCF tracing

In the installation folder (typically _C:\Program Files (x86)\Power Automate Desktop_), edit the _UIFlowService.exe.config_ file. This requires running your text editor as administrator.

Add this config section:

```xml
<system.diagnostics>
  <sources>
    <source name="System.ServiceModel" 
            switchValue="Information,ActivityTracing"
            propagateActivity="true">
      <listeners>
        <add name="wcfTraces"
             type="System.Diagnostics.XmlWriterTraceListener"
             initializeData="c:\logs\PADwcfTraces.svclog" />
      </listeners>
    </source>
  </sources>
 <trace autoflush="true" />
</system.diagnostics>
```

- You can substitute the `c:\logs\PADwcfTraces.svclog` value with any valid path you'd like but the folder (`c:\logs` in this example) must exist, otherwise it won't be created and logs won't be written.
- The Power Automate service must have permission to write in the chosen folder, granting the 'Everyone' user full control over the folder works. You can get the service user's Sid by running `sc showsid UIFlowService` in a command line if you want to give permissions to only that user.

This config section needs to be added between \</system.net> and \<appSettings>, see the following screenshot:

:::image type="content" source="media/direct-connectivity-troubleshooting/added-config-section.png" alt-text="Screenshot of the config section that should be inserted into the correct location.":::

After saving the config file, restart the Power Automate service. This can be done in the Services tool. The tool can be found by typing _services_ in the start menu, finding Power Automate Service, right-clicking it and choosing **Restart**. The following screenshot shows the step to restart the Power Automate service:

:::image type="content" source="media/direct-connectivity-troubleshooting/restart-power-automate-service.png" alt-text="Restart the Power Automate Service in the Services tool.":::

Traces will then be written to the file chosen in the config.
