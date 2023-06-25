---
title: Detours or similar techniques cause issues
description: This article describes Microsoft support policy when you use third-party detours with SQL Server and issues that may occur when you use them.
ms.date: 09/03/2020
ms.custom: sap:General Troubleshooting Information
ms.reviewer: rdorr
ms.topic: article
---
# Detours or similar techniques may cause unexpected behaviors with SQL Server

This article describes Microsoft support policy when you use third-party detours with SQL Server and issues that may occur when you use them.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 920925

## Summary

Microsoft support has encountered numerous third-party products that use detours to provide additional functionalities to SQL Server. These are usually auditing functionalities. There is no certification process for third-party detours for Microsoft applications. Therefore, generally, Microsoft strongly discourages the use of detours.

Features that use detours or similar techniques to change the behavior of SQL Server may cause the following issues:

- Performance problems.
- Incorrect results.
- Disk and memory corruption.
- Loss of SQL Server response.
- Unexpected process termination.
- Inability to use standard diagnostics, such as the fn_get_sql function and the `DBCC INPUTBUFFER` command.
- 100 percent CPU utilization and long database recovery times when you use in-memory OLTP tables in SQL Server.

You may encounter these same issues when you are using non-Microsoft software such as linked servers, extended procedures, or COM objects within the SQL Server process. Detours are hidden from DBA view. To uncover a detour, you must use the techniques that are described in the [More Information](#more-information) section that follows. Linked servers, COM objects, and extended procedures have explicit registration and defined interfaces.

> [!NOTE]
> Because of the hidden nature of detours and the lack of published interfaces, Microsoft does not provide support services for third-party features that use detours or similar techniques. The third party is responsible for support of its own code, just as it would be responsible for its own linked server or other sanctioned deployment.

It is common practice, in the usual course of troubleshooting, for Microsoft support services to ask you to disable nonessential jobs and to disable or remove third-party components and other, similar techniques. Microsoft always tries to reduce the footprint of the issue while it is identifying the problem. After the issue is identified as unrelated to the jobs or third-party products, those jobs or third-party products may be introduced back into production.

It is not our intention to uncover a detour and then consider the instance of SQL Server to be unsupported. Microsoft acknowledges that some implementations are necessary. However, Microsoft requires you to validate the supportability of the detours. A detour from a reputable and trusted company is definitely different from an unexpected detour that is used by a virus. Microsoft does not warrant or certify these third-party products or how the third-party products interact with Microsoft products and services. Instead, third-party vendors are responsible for the identification and trustworthiness of their products and services. If you have any questions about third-party products and services, please reach out to the applicable third party. Microsoft is not responsible for any issues that are caused by your use of third-party products or services in connection with SQL Server.

## More information

Detours provide enhanced capabilities and a risk/reward tradeoff. Typically, when a detour is implemented in SQL Server, third-party code is injected into the process space. This activity may change the behavior of SQL Server.

The following are some example situations and possible side effects:

- Incoming network traffic (TDS) packets are scanned and changed. The detour is added at a critical location at the net_readdata network process thread. Even 100 CPU cycles at this location may significantly reduce batch rate throughput.

  A change in the actual TDS data may lead to memory scribblers. This problem has triggered various SQL Server stability problems and in data corruption. Problems may cause a TDS packet to be partially changed and to replay garbage to SQL Server. Logging facilities at this level may expose passwords and other sensitive data that SQL Server tracing is designed to suppress and to help secure.

- SQL Server parsing routines are detoured to change behavior. The following are possible side effects:

  - Execution plans do not match actual query text.
  - A command is submitted only one time from the client. However, the command is executed multiple times.
  - Trace output shows the original command instead of the altered query.
  - The `DBCC INPUTBUFFER` command shows the original command instead of the altered query.
  - The `fn_get_sql` function shows incorrect data. Additionally, the `fn_get_sql` function is susceptible to exceptions and to incorrect results. The `fn_get_sql` function is used by many monitoring solutions and may cause problems on the monitoring solutions.
  - Overall User Mode Scheduler (UMS) and SQL Server Operating System (SQLOS) scheduling may be interrupted. This leads to loss of SQL Server response, to performance changes, and to outages.

- Win32 APIs that provide enhanced security features are detoured. Depending on the implementation, logging facilities at this level could expose passwords and other sensitive data. Overall UMS and SQLOS scheduling is interrupted. This leads to loss of SQL Server response and to outages.

- Modifying function tables and redirecting core SQL Server functions or Windows API's are not supported within the SQL Server process. This can lead to instability and unexpected behavior in the SQL Server functionality.

The following example shows that the `kernel32!GetQueuedCompletionStatus` function has been detoured.

```console
MyDLL!MyGetQueuedCompletionStatus
ssnetlib!ConnectionReadAsyncWait
```

In the assembly for the `GetQueuedCompletionStatus` function, the first instruction has been replaced with a jump instruction.

```console
0:038> u kernel32!GetQueuedCompletionStatus
kernel32!GetQueuedCompletionStatus
77e660f1 e90a9f00aa jmp 21e70000 ß This points to an address that does not appear in the loaded module list (lm). It is injected code.
77e660f6 83ec10 sub esp,10h
```

The assembly for the injected code shows the detoured activity and a call to the *MyDLL* file.

```console
0:038> u 21e70000
21e70000 55 push ebp
21e70001 8bec mov ebp,esp
21e70003 51 push ecx
21e70004 8b4518 mov eax,dword ptr [ebp+18h]
21e70007 50 push eax
21e70008 8b4d14 mov ecx,dword ptr [ebp+14h]
21e7000b 51 push ecx
21e7000c 8b5510 mov edx,dword ptr [ebp+10h]
21e7000f 52 push edx
21e70010 8b450c mov eax,dword ptr [ebp+0Ch]
21e70013 50 push eax
21e70014 8b4d08 mov ecx,dword ptr [ebp+8]
21e70017 51 push ecx
21e70018 e8234d19ee call MyDLL+0x4d40 (10004d40) <- Call to the MyDLL file.
21e7001d 8945fc mov dword ptr [ebp-4],eax
21e70020 8b55fc mov edx,dword ptr [ebp-4]
```

You can use Debugging Tools for Windows to determine whether detours are being used. To do this, follow these steps.

> [!NOTE]
> Always test this method before you try it in production. When you use Debugging Tools for Windows, the process may freeze when you run the commands. This behavior may adversely affect a production server.

1. Attach Debugging Tools for Windows to SQL Server, or load a full user dump file.

2. Issue the following debugger command. This command inspects each image against the on-disk image to determine whether detours have been injected.

    ```console
    !for_each_module "!chkimg -v @#Base -d"
    ```

3. Detach the debugger.

If the in-memory image was altered, the output may resemble the following:

```console
Comparison image path: c:\program files\microsoft sql server\mssql\binn\ssnetlib.dll\ssnetlib.dll
Scanning section: .text
Size: 56488  
Range to scan: 0c261000-0c26eca8  
0c263710-0c26371a 11 bytes - ssnetlib!ConnectionClose  
[ 8b ff 55 8b ec 83 ec 10:68 00 00 00 00 e9 27 8a ]  
0c2641e0-0c2641ea 11 bytes - ssnetlib!ConnectionReadAsync (+0xad0)  
[ 8b ff 55 8b ec 83 ec 38:68 00 00 00 00 e9 00 7e ]  
0c265160-0c26516a 11 bytes - ssnetlib!ConnectionWriteAsync (+0xf80)  
[ 8b ff 55 8b ec 83 ec 28:68 00 00 00 00 e9 ba 70 ]  
Total bytes compared: 56488(100%)  
Number of errors: 33  
33 errors : 0c260000 (0c263710-0c26516a)
```

You can review the assembly to look more closely at the issue as follows:

```console
0:038> u ssnetlib!ConnectionClose
ssnetlib!ConnectionClose]:
0c263710 6800000000 push 0
0c263715 e9278ada03 jmp MyDLL!MyGetQueuedCompletionStatus <- A detour has been installed.
```

Antivirus programs that track SQL injection attacks can detour SQL Server code. In this scenario, the output of the `!for_each_module "!chkimg -v @#Base -d"` extension may show that the SQL Server functions `yyparse` and `ex_raise2` are modified:

```console
Comparison image path: <symbol file path>\sqlservr.exeRange to scan: c81000-3de7d48 ed71a8-ed71ad 6 bytes - sqlservr!yyparse [ ff f5 41 54 41 55:e9 c7 95 5c 76 90 ]1202820-1202824 5 bytes - sqlservr!ex_raise2 (+0x32b678) [ ff f3 57 41 54:e9 20 e0 29 76 ] Total bytes compared: 51801416(17%)Number of errors: 11
```

We recommend that you contact the provider of the detours or similar techniques for detailed information about how it uses the detours in SQL Server. For more information about detours and similar techniques, see [Detours](https://www.microsoft.com/research/project/detours).
