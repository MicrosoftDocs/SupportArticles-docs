---
title: Troubleshoot WmiPrvse.exe quota exceeded issues
description: Helps troubleshoot the WmiPrvse.exe process quota exceeded issues, and describes how to gather additional information.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, krpg, v-lianna
ms.custom: sap:wmi, csstroubleshoot
---
# Scenario guide: Troubleshoot WmiPrvse.exe quota exceeded issues

This article helps troubleshoot the *WmiPrvse.exe* process quota exceeded issues.

You may experience one or more of the following issues:

- One or more applications report error codes or messages related to the Windows Management Instrumentation (WMI) provider failure listed in [WMI Error Constants](/windows/win32/wmisdk/wmi-error-constants).
- The *WmiPrvse.exe* process regularly or intermittently reaches a specific memory, handle, or thread, and eventually terminates or exits.
- The following events are logged in the Application event log regularly or intermittently.

    > [!NOTE]
    > Here are two event examples. The description of the event may change depending on the issue faced by the *WmiPrvse.exe* process and the WMI providers involved.

    ```output
    Log Name:      Application
    Source:        Microsoft-Windows-WMI
    Date:          <DateTime>
    Event ID:      5612
    Task Category: None
    Level:         Warning
    Keywords:
    User:          NETWORK SERVICE
    Computer:      <MachineName>
    Description:
    Windows Management Instrumentation has stopped WMIPRVSE.EXE because a quota reached a warning value. Quota: PrivatePageCount  Value: 538353664 Maximum value: 536870912 WMIPRVSE PID: 18524 Providers hosted in this process: %systemroot%\system32\wbem\ntevt.dll, %SystemRoot%\System32\wbem\cluswmi.dll, %SystemRoot%\System32\wbem\cluswmi.dll, %systemroot%\system32\wbem\cimwin32.dll
    ```

    ```output
    Log Name:      Application
    Source:        Microsoft-Windows-WMI
    Date:          <DateTime>
    Event ID:      5612
    Task Category: None
    Level:         Warning
    Keywords: 
    User:          SYSTEM
    Computer:      <MachineName>
    Description:
    Windows Management Instrumentation has stopped WMIPRVSE.EXE because a quota reached a warning value. Quota: HandleCount Value: 4099 Maximum value: 4096 WMIPRVSE PID: 4468 Providers hosted in this process: C:\Windows\System32\wbem\WmiPerfClass.dll, %systemroot%\system32\wbem\wmiprov.dll
    ```

When one or more of the above issues (especially Event ID 5612) occur, it means one of the WMI provider processes (*WmiPrvse.exe*) has exceeded its predefined resource value and that the WMI service has explicitly stopped it from running as a process.

The query handled by the stopped *WmiPrvse.exe* process and the application that initiates the process will fail.

## What is WmiPrvse.exe?

*WmiPrvse.exe* is a process in the Windows operating system (OS) that can host one or more WMI providers. It is managed by the WMI service. Each WMI provider primarily contains the WMI provider DLL file and the WMI provider MOF file. The WMI provider is part of the WMI infrastructure, which accepts tasks from the WMI service to address or handle WMI queries initiated by local or remote clients.

Each *WmiPrvse.exe* process has a predefined threshold or resource quota that it can use when it's active. For example:

- `HandlesPerHost`
- `MemoryAllHosts`
- `MemoryPerHost`
- `ProcessLimitAllHosts`
- `ThreadsPerHost`

The values are defined as instances under the WMI class [__ProviderHostQuotaConfiguration](/windows/win32/wmisdk/--providerhostquotaconfiguration).

## Event ID 5612

Event ID 5612 is one of the most descriptive and useful warning messages. In the first event example, the event reports that the resource `PrivatePageCount` has exceeded the quota of 536870912 and reached the value of 538353664.

When any resources reach the quota limit or exceed the value, the WMI service, by design, will explicitly stop the process from further consumption.

In this example, the resource is `PrivatePageCount`, one of the entities of memory, which is limited per host by the `MemoryPerHost` property.

The event also lists the different WMI providers hosted in the stopped *WmiPrvse.exe* process.

- `%systemroot%\system32\wbem\ntevt.dll`
- `%SystemRoot%\System32\wbem\cluswmi.dll`
- `%SystemRoot%\System32\wbem\cluswmi.dll`
- `%systemroot%\system32\wbem\cimwin32.dll`

All the providers listed above are stopped abruptly due to the issue.

## Diagnose the issue

The following scenarios can cause Event ID 5612:

- A client application performs abnormal, inefficient, or large queries.
- The *WmiPrvse.exe* process doesn't release resources as expected while processing a WMI query, which leads to a memory leak and stops the *WmiPrvse.exe* process.
- The scale of the machine or environmental setup is large.

Analyzing the incoming queries can help determine the initial cause and solve the issue. Otherwise, a deeper investigation is required by opening a Microsoft support case.

To diagnose the issue, follow these steps:

1. Understand the pattern of the issue.

    Review Application event logs and filter Event ID 5612 to understand the frequency, history, and pattern.

2. Identify the common WMI providers listed in the event.

    The providers listed may be the same across all the events. Another possibility is that one of the providers consumes more resources, causing this issue and disturbing other WMI providers. In this case, the goal is to diagnose and identify the problematic provider.
3. Identify the currently active WMI providers hosting the same list of WMI providers. You can use Process Explorer to diagnose further:

    1. Run [Process Explorer](/sysinternals/downloads/process-explorer) as an administrator. Select one of the *WmiPrvse.exe* processes, go to its properties, and select the **WMI Providers** tab.

        For example, the *WmiPrvse.exe* process ID (PID) 5584 hosts only one WMI provider, CIMWin32, and the DLL path is *%systemroot%\system32\wbem\cimwin32.dll*.
    2. Review the same information for other active *WmiPrvse.exe* processes until you find the PID of the process that's hosting the list of providers listed in Event ID 5612.

        :::image type="content" source="./media/scenario-guide-troubleshoot-wmiprvse-quota-exceeded-issues/wmiprvse-5584-properties.png" alt-text="Screenshot of the WmiPrvse.exe 5584 Properties window showing that PID 5584 is hosting only one WMI provider CIMWin32.":::

    Sometimes, if the issue is intermittent or infrequent, the *WmiPrvse.exe* process causing the issue may be terminated over time. When the issue reoccurs, it may be the same provider(s) in a new *WmiPrvse.exe* instance.

    In this case, once you have the provider(s) noted, run the following command to show the current PID of the *WmiPrvse.exe* process that contains the provider.

    ```console
    tasklist /m <Provider DLL> 
    ```

    For example:

    ```console
    tasklist /m ntevt.dll
    ```

    :::image type="content" source="./media/scenario-guide-troubleshoot-wmiprvse-quota-exceeded-issues/wmiprvse-instances-pid.png" alt-text="Screenshot showing that the CIMWin32.dll provider is loaded in two different WmiPrvse.exe instances and their PID.":::

    It's important to understand which providers are loaded in the *WmiPrvse.exe* process and note the PID of the *WmiPrvse.exe* process every time.

4. Analyze the incoming queries that are handled by the *WmiPrvse.exe* process listed in Event ID 5612.

    Go through the steps mentioned in the "Analyze the incoming queries," "Review the WMI trace files," and "Find the client PIDs that causing high CPU usage" sections in [Troubleshoot WMI high CPU usage issues](troubleshoot-wmi-high-cpu-issues.md). Then, you can identify:

    - The client process(es)
    - The query leading to the issue
    - The frequency of the query  

### Client application performs abnormal, inefficient, or large queries

When a client application performs abnormal, inefficient, or large queries, it can lead to the WMI provider consuming large amounts of resources.

- Review and understand why the application performs this query and if it's necessary. If it's unnecessary in your environment, remove the application or stop it from performing the query. This should help resolve the issue. You can address this behavior with the application vendor.

- If the application is known or expected to perform WMI queries that lead to the *WmiPrvse.exe* process heavily consuming any resources, and there's no memory or handle leak from the *WmiPrvse.exe* process, increasing the default quota limit to double the default value should address the situation.

    > [!CAUTION]
    >
    > - This change is effective only if there's no leak of any resources. Otherwise, the issue (event ID 5612) will only be delayed for a while and then start recurring.
    > - This change will apply to all WMI providers on the system. That means all the *WmiPrvse.exe* processes will start consuming resources as per the new quota limit applied.

    Increasing the default quota limit may lead to higher consumption of resources such as memory, handles, or CPU. Hence, we don't recommend increasing the quota limit without prior investigation and understanding of the issue.

    To increase the quota limit, follow these steps:

    1. Open the Windows Management Instrumentation Tester (WBEMTEST) as an administrator, select **Connect**, and connect to the "root" namespace.

        :::image type="content" source="./media/scenario-guide-troubleshoot-wmiprvse-quota-exceeded-issues/wbemtest-connect.png" alt-text="Screenshot of the Windows Management Instrumentation Tester window showing how to connect to the root namespace.":::

    2. Select **Enum Instances**, type *__ProviderHostQuotaConfiguration* in the **Class Info** dialog, and then select **OK**. The **Query Result** window is presented. Then, double-click the first result to edit the objects.

        :::image type="content" source="./media/scenario-guide-troubleshoot-wmiprvse-quota-exceeded-issues/query-result.png" alt-text="Screenshot of the Query Result window with the first result selected.":::

    3. In the **Properties** section, scroll down to the list mentioned below and increase the resources by modifying the values of these properties.

        :::image type="content" source="./media/scenario-guide-troubleshoot-wmiprvse-quota-exceeded-issues/object-editor.png" alt-text="Screenshot of the Object editor window with the properties of the instance selected.":::

    4. In the **Object editor** window, select **Save Object**, close the **Query Result** window, and then exit WBEMTEST.
    5. Restart the WMI service (Winmgmt) for the changes to take effect.

### The WmiPrvse.exe process doesn't release resources as expected

If the *WmiPrvse.exe* process doesn't release resources as expected while processing a WMI query, it leads to a memory leak and stops the *WmiPrvse.exe* process. Examine the query processed and the stack of the *WmiPrvse.exe* process that causes the issue.

- Studying the incoming queries helps understand the *WmiPrvse.exe* process behavior.
- If no client applications or services are causing the issue, further check the *WmiPrvse.exe* process activity hosting the providers identified in Event ID 5612.
- Use Process Explorer to review the threads and stacks.

    1. Run Process Explorer as an administrator and locate the *WmiPrvse.exe* process using the technique mentioned in the [Diagnose the issue](#diagnose-the-issue) section.
    2. Go to **Properties** and select the **Threads** tab.

        :::image type="content" source="./media/scenario-guide-troubleshoot-wmiprvse-quota-exceeded-issues/wmiprvse-5180-properties.png" alt-text="Screenshot of the WmiPrvse.exe 5180 Properties window with Thread ID 4016 selected.":::

    3. For each thread, you can review the stack and identify if you locate any non-Microsoft binaries or files.

You may notice binaries from software such as antivirus software, monitoring software, and threat protection software. Although these software applications benefit the environment, they may sometimes interrupt and cause such issues. Hence, you can temporarily uninstall them and check for the issue.

If removing the identified non-Microsoft product helps fix the issue, you can address this behavior of the product with the product vendor.

If not, you need to contact Microsoft support professionals to analyze the event trace log (ETL) tracing and review the dump of WMI providers.

## Data collection

Before opening a support case to further investigate the issue, you can collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-tss/gather-information-using-tss-user-experience.md#wmi).

You can also gather information by using the WMI-Collect tool on the machine that has recently experienced the issue. Here are the steps:

1. Download [WMI-Collect.zip](https://aka.ms/WMI-Collect) and extract it to a folder, such as *C:\\temp*.
2. From an elevated PowerShell command prompt, run the *WMI-Collect.ps1* script from the folder where the script is saved. For example:

    ```cmdlet
    C:\temp\WMI-Collect.ps1 -Logs -Trace
    ```

3. Keep the PowerShell command prompt open with the "Press ENTER to stop the capture:" message.

    You can keep the tracing active for two to three minutes or until the affected *WmiPrvse.exe* is active. Stop the tracing by pressing <kbd>Enter</kbd>.

4. The script creates a subfolder containing the results of all traces and diagnostic information. Compress the folder. After a support case is created, this file can be uploaded to the secure workspace for analysis.
