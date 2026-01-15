---
title: Fix Desktop Flow Failures from Cache Issues
description: Resolve desktop flow errors in Power Automate that are caused by corrupted or conflicting cache files.
ms.reviewer: spanopoulos, v-shaywood
ms.date: 01/15/2026
ms.custom: sap:Desktop flows
---

# Desktop flows fail from binary caching problems

## Summary

Power Automate for desktop uses binary caching to download and store files locally. This method improves performance and reduces flow execution time. However, corrupted, outdated, or conflicting cache files can cause errors when you run desktop flows.

Use this guide when desktop flows don't run from the cloud or behave unexpectedly. This guide helps you to identify your machine runtime configuration, and clear the appropriate cache folders.

## Symptoms

You experience one or more of the following problems:

- Failed desktop flows that are triggered from the cloud
- Error messages about file conflicts or corrupted files
- Unexpected behavior during flow execution

## Cause

Binary caching stores files locally to optimize performance. Cache errors occur when:

- Cache files become corrupted
- Outdated files conflict with newer versions
- Duplicate files exist in the cache directory

## Solution

Clear the cache folders on your computer. The cache folder location depends on your Power Automate machine runtime configuration.

### Determine your configuration

Identify which user account your service account for the Power Automate machine runtime is configured to use.

1. On the Start menu, open the Power Automate machine runtime application. Or, open the Power Automate Console, and then select **Settings** > **Open machine settings**.

1. On the **Troubleshoot** page, the **Service account** section shows the current configuration, including the domain and username.

   - **Default configuration**: The service account for the Power Automate machine runtime runs under the UIFlowService system account (`NT Service\UIFlowService`).
   - **Custom configuration**: The service account for the Power Automate machine runtime runs under a specific user account that you configured (`DOMAIN\Username`).

### Clear cache for the default configuration (UIFlowService account)

If your service account for the Power Automate machine runtime uses the default UIFlowService account configuration:

1. In File Explorer, go to `C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Cache`.
1. Delete both the `storage` and `metadata` folders.
1. Restart the UIFlowService service:
   1. Press <kbd>Win</kbd>+<kbd>R</kbd> to open the **Run** dialog box.
   1. Type **services.msc**, and press <kbd>Enter</kbd>.
   1. In the list, find and right-click **Power Automate Service**, and then select **Restart**.

### Clear cache for a custom user configuration

If your service account for the Power Automate machine runtime is configured to run under a custom user account:

1. In File Explorer, go to `%LOCALAPPDATA%\Cache` or `C:\Users\<Username>\AppData\Local\Cache`.

   > [!NOTE]
   > By default, the AppData folder is hidden. To show it, open File Explorer, and then select **View** &gt; **Show** &gt; **Hidden items**.

1. Delete all files and folders in the Cache directory.
1. Restart the **Power Automate Service** or restart your device.

### Optional cache folders to clear

If the problem persists, clear these additional folders:

1. Under `%LOCALAPPDATA%\Microsoft\Power Automate Desktop`:
   - `Scripts`: Stores execution logs and cached data for cloud-triggered desktop flows.
   - `Console\Scripts`: Stores execution logs and cached data for flows that are triggered from Power Automate Desktop Console.
   - `Designer\Scripts`: Stores execution logs and cached data for flows that are triggered from Power Automate Desktop Designer.
   - `Cache\(MSI or MSIX)`: Safe to remove all folders except `Account` and the `msalcache.bin3` file.
      - Deleting these folders doesn't cause data loss, but you might see previously dismissed notifications again.
      - If you delete the `Account` folder and `msalcache.bin3` file, you are signed out of Power Automate Desktop.
   - `DesktopFlowModules`: Contains custom modules downloaded from the Asset Library. Missing modules are downloaded again at runtime.
2. Under `C:\Windows\ServiceProfiles\UIFlowService\AppData\Local`:
   - `Microsoft\Power Automate Desktop\Cache`: Depending on your Power Automate Desktop version, some files might be cached here instead of the locations that are listed earlier in the previous sections.
   - `Users`: Contains additional intermediate files that are related to binary caching. Clear this folder to resolve further errors.
   - After you remove files from this path, restart **Power Automate Service** as described in the previous procedures.

If clearing cache folders doesn't resolve the problem, contact [Power Automate support](https://www.microsoft.com/power-platform/products/power-automate/support/).
