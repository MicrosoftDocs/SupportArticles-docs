---
title: "Troubleshoot voice-enabled agents and diagnose runtime error codes"
description: "Reference to troubleshoot voice agent runtime error codes and other issues."
ms.reviewer: erickinser
ms.date: 02/26/2025
ms.topic: how-to
author: sophie-roy3
ms.author: sophieroy
manager: kjette
ms.custom: sap:Channels
---

# Troubleshoot voice-enabled agents and diagnose runtime error codes

This article covers troubleshooting guidance for possible issues with your voice-enabled agent, along with runtime error codes you might encounter.

## Unable to turn on Optimize for voice

The **Optimize for voice** setting can't be turned on if the the Power Platform environment hosting the agent is configured to use the **Get new features early** setting. Voice-enabled agents are only supported in **Standard** environments. If you're unable to turn **Optimize for voice**, check your environment and ensure that **Get new features only** is turned off. For more information, see [Early release cycle environments](/power-platform/admin/early-release).

## Callers can't engage with a published agent

**Issue**: After a maker configures a phone number and workstream for a published agent through Dynamics 365 Customer Service, callers only hear hold music or silence, and can't engage with the agent.

**Suggested solution**: Disconnect and reconnect the Telephony channel and Dynamics 365 Customer Service customer engagement hub in Copilot Studio.

**Steps**:

1. In Copilot Studio, go to **Channels > Telephony** and select **Turn off telephony**.

    :::image type="content" source="media/voice/voice-telephony-channel-turn-off-telephony.png" alt-text="Screenshot of the Telephony channel, highlighting the Turn off telephony button.":::

    >[!NOTE]
    >If there's an error message after selecting the button, ignore the message, and refresh the page. The Telephony channel should be turned off afterward.

1. Select **Turn on telephony**.

    :::image type="content" source="media/voice/voice-telephony-channel-turn-on-telephony.png" alt-text="Screenshot of the Telephony channel, highlighting the Turn on telephony button.":::

1. Go to **Channels > Customer engagement hub > Dynamics 365 Customer Service** and select **Disconnect**.

    :::image type="content" source="media/voice/voice-channels-dynamics-365-customer-service-disconnect.png" alt-text="Screenshot of the Dynamics 365 Customer Service customer engagement hub, highlighting the Disconnect button.":::

1. Select **Connect**.

    :::image type="content" source="media/voice/voice-channels-dynamics-365-customer-service-connect.png" alt-text="Screenshot of the Dynamics 365 Customer Service customer engagement hub, highlighting the Connect button.":::

## Can't publish an agent or configure the Telephony channel

**Issue**: Maker can't publish an agent or configure the Telephony channel.

:::image type="content" source="media/voice/voice-channels-telephony-disabled.png" alt-text="Screenshot of the telephony channel being disabled, along with error status messages.":::

**Suggested solution**: If you're unable to publish your agent, or if the Telephony channel is disabled, contact your Power Platform admin and ask them to review the data policies in your tenant.

**Steps**: In the Power Platform admin center, the tenant admin can unblock the needed data policies. See [Data policy example - Block channels to disable agent publish](dlp-example-6.md).

## Voice-enabled agent runtime error codes

Voice: `CopilotNotResponseWithMessageBack`

Error Message: The agent processed the user's message but didn't respond with a message.

Resolution: Make sure all your topics send a message out or end conversation/hangup/transfer the call in the end.

Voice: `HandoffInvalidSipHeader`

Error Message: The SIP header in the transfer activity contains unsupported characters, check the documents. The invalid SIP header value is `{sip header value}`.

Resolution: Check your SIP header value and make sure that it’s correct.

For more information, see [Understand error codes](error-codes.md).

## Related content

- [Test your voice-enabled agent](voice-test.md)
