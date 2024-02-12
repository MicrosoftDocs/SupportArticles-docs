---
title: Netlogon event ID 5719 or Group Policy event 1129
description: Event ID 5719 or Group Policy event 1129 is logged if you have a Gigabit network adapter installed on a Windows-based compute. Provides a resolution.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, v-jomcc
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Netlogon event ID 5719 or Group Policy event 1129 is logged when you start a domain member

This article solves the Netlogon event ID 5719 or Group Policy event 1129 that's logged when you start a domain member.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 938449

## Symptoms

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

Consider this scenario:

- You have a computer that's running Windows 10 or Windows Server 2012 R2.
- The computer is joined to a domain.
- One of these conditions is true:
  - The computer has a Gigabit network adapter installed.
  - You secure the network access by using Network Access Protection (NAP), network authentication (by using 802.1**x**), or another method.
  
In this scenario, the following event is logged in the System log when you start the computer in Windows 8.1 and earlier versions. In Windows 10 and later versions, event 5719 is no longer logged in this situation. The following lines are recorded in Netlogon.log instead:

```output
[CRITICAL] [960] CONTOSO: NlSessionSetup: Session setup: cannot pick trusted DC  
[SESSION] [960] No IP addresses present, skipping No DC event log
```

After this issue occurs, the computer is assigned an IP address:

```output
[SESSION] [960] V6 Winsock Addrs: fe80::5faf:632a:f22c:644a%2 (1) V6WinsockPnpAddresses List used to be empty.  
[SESSION] [960] Winsock Addrs: 10.1.1.80 (1) List used to be empty.
```

On Windows 10 and later versions, you'll see only events by components, depending on the Domain Controller connectivity (such as Group Policy). The following entries are recorded in the group policy debug log:

```output
CGPApplicationService::MachinePolicyStartedWaitingOnNetwork.  
CGPMachineStartupConnectivity::CalculateWaitTimeoutFromHistory: Average is 388.
CGPMachineStartupConnectivity::CalculateWaitTimeoutFromHistory: Current is -1.
CGPMachineStartupConnectivity::CalculateWaitTimeoutFromHistory: Taking min of 776 and 30000.  
Waiting for SamSs with timeout 776

NlaQueryNetSignatures returned 1 networks  
NSI Information (Network GUID) : {395DB3C8-CE45-11E5-9739-806E6F6E6963}  
NSI Information (CompartmentId) : 1  
NSI Information (SiteId) : 134217728  
NSI Information (Network Name) :  
NlaGetIntranetCapability failed with 0x15  
There is no domain compartment  
ProcessGPOs(Machine): MyGetUserName failed with 1355.  
Opened query for NLA successfully  
NlaGetIntranetCapability returned Not Ready error. Consider it as NOT intranet capable.  

GPSVC(530.ae0) <DateTime> There is no connectivity  
GPSVC(530.8e0) <DateTime> ApplyGroupPolicy: Getting ready to create background thread GPOThread.
```

The first section shows the calculation for the time-out to use to bring up the network. It can be based on previous fast startups.

The second section shows that Network Location Awareness (NLA) fails to report a working network within the wait interval that's allowed, and group policy startup processing fails. The third section shows that the Group Policy engine starts a background procedure, and then waits for one minute after a network becomes available.

## Cause

This issue may occur for any of these reasons:

- The Netlogon service starts before the network is ready. The network stack and adapter initialization often start at about the same time. Some network adapters and switches have link arbitration and MAC address uniqueness checks that take longer to complete than the wait time that is set for Netlogon to detect network connectivity.
- Solutions that verify the health of the new network member delay the network connection and your ability to access domain controllers. If you have an automatic Direct Access channel connection enabled, it may also require more time to do than Netlogon allows.
- The 802.1X authentication process delays connections to the domain controllers.
- The client experiences a delay to retrieve an IP address from the DHCP server. It delays the display of the network interface.

Group Policy in Windows Vista and later versions is written to negotiate the network status that has NLA enabled. And it waits for a network that has DC connectivity. However, Group Policy may start prematurely because of a policy application. This situation is especially true when the delay in finding a network alternates between startups.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

## Resolution 1

To resolve this issue, install the most current driver for the Gigabit network adapter. Or, enable the **PortFast** option on the network switches.

## Resolution 2

To resolve this issue, use the registry to change the related settings that affect DC connectivity. To do it, use the following methods.

### Method 1

Adjust the firewall settings or IPSEC policies that are changed to allow DC connectivity. These changes are made when the client receives an IP address but requires more time to access a domain controller, for example, after a successful verification through Cisco NAC or Microsoft NPS Services.

### Method 2

Configure the `Netlogon` registry setting to a value that is safely beyond the time that is required allow DC connectivity.

> [!NOTE]
> This is only effective if the machine already has an IP address. This applies to scenarios where a NAP solution puts the machine into a quarantine network. Use the following settings as guidelines.

> Registry subkey: HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters  
Value Name: ExpectedDialupDelay  
Data Type: REG_DWORD  
Data Value is in seconds (default= 0 )  
Data Range is between 0 and 600 seconds (10 minutes)

For more information, see [Settings for minimizing periodic WAN traffic](https://support.microsoft.com/help/819108).

### Method 3

The IP stack tries to verify the IP address using an ARP broadcast. It delays the time that the IP takes to come online. You can set the ArpRetryCount registry entry to one (1), so the wait for uniqueness is shortened. To do it, follow these steps:

1. Start Registry Editor.
2. Locate and select the following subkey:  
   `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\TcpIp\Parameters\`

3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type *ArpRetryCount*.
5. Right-click the `ArpRetryCount` registry entry, and then select **Modify**.
6. In the **Value data** box, type *1*, and then select **OK**.

    > [!NOTE]
    > The Data Range is between 0 and 3 (3 is default).

7. Exit Registry Editor.

### Method 4

Reduce the Netlogon negative cache period by changing the `NegativeCachePeriod` registry entry in the following subkey:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\NegativeCachePeriod`

After you make this change, the Netlogon service doesn't behave as if the domain controllers are offline for 45 seconds. The event 5719 is still logged. However, the event doesn't cause any other significant problems. This setting allows member to try domain controllers earlier if the process failed previously.

Suggestion: Try to set a low value, such as three seconds. In LAN environments, you can use a value of 0 to turn off the negative cache.

For more information about this setting, see [Settings for minimizing periodic WAN traffic](https://support.microsoft.com/help/819108).

### Method 5

Configure the `Kerberos` registry setting to a value that is safely beyond the time that is required allow DC connectivity. Use the following settings as guidelines.

> [!NOTE]
> This setting applies only to Windows XP and Windows Server 2003 or earlier versions of these systems. Windows Vista and Windows Server 2008 and later versions use a default value of **0**. This value turns off User Datagram Protocol (UDP) functionality for the Kerberos client.

> Registry subkey: HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\Kerberos\Parameters  
Value name: MaxPacketSize  
Data Type: REG_DWORD  
Value Data: 1  
Default: (depends on the system version)

For more information, see [How to force Kerberos to use TCP instead of UDP in Windows](https://support.microsoft.com/help/244474).

### Method 6

Disable media sense for TCP/IP by adding the following value to the `Tcpip` registry subkey:

> Registry subkey: HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters  
Value Name: DisableDHCPMediaSense  
Data Type: REG_DWORD  
Value Data: 1  
Value Range: Boolean ( 0 =False, 1 =True)  
Default: 0 (False)

For more information, see [How to disable the Media Sensing feature for TCP/IP in Windows](https://support.microsoft.com/help/239924).

### Method 7

Group Policy has policy settings to control the wait time for startup policy processing:

1. Corporate LAN or WLAN:

    > Policy Folder: "Computer Configuration\Administrative Templates\System\Group Policy\"  
    > Policy Name: "Specify startup policy processing wait time"

2. External LAN or WLAN:

    > Policy Folder: "Computer Configuration\Administrative Templates\System\Group Policy\"  
    > Policy Name: "Specify workplace connectivity wait time for policy processing"

The time it takes Netlogon to acquire a working IP can be the basis for the setting. For Direct Access scenarios, you can measure the typical delay your user base has until the connection is established.

### Method 8

If `DisabledComponents` registry setting is in place and has an incorrect value of **0xfffffff**, either delete the key or change it to the intended value of **0xff**.

> [!IMPORTANT]
> Internet Protocol version 6 (IPv6) is a mandatory part of Windows Vista and later versions of Windows. We do not recommend that you disable IPv6 or its components. If you do, some Windows components may not function. Additionally, system startup will be delayed for five seconds if IPv6 is disabled incorrectly by setting the `DisabledComponents` registry setting to a value of **0xfffffff**. The correct value is **0xff**.

### Method 9

The behavior may be caused by a race condition between network initialization, locating a Domain Controller and processing Group Policy. If the network isn't available, a Domain Controller won't be located, and Group Policy processing will fail. Once the operating system has loaded and a network link is negotiated and established, background refresh of Group Policy will succeed.

You can set a registry value to delay the application of Group Policy:

1. Start Registry Editor.
2. Locate and select the following subkey:  
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`

3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
4. Type *GpNetworkStartTimeoutPolicyValue*.
5. Right-click the `GpNetworkStartTimeoutPolicyValue` registry entry, and then select **Modify**.
6. Under **Base**, select **Decimal**.
7. In the **Value data** box, type *60*, and then select **OK**.
8. Exit Registry Editor, and then restart the computer.
9. If the Group Policy startup script doesn't run, increase the value of the `GpNetworkStartTimeoutPolicyValue` registry entry.

## More information

If you can log on to the domain without a problem, you can safely ignore event ID 5719. Because the Netlogon service may start before the network is ready, the computer may be unable to locate the logon domain controller. Therefore, event ID 5719 is logged. After the network is ready, the computer will try again to locate the logon domain controller. In this situation, the operation should be successful.

In a Netogon.log, entries that resemble the following example may be logged:

```output
DateTime [CRITICAL] <domain>: NlDiscoverDc: Cannot find DC. DateTime [CRITICAL] <domain>: NlSessionSetup: Session setup: cannot pick trusted DC DateTime [MISC] Eventlog: 5719 (1)"<domain>" 0xc000005e ... DateTime [SESSION] WPNG: NlSetStatusClientSession: Set connection status to c000005e ... DateTime [SESSION] \Device\NetBT_Tcpip_{4A47AF53-40D3-4F92-ACDF-9B5E82A50E32}: Transport Added (10.0.64.232) -> Getting a proper IP address takes >15 seconds.
```

Similar errors might be reported by other components that require Domain Controller connectivity to function correctly. For example, the Group Policy may not be applied at system startup. In this case, startup scripts don't run. The Group Policy failures may be related to the failure of Netlogon to locate a domain controller. You can set Group Policy to be more responsive to late network connectivity arrival.
