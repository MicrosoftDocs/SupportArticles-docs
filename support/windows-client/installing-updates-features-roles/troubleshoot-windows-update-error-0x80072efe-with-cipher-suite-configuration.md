---
title: Troubleshoot Windows Update error 0x80072EFE with cipher suite configuration
description: This article introduces how to troubleshoot Windows Update error 0x80072EFE by updating the cipher suite configuration.
ms.date: 09/12/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: abjos, 5x5dnd
ms.custom: sap:Windows Servicing, Updates and Features on Demand\Windows Update fails - installation stops with error, csstroubleshoot
---
# Troubleshoot Windows Update error 0x80072EFE with cipher suite configuration

The Windows Update error 0x80072EFE typically indicates a connection issue between your computer and the Windows Update servers. This error can occur due to network problems, proxy settings, or Transport Layer Security (TLS)) configuration issues. If you encounter the error and have verified other network components, the issue can also be related to your cipher suite configuration.

This article provides steps to troubleshoot and resolve the error 0x80072EFE by adjusting the cipher suite configuration in the Windows registry.

*Applies to*: &nbsp; Windows 10 or later, Windows Server 2016, and later versions of Windows


## Step 1: Review the Windows Update log

From the following log snippet, the connection attempts to the update server repeatedly fail with the error code 80072EFE. The retry attempts also suggest that this is likely a network-related issue.

Example log entry:

```output
YYYY/MM/DD HH:MM:SS.4926861 22576 27056 SLS             Making request with URL <HTTPS://slscr.update.microsoft.com/SLS/{<GUID>>}/x64/<build>/0?CH=253&L=en-US&P=&PT=0x7&WUA=10.0.20348>. and send SLS events.  
YYYY/MM/DD HH:MM:SS.6134275 22576 27056 Misc            FAILED [80072EFE] Send request  
YYYY/MM/DD HH:MM:SS.6134448 22576 27056 Misc            FAILED [80072EFE] WinHttp: SendRequestToServerForFileInformation (retrying with default proxy)  
YYYY/MM/DD HH:MM:SS.6852866 22576 27056 Misc            FAILED [80072EFE] Send request  
YYYY/MM/DD HH:MM:SS.6853083 22576 27056 Misc            FAILED [80072EFE] Library download error. Will retry. Retry Counter:0  
YYYY/MM/DD HH:MM:SS.7565671 22576 27056 Misc            FAILED [80072EFE] Send request  
YYYY/MM/DD HH:MM:SS.7565831 22576 27056 Misc            FAILED [80072EFE] WinHttp: SendRequestToServerForFileInformation (retrying with default proxy)  
YYYY/MM/DD HH:MM:SS.8197611 22576 27056 Misc            FAILED [80072EFE] Send request  
YYYY/MM/DD HH:MM:SS.8197827 22576 27056 Misc            FAILED [80072EFE] Library download error. Will retry. Retry Counter:1  
0x80072efe -2147012866 WININET_E_CONNECTION_ABORTED The connection with the server was terminated abnormally winerror.h  
```

## Step 2: Verify the cipher suite configuration

If you have specific cipher suites configured in the Windows registry key `HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002`, these settings might be preventing the Windows Update client from establishing a secure connection.

Important cipher suites to check:

- TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA256

Ensure that at least one of these cipher suites is present in your configuration.

For more information about cipher suites, see [Cipher Suites in TLS/SSL (Schannel SSP)](/windows/win32/secauthn/cipher-suites-in-schannel).

## Step 3: Adjust the cipher suite order

If the required cipher suites are present but you're still experiencing issues, consider adjusting their order in the registry. Sometimes, the sequence in which the cipher suites are listed can affect their selection during the handshake process.

How to modify the cipher suites:

1. Press the Windows key+<kbd>R</kbd>, type *regedit*, and press <kbd>Enter</kbd>.
2. Navigate to the cipher suite configuration:

   `HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002`

3. Locate the cipher suites mentioned in [Step 2](#step-2-verify-the-cipher-suite-configuration) and ensure they're listed. If they're present but lower in the list, try to move them higher or even to the top.
4. If any of the cipher suites is missing, add it manually. To do so, right-click the registry key, select **Modify**, and then enter the correct suite name in the appropriate order.

## Step 4: Restart the computer

After making changes to the cipher suite configuration, you need to restart the computer for the settings to take effect.

## Step 5: Test the Windows Update connection

After the computer restarts, follow these steps to try Windows Update again:

1. Open **Settings** > **Update & Security** > **Windows Update**.
2. Select **Check for updates**.
