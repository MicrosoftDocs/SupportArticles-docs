---
title: Direct connectivity issues in Power Automate for desktop
description: Provides more information about how to solve the direct connectivity issues in Power Automate for desktop.
ms.reviewer: guco, madiazor, johndund, qliu
ms.date: 05/15/2025
ms.custom: sap:Desktop flows
---
# Direct connectivity issues in Power Automate for desktop

This article provides more information about how to resolve the direct connectivity issues in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5016345

## Symptoms

When attempting to run your desktop flows from a cloud flow or manage your desktop flow machines, you might encounter one of the following issues:

#### Scenario 1

- Your previously registered machines appear offline when they're started up and connected to the network.
- Runs fail with one of the following error messages:

  - > ConnectionNotEstablished - None of the connected listeners accepted the connections within the allowed timeout. Check that your machine is online.
  - > NoListenerConnected - The endpoint was not found. There are no listeners connected for the endpoint. Check that your machine is online.

#### Scenario 2

- Desktop flows run on a registered machine as long as a user session is running (attended runs) or even for some minutes after the last user signs out (unattended runs).
- The connection to the machine is lost after some minutes (for example, 15 minutes.)
- The connection is re-established once a user signs back in to the machine.

#### Scenario 3

When you sign out of your Windows computer, the machine status shows as disconnected in the Power Automate portal.

## Cause

Direct to machine connectivity uses [Azure Windows Communication Foundation (WCF) relays](/azure/azure-relay/relay-what-is-it#wcf-relay) to allow the Microsoft cloud to connect to on-premises machines and schedule desktop flow runs. The Power Automate Windows service that runs on-premises opens a relay listener that connects to the Azure cloud by opening web sockets.

The most common cause of relay connectivity issues is the machine losing connection to the network. This can be caused by your machine not being powered on or losing network when no user is signed in to the machine.

The Power Automate service runs under its own Windows account (NT Service\UIFlowService by default) which must have access to the network and be able to connect to _*.servicebus.windows.net_ (for more information, see [network requirements](/power-automate/ip-address-configuration#desktop-flows-services-required-for-runtime).)

> [!NOTE]
> If you use an Azure virtual machine (VM) to run Power Automate for desktop, make sure the Microsoft.ServiceBus endpoint is turned off at the subnet level where the Azure VM is located. This is a known limitation. For more information, see [Azure Relay doesn't support network service endpoints](/azure/azure-relay/network-security).

If the machine and Power Automate service have reliable access to the network, the next likeliest source of issues is the on-premises network blocking or interfering with Azure relay connections.

A common culprit in both scenarios is a network proxy or a firewall that restricts outbound traffic.

In particular, authenticated proxies that use the credentials of the connected Windows user, given that the Power Automate service runs under its own dedicated account.

You can refer to [Proxy setup](/power-automate/desktop-flows/how-to/proxy-settings) if you determine that you need to override the default proxy settings used by the Power Automate service. You may also need to [change the on-premises service account](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account).

Azure Relay requires to have all the relay gateways used by the primary and secondary namespaces allowed by the proxy and firewall configurations.

## How to investigate

1. Engage your network administrators.

   Involve your network administrators to analyze network configurations and logs.

2. Understand network topology.

   - Trace the path of traffic through network devices (for example, NAT, firewalls, proxies) to the public internet.
   - Collect logs from devices during impacted runs and confirm traffic to _*.servicebus.windows.net_ successfully reaches the public internet.

3. If your network traffic runs though a proxy, consider [changing the on-premises account](/power-automate/desktop-flows/troubleshoot#change-the-on-premises-service-account) used by the Power Automate service (UIFlowService).

4. Get WCF logs from the Power Automate service (UIFlowService). For more information, see [Enable WCF tracing](#enable-wcf-tracing).

5. Make sure your network configuration allows web socket traffic and long-running connections. Connections terminated after a set time may cause issues.

6. Make sure firewall allows connections to Azure Relay gateways:

   **Step 1: identify the Azure relay namespaces**

   Two Azure relay namespaces can be used for connecting a machine to the Power Automate cloud services. To identify the namespaces used by a machine:

    1. Launch the Power Automate machine runtime application and sign in.
    2. Locate the **Diagnose connectivity issues for cloud runtime** section and select **Launch diagnostic tool**.
    3. Wait for the diagnostics to complete.
    4. Select **Generate the report**.
    5. Open the generated XLS file and locate the **Data** column.
    6. Extract the namespace part from the URLs of **PrimaryRelay** and **SecondaryRelay** (for example, https://\<namespace>/guid_guid.)

    **Step 2: Configure the firewall with the DNS names required for both the primary and secondary relays**

    1. Configure your firewalls with the Domain Name System (DNS) names of all the Relay gateways.

       The DNS names can be found by running the [script](https://github.com/Azure/azure-relay-dotnet/blob/dev/tools/GetNamespaceInfo.ps1). This script will resolve the fully qualified domain names (FQDNs) of all the gateways to which you need to establish a connection.

    2. Configure firewall rules to allow the DNS names on port 443 instead of IP addresses.

    **Step 3: Perform manual connectivity tests**

    WCF tracing can be enabled on the machine if there's cloud connectivity issue. For more information, see [Enable WCF tracing](#enable-wcf-tracing).

    The WCF log should contain exceptions related to connectivity for a specific DNS or IP address or point to missing proxy configuration.

    To test the connection between the machine and the endpoint, run a TCP ping from PowerShell using the following command:

    ```powershell
    Test-netconnection \<ipaddress or dnsname> -port 443
    ```

    If the `TcpTestSucceeded` shows `False`, it's likely that the firewall doesn't allow the connection. Engage your network team to understand if any proxy or firewall could prevent access. There could be several firewalls and proxies between the machine and the Azure Relay services, so make sure to check each subnet configuration.

## What information to include when opening a support ticket

If the issue still persists, you can open a support ticket with Microsoft by providing the following details:

- Your network topology: what are the devices that traffic goes through. For more information, see the step 2 in the [How to investigate](#how-to-investigate).
- Whether the Power Automate service (UIFlowService) on your machine is running as the default account (NT Service\UIFlowService) or if it has been changed to run as a different account.
- Logs from your network devices showing that the traffic is indeed handed off to the public internet. Include times of the issues and the time zones used by the logs.
- WCF traces from the impacted machines. For more information, see [Enable WCF tracing](#enable-wcf-tracing).
- Desktop flow run IDs of impacted runs.
- Local logs from the impacted machine: they can be extracted using the Power Automate machine runtime app's troubleshooting pane.

## Enable WCF tracing

1. In the installation folder (typically _C:\Program Files (x86)\Power Automate Desktop_), edit the _UIFlowService.exe.config_ file. This requires running your text editor as administrator.

2. Add the following configuration section between \</system.net> and \<appSettings>:

    :::image type="content" source="media/direct-connectivity-troubleshooting/added-config-section.png" alt-text="Screenshot of the config section that should be inserted into the correct location.":::

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

    - You can substitute the `c:\logs\PADwcfTraces.svclog` value with any valid path you'd like but the folder (the `c:\logs` in this example) must exist, otherwise it won't be created and logs won't be written.
    - The Power Automate service must have permission to write in the chosen folder, granting the 'Everyone' user full control over the folder works. You can get the service user's Sid by running `sc showsid UIFlowService` in a command line if you want to give permissions to only that user.

3. After saving the config file, restart the Power Automate service.

   1. Open the Windows Services tool (search for "services" in the **Start** menu).
   2. Find **Power Automate service**, right-click, and select **Restart**.

   :::image type="content" source="media/direct-connectivity-troubleshooting/restart-power-automate-service.png" alt-text="Restart the Power Automate Service in the Services tool.":::

Traces will be saved to the specified file, providing detailed logs to diagnose connectivity issues.
