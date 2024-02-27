---
title: Troubleshooting AD Replication error 1818
description: Describes an issue where AD operations fail with error 1818 (The remote procedure call was cancelled (RPC_S_CALL_CANCELLED)).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Troubleshooting AD Replication error 1818: The remote procedure call was cancelled

This article describes an issue where Active Directory Replications fail with error 1818: The remote procedure call was cancelled (RPC_S_CALL_CANCELLED).

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).  

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2694215

## Symptoms

This article describes the symptoms, cause, and resolution steps when Active Directory replication fails with error 1818: The remote procedure call was cancelled (RPC_S_CALL_CANCELLED).

1. Possible formats for the error include:

    |Decimal|Hex|Symbolic|Error string|
    |---|---|---|---|
    |1818|0x71a|RPC_S_CALL_CANCELLED|The remote procedure call was cancelled.|

2. The following events get logged

    |Event Source|Event ID|Event String|
    |---|---|---|
    |NTDS Replication|1232|Active Directory attempted to perform a remote procedure call (RPC) to the following server. The call timed out and was cancelled.|
    |NTDS Replication|1188|A thread in Active Directory is waiting for the completion of a RPC made to the following domain controller.<br/>Domain controller:<br/>b8b5a0e4-92d5-4a88-a601-61971d7033af._msdcs.Contoso.com<br/>Operation:<br/>get changes<br/>Thread ID:<br/>448<br/>Timeout period (minutes):<br/>5<br/>Active Directory has attempted to cancel the call and recover this thread.<br/>User Action<br/>If this condition continues, restart the domain controller.|
    |<br/>NTDS Replication|1173 with error status 1818|Internal event: Active Directory has encountered the following exception and associated parameters. Exception: e0010002 Parameter: 0 Additional Data Error value: 1818 Internal ID: 5000ede|
    |NTDS Replication|1085 with error status 1818|Internal event: Active Directory could not synchronize the following directory partition with the domain controller at the following network address.<br/>Directory partition: \<NC><br/>Network address: \<GUID-based DC name><br/>If this error continues, the Knowledge Consistency Checker (KCC) will reconfigure the replication links and bypass the domain controller.<br/>User Action<br/>Verify that the network address can be resolved with a DNS query.<br/>Additional Data Error value: 1818 The remote procedure call was cancelled.|

    . `Repadmin /showreps` displays the following error message

    > _DC=Contoso,DC=com_  
    >
    > *\<Sitename>\\\<DCname> via RPC DC*  
    >
    > *DC object GUID: \<GUID> Last attempt @ 2009-11-25 10:56:55 failed, result 1818 (0x71a): Can't retrieve message string 1818*  
    >
    > _(0x71a), error 1815. 823 consecutive failure(s). Last success @ (never)._  

3. `Repadmin /showreps` from Domain Controller Name shows that it's failing to pull Domain NC from \<SiteName> but can pull all other NCs

    > \===================  
    >
    > *\<Sitename>\\\<DC name>*  
    >
    > _DC Options: IS_GC_  
    >
    > _Site Options: IS_INTER_SITE_AUTO_TOPOLOGY_DISABLED_  
    >
    > *DC object GUID: \<GUID>*  
    >
    > *DC invocationID: \<InvocationID>*  
    >
    > _==== INBOUND NEIGHBORS =====================================_  
    >
    > _DC=Contoso,DC=com_  
    >
    > *\<Sitename>\\\<DCname> via RPC DC*  
    >
    > *DC object GUID: \<GUID>*  
    >
    > *Last attempt @ \<DateTime> failed, result 1818 (0x71a):*  
    >
    > _Can't retrieve message string 1818 (0x71a), error 1815. 123 consecutive_  
    >
    > _failure(s). Last success @ (never)._  

4. DCPromo may fail while promoting a new domain controller and you'll see the following error on the DCPROMO GUI

    > Active Directory Installation wizard.
    >
    > The Operation Failed because:
    Active Directory could not replicate the directory partition  
    CN=Configuration....from the remote domain controller "server name"  
    " The remote procedure call was cancelled "

    The following entries will be logged in the DCPROMO logs

    > *\<DateTime> [INFO] EVENTLOG (Informational): NTDS General / Service Control : 1004*  
    >
    > _Active Directory Domain Services was shut down successfully._  
    >
    >  
    >
    > *\<DateTime> [INFO] NtdsInstall for \<FQDN fo the domain> returned 1818*  
    >
    > *\<DateTime> [INFO] DsRolepInstallDs returned 1818*  
    >
    > *\<DateTime> [ERROR] Failed to install to Directory Service (1818)*  
    >
    > *\<DateTime> [ERROR] DsRolepFinishSysVolPropagation (Abort Promote) failed with 8001*  
    >
    > *\<DateTime> [INFO] Starting service NETLOGON*  
    >
    > *\<DateTime> [INFO] Configuring service NETLOGON to 2 returned 0*  
    >
    > *\<DateTime> [INFO] The attempted domain controller operation has completed*  
    >
    > *\<DateTime> [INFO] DsRolepSetOperationDone returned 0*  

5. While trying to rehost a partition on the Global catalog

    > _repadmin /rehost fail with DsReplicaAdd failed with status_  
    >
    > _1818 (0x71a)>_
    >
    > _DsReplicaAdd fails with status 1818 (0x71a)_  

## Cause

The issue occurs when the destination DC performing inbound replication doesn't receive replication changes within the number of seconds specified in the "RPC Replication Timeout" registry key. You might experience this issue most frequently in one of the following situations:

- You promote a new domain controller into the forest by using the Active Directory Installation Wizard (Dcpromo.exe).
- Existing domain controllers replicate from source domain controllers that are connected over slow network links.

The default value for the RPC Replication Timeout (mins) registry setting on Windows 2000-based computers is 45 minutes. The default value for the RPC Replication Timeout (mins) registry setting on Windows Server 2003-based computers is 5 minutes. When you upgrade the operating system from Windows 2000 to Windows Server 2003, the value for the RPC Replication Timeout (mins) registry setting is changed from 45 minutes to 5 minutes. If a destination domain controller that is performing RPC-based replication doesn't receive the requested replication package within the time that the RPC Replication Timeout (mins) registry setting specifies, the destination domain controller ends the RPC connection with the non-responsive source domain controller and logs a Warning event.

Some specific root causes for Active Directory logging `1818 \ 0x71a \ RPC_S_CALL_CANCELLED` include:

1. An old Network Interface Card driver installed on Domain Controllers could cause failure of a few network features like Scalable Networking Pack (SNP)
2. Low bandwidth or network packets drops between source and destination domain controllers.
3. The networking device between source and destination device dropping packets.  

> [!Note]
> A speed and duplex mismatch between the NIC and switch on a domain controller could cause dropped frames, resets, duplicate acknowledgments, and retransmitted frames.

## Resolution

1. Increase replication time-out adding the key RPC Replication Timeout (mins) on `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`

    - Start Registry Editor.

    - Locate the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`

    - Right-click Parameters, point to New, and then click DWORD Value.

    - Type RPC Replication Timeout (mins), and then press ENTER to name the new value.

    - Right-click RPC Replication Timeout (mins), and then click Modify.

    - In the Value data box, type the number of minutes that you want to use for the RPC timeout for Active Directory replication, and then click OK.

    On a Windows Server 2003-based computer that is part of a Windows 2000 environment or that was upgraded from Windows 2000 Server, you may want to set this value to 45 minutes. This is value may depend on your network configuration and should be adjusted accordingly.

    > [!NOTE]
    > You must restart the computer to activate any changes that are made to RPC Replication Timeout (mins)

2. Update the network adapter drivers

    To determine whether an updated network adapter driver is available, contact the network adapter manufacturer or the original equipment manager (OEM) for the computer. The driver must meet Network Driver Interface Specification (NDIS) 5.2 or a later version of this specification.

    - To manually disable RSS and TCP Offload yourself, follow these steps:

    - Click Start, click Run, type regedit, and then click OK.

    - Locate the following registry subkey:  
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`

    - Right-click EnableTCPChimney, and then click Modify.

    - In the Value data box, type 0, and then click OK.

    - Right-click EnableRSS, and then click Modify.

    - In the Value data box, type 0, and then click OK.

    - Right-click EnableTCPA, and then click Modify.

    - In the Value data box, type 0, and then click OK.

    - Exit Registry Editor,

    > [!NOTE]
    > You must restart the computer to activate any changes that are made to EnableTCPChimney.  

3. Enable PMTU Black Hole Detection on the Windows-based hosts that will be communicating over a WAN connection. Follow these steps:

    - Start Registry Editor (`Regedit.exe`).

    - Locate the following key in the registry:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\tcpip\parameters`

    - On the Edit menu, click Add Value, and then add the following registry value:

    > Value Name: EnablePMTUBHDetect  
    Data Type: REG_DWORD  
    Value: 1  
    Restart the machine

4. Check the network binding order:

    To configure the network binding order:

    1. Quit any programs that are running.

    2. Right-click Network Neighborhood, and then click Properties.

    3. Click the Bindings tab. In the Show Bindings For box, click All Services.

    4. Double-click each listed service to expand it.

    5. Under each service, double-click each protocol to expand it.

    6. Under each protocol, there's a number of network adapter icons. Click the icon for your network adapter, and then click Move Up until the network adapter is at the top of the list. Leave the "Remote Access WAN Wrapper" entries in any order under the network adapter(s).

        > [!NOTE]
        > If you have more than one network adapter, place the internal adapter (with Internet Protocol [IP] address 10.0.0.2 by default on a Small Business Server network) at the top of the binding order, with the external adapter(s) directly below the internal adapter.

        The final order should appear similar to:  
        [1] Network adapter one  
        [2] Network adapter two (if present)  
        [3] Remote Access WAN Wrapper  
        .  
        .  
        .  
        [n] Remote Access WAN Wrapper  

    7. Repeat step 6 for each service in the dialog box.

    8. After you've verified the settings for each service, click All Protocols in the Show Bindings For box. The entry for "Remote Access WAN Wrapper" doesn't have a network adapter listed. Skip this item. Repeat steps 4 through 6 for each remaining protocol.

    9. After you've verified that the bindings are set correctly for all services and protocols, click OK. This initializes the rebinding of the services. When this is complete, you're prompted to restart the computer. Click Yes.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## More information

[Active Directory changes do not replicate](active-directory-changes-not-replicate.md)
