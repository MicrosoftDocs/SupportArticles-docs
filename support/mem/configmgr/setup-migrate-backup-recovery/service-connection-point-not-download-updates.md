---
title: A service connection point doesn't download updates
description: Fixes an issue where a service connection point in Configuration Manager doesn't download updates. This issue occurs when the Baltimore CyberTrust Root certificate is missing, expired, or corrupted.
ms.date: 12/05/2023
ms.reviewer: kaushika
---
# Configuration Manager service connection point doesn't download updates

This article helps you fix an issue where a service connection point doesn't download updates. This issue occurs when the Baltimore CyberTrust Root certificate is missing, expired, or corrupted.

_Original product version:_ &nbsp; Configuration Manager (current branch), Microsoft Intune  
_Original KB number:_ &nbsp; 3187516

## Symptoms

A service connection point that's running in a Configuration Manager current branch environment doesn't download updates, and entries that resemble the following are logged in DMPDownloader.log:

> Download manifest.cab SMS_DMP_DOWNLOADER 8/2/2016 2:20:24 PM 7568 (0x1D90)  
> WARNING: Failed to download easy setup payload with exception: The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel. SMS_DMP_DOWNLOADER 8/2/2016 2:20:25 PM 10760 (0x2A08)  
> WARNING: Retry in the next polling cycle SMS_DMP_DOWNLOADER 8/2/2016 2:20:25 PM 10760 (0x2A08)

You may also notice client connectivity issues when you use Microsoft Intune.

## Cause

The service connection point uses the Intune service when it connects to [http://go.Microsoft.com](https://go.Microsoft.com) or [https://manage.Microsoft.com](https://manage.microsoft.com). If the Baltimore CyberTrust Root certificate is missing, expired, or corrupted, the Intune connection attempt is rejected.

## Resolution

This is a known issue for Intune, as documented in [Connectivity issues may occur when the Baltimore CyberTrust root certificate is not installed](../../intune/certificates/fix-connectivity-issues.md). However, this update is no longer displayed on the Microsoft Update Catalog.

As a workaround, you can export the certificate from the certificate authority in your environment.

After you've obtained the certificate, you must import it. To import the certificate, follow these steps:

1. Open a command prompt with administrative rights (run as Administrator).
2. Run the `mmc` command.
3. On the **File** menu, select **Add/Remove Snap-in**.
4. Select **Certificates**, and then select **Add**.
5. Select **Computer Account**, and then select **Next**.
6. Select **Local Computer**, select **Finish**, and then select **OK**.
7. In the console tree, expand **Certificates** > **Trusted Root Certificate Authorities** > **Certificates**.
8. Right-click **Certificates**, and then select **Import**.
9. Import the Baltimore CyberTrust Root certificate.
10. Restart the computer.

You should now see an entry for Baltimore CyberTrust Root under **Trusted Root Certificate Authority**:

:::image type="content" source="media/service-connection-point-not-download-updates/certificate.png" alt-text="Screenshot of Baltimore CyberTrust Root entry." lightbox="media/service-connection-point-not-download-updates/certificate.png":::

## More information

The Intune Connector experiences connectivity issues if the Baltimore CyberTrust Root certificate is not installed, is expired, or is corrupted on the computer that's using Intune.

For more information about this issue, see [Connectivity issues may occur when the Baltimore CyberTrust root certificate is not installed](../../intune/certificates/fix-connectivity-issues.md).
