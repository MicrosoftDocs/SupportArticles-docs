---
title: Fails to install applications and run shell scripts in macOS 11.2
description: Fixes an issue in which macOS applications cannot be installed in the Intune portal and you cannot run shell scripts on a macOS 11.2 based device.
ms.date: 06/16/2021
ms.prod-support-area-path: App management
ms.reviewer: markstan
---
# Can't install apps and run shell scripts in macOS 11.2

## Symptoms

On a macOS 11.2 (Big Sur) based device, you cannot install an application and the application is displayed as the **Install Pending** status in the Intune portal. In addition, you also cannot run shell scripts that relay on the installation of the Intune Management Extension (also known as Sidecar) app.

When this issue occurs, entries that resemble the following are displayed in a log report in Console:

> [!NOTE]
> The presence of the error code **506** and the **Install request is a duplicate** string is the diagnostic of this issue.

```output
<Date> <Time>.202335-0500  localhost mdmclient[2611]: [com.apple.ManagedClient:ManagedApps] StartInstall using UUID: <ID> for MDM 'Microsoft.Profiles.MDM'
<Date> <Time>.202391-0500  localhost mdmclient[2611]: [com.apple.ManagedClient:ManagedApps] Installing with MDM options: {
    ManagementFlags = 0;
    ManifestURL = "https://euprodimedatapri.blob.core.windows.net/macsidecaragent-<ID>/sidecar_2103.013.plist";
    RequestType = InstallApplication;
}
<Date> <Time>.203299-0500  localhost mdmclient[2611]: [com.apple.ManagedClient:InstallApplication] InstallApplication (UUID:<ID>) (iOS: no) manifest: no
<Date> <Time>.203333-0500  localhost mdmclient[2611]: [com.apple.ManagedClient:AppStore] Calling AppStore -submitManifestRequest.  ID: <ID>  Platform: <macos>  Manifest: no  URL: YES  Certs: no  Pinning: no
<Date> <Time>.453918-0500  localhost mdmclient[2611]: [com.apple.ManagedClient:MDMDaemon] [ERROR] submitManifestRequest completed.  ID: <ID> Error: Error Domain=ASDErrorDomain Code=506 "Install request is a duplicate" UserInfo={NSLocalizedDescription=Install request is a duplicate}
<Date> <Time>.453928-0500  localhost mdmclient[2611]: [com.apple.ManagedClient:MDMDaemon] [ERROR] Assertion Failed.  File: /AppleInternal/BuildRoot/Library/Caches/com.apple.xbs/Sources/MCXTools/MCXTools-1430/ConfigProfiles/mdmclient/AppStoreUtil.mm  Line: 578
<Date> <Time>.454009-0500  localhost mdmclient[2611]: [com.apple.ManagedClient:MDMDaemon] Logging Manifest request failure.  InstallUUID: <ID>  Error: Error Domain=ASDErrorDomain Code=506 "Install request is a duplicate" UserInfo={NSLocalizedDescription=Install request is a duplicate}
<Date> <Time>.457373-0500  localhost mdmclient[2611]: [com.apple.ManagedClient:ManagedApps] Processing install phase 97 for <ID> ==> {
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

## Cause

This is a known issue in macOS 11.2.

## Resolution

To resolve this issue, upgrade the device to macOS 11.3 or a later version.
