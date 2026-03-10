---
title: Troubleshoot Self-Hosted Extension Update Issues in Edge
description: Fix self-hosted Microsoft Edge extensions that fail to update. Follow step-by-step solutions for resolving update issues caused by configuration errors.
ms.date: 03/10/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: sap:Web Platform and Development\Controls and Extensions
---

# Self-hosted extension doesn't update automatically

## Summary

This article helps you resolve issues where a self-hosted Microsoft Edge extension doesn't update automatically after you deploy a new version. You deploy the extension successfully by using the [ExtensionSettings](/deployedge/microsoft-edge-policies#extensionsettings) or [ExtensionInstallForcelist](/deployedge/microsoft-edge-policies#extensioninstallforcelist) Group Policy, but the browser doesn't detect the new version from the update URL. Common causes include a missing `override_update_url` setting in the policy, version mismatches across extension files, and the periodic nature of Edge's update schedule.

## Symptoms

You experience one or more of the following symptoms:

- You deploy a self-hosted extension successfully by using the **ExtensionSettings** or **ExtensionInstallForcelist** policy, but automatic update to a newer version fails.
- You update `manifest.json`, `update.xml`, and the `.crx` package on your server, but Edge still loads the old extension version.
- The update succeeds only after you delete and re-add the registry keys for the extension.
- Edge doesn't immediately detect the new version from the update URL.

## Cause: The override_update_url setting is missing from ExtensionSettings

If you don't set `"override_update_url": true` in the **ExtensionSettings** policy, Edge might ignore the custom `update_url` specified in the extension's `manifest.json` file and not check your server for updates.

### Solution: Add override_update_url to the ExtensionSettings policy

Add the `"override_update_url": true` setting to the **ExtensionSettings** policy for your extension. This setting forces Edge to always use the custom update URL that you specify.

```json
{
  "<Extension_ID>": {
    "installation_mode": "normal_installed",
    "update_url": "https://contoso.com/updates/update.xml",
    "override_update_url": true
  }
}
```

This method is the most stable and recommended approach for enterprise-managed deployments because it ensures that Edge always checks your server for new versions.

For more information, see [ExtensionSettings](/deployedge/microsoft-edge-policies#extensionsettings).

## Cause: Version mismatch between manifest.json and update.xml, or .crx not repacked

When you publish a new extension version, the version number in `manifest.json` must match the version in `update.xml`. Additionally, you must repack the `.crx` package by using the updated `manifest.json` and the same `.pem` key file that you used to create the original package. If the version numbers don't match, or you don't repack the `.crx` package correctly, the update can fail.

### Solution: Update files and repack the extension

When you publish a new version, complete the following steps:

1. `manifest.json`: Update the `"version"` field to the new version number.
1. `update.xml`: Update the version number and the `.crx` codebase path to match the new version.
1. `.crx` package: Repack the extension by using the updated `manifest.json` and the same `.pem` key file that you used to create the original `.crx` package.

## Cause: Edge update check hasn't occurred yet

Edge checks for extension updates periodically. After you publish a new version on your server, the browser might not detect it for several hours or longer. This delay is by design and is expected behavior.

### Solution: Wait for the scheduled update check or trigger a check manually

To manually trigger an update check for testing purposes:

1. Go to `edge://extensions` in the address bar.
1. Turn on **Developer mode**.
1. Select **Update**.

For production environments, the automatic update check occurs within a few hours. You don't need to take any action.

## More troubleshooting steps

If the extension still doesn't update after you apply the preceding solutions, use the following steps to diagnose the issue.

### Validate policy application

1. Go to `edge://policy` in Edge.
1. Verify the following values:
   - The `override_update_url` setting is set to `true`.
   - The `update_url` value is correct.
   - The policy state shows **OK**.

### Validate the update.xml URL

Open the update URL directly in the browser (for example, `https://contoso.com/updates/update.xml`) to confirm that the file is accessible and contains the correct version and `.crx` path.

### Confirm the .crx download URL

Check the `codebase` attribute in `update.xml` to make sure it points to the correct `.crx` file location:

```xml
<updatecheck codebase="https://contoso.com/updates/extension.crx" version="1.0.1" />
```

### Resolve installation blocks during testing

During testing, Edge blocks manual installs when you deploy the extension through the **ExtensionSettings** or **ExtensionInstallForcelist** policy. To work around this limitation during test and debug scenarios, use one of the following options:

- Add the extension ID to the [ExtensionInstallAllowlist](/deployedge/microsoft-edge-policies#extensioninstallallowlist) policy.
- Temporarily remove the **ExtensionSettings** and **ExtensionInstallForcelist** policies.

## Related content

- [Publish updates to an extension](/deployedge/microsoft-edge-manage-extensions-webstore#publish-updates-to-an-extension)
- [Update URL](/microsoft-edge/extensions-chromium/publish/auto-update#update-url)
- [Microsoft Edge—Policies](/deployedge/microsoft-edge-policies)
