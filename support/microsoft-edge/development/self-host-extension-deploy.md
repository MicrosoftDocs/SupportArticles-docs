---
title: Troubleshoot Self-Hosted Extension Deployment Group Policy Issues
description: Learn how to resolve deployment issues for self-hosted extensions in Microsoft Edge when you use Group Policy policies.
ms.custom: 'sap:Web Platform and Development\Connectivity and Navigation: TCP, HTTP, TLS, DNS, Proxies, Downloads'
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.date: 01/12/2026
---

# Self-hosted extension deployment fails in Group Policy

When you try to deploy a self-hosted extension through Group Policy, you experience an problem in which the extension doesn't appear for the target user. This article provides guidance for how to identify and resolve the cause of this problem so that you can successfully deploy the extension.

## Symptoms

When you deploy a browser extension to Microsoft Edge by using the Group Policy [ExtensionInstallForcelist](/DeployEdge/microsoft-edge-browser-policies/extensioninstallforcelist) or [ExtensionSettings](/DeployEdge/microsoft-edge-browser-policies/extensionsettings), the deployment fails, and the extension doesn't appear on the `edge://extensions` page for the target users.

However, if you manually drag the same extension package (`.crx` file) onto the `edge://extensions` page by having [Developer mode](/microsoft-edge/extensions/getting-started/extension-sideloading#locally-installing-and-running-an-extension) enabled, the extension installs successfully.

## Cause 1: Incorrect group policy configuration

This problem occurs because the Group Policy **ExtensionInstallForcelist** or **ExtensionSettings** policy is configured incorrectly.

### Solution: Verify and correct the Group Policy configuration

Verify and correct the Group Policy extension configuration by using the following documentation:

- [ExtensionInstallForcelist](/deployedge/microsoft-edge-browser-policies/extensioninstallforcelist)
- [ExtensionSettings](/deployedge/microsoft-edge-browser-policies/extensionsettings)

## Cause 2: Incorrect Content-Type header for the .crx file

When you host the extension on an internal HTTP or HTTPS server, and the server doesn't return the correct **Content-Type** header for the `.crx` file, the extension deployment fails.

If the `.crx` file isn't served by using the header, `Content-Type: application/x-chrome-extension`, Microsoft Edge or any other Chromium-based browser won't treat the file as an installable extension package when it's downloaded as part of the Group Policy installation flow.

As a result, the policy is processed, but the browser doesn't silently install the extension.

### Solution: Configure the web server to return the correct content type

Configure the web server to return the correct `Content-Type` for `.crx` files. The HTTP response for the extension package must include the following header:

```http
Content-Type: application/x-chrome-extension
```

After you configure this header, Microsoft Edge recognizes the `.crx` file as an installable extension when it's downloaded through the policy.

#### Example: Configure MIME mapping on IIS

1. In **IIS Manager**, select the target site that hosts the extension.
1. Double-click **MIME Types**.
1. In the **Actions** pane, select **Add…**.
1. Set **File name extension** to `.crx`.
1. Set **MIME type** to `application/x-chrome-extension`.
1. Select **OK**, then recycle the website or application pool, if it's necessary.

## Cause 3: Invalid extension manifest or update manifest XML

The extension metadata in `manifest.json` or in the _update manifest XML_ is invalid, such as in the following examples:

- The `version` field in `manifest.json` uses an invalid format (for example, `1.0-beta` or other non-numeric characters).
- The _update manifest XML_ that's used for self-hosted updates contains invalid or inconsistent values (for example, mismatched version numbers or malformed XML).

In these cases, manual drag-and-drop installation might succeed in some scenarios. However, policy-based installation or automatic updates might fail.

### Solution: Validate and correct the extension manifests

Validate and correct the extension manifest or update manifest XML by following the Chrome documentation (applies also to Microsoft Edge and other Chromium-based browsers):

- [Manifest - Version](https://developer.chrome.com/docs/extensions/reference/manifest/version)
- [Self-host for Linux - Update manifest](https://developer.chrome.com/docs/extensions/how-to/distribute/host-on-linux#update_manifest)

## Related content

- [Self-host for Linux - Host](https://developer.chrome.com/docs/extensions/how-to/distribute/host-on-linux#hosting)

[!INCLUDE [Third-party disclaimer](~/includes/third-party-disclaimer.md)]
