---
title: New functionality in MS DTC service
description: This article describes security-related changes to the Distributed Transaction Coordinator service.
ms.date: 06/11/2025
ms.custom: sap:Distributed Transactions\DTC programming and runtime
ms.topic: article
---

# New functionality in the Distributed Transaction Coordinator service in Windows

This article describes some Windows security-related updates and changes, and how they affect the Microsoft Distributed Transaction Coordinator (MS DTC) service.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 899191

## Summary

Since Windows Server 2003 Service Pack 1 (SP1) and Windows XP Service Pack 2 (SP2), some security-related updates and changes were introduced to Windows and affect the MS DTC service.

These changes can be accessed by using the updated **Security Configuration** dialog box that is available in the Component Services administrative tool.

These changes are made to the default security settings that cause DTC traffic to fail over the network. In this situation, you may receive one or more error messages or error codes.

By modifying the settings in the **Security Configuration** dialog box, you can help control how the DTC service communicates with remote computers over the network.

This article describes new functionality in the MS DTC service in the following operating systems:

- Windows Server 2003 Service Pack 1 (SP1)
- Windows XP Service Pack 2 (SP2)
- Windows Vista
- Windows Server 2008
- Windows 7
- Windows Server 2008 R2
- Windows 8
- Windows Server 2012
- Windows 8.1
- Windows Server 2012 R2

The DTC service coordinates transactions that update two or more transaction-protected resources. Transaction-protected resources include databases, message queues, and file systems. These transaction-protected resources may be located on a single computer or may be distributed between many networked computers.

## Manage network communication by using Security Configuration

In Windows, the DTC service gives you more control over the network communication between computers. By default, all network communication is disabled. The DTC **Security Configuration** dialog box has been enhanced so that you can manage these communication settings. To view the **Security Configuration** dialog box, follow these steps:

1. Start the Component Services administrative tool. To do this, select **Start**, select **Run**, type **dcomcnfg.exe**, and then select **OK**.
2. In the console tree of the Component Services administrative tool, expand **Component Services**, expand **Computers**, right-click **My Computer**, and then select **Properties**.
3. Select the **MSDTC** tab, and then select **Security Configuration**.

## New options in Security Configuration

The following information describes the new options that are available in the **Security Configuration** dialog box. This information also describes the registry entries that are affected by the new options in the **Security Configuration** dialog box.

### Network DTC Access

The **Network DTC Access** check box lets you determine whether the DTC service can access the network. The **Network DTC Access** check box must be selected together with one of the other check boxes under the **Network DTC Access** check box to enable network DTC transactions.

The **Network DTC Access** check box affects the following registry entry:

- Registry path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\Security`
- Value name: `NetworkDtcAccess`
- Value type: REG_DWORD
- Value data: 0 (default)

> [!NOTE]
> On a server cluster, the **Network DTC Access** check box affects a value in the shared cluster registry key under the MS DTC resource registry key. The registry key of the shared cluster for MS DTC is located at the `HKEY_LOCAL_MACHINE\Cluster\Resources\<MSDTC resource GUID>` location.

By default, the value of the `NetworkDtcAccess` registry entry is set to 0. A value of 0 turns off the `NetworkDtcAccess` registry entry. To turn on the `NetworkDtcAccess` registry entry, set this registry value to 1.

### Allow Inbound

The **Allow Inbound** check box lets you determine whether to allow a distributed transaction that originates from a remote computer to run on the local computer. By default, this setting is turned off. To enable this setting, click to select the **Network DTC Access** check box to set the following registry entry to 1:

- Registry path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\Security`
- Value name: `NetworkDtcAccess`
- Value type: REG_DWORD

To disable this setting, click to clear the **Network DTC Access** check box to set this registry entry to 0.

The **Allow Inbound** check box affects both of the following REG_DWORD registry entries under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\Security`:

- `NetworkDtcAccessTransactions`
- `NetworkDtcAccessInbound`

### Allow Outbound

The **Allow Outbound** check box lets you determine whether to allow the local computer to initiate a transaction and run that transaction on a remote computer. To enable this setting, select the **Network DTC Access** check box to set the following registry entry to 1:

- Registry path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\Security`
- Value name: `NetworkDtcAccess`
- Value type: REG_DWORD

To disable this setting, clear the **Network DTC Access** check box to set this registry entry to 0.

The **Allow Outbound** check box affects both of the following REG_DWORD registry entries under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\Security`:

- `NetworkDtcAccessTransactions`
- `NetworkDtcAccessOutbound`

### Mutual Authentication Required

The **Mutual Authentication Required** option adds support for mutual authentication in Windows. **Mutual Authentication Required** sets the greatest security mode that is currently available for network communication. We recommend this transaction mode for client computers that are running Windows XP SP2 together with server computers that are running Windows Server 2003 SP1.

**Mutual Authentication Required** affects the following registry entries under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC`:

- Registry key 1

  - Value name: `AllowOnlySecureRpcCalls`
  - Value type: REG_DWORD
  - Value data: 1

- Registry key 2

  - Value name: `FallbackToUnsecureRPCIfNecessary`
  - Value type: REG_DWORD
  - Value data: 0

- Registry key 3

  - Value name: `TurnOffRpcSecurity`
  - Value type: REG_DWORD
  - Value data: 0

The functionality that is set by using **Mutual Authentication Required** differs from the functionality that is set by using **Incoming Caller Authentication Required**. The three options that are listed under **Transaction Manager Communication** behave as follows:

- The **Mutual Authentication Required** transaction mode requires the remotely accessing component to provide an authenticated connection with the local computer. This authentication is verified by impersonation on the local computer. Additionally, if the remote access communication is performed between two DTC services, this authentication information must specify a computer account that matches the remote transaction mode computer's host name.

- The **Incoming Caller Authentication Required** transaction mode only requires the remote connection to be authenticated. Additionally, if the remotely accessing component is a DTC service, the authentication information must be for a computer account.

- The **No Authentication Required** transaction mode does not validate an authenticated connection or verify whether an authenticated connection is being established.

In a clustered environment, the computer account for the DTC service specifies the cluster node's host name. In a clustered environment, the DTC authentication does not use the transaction mode's host name. In a clustered environment, the transaction mode's host name is the name of the virtual service. Therefore, you cannot use the **Mutual Authentication Required**  transaction mode in a clustered environment, or on any computers that are negotiating transactions with such computers. You can use the **Mutual Authentication Required** transaction mode between two nonclustered computers that are running Windows Server 2003 SP1 or between two computers that are running Windows XP SP2.

Use the **Incoming Caller Authentication Required** transaction mode between Windows Server 2003-based computers in a clustered environment.

Use the **No Authentication Required** transaction mode where one or more of the following conditions are true:

- The network access is between computers that are running Microsoft Windows 2000.
- The network access is between two domains that do not have a mutual trust configured.
- The network access is between computers that are members of a work group.

### Incoming Caller Authentication Required

**Incoming Caller Authentication Required** requires the local DTC service to communicate with a remote DTC service by using only encrypted messages. Only the incoming connection will be authenticated. Only Windows Server 2003 SP1, Windows XP SP2, and later version of Windows support this feature. Therefore, only enable this option if the remote DTC service is running on a computer that is running Windows Server 2003 SP1, Windows XP SP2, or later version of Windows.

**Incoming Caller Authentication Required** affects the following registry entries under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC`:

- Registry key 1

  - Value name: AllowOnlySecureRpcCalls
  - Value type: REG_DWORD
  - Value data: 0

- Registry key 2

  - Value name: FallbackToUnsecureRPCIfNecessary
  - Value type: REG_DWORD
  - Value data: 1

- Registry key 3

  - Value name: TurnOffRpcSecurity
  - Value type: REG_DWORD
  - Value data: 0

For more information about **Incoming Caller Authentication Required**, see the **Mutual Authentication Required** section.

### No Authentication Required

**No Authentication Required** enables operating system compatibility between earlier versions of the Windows operating system. When this option is enabled, network communication between DTC services can fall back to non-authenticated communication or to non-encrypted communication if a secure communication channel cannot be established.

> [!NOTE]
> We recommend that you use this setting if the remote DTC service is running on a computer that is running Microsoft Windows 2000 or on a computer that is running a version of Windows XP that is earlier than Windows XP SP2.

You can also use **No Authentication Required** to resolve a situation where the DTC services are running on computers that are in domains that do not have a trust relationship established. Additionally, you can use **No Authentication Required** to resolve a situation where the DTC services are running on computers that are members of a work group.

**No Authentication Required** affects the following registry entries under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC`:

- Registry key 1

  - Value name: AllowOnlySecureRpcCalls
  - Value type: REG_DWORD
  - Value data: 0

- Registry key 2

  - Value name: FallbackToUnsecureRPCIfNecessary
  - Value type: REG_DWORD
  - Value data: 0

- Registry key 3

  - Value name: TurnOffRpcSecurity
  - Value type: REG_DWORD
  - Value data: 1

> [!NOTE]
> On a server cluster, these registry entries are located in the shared cluster registry.

## Significance of the new options

The new options that are available in the **Security Configuration** dialog box let you apply security settings to outgoing or incoming network communications. By default, after you install Windows, the computer does not accept network traffic. Therefore, the computer is less vulnerable to network access by a malicious user. Additionally, the protocols that are sent over the network are updated to support a more securely encrypted and mutually authenticated communications mode. This helps reduce the chance that a malicious user could intercept and take over communications between DTC services.

## Network communication changes in Windows

The network communication coming out of the DTC service or coming in to the DTC service is disabled. For example, if a COM+ object tries to update a Microsoft SQL Server database that is located on a remote computer by using a DTC transaction, this transaction does not succeed. Conversely, if the computer hosts a SQL Server database that components from a remote computer try to access by using a DTC transaction, this transaction does not succeed.

The following issues are related to the DTC service:

## Transactions fail because of network connectivity issues

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows).

If the DTC transactions fail because of network connectivity issues, click to select the following check boxes in the **Security Configuration** dialog box:

- Click to select the **Network DTC Access** check box.
- Click to select one or both of the following check boxes under **Transaction Manager Communication** depending on your requirements:

  - **Allow Inbound**
  - **Allow Outbound**
  
If you want to programmatically change these settings as part of a Windows, you can directly modify the registry settings that correspond to the settings that you want to set. After you modify the registry settings, you must restart the DTC service.

We recommend that you do not manually modify the registry to change these settings. If you manually modify these registry settings, you may experience issues with the Cluster service on Windows Server 2003 SP1-based server clusters.

## Windows Firewall blocks DTC traffic

> [!IMPORTANT]
> These steps may increase your security risk. These steps may also make the computer or the network more vulnerable to attack by malicious users or by malicious software such as viruses. We recommend the process that this article describes to enable programs to operate as they are designed to or to implement specific program capabilities. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this process in your particular environment. If you decide to implement this process, take any appropriate additional steps to help protect the system. We recommend that you use this process only if you really require this process.

If you use Windows Firewall, you must add the DTC service to the exception list in the Windows Firewall settings. To do this, follow these steps:  

1. Select **Start**, select **Run**, type **firewall.cpl**, and then select **OK**.
2. In the **Windows Firewall** dialog box, select the **Exceptions** tab, and then select **Add Program**.
3. Select **Browse**, locate and then select `C:\Windows\System32\msdtc.exe`, and then select **Open**.
4. Select **OK**, select the **msdtc.exe** check box in the **Programs and Services** list if this check box is not already selected, and then select **OK**.

## Settings that are changed or added

The following table describes the registry entries that are changed since Windows XP SP2 from earlier versions of Windows.

| Entry name |Location |Previous default value|Windows XP SP2 default value |Possible values|
| ----- | ----- |----- |----- |----- |
|NetworkDtcAccess|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\Security`|1|0|0 or 1|
|NetworkDtcAccessTransactions|`KEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\Security`|1|0|0 or 1|
|NetworkDtcAccessInbound|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\Security`|Not applicable|0|0 or 1|
|NetworkDtcAccessOutbound|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\Security`|Not applicable|0|0 or 1|
|AllowOnlySecureRpcCalls|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC`|Not applicable|1|0 or 1|
|FallbackToUnsecureRPCIfNecessary|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC`|Not applicable|0|0 or 1|
|TurnOffRpcSecurity|`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC`|Not applicable|0|0 or 1|
  
> [!NOTE]
> These changes appear in the shared cluster registry on a Windows Server 2003 SP1-based server cluster.

## Error codes that are associated with the DTC service changes

You may receive one of the following error codes when you run DTC transactions between computers:

- Error code 1

    > MessageId: XACT_E_NETWORK_TX_DISABLED  
    > MessageText:  
    > The transaction manager has disabled its support for remote/network transactions.  
    > #define XACT_E_NETWORK_TX_DISABLED       _HRESULT_TYPEDEF_(0x8004D024L)

- Error code 2

    > MessageId: XACT_E_PARTNER_NETWORK_TX_DISABLED  
    > MessageText:  
    > The partner transaction manager has disabled its support for remote/network transactions.  
    > #define XACT_E_PARTNER_NETWORK_TX_DISABLED _HRESULT_TYPEDEF_(0x8004D025L)

## Applies to

- Windows Server 2012 R2
- Windows 8.1
- Windows 8
- Windows 7
- Windows Vista
- Windows Server 2008
- Windows Server 2003
- Windows XP
