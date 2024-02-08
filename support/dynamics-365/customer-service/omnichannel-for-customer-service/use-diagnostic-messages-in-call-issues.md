---
title: Use diagnostic messages to troubleshoot issues in voice calls
description: Learn how to interpret the error and warning messages that may appear when you have problems with your voice call.
ms.author: araghunath
author: araghunath08
ms.reviewer: nenellim 
ms.collection: 
ms.date: 09/13/2023
ms.custom: bap-template
---
# Use diagnostic messages to troubleshoot issues in voice calls

When your agents are on a voice call, they might sometimes see warning or error messages on the **Communication Panel**. These messages will help them understand the issues that are affecting their call experience. Agents can use the information in the message to diagnose and resolve the issues themselves. For example, if an agent speaks when the microphone is muted, a "You are muted" message occurs to let them consider unmuting the microphone.

:::image type="content" source="media/use-diagnostic-messages-in-call-issues/communication-panel.png" alt-text="Screenshot that shows a 'You are muted' message to help you solve the issue during a voice call.":::

## Troubleshoot network issues

The following table lists the warning messages that appear when your agents have network issues in their voice calls. These messages help agents diagnose and resolve the issues. Use the network values to find more information about the cause and mitigation steps described in [Azure Communication Services](/azure/communication-services/concepts/voice-video-calling/user-facing-diagnostics#network-values).

| Message| Description| Network value |
| -------- | -------- |-----------|
|  Your network is causing poor call quality. Try switching to a better network, or moving closer to a Wi-Fi access point.  | Appears when the network connection is lost and the system tries to reconnect to the network.  | `networkReconnect` |
| Your network is causing poor call quality. Try switching to a better network, or moving closer to a Wi-Fi access point.  | Appears when the incoming streaming quality is poor.  | `networkReceiveQuality` |
| Your network is causing poor call quality. Try switching to a better network, or moving closer to a Wi-Fi access point.  | Appears when the outgoing streaming quality is poor. | `networkSendQuality` |

## Troubleshoot device issues

The following table lists the messages that appear when your agents have issues with their audio devices in voice calls. Your agents can use the information to take action and resolve the problem. Use the audio values to find more information about the cause and mitigation steps described in [Azure Communication Services](/azure/communication-services/concepts/voice-video-calling/user-facing-diagnostics#audio-values).

| Message| Description| Audio value |
| -------- | -------- |-----------|
| No speakers detected. Try connecting one to receive call audio. | Appears when no audio output device or speaker is detected on the user's system.  | `noSpeakerDevicesEnumerated` |
| You are muted.  | Appears when an agent is speaking while it's muted. | `speakingWhileMicrophoneIsMuted` |
| No microphone detected. Try connecting one so that others can hear you. | Appears when no microphone is detected on the agent's system.  | `noMicrophoneDevicesEnumerated` |
|Your microphone is not working. On the communication panel, select More -> Device settings to connect to a different device or try reconnecting this one. |Appears when the microphone is muted unexpectedly or is not functioning.| `microphoneMuteUnexpectedly` `microphoneNotFunctioning`|

## Troubleshoot incoming call notification issues 

Ensure that when utilizing a custom Incoming notification template for your voice workstreams, the Countdown (seconds) **must not exceed 40 seconds**. Setting it beyond 40 seconds will result in agents receiving incoming call notifications for longer than 40 seconds if the call remains unaccepted, and upon acceptance, agents will encounter an error. So to avoid this, ensure the Coundown value does not exeed 40 seconds.

![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/47166753/4c87a53c-c29f-4263-b1c7-09640700adfb)
![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/47166753/9be61bee-0fce-40ce-96d6-ceba3e8c95d6)



## See also

- [Azure Communication Services user-facing diagnostics](/azure/communication-services/concepts/voice-video-calling/user-facing-diagnostics)  
- [How to avoid calls from being disconnected](/dynamics365/customer-service/voice-channel-agent-experience#how-to-avoid-call-disconnection)
