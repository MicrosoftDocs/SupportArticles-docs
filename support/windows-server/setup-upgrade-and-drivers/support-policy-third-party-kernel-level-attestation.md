---
title: Support policy for third-party, kernel-level software
description: Describes the support that Microsoft Support provides for Microsoft software products, when you run that product together with attestation-signed kernel-level drivers and any associated physical devices or applications.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, sandyar, cpuckett
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Support policy for third-party, kernel-level software that is signed using the attestation process in Windows

This article describes the support that Microsoft Support provides for Microsoft software products, such as the Windows Server operating system (all versions), when you run that Microsoft product together with attestation-signed kernel-level drivers and any associated physical adapter, controller, or other device or application.

> [!NOTE]
> The attestation signing process for a third-party, kernel-level driver does not require that the driver vendor provide test results in order to obtain a driver signature from Microsoft. For more information, see [Attestation signing a kernel driver for public release](/windows-hardware/drivers/dashboard/attestation-signing-a-kernel-driver-for-public-release).

_Original KB number:_ &nbsp; 4519013

## Check whether the drivers are fully tested and supported

Except as described in this article, Microsoft Support does not support software that has kernel-level drivers that are attestation-signed. Additionally, Microsoft does not support any physical device, filter driver, or application that is associated with that software.

Microsoft supports drivers for physical devices, filters, and applications that are tested by using the test kit that is appropriate for the version of the Windows Server operating system for which the driver was submitted and then either signed or certified by Microsoft.

If a customer-reported problem is caused by an attestation-signed kernel driver, Microsoft Support engineers may try to determine the origin of the driver by asking whether any drivers have been recently updated.

This can be determined by checking the *Setupapi.dev.log* file that is located at *%SystemRoot%\\inf*.

If any drivers were recently installed, they can be examined to learn whether they were tested and submitted for signature or were signed by using the attestation process.

Microsoft Support engineer may also check either the [Windows Server Catalog](https://www.windowsservercatalog.com) or the [Windows Compatible Products List](https://partner.microsoft.com/dashboard/hardware/search/cpl) to determine whether the device and driver were tested, submitted, and certified or signed recently. You can do it by searching for the vendor name value in the Windows Compatible Products List, and entering an asterisk in the **Product Name** field. For example, see the following screenshot.

:::image type="content" source="media\support-policy-third-party-kernel-level-attestation\windows-compatible-products-list.png" alt-text="Screenshot of the Windows Compatible Products List window, in which you can test the hardware to meet Microsoft's compatibility requirements." lightbox="media\support-policy-third-party-kernel-level-attestation\windows-compatible-products-list.png":::

The **Certifications** column indicates the Windows or Windows Server operating system versions, editions, and processor platforms for which the product was tested and submitted.

> [!NOTE]
> The same information is available in the Verification Report.

You can also use [Windows Server Catalog](https://www.windowsservercatalog.com) to check whether a product is using a driver that was recently tested, submitted, and signed. To do this, use the **Search** functionality in Windows Server Catalog for the product name, driver name, or vendor name.

:::image type="content" source="media\support-policy-third-party-kernel-level-attestation\windows-server-catalog.png" alt-text="Screenshot of the Windows Server Catalog window with a Search field to check whether a product is using a driver that was recently tested, submitted, and signed." border="true":::

> [!NOTE]
> A driver may be listed as **Signature Only**. It indicates that the device or driver had no matching defined Product Type. However, the requirements that do apply to that product were validated by the tests in the relevant kit, and the driver was submitted.

A driver may have been signed by using the attestation process as part of the following scenario:

- The driver may have been previously tested, and the results submitted for certification or signature. Support may check the sources in the previous section to verify that information.
- The vendor may have had to provide the driver with a hotfix immediately to a customer to mitigate or fix a serious problem for that customer.
- The vendor may not have been able to take the time to run the full test list that is mandated for that Product type. It is because such a test can take days or even weeks to complete. Therefore, the vendor used the attestation process to provide some relief for that customer.

    > [!NOTE]
    > In this case, the likelihood is low that a regression occurred from a single hotfix that caused some additional issue in regards to security, reliability, or compatibility.

In this scenario, the driver should be considered as being fully tested and supported.

## Support policy

A vendor may have an established support relationship with Microsoft for either of the following reasons:

- The vendor is a [TSANet](https://tsanet.org) member and uses the TSANet process and path.
- The vendor has a Premier-level support contract.

For Microsoft customers who have Premier-level support and have Windows Server systems that are running attestation-signed kernel-level drivers from a vendor with which Microsoft has an established support relationship, Microsoft will coordinate with the vendor to jointly investigate support issues.

As part of the investigation, Microsoft will determine whether there are Test Kit results for the kit that is associated with that version of the Windows Server operating system that were submitted in the recent past for the kernel-level driver that is determined to be currently attestation-signed. In this context, the "recent past" is a period of no more than two or three months. This is based on the average time between tested submissions for products that use drivers.

For Microsoft customers who have Premier-level support and have Windows Server systems that are running attestation-signed kernel-level drivers from a vendor with which Microsoft does not have an established support relationship, Microsoft will investigate potential issues that affect Microsoft software as follows:

- If the driver is certified or was signed in the recent past because of a previous tested submission, Microsoft will support Microsoft products as if the vendor product and kernel-level driver and associated physical product or application are still certified based on full test results.
- If the driver has not been certified or signed in the recent past because of a previous tested submission, the Premier-level customer will be directed to contact the vendor that provided the attestation-signed kernel-level driver for any further support.

Regardless of the support relationship between Microsoft and the vendor that is providing the attestation-signed driver, the vendor that provides the kernel driver is ultimately responsible for supporting the product and driver.

## How to determine whether a driver is attestation-signed

1. In the *%SystemRoot%\\system32\\drivers* directory, right-click the driver file name in question. Select **Properties** from the drop-down list.

    :::image type="content" source="media\support-policy-third-party-kernel-level-attestation\drive-properties-general.png" alt-text="Screenshot of the driver's Properties window, which shows the General tab information." border="false":::

2. Select the **Digital Signatures** tab.

    :::image type="content" source="media\support-policy-third-party-kernel-level-attestation\driver-properties-digital-signatures-microsoft.png" alt-text="Screenshot of the driver's Properties window, which shows the Digital Signatures tab information." border="false":::

3. Select the **Microsoft** entry in the **Signature list**, and then select the **Details** button.

    :::image type="content" source="media\support-policy-third-party-kernel-level-attestation\driver-properties-digital-signatures.png" alt-text="Screenshot of the Digital Signatures tab of the driver's Properties window, which shows a Microsoft entry." border="false":::

4. In the **Digital Signature Details** window, select the **Advanced** tab.

    :::image type="content" source="media\support-policy-third-party-kernel-level-attestation\digital-signature-details-advanced.png" alt-text="Screenshot of the Digital Signatures Details window, which shows the Advanced information." border="false":::

5. Select the **View Certificate** button.

    :::image type="content" source="media\support-policy-third-party-kernel-level-attestation\digital-signature-information.png" alt-text="Screenshot of the Digital Signatures Details window with the General tab opened, in which you can select the View Certificate button." border="false":::

6. In the **Certificate** window, select the **Details** tab.

    :::image type="content" source="media\support-policy-third-party-kernel-level-attestation\digital-signature-details-certificate-information.png" alt-text="Screenshot of the Certificate window with the Certificate Information in the General tab." border="false":::

7. In the resulting list box, scroll down to the **Enhanced Key Usage** row.

    :::image type="content" source="media\support-policy-third-party-kernel-level-attestation\certificate-enhanced-key-usage.png" alt-text="Screenshot of the Certificate window with the Details tab opened, which shows the value of the Enhanced Key Usage." border="false":::

    If the text in that row includes **Windows Hardware Driver Attested Verification**, the driver was attestation-signed.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
