---
title: How to downgrade from Windows 8
description: Describes the factors that determine whether you can downgrade Windows 8 to an earlier version of Windows.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jennrowe
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# How to downgrade from Windows 8

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2832566

## Summary

Your ability to downgrade Windows 8 to an earlier version of Windows depends both on the version of Windows 8 that you've and on the method by which you obtained Windows 8. Not all Windows editions provide downgrade rights. If you do have downgrade rights and decide to use them, you continue to keep the license and rights of use for your original version and may "upgrade" back at any time.

## More information

The primary methods of obtaining Windows 8 are as follows:

- You can buy a retail version of Windows 8 and install it as an upgrade on a PC that is running Windows XP, Windows Vista, or Windows 7.
- You can buy and install a personal-use license of Windows 8 System Builder.
- You can buy a PC that has Windows 8 preinstalled from an OEM. 
- You can buy a Volume Licensing agreement and then install a Windows 8 Pro upgrade or Windows 8 Enterprise on a PC that is running a qualifying operating system.

## Downgrade rights

The downgrade rights for each scenario that is mentioned in the previous section are as follows.

### For a retail version of Windows 8

There are no downgrade rights for retail versions of Windows 8. If you upgraded Windows by using a retail version of Windows 8, you have to reinstall your earlier version of Windows by using the recovery or installation media that was included with your PC.

If you don't have recovery media, you can create it before you upgrade from a recovery partition on your PC by using software that is provided by your PC manufacturer. Check the support section of your PC manufacturer's website for more information. Make sure that you have this recovery disk before you upgrade, because you won't be able to use the recovery partition to create a recovery disk after you install Windows 8.

For more information about how to start your PC from recovery media, see [Create installation media for Windows](https://support.microsoft.com/windows/create-installation-media-for-windows-99a58364-8c02-206f-aa6f-40c3b507420d).

### For a personal-use license of Windows 8 System Builder

If you installed Windows 8 by purchasing and installing Windows 8 System Builder yourself, there are no downgrade rights. It's governed by the personal-use Microsoft Software License Terms for the product. The process for downgrading to an earlier version of Windows is the same as it is for a retail version of Windows 8. That is, you have to buy or have previously bought a product key for the earlier version of Windows and then install that version by using the recovery or installation media.

### For a PC that has Windows 8 preinstalled by an OEM

OEM downgrade rights apply to only Windows 8 Pro and allow for downgrades for up to two earlier versions (to Windows 7 Professional and to Windows Vista Business).

## How to downgrade your PC

Your OEM will have the best information about how to downgrade your specific PC and in some cases may decide to send you installation media or a PC that has the operating system downgrade already installed.

> [!NOTE]
> Neither Microsoft nor the OEM is obligated to provide media for the downgrade.

To do the downgrade on your PC yourself, follow these steps:

1. Change the settings so that the computer starts in legacy BIOS mode.

    > [!NOTE]
    > If you want to upgrade back to Windows 8 Pro later and want full Windows 8 Pro functionalities, you must change the BIOS setting back to native UEFI mode before you install Windows 8 Pro. This is also true if you upgrade to Windows 8 Pro on a PC that was sold to you with the downgrade preinstalled.
2. Some OEMs pre-inject the product key for Windows 7 Professional or Windows Vista Business into the BIOS for just such an occasion. If your OEM did it on your PC, you have to take only one of the following actions:
   - Install Windows 7 Professional or Windows Vista Business by using the recovery media for that version of Windows that was provided by the same OEM. Your system will activate automatically by using the product key that was injected into the BIOS.
   - Install Windows 7 Professional or Windows Vista Business by using a genuine copy of the installation media for that version of Windows. Your system will activate automatically by using the product key that was injected into the BIOS.
   - Activate your copy of Windows 7 Professional or Windows Vista Business by using a Volume License Key Management Service (KMS). The KMS will be able to activate your system by checking the preinstalled product key.
3. If your OEM hasn't injected your product key into the BIOS on your PC, follow these steps:
    1. Obtain genuine Windows 7 Professional or Windows Vista Business installation media and the corresponding product key. You may have to buy a full-package product copy of the Windows downgrade from a retailer.
    2. Insert the media for the downgrade version of Windows into the PC, and then follow the installation instructions.
    3. Type the product key when you're asked to do this. If the software was previously activated, you can't activate it online. In this case, the local Activation Support telephone number will be displayed. Call the number, and explain the circumstances. When it's determined that you have an eligible Windows license, the customer service representative will provide a single-use activation code to activate the software. Microsoft doesn't provide a full product key in this scenario.

## How to downgrade by using a Volume Licensing agreement for Windows 8 Pro Upgrade or Windows 8 Enterprise

Volume Licensing provides the greatest flexibility as to downgrade rights. Volume Licensing allows for downgrades to additional earlier versions and editions. The following table summarizes downgrade eligibility. There are no downgrade rights to Windows 7 Ultimate.

:::image type="content" source="media/downgrade-from-windows-8/downgrade-eligibility.png" alt-text="Screenshot of a table that summarizes downgrade eligibility." border="false":::

> [!NOTE]
> A Windows 8 customer who has multi-language functionality cannot downgrade to Windows 7 Pro or to Windows XP Pro. This is because the multi-language functionality is exclusive to Windows 7 Enterprise and is not available for a Professional edition.

The Microsoft Volume Licensing Service Center (VLSC) provides download access to versions of Windows through the end of those versions' support life cycle.

> [!NOTE]
> In addition to the VLSC download software access, all Volume Licensing customers may decide to buy physical media (CD/DVD) copies of their licensed software through their Microsoft reseller.

If you legally obtained physical media (CD/DVD) of earlier Microsoft products that your organization is currently licensed to use through downgrade rights, you can use these prior software versions at your discretion.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
