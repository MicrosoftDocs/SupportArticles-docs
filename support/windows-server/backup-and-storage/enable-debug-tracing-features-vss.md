---
title: Enable debug tracing features of VSS
description: Provides steps for modifying the registry in Windows Server 2003 to enable the Volume Shadow Copy service's debug tracing features.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-jomcc
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
ms.subservice: backup-and-storage
---
# How to enable the Volume Shadow Copy service's debug tracing features in Windows Server 2003 and Windows Server 2008

This article describes how to enable the Volume Shadow Copy service's debug tracing features in Windows Server 2003 and Windows Server 2008.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 887013

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [Windows registry information for advanced users](https://support.microsoft.com/help/256986).

## Steps to enable the Volume Shadow Copy service's debug tracing features

> [!NOTE]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To enable the Volume Shadow Copy service's debug tracing features in Windows Server 2003 and Windows Server 2008, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. In Registry Editor, locate the following registry subkey:  
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VSS`

3. In the left pane, right-click **VSS**, point to **New**, and then click **Key**.
4. Type *Debug*, and then press ENTER.
5. In the left pane, right-click **Debug**, point to **New**, and then click **Key**.
6. Type *Tracing*, and then press ENTER.
7. In the left pane, right-click **Tracing**, point to **New**, and then click **DWORD Value**.
8. Type *TraceLevel*, and then press ENTER.
9. Double-click **TraceLevel**, and then type *ffffffff* in the **Value data** box. That is, type f eight times in the **Value data** box. Click **OK**.

    > [!NOTE]
    > The TraceLevel registry entry determines the type of debug tracing that will occur. A value of 0 (the default) indicates that no tracing will occur. A value of ffffffff turns on tracing for all events.

10. In the left pane, right-click **Tracing**, point to **New**, and then click **DWORD Value**.
11. Type *TraceEnterExit*, and then press ENTER.
12. Double-click **TraceEnterExit**, type *1* in the **Value data** box, and then click **OK**.

    > [!NOTE]
    > The TraceEnterExit registry entry determines whether the entry and exit information of the function is output to the trace file and to the debug output stream. A value of 0 (the default) indicates that no entry and exit information of the function is output. A value of 1 indicates that the entry and exit information of the function is output.

13. In the left pane, right-click **Tracing**, point to **New**, and then click **DWORD Value**.
14. Type *TraceToFile*, and then press ENTER.
15. Double-click **TraceToFile**, type *1* in the **Value data** box, and then click **OK**.

    > [!NOTE]
    > The TraceToFile registry entry determines whether trace information is output to the trace file. A value of 0 (the default) indicates that no trace information is output to the trace file. A value of 1 indicates that the trace information is output to the trace file. If you set the value to 1, you must also set the TraceFile registry entry. To set the TraceFile registry entry, follow these steps:
    >
    > 1. In the left pane, right-click **Tracing**, point to **New**, and then click **String Value**.
    > 2. Type *TraceFile*, and then press ENTER.
    > 3. Double-click **TraceFile**, type *c:\\trace.txt* in the **Value data** box, and then click **OK**.
    >
    > The TraceFile registry entry cannot be stored on the disk where the shadow copy is created.

16. In the left pane, right-click **Tracing**, point to **New**, and then click **DWORD Value**.
17. Type *TraceToDebugger*, and then press ENTER.
18. Double-click **TraceToDebugger**, type *1* in the **Value data** box, and then click **OK**.

    > [!NOTE]
    > The TraceToDebugger registry entry determines whether trace information is output to the debug output stream. A value of 0 (the default) indicates that no trace information is output to the debug output stream. A value of 1 indicates that the trace information is output to the debug output stream.

19. In the left pane, right-click **Tracing**, point to **New**, and then click **DWORD Value**.
20. Type TraceTimeStamp, and then press ENTER.
21. Double-click **TraceTimeStamp**, type *1* in the **Value data** box, and then click **OK**.

    > [!NOTE]
    > The TraceTimeStamp registry entry determines whether the time stamp information is output to the trace file and to the debug output stream. A value of 0 (the default) indicates that no time stamp information is output. A value of 1 indicates that the time stamp information is output.

22. In the left pane, right-click **Tracing**, point to **New**, and then click **DWORD Value**.
23. Type *TraceFileLineInfo*, and then press ENTER.
24. Double-click **TraceFileLineInfo**, type *1* in the **Value data** box, and then click **OK**.

    > [!NOTE]
    > The FileLineInfo registry entry determines whether the module file name information and the line number information are output to the trace file and to the debug output stream. A value of 0 (the default) indicates that no module file name information and no line number information are output. A value of 1 indicates that the module file name information and the line number information are output.

25. In the left pane, right-click **Tracing**, point to **New**, and then click **DWORD Value**.
26. Type *TraceForceFlush*, and then press ENTER.
27. Double-click **TraceForceFlush**, type 1 in the **Value data** box, and then click **OK**.

    > [!NOTE]
    > The TraceForceFlush registry entry determines whether a forced flush occurs after each trace message is written to the trace file. A value of 0 (the default) indicates that no forced flush occurs. A value of 1 indicates that a forced flush occurs. When a forced flush occurs, no trace records are ever lost, but computer performance is greatly reduced.

28. Quit Registry Editor.

For more information about the Volume Shadow Copy service, visit the following Microsoft Web site:

[Volume Shadow Copy Service](/windows-server/storage/file-server/volume-shadow-copy-service)
