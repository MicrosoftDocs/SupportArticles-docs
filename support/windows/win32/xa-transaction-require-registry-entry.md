---
title: XA transaction support requires registry entries
description: This article explains about how to create registry values for all XA DLLs you intend to use in order to use Microsoft Distributed Transaction Coordinator (MS DTC), starting with Windows Server 2003.
ms.date: 06/11/2025
ms.custom: sap:Distributed Transactions\DTC programming and runtime
ms.topic: article
---
# Registry entries are required for XA transaction support

Starting with Windows Server 2003, Microsoft Distributed Transaction Coordinator (MS DTC) requires that you create registry values for all XA DLLs that you plan to use. This article provides steps to modify the registry.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 817066

## Summary

Starting with Windows Server 2003, MS DTC requires that you create registry values for all XA DLLs that you plan to use. This requirement was added to Windows Server 2003 to help you to minimize the risks that are associated with using third-party XA DLLs in the MS DTC process. To retain the same functionality when you use XA transactions, you must add a registry value in the XA DLL key for each XA DLL that you plan to use. This article describes these registry values.

For example, when you upgrade an existing system to Windows Server 2003, and the existing system uses MS DTC with third-party XA DLLs, support for XA transactions is disabled until you create these required registry values. Also, if you later install a third-party product that provides XA DLLs to support XA transactions, you must do one of the followings:

- Create these registry values manually
- Verify that the third-party installer creates these registry values

## Turn on support for XA transactions

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

A security risk occurs when MS DTC uses user-specified DLLs. These DLLs are loaded directly in the MS DTC process. MS DTC uses these DLLs to communicate with the Transaction Manager (TM) of the XA partner. This scenario can expose the Resource Manager (RM) databases to serious data corruption. This scenario can also permit denial-of-service attacks if a malicious or defective XA DLL doesn't verify that the distributed transaction commits or aborts correctly. Also, if a malicious or defective XA DLL contains code that isn't security-enhanced, an attacker might exploit this weakness to cause a denial-of-service attack.

To help to prevent this security risk, Windows Server 2003 turns off all XA transactions when you upgrade to Windows Server 2003. If the support for XA transactions is turned off, Windows Server 2003 helps to protect MS DTC from denial-of-service attacks.

You may have to turn on support for XA transactions. To do this, follow these steps:

1. Open **Component Services**.
2. Expand the tree view to locate the computer on which you want to turn on support for XA transactions (for example, **My Computer**).
3. Right-click the computer name, and then select **Properties**.
4. Select the **MSDTC** tab, and then select **Security Configuration**.
5. Under **Security Settings**, select the check box for **XA Transactions** to turn on this support.

Windows Server 2003 provides a registry entry for you to specify the XA DLLs that you'll use. When you upgrade to Windows Server 2003, you can work with XA transactions in the same way that you worked with them in earlier versions of Microsoft Windows Server.

To do this, create a registry named-value under the following registry subkey:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSDTC\XADLL`

In your registry named-value, **Name** can be the file name of the XA DLL (for example, dllname.dll), although you aren't required to use this naming convention. Also in this named-value, **Type** is String (REG_SZ), and the value is the full path name (including the file name) of the DLL file.

Create an entry for each XA DLL file that you plan to use. Also, if you're configuring MS DTC on a cluster, you must create these registry entries on each node in the cluster.

## References

- [Managing XA Transactions](/previous-versions/windows/desktop/ms686014(v=vs.85))

- [Disabling TIP, LU and XA Transactions](/previous-versions/windows/desktop/ms681242(v=vs.85))

- [DTC Security Considerations](/previous-versions/windows/desktop/ms680682(v=vs.85))

- [What's New in COM+ 1.5](/windows/win32/cossdk/what-s-new-in-com--1-5)
