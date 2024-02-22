---
title: Can't attach large files in Outlook on the web
description: An increase in the message size limit in Exchange Server 2019 still prevents large file attachments in Outlook on the web.
author: cloud-writer
ms.author: meerak
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
  - Outlook on the web
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't attach large files after increasing message size limit in Exchange Server 2019

## Symptoms

To send large attachments by using Outlook on the web, you [increase the message size limit](/exchange/troubleshoot/mailflow/cannot-add-attachment-outlook-web) in Microsoft Exchange Server 2019. However, you're still unable to attach a large file. You might either receive the following error message or the attachment gets removed:

> The following files couldn't be attached: \<Name_of_attached_file>. Please try again later.

To get more information about this issue,  you can [run a network trace in your browser](/azure/azure-web-pubsub/howto-troubleshoot-network-trace#collect-a-network-trace-in-the-browser-browser-based-apps-only) when the issue occurs. In the trace, check the last request that has the **CreateAttachmentFromLocalFile** action for Outlook on the web. You'll see the **ErrorIrresolvableConflict** response code in the **Response** tab.

:::image type="content" source="media/owa-cannot-attach-large-files/network-trace.png" alt-text="Screenshot of the network trace page, and the ErrorIrresolvableConflict response code for the OWA request is highlighted.":::

Here's an example of a complete response that includes the reason for the error in the Message Text section:

> {"Header":{"ServerVersionInfo":{"MajorVersion":15,"MinorVersion":2,"MajorBuildNumber":986,"MinorBuildNumber":22,"Version":"V2017_08_18"}},"Body":{"ResponseMessages":{"Items":[{"__type":"AttachmentInfoResponseMessage:#Exchange","MessageText":"**The send or update operation could not be performed because the change key passed in the request does not match the current change key for the item., Cannot save changes made to an item to store.SaveStatus: IrresolvableConflict**\u000d\u000aPropertyConflicts:\u000d\u000a","ResponseCode":"**ErrorIrresolvableConflict**","ResponseClass":"Error","Attachments":[null]}]},"SharingInformation":null}}

## Cause

This issue occurs because the `BigFunnelDelayItemSizeThreshold` limit is still set to the default value. In Exchange Server 2019, when you increase the message size limit, you also need to increase the new `BigFunnelDelayItemSizeThreshold` limit for the size limit update to take effect. If the latter step isn't completed, you'll see the error message.

## Resolution

Run the [New-SettingOverride](/powershell/module/exchange/new-settingoverride) cmdlet as an administrator to increase the `BigFunnelDelayItemSizeThreshold` limit.  

```powershell
New-SettingOverride -Name "<Name_of_setting_override>"  -Component "BigFunnel" -Section "BigFunnelGlobalSettings" -Parameters @("BigFunnelDelayItemSizeThreshold=<largest_size_of_message_allowed_with_attachments>") -Reason "<Reason_for_creating_the_override>"
```

Set the value of the `BigFunnelDelayItemSizeThreshold` parameter to be the largest size in bytes that you expect for a message that includes attachments. The default value of this parameter is 3145728 bytes.

For example:

```powershell
New-SettingOverride -Name "Large Attachments" -Component "BigFunnel" -Section "BigFunnelGlobalSettings" -Parameters @("BigFunnelDelayItemSizeThreshold=75497472") -Reason "Configuration for Large Attachments" 
```

In this example, the value for the `BigFunnelDelayItemSizeThreshold` parameter is set to 75497472 bytes.

## Related articles

- [Configure client-specific message size limits in Exchange Server](/Exchange/architecture/client-access/client-message-size-limits)
- [Error when adding a large attachment in Outlook on the web](/exchange/troubleshoot/mailflow/cannot-add-attachment-outlook-web)
