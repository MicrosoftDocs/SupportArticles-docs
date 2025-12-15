---
title: Troubleshoot Binary caching issues in Desktop flow executions triggered from cloud
description: Resolve issues due to conflicting or duplicate files in the disk, related to the binary caching feature in Power Automate for desktop.
author: sokopa
ms.author: spanopoulos
ms.reviewer: spanopoulos
ms.date: 12/15/2025
ms.custom: sap:Desktop flows
---

# Troubleshooting Binary Caching issues

This article provides solutions to resolve issues caused by conflicting or duplicate files in the disk cache. The binary caching feature in Power Automate for desktop downloads and stores files locally to reduce flow execution time, but corrupted or outdated cache files can sometimes cause errors during desktop flow execution.

## Clear cache folders

If you encounter errors during desktop flow execution, you can attempt to resolve them by clearing the cache folders on your machine. The cache folder location depends on how the Power Automate Desktop Machine Runtime is configured.

### Determine your configuration

Before clearing the cache, identify which user account your Service account for the Power Automate machine runtime is configured to use.

This can be found in the Power Automate machine runtime application, which can be accessed from its shortcut in the Windows Start Menu or from Power Automate Console, via Settings -> Open machine settings.

Under the Troubleshoot page, the section for Service account indicates the current configuration, with the domain and username of the account that will be used.

- **Default configuration**: The Service account for the Power Automate machine runtime runs under the UIFlowService system account (NT Service\UIFlowService)
- **Custom configuration**: The Service account for the Power Automate machine runtime runs under a specific user account that you configured (DOMAIN\Username)

### Clear cache for default configuration (UIFlowService account)

If your Service account for the Power Automate machine runtime uses the default UIFlowService account configuration:

1. Open File Explorer and navigate to the cache folder: `C:\Windows\ServiceProfiles\UIFlowService\AppData\Local\Cache`
2. Delete both folders under this path (`storage` and `metadata`)
3. Restart the UIFlowService service:
   - Press <kbd>Win</kbd>+<kbd>R</kbd> to open the **Run** dialog
   - Type **services.msc** and press <kbd>Enter</kbd>
   - Locate **Power Automate Service** in the list
   - Right-click on **Power Automate Service** and select **Restart**

### Clear cache for custom user configuration

If your Service account for the Power Automate machine runtime is configured to run under a custom user account:

1. Open File Explorer and navigate to the cache folder: `%LOCALAPPDATA%\Cache` or `C:\Users\<username>\AppData\Local\Cache` (where `<username>` is the configured user account)
   > [!NOTE]
   > The AppData folder is hidden by default. To show hidden folders, in File Explorer, go to **View** > **Show** > **Hidden items**.

2. Delete all files and folders in the Cache directory
3. Restart the **Power Automate Service** or restart your machine

## Next steps

Additional folders that you can safely clear in case you encounter errors with desktop flow execution:

1. Under `%LOCALAPPDATA%\Microsoft\Power Automate Desktop`:
   - `Scripts`: Contains execution logs and intermediate cached data for desktop flows triggered by a cloud flow
   - `Console\Scripts`: Contains execution logs and intermediate cached data for desktop flows triggered by PAD Console
   - `Designer\Scripts`: Contains execution logs and intermediate cached data for desktop flows triggered by PAD Designer
   - `Cache\(MSI or MSIX)`: All folders except `Account` and `msalcache.bin3` file are safe to remove and will not result in any data loss. You might get back some notifications that you have previously dismissed. If you also choose to delete `Account` folder and the `msalcache.bin3` file, you will be signed out from Power Automate Desktop.
   - `DesktopFlowModules`: Contains custom modules that have been downloaded through the Asset Library - they will be downloaded again during runtime if they are missing.
2. Under `C:\Windows\ServiceProfiles\UIFlowService\AppData\Local`:
   - `Microsoft\Power Automate Desktop\Cache`: depending on your PAD version, you might have some files being cached under this directory instead of the ones mentioned in the previous section
   - `Users`: additional intermediate files can be located here related to binary caching, and purging this folder can be used to eliminate further errors.
   - After removing any files under this path, also make sure to restart the **Power Automate Service** as previously instructed.

If clearing the cache folders doesn't resolve your issue, contact [Power Automate support](https://www.microsoft.com/power-platform/products/power-automate/support/).