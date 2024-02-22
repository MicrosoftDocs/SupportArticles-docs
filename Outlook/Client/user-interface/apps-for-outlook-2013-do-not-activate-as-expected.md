---
title: Apps for Outlook 2013 do not activate as expected in email
description: Apps for Outlook 2013 cannot be displayed as expected in an open email message. Provides a resolution.
ms.date: 10/30/2023
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto: 
  - Exchange Server 2013 Enterprise
  - Outlook 2013
search.appverid: MET150
---
# Apps for Outlook 2013 do not activate as expected in email messages

_Original KB number:_ &nbsp; 2790827

## Symptoms

When you view an email message in Outlook 2013, you do not see any Apps for Outlook displayed even though the necessary text to start one or more apps is contained in the email message.

For example, you see the following screenshot when you view an email message that contains a street address.

:::image type="content" source="media/apps-for-outlook-2013-do-not-activate-as-expected/email-message-that-contains-street-address.png" alt-text="Screenshot that is displayed when you view an email message." border="false":::

Your expectation is that the Bing Maps app for Outlook is displayed, as in the following figure.

:::image type="content" source="media/apps-for-outlook-2013-do-not-activate-as-expected/bing-maps-app-shown-in-outlook.png" alt-text="Screenshot of the email message with Bing Maps." border="false":::

## Cause

This symptom will occur if the `AppsForOfficeEnabled` parameter of the `OrganizationConfig` object is set to **$False**.

## Resolution

You can use the following cmdlet in Exchange Server 2013 to determine the current value of the `AppsForOfficeEnabled` parameter.

```powershell
Get-OrganizationConfig | FL AppsForOffice*
```

In the configuration where you do not see any Apps for Outlook in email messages, the result from this cmdlet will be the same as that shown in the following screenshot:

:::image type="content" source="media/apps-for-outlook-2013-do-not-activate-as-expected/get-organizationconfig-cmdlet.png" alt-text="Screenshot of the result from this cmdlet.":::

If it is necessary, you can use the following cmdlet in Exchange Server 2013 to set the value of the `AppsForOfficeEnabled` parameter to **$True**.

```powershell
Set-OrganizationConfig -AppsForOfficeEnabled $True
```

If you make this change, you can force an update by recycling the MSExchangeServicesAppPool application pool in Internet Information Services (IIS) manager.

## More information

The `AppsForOfficeEnabled` parameter value is stored in the `msExchProvisioningFlags` attribute in Active Directory, as shown in the following screenshot.

:::image type="content" source="media/apps-for-outlook-2013-do-not-activate-as-expected/msexchprovisioningflags-value.png" alt-text="Screenshot for msExchProvisioningFlags value in AD." border="false":::

|AppsForOfficeEnabled parameter setting|msExchProvisioningFlags attribute value |
|---|---|
|$True|0|
|$False|512 (decimal)|

As the `msExchProvisioningFlags` attribute can contain several flag values for different parameters (not just the `AppsForOfficeEnabled` parameter), you may have to do some math to determine the current value of the `AppsForOfficeEnabled` parameter. Therefore, if the value of this attribute is greater than 512, you have to see whether the value is made up of several values, one of which includes 512.

For example:

|msExchProvisioningFlags attribute value| Contains Flags|AppsForOfficeEnabled parameter| Reason |
|---|---|---|---|
|640|512 & 128|$False|because 512 is part of the attribute value, the `AppsForOfficeEnabled` parameter is set to **$False**. This always adds **512** to the attribute value.|
|1280|1024 & 256|$True|because 512 is Not part of the attribute value, the `AppsForOfficeEnabled` parameter is set to **$True**. This always adds **0** to the attribute value.|
