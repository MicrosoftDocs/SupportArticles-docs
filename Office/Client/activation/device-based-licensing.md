---
title: Troubleshooting device-based licensing for Microsoft 365 Apps
description: Describes issues you might encounter with Microsoft 365 device-based licensing.
author: Cloud-Writer
ms.reviewer: vikkarti
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Licensing Office using Device Based Subscriptions (and DBA)
  - CSSTroubleshoot
  - CI 157764
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 06/06/2024
---

# Troubleshooting device-based licensing for Microsoft 365 Apps

You can set up Microsoft 365 Apps for enterprise to use device-based licensing for devices used by multiple users. For information on setting up device-based licensing, see [Device-based licensing for Microsoft 365 Apps for enterprise](/deployoffice/device-based-licensing).

If you have trouble with device-based licensing, see the following troubleshooting methods.

## Initial troubleshooting

You can view device licensing status by signing in to the [Microsoft 365 Apps admin center](https://config.office.com) and going to **Health** > **Licensing**. That page shows devices that failed to activate with a device license.

You can also verify that Microsoft 365 Apps for enterprise is using a device-based license by opening an Office application, such as Word, and going to **File** > **Account**. In the **Product Information** section, you should see **Belongs to: This device**.

If the device hasn't been properly configured for device-based licensing, when a user tries to use Microsoft 365 Apps for enterprise on the device, Office will be in reduced functionality mode. That means the user can open and print existing documents in Office applications, but the user can't create new documents or edit and save existing documents.

In those cases, the user will also see a banner beneath the ribbon in the document with the following message:

> LICENSE REQUIRED Your admin needs to assign an Office license to this device so you can edit your files.

To troubleshoot this issue, make sure the device is correctly joined to Microsoft Entra ID and that the device is added to the group that has been assigned the licenses. Also, there can be a delay of approximately one hour after you add the device to the group, so that might be causing this message to appear. Close the app and open the app again later.

In other cases, the user might see this message:

> CAN'T VERIFY LICENSE We're having trouble verifying the Office license for this device.

In this case, the device is having problems contacting the Office Licensing Service on the internet. Office tries to contact the Office Licensing Service to ensure the device is properly licensed and to automatically renew a license that is about to expire. A device-based license is set to expire in 90 days, so the device doesn't have to access to internet constantly. The CAN'T VERIFY LICENSE message usually appears about 10 days before the license is about to expire.

## Transition from subscription licensing or shared computer activation to device-based licensing

If Microsoft 365 Apps are already installed and activated with user-based subscription licensing or shared computer activation, you need to reset the license state on the device before it will transition over to device-based licensing. To reset the activation state, see [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state).

Make sure the device has access to the internet or that your firewall isn't preventing access to the Office licensing service. For more information about firewall settings, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges).

Note If the user account has been configured to use a proxy, but the SYSTEM account hasn’t, the device might be unable to get the device-based license. Use the [BITSAdmin tool](/windows/win32/bits/bitsadmin-tool) to configure the SYSTEM account to use the proxy.

> Confirm the activation state

To confirm that the device-based license is activated, run the PowerShell script `vnextdiag.ps1` located in the folder C:\Program Files\Microsoft Office\Office16.

Further information can be found by downloading and running the [Office Licensing Diagnostic Tool](https://www.microsoft.com/download/details.aspx?id=55948).

## Using Remote Desktop Services (RDS)

Device-based licensing can be used with RDS. However, you must have enough licenses to match the number of clients that will connect to RDS. Device-based licensing doesn’t support license token roaming or offline activation.

If you want the activation process to be invisible to the RDS user, you can create a script to open a Microsoft 365 App, such as Word or Excel, when the device is started. This will acquire the device-based license.

<a name='make-sure-the-device-is-joined-to-azure-active-directory-azure-ad'></a>

## Make sure the device is joined to Microsoft Entra ID

Sign in to the [Microsoft Azure portal](https://portal.azure.com/) and go to **Microsoft Entra ID** > **Devices**. The type of join for your Windows client device is listed in the **Join Type** column.

If the Windows client device doesn't appear, sign in to the Windows client device. Then go to **Settings** > **Accounts** > **Access work or school**, choose **Connect**, and follow the steps to join the device to either Microsoft Entra ID or to a local Active Directory domain.
