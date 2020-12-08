---
title: Error message when you try to access a server locally by using its FQDN or its CNAME alias after you install Windows Server 2003 Service Pack 1: 
description: Describes a problem where you may receive an error message when you try to access a server locally by using its FQDN or its CNAME alias after you install Windows Server 2003 Service Pack 1.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: renatewi, Waltere
---
# Error message when you try to access a server locally by using its FQDN or its CNAME alias after you install Windows Server 2003 Service Pack 1: "Access denied" or "No network provider accepted the given network path"

> [!IMPORTANT]
> This article contains information that shows you how to help lower security settings or how to turn off security features on a computer. You can make these changes to work around a specific problem. Before you make these changes, we recommend that you evaluate the risks that are associated with implementing this workaround in your particular environment. If you implement this workaround, take any appropriate additional steps to help protect your system. 

_Original product version:_ &nbsp; Microsoft Windows Server 2003 Service Pack 1, Microsoft Windows Server 2003 Service Pack 2, Windows Server 2008 Standard, Windows Server 2008 Enterprise, Windows Server 2008 R2 Standard, Windows Server 2008 R2 Enterprise, Windows Vista Business, Windows Vista Enterprise, Windows Vista Ultimate, Windows 7 Professional, Windows 7 Enterprise, Windows 7 Ultimate  
_Original KB number:_ &nbsp; 926642

## Symptoms

Consider the following scenario. You install Microsoft Windows Server 2003 Service Pack 1 (SP1) on a Windows Server 2003-based computer. After you do this, you experience authentication issues when you try to access a server locally by using its fully qualified domain name (FQDN) or its CNAME alias in the following Universal Naming Convention (UNC) path:\\ **servername** \ **sharename**  
In this scenario, you experience one of the following symptoms:

- You receive repeated logon windows.
- You receive an "Access denied" error message.
- You receive a "No network provider accepted the given network path" error message.
- Event ID 537 is logged in the Security event log.> [!NOTE]
> You can access the server by using its FQDN or its CNAME alias from another computer in the network other than this computer on which you installed Windows Server 2003 SP1. Additionally, you can access the server on the local computer by using the following paths:
- \\ **IPaddress-of-local-computer**  
- \\ **Netbiosname** or \\ **ComputerName** 

## Cause

This problem occurs because Windows Server 2003 SP1 includes a new security feature named loopback check functionality. By default, loopback check functionality is turned on in Windows Server 2003 SP1, and the value of the DisableLoopbackCheck registry entry is set to 0 (zero).

> [!NOTE]
> The loopback check functionality is stored in the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\DisableLoopbackCheck` 

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

> [!WARNING]
> This workaround may make your computer or your network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend this workaround but are providing this information so that you can implement this workaround at your own discretion. Use this workaround at your own risk. 

To resolve this problem, set the DisableStrictNameChecking registry entry to 1. This procedure is described in the Knowledge Base article 281308 that is mentioned in the "References" section. Then use either of the following methods, as appropriate for your situation.

#### Method 1 (recommended): Create the Local Security Authority host names that can be referenced in an NTLM authentication request

To do this, follow these steps for all the nodes on the client computer:

1. Click **Start**, click **Run**, type regedit , and then click **OK**.

2. Locate and then click the following registry subkey:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0` 
3. Right-click **MSV1_0**, point to
 **New**, and then click **Multi-String Value**.

4. In the **Name** column, type
 BackConnectionHostNames , and then press ENTER.

5. Right-click **BackConnectionHostNames**, and then click **Modify**.
6. In the **Value** data box, type the CNAME or the DNS alias, that is used for the local shares on the computer, and then click **OK**.

> [!NOTE]
> Type each host name on a separate line.

> [!NOTE]
> If the BackConnectionHostNames registry entry exists as a REG_DWORD type, you have to delete the BackConnectionHostNames registry entry.
7. Exit Registry Editor, and then restart the computer.

#### Method 2: Disable the authentication loopback check

Re-enable the behavior that exists in Windows Server 2003 by setting the DisableLoopbackCheck registry entry in the
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa registry` subkey to 1. To set the DisableLoopbackCheck registry entry to 1, follow these steps on the client computer:

1. Click **Start**, click **Run**, type regedit , and then click **OK**.

2. Locate and then click the following registry subkey:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa` 
3. Right-click **Lsa**, point to
 **New**, and then click **DWORD** Value.
4. Type DisableLoopbackCheck , and then press ENTER.
5. Right-click **DisableLoopbackCheck**, and then click **Modify**.
6. In the **Value data** box, type
 1 , and then click **OK**.
7. Exit Registry Editor.
8. Restart the computer.> [!NOTE]
> You must restart the server for this change to take effect. By default, loopback check functionality is turned on in Windows Server 2003 SP1, and the DisableLoopbackCheck registry entry is set to 0 (zero). The security is reduced when you disable the authentication loopback check, and you open the Windows Server 2003 server for man-in-the-middle (MITM) attacks on NTLM.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. 

## More Information

After you install security update 957097, applications such as SQL Server or Internet Information Services (IIS) may fail when making local NTLM authentication requests.

For more information about how to resolve this issue, click the following article number to view the article in the Microsoft Knowledge Base:

[957097](https://support.microsoft.com/help/957097) MS08-068: Vulnerability in SMB could allow remote code execution  

See the "Known issues with this security update" section of KB article 957097 for details about how to resolve the issue.
 For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[281308](https://support.microsoft.com/help/281308) Connecting to SMB share on a Windows 2000-based computer or a Windows Server 2003-based computer may not work with an alias name
