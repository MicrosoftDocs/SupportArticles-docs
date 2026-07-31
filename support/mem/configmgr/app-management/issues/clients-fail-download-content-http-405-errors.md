---
title: Clients fail to download content with HTTP 405 errors
description: Helps resolve HTTP 405 errors that prevent Configuration Manager clients from downloading content from a distribution point when WebDAV is enabled.
ms.date: 07/30/2026
ms.reviewer: payur
ms.custom: sap:Application Management\Application Download
ai-usage: ai-assisted
---
# Clients fail to download content from a distribution point with HTTP 405 errors

## Summary

This article helps you resolve an issue in which Microsoft Configuration Manager clients can't download content from a distribution point and receive HTTP 405 (Method Not Allowed) errors. This issue occurs when Web Distributed Authoring and Versioning (WebDAV)  Publishing role service is installed and enabled in Internet Information Services (IIS) on the distribution point server. WebDAV isn't supported on Configuration Manager distribution points and interferes with client content download requests.

## Symptoms

When clients try to download content from a Configuration Manager distribution point, the download fails. Eventually, in the Configuration Manager console, the **Deployment Status** workspace shows error `0x800705b4` (**Download timeout**).

The following entries are logged in DataTransferService.log on the client:

```output
GetDirectoryList_HTTP Error sending DAV request. HTTP code 405, status 'Method Not Allowed'
GetDirectoryList_HTTP GetDirectoryList_HTTP failed after retry
GetDirectoryList_HTTP GetDirectoryList_HTTP('https://DP.Contoso.com:443/SMS_DP_SMSPKG$/Content_<ContentGUID>.1') failed with code 0x87d0027e.
DTSJob({<DTSJobGUID>}):CDTSJob::ProcessManifestCallback - Error retrieving manifest (0x87d0027e).

```

The Internet Information Services (IIS) logs on the distribution point server contain `405 0` responses to `PROPFIND` requests for the `SMS_DP_SMSPKG$` or `CCMTOKENAUTH_SMS_DP_SMSPKG$` virtual directory for the content being downloaded. The log entries resemble the following:

```output
W3SVC1 192.168.2.20 PROPFIND /SMS_DP_SMSPKG$/Content_<ContentGUID>.1 - 443 Contoso\Client$ 192.168.2.10 SMS+CCM+5.0 405 0 0 1820 3
W3SVC1 192.168.2.20 PROPFIND /NOCERT_SMS_DP_SMSPKG$/Content_<ContentGUID>.1 - 443 Contoso\Client$ 192.168.2.10 SMS+CCM+5.0 405 0 0 1820 4
W3SVC1 192.168.2.20 PROPFIND /CCMTOKENAUTH_SMS_DP_SMSPKG$/Content_<ContentGUID>.1 - 443 - 192.168.2.10 SMS+CCM+5.0 405 0 0 1519 4
```

## Cause

The WebDAV Publishing role service is installed and enabled in IIS on the distribution point server. WebDAV isn't supported on Configuration Manager distribution points and interferes with client content requests.

## Resolution

Remove the WebDAV Publishing role service from the distribution point server:

1. On the distribution point server, open **Server Manager**.
1. Select **Manage** > **Remove Roles and Features**.
1. In the wizard, go to **Server Roles** > **Web Server (IIS)** > **Web Server** > **Common HTTP Features**.
1. Clear **WebDAV Publishing**, and then complete the wizard.
1. Restart IIS or the server if prompted.

After you remove WebDAV, wait until Configuration Manager client retries the content download. If the download already hit the timeout, update the content version of an application or a package - or just recreate the deployment. Confirm that the download succeeds and that the IIS log no longer records HTTP 405 responses for the client requests.
