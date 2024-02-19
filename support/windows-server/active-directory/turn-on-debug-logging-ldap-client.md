---
title: How to Turn on Debug Logging of the LDAP Client (Wldap32.dll)
description: Describes how to turn on debug logging of the LDAP client (Wldap32.dll).
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tea, v-jesits, herbertm
ms.custom: sap:ldap-configuration-and-interoperability, csstroubleshoot
---
# How to turn on debug logging of the LDAP client (Wldap32.dll)

This article describes how to turn on debug logging of the LDAP client (Wldap32.dll).

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Window 10 - all editions  
_Original KB number:_ &nbsp; 325616

## Summary

In Windows Vista and newer versions of Windows, you can use Event Tracing for Windows (ETW) to trace LDAP client activity, including encrypted (TLS or SASL) activity.

## More information

To turn on LDAP client tracing, follow these steps:

1. Create the following registry subkey:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\ldap\Tracing\<ProcessName>`

   > [!Note]
   > In this subkey, \<ProcessName> is the full name of the process that you want to trace, including its extension. For example: "ldp.exe." Inside this subkey, you can place an optional entry that is named "PID" and that has a DWORD value. If you set the value to a process ID, only the instance of the application that has this process ID will be traced.

   > [!Important]
   > If you don't have such a registry subkey for at least one process, the trace file will not contain data.

2. To start a tracing session, run the following command at a command prompt:

    ```console
    logman create trace "ds_ds" -ow -o c:\ds_ds.etl -p "Microsoft-Windows-LDAP-Client" 0x1a59afa3 0xff -nb 16 16 -bs 1024 -mode Circular -f bincirc -max 4096 -ets
    ```

    > [!Note]
    In this command,  "0x1a59afa3" is a trace flag. Such flags control what information gets recorded, and the verbosity of data. You can use individual flags or combine bit values to specify multiple flags simultaneously. For common tracing scenarios, the following flag combinations are useful:
    >
    > - **0x1A59AFA3**. Log settings that should get the information that you require most of the time.
    > - **0x18180380**. Get information specifically on connection establishment problems.
    > - **0x1bddbf73**. Verbose session information.
    >
    > For information about the available flags, see the "[Values for trace flags](/windows-server/identity/ad-ds/manage/troubleshoot/troubleshoot-ldap-using-etw#values-for-trace-flags)" section of "[Using ETW to troubleshoot LDAP connections](/windows-server/identity/ad-ds/manage/troubleshoot/troubleshoot-ldap-using-etw)."

3. Reproduce the behavior that you want to investigate.
4. To stop the tracing session, run the following command:

    ```console
    logman stop "ds_ds" -ets
    ```

To view the trace as text, use the `netsh` tool to decode the ETL file as a .txt file, as follows:

```console
netsh trace convert input=c:\ds_ds.etl output=LDAP_CLIENT-formatted.txt
```

For more information about `netsh trace convert`, see the `netsh trace convert` help. To do this, enter `netsh trace convert /?` at the command prompt.
