---
title: Troubleshoot the Azure Cosmos DB emulator
description: Learn how to troubleshoot problems related to service unavailability, certificate encryption, and versioning when you use the Azure Cosmos DB emulator. 
ms.service: cosmos-db
author: oury-msft
ms.author: ouryba
ms.reviewer: v-jayaramanp
ms.topic: troubleshooting
ms.date: 10/04/2023
---

# Troubleshoot the Azure Cosmos DB emulator

The Azure Cosmos DB emulator provides an environment that emulates the cloud service for development. Use the tips in this article to help troubleshoot problems that you might experience when you install or use the emulator.

## Troubleshooting checklist

Here's a list of common troubleshooting steps to follow if the Azure Cosmos DB emulator isn't working as expected.

## Reset data

If you installed a new version of the emulator, and you're experiencing errors, make sure that you reset the data. To reset the data, open the Azure Cosmos DB emulator context menu from the system tray, and then select **Reset Data**.

If resetting the data doesn't fix the errors, you can:

- Uninstall the emulator.
- Uninstall older versions of the emulator (if they exist).
- Remove the `%ProgramFiles%\Azure Cosmos DB Emulator` folder.
- Reinstall the emulator.

Alternatively, if resetting the data doesn't work, go to the `%LOCALAPPDATA%\CosmosDBEmulator` location, and then delete the folder.

## Review corrupted Windows performance counters

- If the Azure Cosmos DB emulator stops responding, collect the dump files from the `%LOCALAPPDATA%\CrashDumps` folder, compress the files, and then open a support ticket in [the Azure portal](https://portal.azure.com).

- If `Microsoft.Azure.Cosmos.ComputeServiceStartupEntryPoint.exe` stops responding, this crash could indicate that the performance counters are corrupted. To check the counter status, run the following command:

  ```cmd
  lodctr /R
   ```

## Diagnose connectivity problems

- If you experience a connectivity problem, [collect trace files](#collect-trace-files), compress the files, and then open a support ticket in the [Azure portal](https://portal.azure.com).

- If you receive a "Service Unavailable" message, the emulator might not be initializing the network stack. Check to see whether you have the **Pulse Secure Client** or **Juniper Networks Client** installed because their network filter drivers might be causing the problem. You can also try uninstalling third-party network filter drivers to fix the problem. Alternatively, start the emulator by using `/DisableRIO` to switch the emulator network communication to regular Winsock.

- If you receive a connectivity error message such as "Forbidden","message":"Request is being made with a forbidden encryption in transit protocol or cipher. Check account SSL/TLS minimum allowed protocol setting...", this error message might indicate global changes in the OS (for example Insider Preview Build 20170) or changes in the browser settings that enable TLS 1.3 as the default protocol. A similar error message, such as "Microsoft.Azure.Documents.DocumentClientException: Request is being made with a forbidden encryption in transit protocol or cipher. Check account SSL/TLS minimum allowed protocol setting" might be generated if you use the SDK to run a request against the Azure Cosmos DB emulator. This error might also occur because the Azure Cosmos DB emulator supports only the TLS 1.2 protocol. The recommended workaround is to set TLS 1.2 as the default.

  For example:

  1. In **IIS Manager**, go to **Sites** > **Default Web Sites**.
  1. Locate the **Site Bindings** for port **8081**, and edit them to disable TLS 1.3. You can also update the settings for the web browser by using the **Settings** option.

     > [!NOTE]
     > If your computer enters sleep mode or runs any OS updates while the emulator is running, you might see a "Service is currently unavailable" error message.

  1. To reset the emulator data, right-click the icon that appears in the Windows notification tray, and then select **Reset Data**.

## Collect trace files

To collect debugging traces, run the following commands as an administrator in a Command Prompt window:

1. Navigate to the path in which the emulator is installed:

   ```cmd
   cd /d "%ProgramFiles%\Azure Cosmos DB Emulator"
   ```

1. Shut down the emulator, and watch the system tray to make sure that the program is shut down:

   ```cmd
   Microsoft.Azure.Cosmos.Emulator.exe /shutdown
   ```

   > [!NOTE]
   > It might take one minute for the process to finish. You can also select **Exit** in the Azure Cosmos DB emulator user interface.

1. Start logging by running the following command:

   ```cmd
   Microsoft.Azure.Cosmos.Emulator.exe /startwprtraces
   ```

1. Start the emulator:

   ```cmd
   Microsoft.Azure.Cosmos.Emulator.exe
   ```

1. Reproduce the problem. If the data explorer isn't working, you have to wait only a few seconds for the browser to load to be able to detect the error.

1. Stop logging:

   ```cmd
   Microsoft.Azure.Cosmos.Emulator.exe /stopwprtraces
   ```

1. Navigate to the `%ProgramFiles%\Azure Cosmos DB Emulator` path, and locate the *docdbemulator_000001.etl* file.

1. Open a support ticket in the [Azure portal](https://portal.azure.com), and include the .etl file together with any steps that are required to reproduce the problem.
