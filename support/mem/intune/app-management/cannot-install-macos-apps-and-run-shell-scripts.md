---
title: App installation and shell script execution fail in macOS 11.2
description: Resolves a known issue in which applications don't install and shell scripts don't run on devices that run macOS 11.2.x.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:AppDeployment - MacOS\MacoS(DMG
ms.reviewer: kaushika, markstan, v-six
---
# Apps don't install and shell scripts don't run in macOS 11.2

## Symptoms

You experience the following issues on a macOS Big Sur 11.2._x_-based device:

- Apps can't be downloaded and installed.
- The app installation status shows **Install Pending** in the Microsoft Intune admin center indefinitely.
- Shell scripts don't run because the Microsoft Intune management agent can't be installed successfully.

> [!NOTE]
> These issues might occur sporadically. Not all macOS 11.2._x_ clients in a tenant experience the issues.

When these issues occur, entries that resemble the following example are logged on the device console:

```output
<Time>  localhost mdmclient[2611]: [com.apple.ManagedClient:ManagedApps] StartInstall using UUID: <ID> for MDM 'Microsoft.Profiles.MDM'
<Time>  localhost mdmclient[2611]: [com.apple.ManagedClient:ManagedApps] Installing with MDM options: {
    ManagementFlags = 0;
    ManifestURL = "https://euprodimedatapri.blob.core.windows.net/macsidecaragent-<ID>/sidecar_2103.013.plist";
    RequestType = InstallApplication;
}
<Time>  localhost mdmclient[2611]: [com.apple.ManagedClient:InstallApplication] InstallApplication (UUID:<ID>) (iOS: no) manifest: no
<Time>  localhost mdmclient[2611]: [com.apple.ManagedClient:AppStore] Calling AppStore -submitManifestRequest.  ID: <ID>  Platform: <macos>  Manifest: no  URL: YES  Certs: no  Pinning: no
<Time>  localhost mdmclient[2611]: [com.apple.ManagedClient:MDMDaemon] [ERROR] submitManifestRequest completed.  ID: <ID> Error: Error Domain=ASDErrorDomain Code=506 "Install request is a duplicate" UserInfo={NSLocalizedDescription=Install request is a duplicate}
<Time>  localhost mdmclient[2611]: [com.apple.ManagedClient:MDMDaemon] [ERROR] Assertion Failed.  File: /AppleInternal/BuildRoot/Library/Caches/com.apple.xbs/Sources/MCXTools/MCXTools-1430/ConfigProfiles/mdmclient/AppStoreUtil.mm  Line: 578
<Time>  localhost mdmclient[2611]: [com.apple.ManagedClient:MDMDaemon] Logging Manifest request failure.  InstallUUID: <ID>  Error: Error Domain=ASDErrorDomain Code=506 "Install request is a duplicate" UserInfo={NSLocalizedDescription=Install request is a duplicate}
<Time>  localhost mdmclient[2611]: [com.apple.ManagedClient:ManagedApps] Processing install phase 97 for <ID> ==> {
    "__Error__" =     {
        code = 506;
        domain = ASDErrorDomain;
        userInfo =         {
            NSLocalizedDescription = "Install request is a duplicate";
        };
    };
    "__Success__" = 0;
}
```

> [!NOTE]
> The presence of error code **506** and an **Install request is a duplicate** entry in the log are evidence of this issue.

## Cause

This is a known issue in macOS 11.2._x_.

## Solution

To fix this issue, upgrade the device to macOS 11.3 or a later version.
