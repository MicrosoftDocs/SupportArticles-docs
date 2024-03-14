---
title: Create the IMTraceLog.txt file
description: Describes how to create a trace file for Integration Manager for Microsoft Dynamics GP. The IMTraceLog.txt file replaces the Macros.txt file.
ms.reviewer: theley, kvogel
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to configure the new Microsoft.Dynamics.GP.IntegrationManager.exe.config file so that Integration Manager for Microsoft Dynamics GP 10.0 creates the IMTraceLog.txt file

This article describes how to configure the new Microsoft.Dynamics.GP.IntegrationManager.exe.config file so that Integration Manager for Microsoft Dynamics GP 10.0 creates the IMTraceLog.txt file for a Microsoft Dynamics GP destination adapter.

__Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 947930

## Introduction

Integration Manager creates the IMTraceLog.txt file when you run an integration.

The IMTraceLog.txt file replaces the Macros.txt file that is created by Integration Manager for Microsoft Dynamics GP 9.0 and for earlier versions.

## More information

You must change two switches in the Microsoft.Dynamics.GP.IntegrationManager.exe.config file. To do it, follow these steps:

1. In Notepad, open the Microsoft.Dynamics.GP.IntegrationManager.exe.config file.

2. Change the value of the IMTracingOn switch to **1** as follows.

    ```xml
    <add name="IMTracingOn" value="1"/>
    ```

3. Change the value of the TraceGPDexInstructions switch to **1** as follows.

    ```xml
    <add name="TraceGPDexInstructions" value="1"/>
    ```

4. Save the Microsoft.Dynamics.GP.IntegrationManager.exe.config file, and then close the file.

After you follow these steps, Integration Manager creates the IMTraceLog.txt file when you start Integration Manager and then run any Microsoft Dynamics GP destination adapter. The IMTraceLog.txt file is in the root directory of the Integration Manager code folder.
