---
title: Fix Visual Studio Setup Issues Due to Missing Certificate
description: Resolve Visual Studio installation errors caused by missing certificates. Learn how to fix online and offline setup issues for Visual Studio 2017 and later.
ms.date: 12/30/2025
ms.reviewer: khgupta, v-shaywood
ms.custom: sap:Installation\Setup, maintenance, or uninstall
---

# Visual Studio installation problems caused by missing certificate

_Applies to:_&nbsp;Visual Studio 2017 and later versions  

When you try to install Microsoft Visual Studio 2017 or a later version, the installation wizard unexpectedly closes or indicates that it can't download some installation files. A missing certificate required for the Visual Studio install can cause this problem. This article provides guidance for resolving the missing certificate problem and enables you to successfully install Visual Studio.

## Symptoms

The symptoms of this problem depend on whether you're trying an [online installation](/visualstudio/install/install-visual-studio) or an [offline installation](/visualstudio/install/create-an-offline-installation-of-visual-studio).

### Online installation

When you try an _online installation_ of Visual Studio 2017 or a later version, the installation wizard displays the following message:

> Before you get started, we need to set up a few things so that you can configure your installation.

:::image type="content" source="./media/install-failure-2017-later-versions/install-wizard-set-up-things.png" alt-text="Visual Studio installation wizard message about configuring the installation.":::

After you select **Continue** in the message dialog box, the installation wizard closes and the installation stops.

### Offline installation

When you try an _offline installation_ of Visual Studio 2017 or a later version on a device that has limited or no internet access, the installation wizard displays the following error message:

> Unable to download installation files. Check your internet connection and try again.

:::image type="content" source="./media/install-failure-2017-later-versions/install-wizard-download-error.png" alt-text="Visual Studio installation wizard error message that states that the installer can't download installation files.":::

If your device has event logging enabled for the [CryptoAPI (CAPI2)](/windows/win32/seccrypto/cryptography--cryptoapi--and-capicom), you also see the following error message in the CAPI2 [Event Viewer](/host-integration-server/core/windows-event-viewer1) logs (Event ID 30):

:::image type="content" source="./media/install-failure-2017-later-versions/event-viewer-capi2-errors.png" alt-text="Event Viewer display that shows multiple CAPI2 errors and Event ID 30.":::

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

To access the CAPI2 event logs from the Event Viewer, go to **Applications and Services Logs** > **Microsoft** > **Windows** > **CAPI2** > **Operational**.

#### Enable CAPI2 logs

To enable CAPI2 event logging, follow these steps:

1. Open Event Viewer by pressing <kbd>Win</kbd> + <kbd>R</kbd>, type _eventvwr_, and then press <kbd>Enter</kdb>.
1. Navigate to **Applications and Services Logs** > **Microsoft** > **Windows** > **CAPI2** > **Operational**.
1. To delete any previous logs, right-click **Operational**, and then select **Clear Log**.
1. To start logging, right-click **Operational**, and then select **Enable Log**.

   :::image type="content" source="./media/install-failure-2017-later-versions/event-viewer-enable-capi2-logs.png" alt-text="Event Viewer showing the right-click menu to clear or enable logs for CAPI2.":::

1. Try again to install Visual Studio by using the offline installer.
1. After you reproduce the problem, the CAPI2 event logs should contain details about the installation failure.
1. To stop logging, right-click **Operation**, and then select **Disable Log**.

## Cause

This problem can occur for one of the following reasons, depending on the type of installation:

- _Offline installation_: The device doesn't have the latest [Microsoft Windows Code Signing PCA 2024](https://www.microsoft.com/pkiops/certs/Microsoft%20Windows%20Code%20Signing%20PCA%202024.crt) certificate that Visual Studio uses.
- _Online installation_: The device's internet access is restricted, and the user doesn't have permission to download the [Microsoft Windows Code Signing PCA 2024](https://www.microsoft.com/pkiops/certs/Microsoft%20Windows%20Code%20Signing%20PCA%202024.crt) certificate.

## Solution

To resolve this problem, follow these steps:

1. Download the [Microsoft Windows Code Signing PCA 2024](https://www.microsoft.com/pkiops/certs/Microsoft%20Windows%20Code%20Signing%20PCA%202024.crt) certificate by using a device that has internet access.
1. Copy the certificate file to `C:\Temp` on the device that experiences the installation problem.
1. Install the _Microsoft Windows Code Signing PCA 2024_ certificate in the [Trusted Root Certification Authorities store](/windows-hardware/drivers/install/trusted-root-certification-authorities-certificate-store). You can install the certificate by using either the _Certificate Import Wizard_ or command line:

   - To install using the command line, run the following command in an elevated Command Prompt window:

     ```cli
     CertUtil -addStore CA "C:\Temp\Microsoft Windows Code Signing PCA 2024.crt"
     ```

   - To install using the _Certificate Import Wizard_:

     1. Right-click the certificate file and select **Install Certificate**.
     1. In the _Certificate Import Wizard_, choose **Local Machine** and select **Next**.
     1. Select **Place all certificates in the following store**.
     1. Select **Browse...** and choose **Trusted Root Certification Authorities**.
     1. Select **Next**, then select **Finish** to install the certificate.

1. Try again to install Visual Studio by using the offline installer.
