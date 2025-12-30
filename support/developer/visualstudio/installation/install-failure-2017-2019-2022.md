---
title: Troubleshoot Visual Studio 2017, 2019, and 2020 Installation Failures
description: Learn how to troubleshoot and resolve Visual Studio installation failures, including online and offline setup issues, with clear, actionable steps.
ms.date: 12/30/2025
ms.reviewer: khgupta, v-shaywood
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Unable to install Visual Studio 2017, 2019, or 2022

_Applies to:_&nbsp;Visual Studio 2017, 2019, and 2022  

When you attempt to install Visual Studio 2017, 2019, or 2022 you might experience an issue where the installation wizard disappears unexpectedly or returns an error message that indicates some installation files couldn't be downloaded. This article provides a solution that resolves these installation issues and enables you to successfully install Visual Studio.

## Symptoms

The symptoms of this issue depends on whether you are attempting an [online install](/visualstudio/install/install-visual-studio) or an [offline install](/visualstudio/install/create-an-offline-installation-of-visual-studio).

### Online install

When you attempt an _online install_ of Visual Studio 2017, 2019, or 2022, the installation wizard shows the following message dialog:

> Before you get started, we need to set up a few things so that you can configure your installation.

:::image type="content" source="./media/install-failure-2017-2019-2022/install-wizard-set-up-things.png" alt-text="Screenshot of the Visual Studio installation wizard with a message that the installer needs to set up a few things so that you can configure your installation":::

After you select **Continue** in the message dialog, the installation wizard disappears and the install stops.

### Offline install

When you attempt an _offline install_ of Visual Studio 2017, 2019, or 2022 on a device with no or limited internet access, the installation wizard shows the following error dialog:

> Unable to download installation files. Check your internet connection and try again.

:::image type="content" source="./media/install-failure-2017-2019-2022/install-wizard-download-error.png" alt-text="Screenshot of the Visual Studio installation wizard with an error message that the installer was unable to download installation files":::

If your device has event logging enabled for the [CryptoAPI (CAPI2)](/windows/win32/seccrypto/cryptography--cryptoapi--and-capicom), you will also see the following error in the CAPI2 [Event Viewer](/host-integration-server/core/windows-event-viewer1) logs (Event ID 30):

:::image type="content" source="./media/install-failure-2017-2019-2022/event-viewer-capi2-errors.png" alt-text="Screenshot of the Event Viewer showing multiple CAPI2 errors with Event ID 30":::

```xml
<Event>
  <UserData>
    <CertVerifyCertificateChainPolicy>
      <Policy type="CERT_CHAIN_POLICY_BASE" constant="1" />
      <Certificate fileRef="8D68C42C0E1487E33AFCD85B764E514AFC2F8772.cer" subjectName="Microsoft Corporation" />
      <CertificateChain chainRef="{6B598FF8-1F8F-429E-AE87-001A5FE49268}" />
      <Flags value="1" CERT_CHAIN_POLICY_IGNORE_NOT_TIME_VALID_FLAG="true" />
      <Status chainIndex="0" elementIndex="-1" />
      <EventAuxInfo ProcessName="vs_setup_bootstrapper.exe" />
      <CorrelationAuxInfo TaskId="{3553E2D5-941F-428B-904E-ADEC5F1F20A7}" SeqNumber="1" />
      <Result value="800B010A">
        A certificate chain could not be built to a trusted root authority.
      </Result>
    </CertVerifyCertificateChainPolicy>
  </UserData>
</Event>
```

The CAPI2 event logs can be accessed from the Event Viewer by going to **Applications and Services Logs** > **Microsoft** > **Windows** > **CAPI2** > **Operational**.

#### Enable CAPI2 logs

Use the following steps to enable CAPI2 event logging:

1. Open Event Viewer by pressing <kbd>Win</kbd> + <kbd>R</kbd>, type _eventvwr_, then press <kbd>Enter</kdb>.
1. Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **CAPI2** > **Operational**.
1. Right-click **Operational** and select **Clear Log** to delete any previous logs.
1. Right-click **Operational** and select **Enable Log** to start logging.

   :::image type="content" source="./media/install-failure-2017-2019-2022/event-viewer-enable-capi2-logs.png" alt-text="Screenshot of the Event Viewer with the right-click menu to clear or enable logs for CAPI2":::

1. Try installing Visual Studio again using the offline installer.
1. After reproducing the issue, the CAPI2 event logs should contain details about the install failure.
1. To stop logging, right-click **Operation** and select **Disable Log**.

## Solution

Use the following steps to resolve this issue:

1. Download the [Microsoft Windows Code Signing PCA 2024](https://www.microsoft.com/pkiops/certs/Microsoft%20Windows%20Code%20Signing%20PCA%202024.crt) certificate using a device that has internet access.
1. Copy the certificate file to `C:\Temp` on the device experiencing install issues.
1. Install the _Microsoft Windows Code Signing PCA 2024_ certificate into the [Trusted Root Certification Authorities store](/windows-hardware/drivers/install/trusted-root-certification-authorities-certificate-store) by running the following command from an elevated command prompt:

   ```cli
   CertUtil -addStore CA "C:\Temp\Microsoft Windows Code Signing PCA 2024.crt"
   ```

1. Try installing Visual Studio again using the offline installer.
