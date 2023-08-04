---
title: Use diagnostic messages to troubleshoot issues in voice calls
description: Learn how to interpret the error and warning messages that may appear when you face issues on a voice call.
ms.author: araghunath
ms.reviewer: nenellim 
ms.topic: troubleshooting
ms.collection: 
ms.date: 08/04/2023
ms.custom: bap-template
---

# Use diagnostic messages to troubleshoot issues in voice calls

When your agents are in a voice call, they might sometimes see warning and error messages on the communication panel. These messages will help them understand the issues that are affecting their call experience. Agents can self-diagnose and resolve the issues themselves by using the message information. For example, if agents speak when their mic is muted, a message appears to let them know to remove themselves from mute.

## Troubleshoot network issues

The following table lists the warning messages that appear when your agents face network issues in their voice calls. These messages help agents diagnose the problem and take actions to resolve them. Use the network value to look up more information about the cause and mitigation steps described in [Azure Communication Services](/azure/communication-services/concepts/voice-video-calling/user-facing-diagnostics#network-values).

| Message| Description| Network value |
| -------- | -------- |-----------|
|  Your network is causing poor call quality. Try switching to a better network, or moving closer to a WiFi access point.  | Appears when the network connection is lost and the system tries to reconnect to the network.  | networkReconnect |
| Your network is causing poor call quality. Try switching to a better network, or moving closer to a WiFi access point.  | Appears when the incoming streaming quality is poor.  | networkReceiveQuality |
| Your network is causing poor call quality. Try switching to a better network, or moving closer to a WiFi access point  | Appears when the outgoing streaming quality is poor. | networkSendQuality |

## Troubleshoot device issues

The following table lists the messages that appear when your agents face issues with their audio device in the voice calls. Your agents can use the information to take actions and resolve the problem. Use the audio value to look up more information about the cause and mitigation steps described in [Azure Communication Services](/azure/communication-services/concepts/voice-video-calling/user-facing-diagnostics#audio-values).

| Message| Description| Audio value |
| -------- | -------- |-----------|
| No speakers detected. Try connecting one to receive call audio. | Appears when audio output device or speaker isn't detected on the user's system.  | noSpeakerDevicesEnumerated |
| You are muted.  | Appears when the agent is speaking while on mute. | speakingWhileMicrophoneIsMuted |
| No microphone detected. Try connecting one so that others can hear you. | Appears when a microphone isn't detected on the agent’s system.  | noMicrophoneDevicesEnumerated |
|Your microphone is not working. Connect to a different device or try reconnecting this one. | Appears when microphone is muted unexpectedly or stops working.  | microphoneMuteUnexpectedly |

### See also

[Azure Communication Services user-facing diagnostics](/azure/communication-services/concepts/voice-video-calling/user-facing-diagnostics)  
[How to avoid calls from being disconnected](/dynamics365/customer-service/voice-channel-agent-experience#how-to-avoid-call-disconnection)
