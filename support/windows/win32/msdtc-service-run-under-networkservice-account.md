---
title: MSDTC Service must run under NetworkService account
description: This article discusses the Windows account that Microsoft Distributed Transaction Coordinator must run in Windows.
ms.date: 08/27/2020
ms.custom: sap:Distributed transactions
ms.technology: windows-dev-apps-distributed-transactions
---
# The Microsoft Distributed Transaction Coordinator service must run under the NT AUTHORITY\NetworkService Windows account

This article introduces the Windows account that Microsoft Distributed Transaction Coordinator (MSDTC) must run in Windows.

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see: [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

_Original product version:_ &nbsp; Windows Server 2012, Windows 8, Windows 7  
_Original KB number:_ &nbsp; 903944

## Summary

On all Windows Client and Server Operating Systems, you may have to restart the MSDTC service to perform these steps. To restart the MSDTC service, follow these steps:

1. For Windows 8.1 and Windows 8

    - From the Start screen, swipe in from the right side to display the charms, select **Search**, and then search for *cmd*. (Or, if you are using a keyboard and mouse, type *cmd* at the Start screen.) In the search results, press-and-hold or right-click Command Prompt, and then select **Run as Administrator**.

    For Windows 7 and earlier versions  
    - Press the Windows logo **key+R**, type *cmd* in the Run box, and then press Enter. Right-click **cmd**, and then select **Run as Administrator**.
2. Type `net stop msdtc` , and then press the **ENTER** button.
3. Type `net start msdtc` , and then press the **ENTER** button.
4. Open the Component Services Microsoft Management Console (MMC) snap-in. To do this, click **Start**, and then click **Run** Type *dcomcnfg.exe*, and then click **OK**.
5. Expand **Component Services**, expand **Computers**, and then expand **My Computer**.
6. Right-click **My Computer**, and then click **Properties**.
7. Click the **MSDTC** tab, and then click **Security Configuration**.
8. Change the account in **DCT Logon Account** to **NT AUTHORITY\NetworkService**. If a password is needed, enter a blank password.
9. Click **OK** two times.

## For Windows XP and Windows Server 2003

Starting in Windows XP and then continuing in Windows Server 2003, the MSDTC service must run under the `NT AUTHORITY\NetworkService` Windows account.

If you change the account to an account other than the NetworkService account, the distributed transaction fails. The transaction fails because the MSDTC service cannot do mutual authentication together with other parties that are involved in the transaction. Local transactions that use the MSDTC service may also fail.

> [!NOTE]
> Other parties can be transaction managers, resource manager, or clients.

In both Microsoft Windows NT 4.0 and Microsoft Windows 2000, you can change the default MSDTC service account to a domain account. You may change the account to perform Windows authentication when you are performing an XA recovery operation on an XA database such as an Oracle database.

However, in Windows Server 2003 and Windows XP, you cannot change the account. Instead, you must give the permissions and the roles that are required to perform an XA recovery operation to the NetworkService account on the computer where the MSDTC service is running.

The exact method of setting up an XA recovery operation is specific to each XA database. Typically, you have to add the computer account of the computer where the MSDTC service is running to the list of users who can perform an XA recovery operation on the XA database. Additionally, because the NetworkService account is a restricted account, you must provide the NetworkService account access to the folder where the XA DLL is located.

To change the account that the MSDTC service runs under back to the NetworkService account, follow these steps.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC`.
  
    If the following entries exist, go to step 6:
   - `TurnOffRpcSecurity`
   - `AllowOnlySecureRpcCalls`
   - `FallbackToUnsecureRPCIfNecessary`
3. Create the `TurnOffRpcSecurity` entry:
   1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
   2. Type *TurnOffRpcSecurity*, and then press ENTER.
4. Create the `AllowOnlySecureRpcCalls` entry:
   1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
   2. Type *AllowOnlySecureRpcCalls*, and then press ENTER.
5. Create the `FallbackToUnsecureRPCIfNecessary` entry:
   1. On the **Edit** menu, point to **New**, and then click **DWORD Value**.
   2. Type *FallbackToUnsecureRPCIfNecessary*, and then press ENTER.
6. Set the DWORD value for the `TurnOffRpcSecurity` entry:
   1. Right-click **TurnOffRpcSecurity**, and then click **Modify**.
   2. In the **Edit DWORD Value** dialog box, type the value *1*, and then click **OK**.
7. Set the DWORD value for the `AllowOnlySecureRpcCalls` entry:
   1. Right-click **AllowOnlySecureRpcCalls**, and then click **Modify**.
   2. In the **Edit DWORD Value** dialog box, type the value *0*, and then click **OK**.
8. Set the DWORD value for the `FallbackToUnsecureRPCIfNecessary` entry:
   1. Right-click **FallbackToUnsecureRPCIfNecessary**, and then click **Modify**.
   2. In the **Edit DWORD Value** dialog box, type the value *0*, and then click **OK**.
  
After you have made the registry changes, you must restart the MSDTC service. To restart the MSDTC service, follow these steps:

1. Click **Start**, click **Run**, type *cmd*, and then click **OK**.
2. Type `net stop msdtc` , and then press ENTER.
3. Type `net start msdtc` , and then press ENTER.
4. Open the Component Services Microsoft Management Console (MMC) snap-in. To do this, click **Start**, click **Run**, type *dcomcnfg.exe*, and then click **OK**.
5. Expand **Component Services**, expand **Computers**, and then expand **My Computer**.
6. Right-click **My Computer**, and then click **Properties**.
7. Click the **MSDTC** tab, and then click **Security Configuration**.
8. Change the account in **DCT Logon Account** to **NT AUTHORITY\NetworkService**. If a password is needed, enter a blank password.
9. Click **OK** two times.

## References

- [New functionality in the Distributed Transaction Coordinator service in Windows](new-functionality-in-msdtc-service.md)
- [Managing Accounts and Privileges](/previous-versions/windows/desktop/ms682801(v=vs.85))

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

## Applies to

- Windows Server 2012 R2 Datacenter
- Windows Server 2012 R2 Standard
- Windows Server 2012 R2 Essentials
- Windows 8.1 Enterprise
- Windows 8.1 Pro
- Windows 8.1
- Windows Server 2012 Datacenter
- Windows Server 2012 Datacenter
- Windows Server 2012 Standard
- Windows Server 2012 Standard
- Windows Server 2012 Essentials
- Windows 8 Enterprise
- Windows 8 Pro
- Windows 8
- Windows Server 2008 R2 Datacenter
- Windows Server 2008 R2 Standard
- Windows Server 2008 R2 Enterprise
- Windows 7 Enterprise
- Windows 7 Professional
- Windows Server 2008 Datacenter
- Windows Server 2008 Standard
- Windows Server 2008 Enterprise
- Windows Vista Enterprise
- Windows Vista Business
- Microsoft Windows Server 2003 Enterprise Edition (32-bit x86)
- Microsoft Windows Server 2003 Standard Edition (32-bit x86)
- Microsoft Windows Server 2003 Datacenter Edition (32-bit x86)
- Microsoft Windows Server 2003 Web Edition
- Microsoft Windows Server 2003 Standard x64 Edition
- Microsoft Windows Server 2003 Enterprise x64 Edition
- Microsoft Windows Server 2003 Datacenter x64 Edition
- Microsoft Windows XP Professional
- Microsoft Windows XP Professional x64 Edition
