---
title: Fix Desktop Flow Failures from Cache Issues
description: Resolve desktop flow errors in Power Automate caused by corrupted or conflicting cache files. Learn how to clear cache folders and fix execution issues.
ms.reviewer: spanopoulos, v-shaywood
ms.date: 01/15/2026
ms.custom: sap:Desktop flows
---

# Desktop flows fail due to binary caching problems

## Summary

Power Automate for desktop uses binary caching to download and store files locally. This method improves performance and reduces flow execution time. However, corrupted, outdated, or conflicting cache files can cause errors when running desktop flows.

Use this guide when desktop flows fail to execute from the cloud or behave unexpectedly. You can learn how to identify your machine runtime configuration and clear the appropriate cache folders.

## Symptoms

You might experience one or more of the following problems:

- Desktop flows fail when triggered from the cloud
- Error messages about file conflicts or corrupted files
- Unexpected behavior during flow execution

## Cause

Binary caching stores files locally to optimize performance. Cache errors occur when:

- Cache files become corrupted
- Outdated files conflict with newer versions
- Duplicate files exist in the cache directory

## Solution

Clear the cache folders on your machine. The cache folder location depends on your Power Automate machine runtime configuration.

### Determine your configuration

First, identify which user account your service account for the Power Automate machine runtime is configured to use.

1. Open the Power Automate machine runtime application from the Windows Start menu, or from Power Automate Console via **Settings** > **Open machine settings**.

1. On the **Troubleshoot** page, the **Service account** section shows the current configuration, including the domain and username.

   - **Default configuration**: The service account for the Power Automate machine runtime runs under the UIFlowService system account (`NT Service\UIFlowService`).
   - **Custom configuration**: The service account for the Power Automate machine runtime runs under a specific user account you configured (`DOMAIN\Username`).

### Clear cache for the default configuration (UIFlowService account)

If your service account for the Power Automate machine runtime uses the default UIFlowService account configuration:

1. In File Explorer, go to `C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Cache`.
1. Delete both the `storage` and `metadata` folders.
1. Restart the UIFlowService service:
   1. Press <kbd>Win</kbd>+<kbd>R</kbd> to open the **Run** dialog.
   1. Type **services.msc** and press <kbd>Enter</kbd>.
   1. Find **Power Automate Service** in the list.
   1. Right-click **Power Automate Service** and select **Restart**.

### Clear cache for a custom user configuration

If your service account for the Power Automate machine runtime is configured to run under a custom user account:

1. In File Explorer, go to `%LOCALAPPDATA%\Cache` or `C:\Users\<Username>\AppData\Local\Cache` (replace `<Username>` with the configured account).

   > [!NOTE]
   > The AppData folder is hidden by default. To show it, in File Explorer select **View** > **Show** > **Hidden items**.

1. Delete all files and folders in the Cache directory.
1. Restart the **Power Automate Service** or restart your machine.

### Optional cache folders to clear

If the problem persists, clear these additional folders:

1. Under `%LOCALAPPDATA%\Microsoft\Power Automate Desktop`:
   - `Scripts`: Stores execution logs and cached data for cloud-triggered desktop flows.
   - `Console\Scripts`: Stores execution logs and cached data for flows triggered from Power Automate Desktop Console.
   - `Designer\Scripts`: Stores execution logs and cached data for flows triggered from Power Automate Desktop Designer.
   - `Cache\(MSI or MSIX)`: Safe to remove all folders except `Account` and the `msalcache.bin3` file.
      - Deleting these folders doesn't cause data loss, but you might see previously dismissed notifications again.
      - If you delete the `Account` folder and `msalcache.bin3` file, you'll be signed out of Power Automate Desktop.
   - `DesktopFlowModules`: Contains custom modules downloaded from the Asset Library. Missing modules are downloaded again at runtime.
2. Under `C:\Windows\ServiceProfiles\UIFlowService\AppData\Local`:
   - `Microsoft\Power Automate Desktop\Cache`: Depending on your Power Automate Desktop version, some files might be cached here instead of the locations listed earlier.
   - `Users`: Contains additional intermediate files related to binary caching. Clearing this folder can resolve further errors.
   - After removing files from this path, restart **Power Automate Service** as described earlier.

If clearing cache folders doesn't resolve the problem, contact [Power Automate support](https://www.microsoft.com/power-platform/products/power-automate/support/).
