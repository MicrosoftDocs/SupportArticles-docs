---
title: Event ID 4448 with KTMRM service
description: Describes a problem that a distributed transaction fails to run from a process (ex. w3wp.exe) under a domain account on Windows Server 2008 and above. Provides a workaround.
ms.date: 03/09/2020
ms.custom: sap:Distributed transactions
ms.technology: windows-dev-apps-distributed-transactions
---
# KTMRM service failed with event ID 4448 and 0x80070005 (Access Denied)

This article helps you resolve the problem where Kernel Transaction Manager Resource Manager (KTMRM) service fails when you run a distributed transaction from a process (for example, w3wp.exe) under a domain account on Windows.

_Original product version:_ &nbsp; Windows Server 2008  
_Original KB number:_ &nbsp; 2607379

## Symptoms

When you run a distributed transaction from a process (for example, w3wp.exe) under a domain account on Windows Server 2008 and above, the transaction may fail. An access denied error (0x80070005) is logged in the application log:

> Log Name:      Application  
> Source:        Microsoft-Windows-MSDTC Client  
> Event ID:      4448  
> Task Category: KTMRM  
> Level:         Error  
> Keywords:      Classic  
> Description:  
> KTMRM service failed to load the system restore information. As a result, the service is exiting. Please try restarting the service, if the service fails to start, contact product support. Error Specifics: hr = 0x80070005, xxxx, CmdLine: xxxx, Pid: xxxx

## Cause

During System Restore operations the Microsoft Distributed Transaction Coordinator service (MSDTC) on Windows Server 2008 and above uses the Kernel Transaction Manager Resource Manager service (KtmRm) to coordinate transactions with the Windows Kernel Transaction Manager (KTM).

The access denied error (0x80070005) in the Microsoft-Windows-MSDTC event ID 4448 is returned from the `OpenSCManager` function that's invoked by the MSDTC proxy. During the process of recovering transactions, a registry check fails because the application process identity is a domain account in the Users group and doesn't have permissions to access the registry. When this registry check fails, the recovery will call `OpenSCManager`, which also fails because of permission issues. The MSDTC proxy specifies `SC_MANAGER_CONNECT` and `SC_MANAGER_QUERY_LOCK_STATUS` as desired access rights to the `OpenSCManager` function. However, the domain account in the Users group doesn't have the `SC_MANAGER_QUERY_LOCK_STATUS` access right. Therefore, `OpenSCManager` function fails.

For more information about the `SC_MANAGER_QUERY_LOCK_STATUS` access right, please see [Service Security and Access Rights](/windows/win32/services/service-security-and-access-rights).

## Workaround

This behavior is by design.

The workaround is to grant the authenticated user the `SC_MANAGER_QUERY_LOCK_STATUS` access right to the Service Control Manager (SCM). Another simple workaround is to add the identity account of the application process to the administrators group.

To change the access right, follow the steps below:

1. Run the following `SC` command at a command prompt to display the current discretionary access control list (DACL) on the SCM.

    ```console
    sc sdshow SCMANAGER
    ```

    Here is a sample output:

    ```console
    D:(A;;CC;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)
    ```

    In the output above, there's `(A;;CC;;;AU)`. The first `A` means allow access. The `CC` means the `SC_MANAGER_CONNECT` right and the `AU` represents the `Authenticated Users` group. This means the `Authenticated Users` have the `SC_MANAGER_CONNECT` access right to SCM.

2. Run the following `SC` command at a command prompt to add the `Authenticated Users` the `SC_MANAGER_QUERY_LOCK_STATUS` (RP) access right to the SCM:

    ```console
    sc sdset scmanager D:(A;;CCRP;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)
    ```

This workaround will ensure the user has the `SC_MANAGER_CONNECT` and `SC_MANAGER_QUERY_LOCK_STATUS` access rights to the SCM.

For more information, see [Troubleshooting MSDTC Permission Issues When a Distributed Transaction Starts](/archive/blogs/distributedservices/troubleshooting-msdtc-permission-issues-when-a-distributed-transaction-starts).
