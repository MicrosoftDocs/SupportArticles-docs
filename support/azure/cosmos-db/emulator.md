---
title: Troubleshoot the Azure Cosmos DB emulator
description: Learn how to troubleshot service unavailable, certificate, encryption, and versioning issues when using the Azure Cosmos DB emulator. 
ms.service: cosmos-db
author: oury-msft
ms.author: ouryba
ms.reviewer: v-jayaramanp
ms.topic: landing-page
ms.date: 09/21/2023
---

# Troubleshoot the Azure Cosmos DB emulator

The Azure Cosmos DB emulator provides an environment that emulates the cloud service for development purposes. Use the tips in this article to help troubleshoot issues you experience when installing or using the emulator.

## Troubleshooting checklist

Here's a list of common troubleshooting steps to follow when the Azure Cosmos DB emulator isn't working as expected.

## Reset data

If you installed a new version of the emulator and are experiencing errors, make sure you reset your data. You can reset your data by opening the Azure Cosmos DB emulator's context menu from the system tray, and then selecting **Reset Data…**.

If resetting the data doesn't fix the errors, you can:

- Uninstall the emulator.
- Uninstall any older versions of the emulator (if they exist).
- Remove *%ProgramFiles%\Azure Cosmos DB Emulator* directory.
- Reinstall the emulator.

Alternatively, if resetting the data doesn't work, go to *%LOCALAPPDATA%\CosmosDBEmulator* location and delete the folder.

## Review corrupted windows performance counters

- If the Azure Cosmos DB emulator crashes, collect the dump files from *%LOCALAPPDATA%\CrashDumps* folder, compress them, and open a support ticket from the [Azure portal](https://portal.azure.com).

- If you experience crashes in `Microsoft.Azure.Cosmos.ComputeServiceStartupEntryPoint.exe`, these crashes might be a symptom where the performance counters are in a corrupted state. Usually, the issue is fixed when you run the following command from an admin command prompt:

  ```cmd
  lodctr /R
   ```

## Diagnose connectivity issues

- If you experience a connectivity issue, [collect trace files](#collect-trace-files), compress them, and open a support ticket in the [Azure portal](https://portal.azure.com).

- If you receive a "Service Unavailable" message, the emulator might be failing to initialize the network stack. Check to see if you have the Pulse secure client or Juniper networks client installed, as their network filter drivers may cause the problem. Uninstalling third-party network filter drivers typically fixes the issue. Alternatively, start the emulator with /DisableRIO, which switches the emulator network communication to regular Winsock.

- If you encounter **"Forbidden","message":"Request is being made with a forbidden encryption in transit protocol or cipher. Check account SSL/TLS minimum allowed protocol setting..."** connectivity issues, this error might be caused by global changes in the OS (for example Insider Preview Build 20170) or the browser settings that enable TLS 1.3 as default. Similar error might occur when using the SDK to execute a request against the Azure Cosmos DB emulator, such as **Microsoft.Azure.Documents.DocumentClientException: Request is being made with a forbidden encryption in transit protocol or cipher. Check account SSL/TLS minimum allowed protocol setting**. This error is expected at this time since Azure Cosmos DB emulator only accepts and works with TLS 1.2 protocol. The recommended work-around is to change the settings and default to TLS 1.2. For instance, in IIS Manager navigate to **Sites -> Default Web Sites** and locate the **Site Bindings** for port **8081** and edit them to disable TLS 1.3. Similar operation can be performed for the Web browser via the**Settings** options.

- While the emulator is running, if your computer goes to sleep mode or runs any OS updates, you might see a **Service is currently unavailable** message. Reset the emulator's data, by right-clicking on the icon that appears on the windows notification tray and select **Reset Data**.

## Collect trace files

To collect debugging traces, run the following commands from an administrative command prompt:

1. Navigate to the path where the emulator is installed:

   ```bash
   cd /d "%ProgramFiles%\Azure Cosmos DB Emulator"
   ```

1. Shut down the emulator and watch the system tray to make sure the program has shut down. It may take a minute to complete. You can also select **Exit** in the Azure Cosmos DB emulator user interface.

   ```bash
   Microsoft.Azure.Cosmos.Emulator.exe /shutdown
   ```

1. Start logging with the following command:

   ```bash
   Microsoft.Azure.Cosmos.Emulator.exe /startwprtraces
   ```

1. Launch the emulator

   ```bash
   Microsoft.Azure.Cosmos.Emulator.exe
   ```

1. Reproduce the problem. If the data explorer isn't working, you only need to wait for the browser to open for a few seconds to catch the error.

1. Stop logging with the following command:

   ```bash
   Microsoft.Azure.Cosmos.Emulator.exe /stopwprtraces
   ```

1. Navigate to `%ProgramFiles%\Azure Cosmos DB Emulator` path and find the *docdbemulator_000001.etl* file.

1. Open a support ticket in the [Azure portal](https://portal.azure.com) and include the .etl file along with repro steps.
