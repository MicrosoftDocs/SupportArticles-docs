---
title: Actionable messages render incorrectly
description: Provides a resolution for an issue in which Actionable messages render incorrectly in Outlook.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 190031
ms.reviewer: sushilsh, gbratton, meerak, v-trisshores
appliesto: 
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 05/22/2024
---

# Actionable messages render incorrectly

## Symptoms

[Actionable messages](/outlook/actionable-messages/send-via-email) are rendered incorrectly in Microsoft Outlook.

The following screenshot shows an Actionable message that's rendered correctly.

:::image type="content" source="media/actionable-messages-render-incorrectly/actionable-message-good.png" alt-text="Screenshot of an actionable message that is rendered correctly." border="true" lightbox="media/actionable-messages-render-incorrectly/actionable-message-good-lrg.png":::

The following screenshot shows the same Actionable message if it's rendered incorrectly.

:::image type="content" source="media/actionable-messages-render-incorrectly/actionable-message-bad.png" alt-text="Screenshot of an actionable message that is rendered incorrectly." border="true" lightbox="media/actionable-messages-render-incorrectly/actionable-message-bad-lrg.png":::

## Cause

To render Actionable messages correctly, Outlook uses the following GET request to get the Actions protocol endpoint URL from the Autodiscover V2 service: `https://outlook.office365.com/autodiscover/autodiscover.json/v1.0/<user email address>?protocol=actions`.

If the request is successful, the Autodiscover V2 service returns HTTP status code 200 and provides the requested URL in the response body. For example, the response body might be `{ "Protocol": "Actions", "Url": https://outlook.office365.com/actionsb2netcore }`.

However, if the Autodiscover V2 service is disabled on the user's computer that has Outlook installed, the GET request fails, and Outlook can't connect to the actions protocol endpoint.

> [!NOTE]
> The Autodiscover V2 service is disabled if the `DisableAutodiscoverV2Service` registry entry exists under the `Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\AutoDiscover` subkey, and the DWORD value of the `DisableAutodiscoverV2Service` entry is `1`.

## Resolution

To fix the issue, follow these steps to enable the Autodiscover V2 service on the user's computer that has Outlook installed.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For protection, back up the registry before you modify it so that you can restore it if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. If the user's computer is domain-joined and your organization [controls Autodiscover by using Group Policy](/outlook/troubleshoot/profiles-and-accounts/how-to-control-autodiscover-via-group-policy), make sure that the `Disable the Autodiscover V2 service` option isn't enabled in the [Disable Autodiscover](https://admx.help/?Category=Office2016&Policy=outlk16.Office.Microsoft.Policies.Windows::L_OutlookDisableAutoDiscover) group policy.

2. Run regedit on the user's computer that has Outlook installed.

3. Navigate to the `Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\AutoDiscover` registry subkey.

4. Either set the DWORD value of the `DisableAutodiscoverV2Service` registry entry to `0` or delete the registry entry.

5. Delete the following Autodiscover cache files:

   1. *%LocalAppData%\Microsoft\Outlook\\<any partial file name\> - Autodiscover.xml*

   2. *%LocalAppData%\Microsoft\Outlook\16\\<any file name\>.xml*

   3. *%LocalAppData%\Microsoft\Outlook\16\\<any file name\>.json*

6. Restart Outlook.
