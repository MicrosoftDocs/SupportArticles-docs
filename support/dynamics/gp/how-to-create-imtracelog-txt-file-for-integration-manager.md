---
title: How to create IMTraceLog.txt for Integration Manager
description: This article describes how to create the IMTraceLog.txt file for Integration Manager for Microsoft Dynamics GP so that you can view more detailed error messages.
ms.reviewer: theley, v-anlang, dlanglie
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to create an IMTraceLog.txt file for Integration Manager for Microsoft Dynamics GP

This article describes how to create an IMTraceLog.txt file that you can use to view more detailed error messages for Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 970224

You can use the IMTrace.log file to help determine the reason an error message occurs in an integration in Integration Manager. To create the IMTrace.log file, follow these steps:

1. Browse to your Integration Manager folder. This folder is typically at the following location:

   C:\Program Files\Microsoft Dynamics\Integration Manager 10

2. Open the Microsoft.Dynamics.GP.IntegrationManager.exe.config file by using Notepad or another text editor.

3. Locate the three switches near the bottom of the file. Change the value of the first switch and the third switch to **1**. For example, the switches section will resemble the following:

    ```console
    <switches>
    <add name="IMTracingOn" value="1"/>
    <add name="TraceGPScriptInstructions" value="0"/>
    <add name="TraceGPDexInstructions" value="1"/>
    ```

After you run the integration again, a more detailed version of the error appears in the IMTraceLog.txt file.
