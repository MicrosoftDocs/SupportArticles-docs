---
title: Can't access SMB file server
description: Describes an issue that blocks SMB file server share access to files and other resources through the DNS CNAME alias in some scenarios and successful in other scenarios. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, waltere, nedpyle
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# SMB file server share access is unsuccessful through DNS CNAME alias

This article provides solutions for the issue that DNS CNAME alias can't access SMB file servers.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 3181029

## Symptoms

Configuration

- You're running an SMB file server, such as Windows Server. The server has files and resources that are configured by using their NetBIOS name, the DNS fully qualified domain name (FQDN), and their alias (CNAME).
- You have a client that's running Windows 7, Windows Server 2008 R2, or a later version of Windows.

Scenarios

- When an application or user uses the actual storage name (the NetBIOS name or the FQDN) for files or other resources on the server that's using SMB, access is successful.
- When an application or user uses the CNAME alias for files or other resources on the server that's using SMB, and you try to connect to a share on the file server with its DNS CNAME alias. For example, you try to connect to a share on the file server by using its DNS CNAME alias:

  ```console
  NET USE * \\CNAME\share_name
  ```

  In this case, you experience the following behaviors:

  - Access from a Windows Server 2008 R2 or Windows 7 client is successful.
  - Access from a Windows Server 2012 R2, Windows 8.1, or a later version of Windows client is unsuccessful. In this case, you receive an error message that resembles the following one:
  
    > Open Folder
    >
    > \\\\**uncpath** is not accessible. You might not have permission to use this network resource. Contact the administrator of this server to find out if you have access permissions.
    >
    > Logon Failure: The target account name is incorrect.

## Cause

- If you use Network Monitor, Wire Shark, or Microsoft Message Analyzer to examine the network trace when the SMB Session Setup is successful, the session goes to the TREE Connect.

  However, if you examine the network trace when the SMB Session Setup is unsuccessful, the session fails with a Kerberos KRB_AP_ERR_MODIFIED error. Here's an example of an unsuccessful SMB Session Setup request in a network trace:

  ```output
  MessageNumber DiagnosisTypes Timestamp Source Destination Module Summary  
  112 None DateTime Client Server SMB2 Negotiate, Status: Success, 2780879Guid: {12f74af4-be82-11e5-b5c2-005056890096}, DialectRevision: SMB 2.  
  112 None DateTime Client Server SMB2 NegotiateRequest, Dialects: [SMB 2.0.2, SMB 2.1], Capabilities: , 2780879Guid: {12f74af4-be82-11e5-b5c2-  
  115 None DateTime Server Client SMB2 NegotiateResponse, Status: Success, DialectRevision: SMB 2.1, Capabilities: SMB2GlobalCapDfs|SMB2GlobalC  
  116 None DateTime Client Server SMB2 SessionSetup, Status: STATUS_MORE_PROCESSING_REQUIRED, Kerberos, Flags: 0  
  116 None DateTime Client Server SMB2 SessionSetupRequest, Kerberos, Flags: Unknown(0), PreviousSessionId: 0x0000000000000000  
  122 None DateTime Server Client SMB2 SessionSetupResponse, Status: STATUS_MORE_PROCESSING_REQUIRED, Kerberos, SessionId: 0x000004030800006D  
  135 None DateTime Client Server SMB2 SessionSetup, Status: STATUS_MORE_PROCESSING_REQUIRED, Kerberos, Flags: 0  
  135 None DateTime Client Server SMB2 SessionSetupRequest, Kerberos, Flags: Unknown(0), PreviousSessionId: 0x0000000000000000  
  143 None DateTime Server Client SMB2 SessionSetupResponse, Status: STATUS_MORE_PROCESSING_REQUIRED, Kerberos, SessionId: 0x000004030800006D
  ```

  In an unsuccessful SMB Session Setup request, the client forwards an incorrect CNAME SPN. The SPN may be incorrect because it's registered for an old server. However in a successful SMB Session Setup request such as in the Windows Server 2008 R2 client case, the client forwards the SPN for the actual server name.

- If the file server name was resolved through DNS, the SMB client appends the DNS suffix to the user-supplied name. That is, the first component of the SPN will always be the user supplied name as in the following example:

  ```console
  CNAME.contoso.com\share_name
  ```

  > [!NOTE]
  > This try would fail on older SMB implementations (Like AIX Samba 3.5.8), that cannot be configured for Kerberos authentication and does not listen to SMB direct host port 445, but only on NetBIOS port 139.

- If the file server name was resolved through some other mechanism such as
  
  - NetBIOS
  - Link-Local Multicast Name Resolution (LLMNR)
  - Peer Name Resolution Protocol (PNRP) processes
  
  the SMB client uses the user supplied name such as the following one:

  ```console
  CNAME\share_name
  ```

## Resolution

To resolve this issue on a file server that is running the SMB version 1 protocol, add the `DisableStrictNameChecking` value to the registry:

> Registry location: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters  
DWORD name: DisableStrictNameChecking  
DWORD value: 1

> [!IMPORTANT]
> Do not use DNS CNAMEs in the future for file servers. If you want to still give alternate names to servers, you can do so with the following command:  
> NETDOM COMPUTERNAME/ADD
>
> This command automatically registers SPNs for the alternate names.

We don't recommend that you resolve this issue for a file server that isn't Windows-based by typing the following commands in an elevated Command Prompt window on a Windows-based computer. You would have to be logged on with Domain Administrator credentials. Then press Enter at the command prompt to register the SPN for the CNAME of the non-Windows-based File Server storage device:

```console
SETSPN -a host/alias_name targetserver
SETSPN -a host/alias_name.contoso.com targetserver
```

> [!NOTE]
>
> - If you use Windows 2012 Clustering, install the hotfix for down-level clients in which Windows XP or Windows Server 2003 computers cannot connect: [Can't access a resource that is hosted on a Windows Server 2012-based failover cluster](https://support.microsoft.com/help/2838043).
> - If you create a CNAME for the clustered name the clients are connecting to, you have to make sure that you set the properties on that Clustered name so that it responds to the CNAMEs:
 [How to configure an alias for a clustered SMB share with Windows Server 2012](https://techcommunity.microsoft.com/t5/failover-clustering/how-to-configure-an-alias-for-a-clustered-smb-share-with-windows/ba-p/371737).

## Network trace

To collect a network trace, follow these steps:

1. Open an elevated Command Prompt window, type the following command, and then press Enter:

    ```console
    netsh trace start NetConnection capture=yes maxsize=100 filemode=circular overwrite=yes traceFile=c:\%COMPUTERNAME%_Repro_trace.etl
    ```

2. Delete any existing File Server network connections by running the following command:

    ```console
    NET USE * /DELETE
    ```

3. Initialize all name caching by deleting the existing cache:
   1. To delete the DNS cache, type the following command, and then press Enter:

      ```console
      IPCONFIG /FLUSHDNS
      ```

   2. To delete the NetBIOS cache, type the following command, and then press Enter:

      ```console
      NBTSTAT /RR
      ```

   3. To delete the Kerberos cache, type the following command, and then press Enter:

      ```console
      KLIST /PURGE
      ```

   4. To delete the ARP cache, type the following command, and then press Enter:

      ```console
      ARP -d
      ```

4. Try to connect to the network share by typing the following command and then pressing Enter:

    ```console
    NET USE * \\server_name\share_name
    ```

5. To stop the network trace in an unsuccessful scenario, type the following command, and then press Enter:

    ```console
    netsh trace stop
    ```

## Collect registry settings

To collect registry settings on the file server, select **Start**, select **Run**, type the command in the Open box, and then select **OK**. Repeat this step for the following commands:

```console
REG.EXE SAVE HKLM\SYSTEM C:\TEMP\%COMPUTERNAME%_SYSTEM.HIV
REG.EXE SAVE HKLM\SOFTWARE C:\TEMP\%COMPUTERNAME%_SOFTWARE.HIV
REG.EXE SAVE HKCU\Software C:\TEMP\%COMPUTERNAME%_HKCU.HIV
```

> [!NOTE]
> The registry setting files (.HIV) are saved to the TEMP folder on the file server.

## Check registry settings

Check the settings of the following registry values on the file server:

```console
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters\SmbServerNameHardeningLevel
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters\DisableStrictNameChecking
```

## Apply hotfixes (server and client)

For Windows 7 and Windows Server 2008 R2, apply the following Windows 7 Enterprise hotfix rollup:

[An enterprise hotfix rollup is available for Windows 7 SP1 and Windows Server 2008 R2 SP1](https://support.microsoft.com/help/2775511)

Additionally, apply the following hotfixes:

- ["Delayed write failed" error message when .pst files are stored on a network file server that is running Windows Server 2008 R2](https://support.microsoft.com/help/2732673)
- [You experience a long logon time when you try to log on to a Windows 7-based or a Windows Server 2008 R2-based client computer that uses roaming profiles](https://support.microsoft.com/help/2728738)
- [OpsMgr 2012 or OpsMgr 2007 R2 generates a "Heartbeat Failure" message and then goes into a greyed out state in Windows Server 2008 R2 SP1](https://support.microsoft.com/help/2878378)

## References

- [Error message when you try to access a server locally by using its FQDN or its CNAME alias after you install Windows Server 2003 Service Pack 1: "Access denied" or "No network provider accepted the given network path"](https://support.microsoft.com/help/926642)
- [MS08-068: Vulnerability in SMB could allow remote code execution](https://support.microsoft.com/help/957097)
- [Can't access a resource that is hosted on a Windows Server 2012-based failover cluster](https://support.microsoft.com/help/2838043)
- [List of currently available hotfixes for the File Services technologies in Windows Server 2008 and in Windows Server 2008 R2](https://support.microsoft.com/help/2473205)
- [List of currently available hotfixes for the File Services technologies in Windows Server 2012 and in Windows Server 2012 R2](https://support.microsoft.com/help/2899011)
- [Add DisableStrictNameChecking registry key](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff660057(v=ws.10))
- [DisableStrictNameChecking; server alias doesn't work from the actual server](https://social.technet.microsoft.com/forums/windowsserver/94f9b04f-e0a4-41a7-bbf3-b68e9a4c98db/disablestrictnamechecking-server-alias-does-not-work-from-the-actual-server)
- [Why do we need SPN for File Server (NAS / RAS / File Share System) DNS Alias (Cname)](/archive/blogs/sqlserverfaq/why-do-we-need-spn-for-file-server-nas-ras-file-share-system-dns-alias-cname)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
