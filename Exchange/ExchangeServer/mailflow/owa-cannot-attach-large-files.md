---
title: Can't attach large files in Outlook on the web
description: Fixes an issue in which you can't a large file to an email message in Outlook on the web after increasing the message size limit.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 162363
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: igserr
appliesto: 
  - Exchange Server 2019
search.appverid: MET150
ms.date: 4/22/2022
---
# Can't attach large files after increasing the message size limit

## Symptoms

After the message size limit is increased in Microsoft Exchange Server 2019, you still can't attach a large file to an email message in Outlook on the web (formally known as Outlook Web App or OWA). Sometimes, you may receive the following error message:

> The following files couldn't be attached: AttachedFileName.ext. Please try again later.

If you open Developer tools by pressing F12 to check the network trace in Microsoft Edge and reproduce the issue, in the last request that has the **CreateAttachmentFromLocalFile** action, you see the **ErrorIrresolvableConflict** response code under the **Response** tab.

:::image type="content" source="media/owa-cannot-attach-large-files/network-trace.png" alt-text="Screenshot of the network trace page, and the ErrorIrresolvableConflict response code for the OWA request is highlighted.":::

Here's an example of the full response that contains the detailed error message:

> {"Header":{"ServerVersionInfo":{"MajorVersion":15,"MinorVersion":2,"MajorBuildNumber":986,"MinorBuildNumber":22,"Version":"V2017_08_18"}},"Body":{"ResponseMessages":{"Items":[{"__type":"AttachmentInfoResponseMessage:#Exchange","MessageText":"**The send or update operation could not be performed because the change key passed in the request does not match the current change key for the item., Cannot save changes made to an item to store.SaveStatus: IrresolvableConflict**\u000d\u000aPropertyConflicts:\u000d\u000a","ResponseCode":"**ErrorIrresolvableConflict**","ResponseClass":"Error","Attachments":[null]}]},"SharingInformation":null}}

## Cause

This issue occurs because the new BigFunnelDelayItemSizeThreshold limit that's used in Exchange Server 2019 isn't increased.

## Resolution

To resolve this issue, create a setting override to increase the `BigFunnelDelayItemSizeThreshold` limit by running the [New-SettingOverride](/powershell/module/exchange/new-settingoverride) cmdlet as an administrator. For example:

```powershell
New-SettingOverride -Name "Large Attachments" -Component "BigFunnel" -Section "BigFunnelGlobalSettings" -Parameters @("BigFunnelDelayItemSizeThreshold=75497472") -Reason "Configuration for Large Attachments"
```

**Note:** The `BigFunnelDelayItemSizeThreshold` value is the largest size that you expect for a message that includes attachments. By default, the `BigFunnelDelayItemSizeThreshold` value is 3145728 bytes. In this example, the value is set to 75497472 bytes.

## Related articles

- [Configure client-specific message size limits in Exchange Server](/Exchange/architecture/client-access/client-message-size-limits)
- [Error when adding a large attachment in Outlook on the web](/exchange/troubleshoot/mailflow/cannot-add-attachment-outlook-web)
