---
title: SMB sharing not accessible when TCP port 445 listening in Windows Server
description: Provides a solution to an issue where Server Message Block (SMB) sharing is not accessible when TCP port 445 is listening in Windows Server.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, dantes
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# SMB sharing is not accessible when TCP port 445 is listening in Windows Server

This article provides a solution to an issue where you can't access a Server Message Block (SMB) shared resource even when the shared resource is enabled in the target Windows Server.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 4471134

## Symptoms

You can't access a Server Message Block (SMB) shared resource even when the shared resource is enabled on the target Windows Server. When you run the netstat command to show the network connections, the results show that TCP port 445 is listening. However, network traces show that communication on TCP port 445 is failing as follows:

|Source|Destination|Protocol|Description|
|---|---|---|---|
|Client|SERVER|TCP|TCP:Flags=......S., SrcPort=62535, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=4085616235, Ack=0, Win=8192 (Negotiating scale factor 0x8) = 8192|
|Client|SERVER|TCP|TCP:[**SynReTransmit** #600]Flags=......S., SrcPort=62535, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=4085616235, Ack=0, Win=8192 (Negotiating scale factor 0x8) = 8192|
|Client|SERVER|TCP|TCP:[**SynReTransmit** #600]Flags=......S., SrcPort=62535, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=4085616235, Ack=0, Win=8192 (Negotiating scale factor 0x8) = 8192|
  
After you enable the [auditing](/windows/desktop/FWP/auditing-and-logging) of Filtering Platform Policy Change events by using the following command, you may experience some events (such as event ID 5152) that indicate blocking.

```console
auditpol /set /subcategory:"Filtering Platform Packet Drop" /success:enable /failure:enable
```

**Example of event ID 5152:**

|Event log|Event source|Event ID|Message text|
|---|---|---|---|
|Security|Microsoft-Windows-Security-Auditing|5152|Description:<br/>The Windows Filtering Platform has blocked a packet.<br/><br/>Application Information:<br/>Process ID: 0<br/>Application Name: -<br/>Network Information:<br/>Direction: Inbound<br/>Source Address: 192.168.88.50<br/>Source Port: 52017<br/>Destination Address: 192.168.88.53<br/>Destination Port: 445<br/>Protocol: 6Filter Information:<br/>Filter Run-Time ID: 67017<br/>Layer Name: Transport<br/>Layer Run-Time ID: 12|
  
## Cause

This issue occurs because the Adylkuzz malware that leverages the same SMBv1 vulnerability as Wannacrypt adds an IPSec policy that's named _NETBC_ that blocks incoming traffic on the SMB server that's using TCP port 445. Some Adylkuzz-cleanup tools can remove the malware but fail to delete the IPSec policy. For details, see [Win32/Adylkuzz.B](https://www.microsoft.com/en-US/wdsi/threats/malware-encyclopedia-description?Name=Trojan:Win32/Adylkuzz.B).

## Resolution

To fix this issue, follow these steps:

1. Install the [security update MS17-010](/security-updates/SecurityBulletins/2017/ms17-010) version appropriate to the operating system.
2. Follow the steps on the "What to do now tab" of [Win32/Adylkuzz.B](https://www.microsoft.com/en-US/wdsi/threats/malware-encyclopedia-description?Name=Trojan:Win32/Adylkuzz.B).
3. Run a scan by using the [Microsoft Security Scanner](/windows/security/threat-protection/intelligence/safety-scanner-download).
4. Check whether the IPSec policy blocks the TCP port 445 by using the following commands (and see the cited results for examples).

    ```console
    netsh ipsec static show policy all
    ```

    ```output
    Policy Name: netbc  
    Description: NONE  
    Last Modified: <DateTime>  
    Assigned: YES  
    Master PFS: NO  
    Polling Interval: 180 minutes
    ```

    ```console
    netsh ipsec static show filterlist all level=verbose
    ```

    ```output
    FilterList Name: block  
    Description: NONE  
    Store: Local Store <WIN>  
    Last Modified: <DateTime>  
    GUID: {ID}  
    No. of Filters: 1  
    Filter(s)  
    ---------  
    Description: 445  
    Mirrored: YES  
    Source IP Address: <IP Address>  
    Source Mask: 0.0.0.0  
    Source DNS Name: <IP Address>  
    Destination IP Address: <IP Address>  
    Destination DNS Name: <IP Address>  
    Protocol: TCP  
    Source Port: ANY  
    Destination Port : 445  
    ```

    > [!NOTE]
    > When you run the commands on an uninfected server, there is no policy.

5. If the IPSec policy exists, delete it by using one of the following methods.

    - Run the following command:

        ```console
        netsh ipsec static delete policy name=netbc
        ```

    - Use Group Policy Editor (GPEdit.msc):

        Local Group Policy Editor/Computer Configuration/Windows Settings/Security Settings/IPSec Security

## More information

Since October 2016, Microsoft has been using a new servicing model for the supported versions of Windows Server updates. This new servicing model for distributing updates simplifies the way that security and reliability issues are addressed. Microsoft recommends keeping your systems up-to-date to make sure that they are protected and have the latest fixes applied.

This threat can run the following commands:

```console
netsh ipsec static add policy name=netbc
netsh ipsec static add filterlist name=block
netsh ipsec static add filteraction name=block action=block
netsh ipsec static add filter filterlist=block any srcmask=32 srcport=0 dstaddr=me dstport=445 protocol=tcp description=445
netsh ipsec static add rule name=block policy=netbc filterlist=block filteraction=block
netsh ipsec static set policy name=netbc assign=y
```

It can also add firewall rules to allow connections by using these commands:

```console
netsh advfirewall firewall add rule name="Chrome" dir=in program="C:\Program Files (x86)\Google\Chrome\Application\chrome.txt" action=allow
netsh advfirewall firewall add rule name="Windriver" dir=in program="C:\Program Files (x86)\Hardware Driver Management\windriver.exe" action=allow
```
