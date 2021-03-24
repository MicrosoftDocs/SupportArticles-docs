---
title: How to join a Teams meeting
description: Explains how to join a Teams meeting as well as troubleshooting tips.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: msteams
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Microsoft Teams
search.appverid: MET150
---
# How to join a Microsoft Teams meeting

_Original KB number:_ &nbsp; 10055

## Summary

In this article, you'll find detailed how-to instructions on joining a Teams meeting with a computer or mobile device, or by phone. You'll also find troubleshooting tips specific to your situation. Keep in mind that to join a Teams meeting, you need to have received a Teams meeting request, usually sent in email

Estimated time of completion:  
10-15 minutes.

## Join a Microsoft Teams meeting

How do you want to join the Teams meeting?

- If you want to use a computer or laptop, see [Join with a computer or laptop](#join-with-a-computer-or-laptop).
- If you want to use a smartphone or tablet, see [Install Teams on your mobile device](#install-teams-on-your-mobile-device).
- If you want to call in by phone, see [Join a meeting by phone: check meeting request for dial-in numbers](#join-a-meeting-by-phone-check-meeting-request-for-dial-in-numbers).
- [Troubleshooting meeting join](#troubleshooting-meeting-join)

### Join with a computer or laptop

Follow these steps:

1. Go to **Outlook** > **Calendar**, and open the meeting request.
2. Select **Join Microsoft Teams Meeting**.

    :::image type="content" source="media/how-to-join-a-teams-meeting/join-teams-meeting.png" alt-text="the Join Teams Meeting option":::

Are you able to join the meeting?

- If yes, congratulations, you've successfully joined a Teams meeting.
- If yes but you're having trouble with the meeting audio, see [Troubleshoot audio](#troubleshoot-audio).
- If the meeting opened in Teams Web Access instead of in the desktop version of Teams, see [Check your default browser](#check-your-default-browser).
- If you are not able to join the meeting, see [Join with Teams Web App when Teams is installed](#join-with-teams-web-app-when-teams-is-installed).

### Join with Teams Web App when Teams is installed

If the desktop version of Teams is installed on your computer but you can't join the meeting, follow these steps to join with Teams Web App:

1. In the meeting request, right-click **Join Microsoft Teams Meeting** and select **Copy Hyperlink**.
2. Paste the meeting link into a browser address box, and add **?sl=1** at the end. For example: `https://join.contoso.com/meet/patrick/ABCDEFGH?sl=1`.
3. Press **Enter** to join the meeting with Teams Web App.

If you don't have the desktop version of Teams, you can use Teams Web App to join a Teams meeting from a Windows or Mac computer with a supported browser installed.

You don't have to download anything, just follow these steps:

1. Go to **Outlook** > **Calendar**, open the Teams meeting request, and select **Join Microsoft Teams Meeting**.

2. Do one of the following:

   - Enter your name, and select **Join the meeting**.

     OR

   - If the meeting request is from somebody in your own organization, select **Sign in if you are from the organizer's company** or **Sign in if you are an Office 365 user**.

> [!TIP]
> If you're having trouble joining the meeting, open an **InPrivate Browsing** session in Internet Explorer, and try joining the meeting again.

Are you able to join the meeting?

- If yes, congratulations, you've successfully joined a Teams meeting.
- If you can't connect to meeting audio or see the meeting content, see [Troubleshoot using the Teams Web App](#troubleshoot-using-the-teams-web-app).
- If you are not able to join the meeting, or an error occurred, see [Troubleshoot joining a meeting with Teams Web App](#troubleshoot-joining-a-meeting-with-teams-web-app).

### Check your default browser

If Teams is installed on your computer but the meeting opens in Teams Web App, it usually means that Internet Explorer is not your default browser.

To fix this issue, you have two options:

- Make Internet Explorer your default browser, and then try joining the meeting again.

  OR

- Copy the meeting link, and paste it into Internet Explorer.

#### Details

**Make Internet Explorer your default browser**

1. On the Windows desktop, start Internet Explorer.
2. Go to **Tools** > **Internet Options** > **Programs**.
3. Select **Make default**, and select **OK**.

**Paste the meeting link into Internet Explorer**

1. Go to **Outlook** > **Calendar**, and open the meeting request.
2. Right-click the meeting link, and choose **Copy Hyperlink**.
3. Open Internet Explorer, and paste the meeting link into the address box.

If your problem is not solved, see [Not able to join a Teams meeting](#not-able-to-join-a-teams-meeting).

### Troubleshoot using the Teams Web App

1. Make sure you're using a supported [platform and browser](https://support.microsoft.com/office/supported-platforms-for-skype-meetings-app-skype-for-business-web-app-0269b0a0-d8da-4820-91d8-a868a439c0f7).

2. Find the Teams web app at [https://teams.microsoft.com](https://teams.microsoft.com).

3. Do one of the following:

   - Enter your name, and select **Join the meeting**.

     OR
   - If the meeting request is from somebody in your own organization, select **Sign in if you are from the organizer's company** or **Sign in if you are an Office 365 user**.

If your problem is not solved, see [Not able to join a Teams meeting](#not-able-to-join-a-teams-meeting).

### Troubleshoot joining a meeting with Teams Web App

If you've already joined the meeting, close all your browser windows, and follow these steps:

1. Make sure you're using a supported [platform and browser](https://support.microsoft.com/office/supported-platforms-for-skype-meetings-app-skype-for-business-web-app-0269b0a0-d8da-4820-91d8-a868a439c0f7).
1. Find the Teams web app at [https://teams.microsoft.com](https://teams.microsoft.com).
1. Do one of the following:

   - Enter your name, and select **Join the meeting**.

     OR
   - If the meeting request is from somebody in your own organization, select **Sign in if you are from the organizer's company** or **Sign in if you are an Office 365 user**.

If your problem is not solved, see [Not able to join a Teams meeting](#not-able-to-join-a-teams-meeting).

### Install Teams on your mobile device

First, make sure you've installed the most current Teams app for your mobile device. Even if you don't have an account on the meeting organizer's network, you'll need the Teams app to join the meeting as a guest.

Teams is available on the following devices:

- Windows phone or tablet
- iPhone or iPad
- Android phone or tablet

To install or update Teams:

- Go to your device's app store and search for Teams.

#### Join the Teams meeting on a mobile device

To join a Teams meeting on your mobile device, follow these steps:

1. Connect to a Wi-Fi access point if available. Wi-Fi is required by default for viewing meeting content and video.
2. Open the calendar on your device, and find the meeting you want to join.
3. If the meeting request is from someone outside your organization, make sure you're signed out of Teams.
4. Select Join Teams meeting.

If you are not able to successfully join the Teams meeting, see [Troubleshoot joining a Teams meeting on a mobile device](#troubleshoot-joining-a-teams-meeting-on-a-mobile-device).

### Troubleshoot joining a Teams meeting on a mobile device

#### I can't see meeting presentations or video

Make sure you're connected to a Wi-Fi access point.

#### I can't connect to meeting audio

If you're not connected to a Wi-Fi access point, go to My info > More > Settings, and make sure Require Wi-Fi for VoIP is set to OFF.

#### When I join the meeting, I get an error message, or I keep getting kicked out and asked to rejoin

If the meeting request is from someone outside your company, sign out of Teams and join the meeting again as a guest.

If your problem is not solved, see [Not able to join a Teams meeting](#not-able-to-join-a-teams-meeting).

### Join a meeting by phone: check meeting request for dial-in numbers

To join a meeting by phone, you'll need the dial-in information provided by the meeting organizer.

Go to your calendar, and open the meeting you want to join.

Does it contain dial-in information similar to this?

:::image type="content" source="media/how-to-join-a-teams-meeting/join-teams-meeting.png" alt-text="Join a meeting by phone":::

- If yes, see [Join a meeting by phone](#join-a-meeting-by-phone).
- If no, see [Join a meeting by phone: no dial-in numbers available](#join-a-meeting-by-phone-no-dial-in-numbers-available).

### Join a meeting by phone: no dial-in numbers available

If dial-in information isn't available, you can try contacting the meeting organizer, or join the meeting using an alternate method.

What do you want to do?

- [Join with a computer](#join-with-a-computer-or-laptop)
- [Join with a mobile device](#install-teams-on-your-mobile-device)
- If you're done for now, see [Join a Teams meeting: walkthrough complete](#join-a-teams-meeting-walkthrough-complete).

### Join a meeting by phone

To join a meeting by phone:

- Dial the conference call number.

  :::image type="content" source="media/how-to-join-a-teams-meeting/join-teams-meeting.png" alt-text="Join a meeting by phone":::

Enter the **Conference ID**.

(Optional) Once you're connected to the meeting, dial ***1** to hear a list of available keypad commands, such as mute and unmute.

> [!IMPORTANT]
> If the meeting request contains a link that says **Forgot your dial-in PIN**, you may also have to enter a dial-in PIN when you dial in as the meeting organizer or join a secured meeting by phone. For more information, see [Call in to a Teams meeting](https://support.microsoft.com/office/call-in-to-a-meeting-in-teams-44607421-aeae-4481-8c39-d6b40bc5d554).

If you are not able to join the meeting by phone, see [Not able to join a Teams meeting](#not-able-to-join-a-teams-meeting).

### Troubleshooting meeting join

#### Frequently asked questions

**Where can I find the link to the meeting?**

Look for the link in the meeting request you received from the organizer. Go to **Outlook** > **Calendar**, double-click the meeting to open it, and then select **Join Teams meeting**.

**How do I connect to the meeting audio by phone?**

You can connect to the meeting audio by phone if the meeting request contains information similar to this:

:::image type="content" source="media/how-to-join-a-teams-meeting/join-teams-meeting.png" alt-text="Join a meeting by phone":::

For more information, see [Call in to a Teams meeting](https://support.microsoft.com/office/call-in-to-a-meeting-in-teams-44607421-aeae-4481-8c39-d6b40bc5d554).

Did this solve your problem?

- If yes, congratulations, you've successfully joined a Teams meeting.
- If no, see [Troubleshoot meeting join](#troubleshoot-meeting-join).

### Join a Teams meeting: walkthrough complete

Thank you for completing the guide for joining a Teams meeting.

### Not able to join a Teams meeting

We're sorry you weren't able to join the Teams meeting. Suggested next steps:

- Try joining the meeting on a different device, or connect to the meeting by phone if the meeting request contains dial-in information.
- Contact your workplace technical support-typically, the person who set up your Teams account for you.

### Troubleshoot audio

Choose the issue that best describes your situation:

#### Audio doesn't work with Windows 8.1

If you're running Teams on Windows 8.1 operating system, certain audio or video devices may not work if the device drivers aren't installed properly. This is a known issue on Windows 8.1, and a possible workaround is to update the device drivers to the latest version.

See [Download and install drivers in Windows 8.1](https://support.microsoft.com/help/15046/windows-8-download-install-drivers).

#### Teams doesn't recognize my audio device or you got an error that says your speaker and microphone are not working

Try the following suggestions to resolve the problem. After each suggestion, check to see if your device is working before moving on to the next one.

- If you're on Windows 8.1, make sure your device drivers are up to date. See [Download and install drivers in Windows 8.1](https://support.microsoft.com/help/15046/windows-8-download-install-drivers).
- If your audio device is connected to a USB hub, plug it directly into your computer.
- Unplug your device, reboot and plug it back in.
- Make sure your audio device is not disabled:

    1. Go to **Start** > **Control panel**.
    2. In **Control panel**, search for **Sound** and open it.
    3. Right-click to make sure **Show Disabled Devices** is checked.

       :::image type="content" source="media/how-to-join-a-teams-meeting/show-disabled-devices.png" alt-text="screenshot of showing the disabled devices" border="false":::

    4. If your audio device is disabled, right-click the device and select **enable**.

       :::image type="content" source="media/how-to-join-a-teams-meeting/enable-audio-device.png" alt-text="screenshot of enabling audio devices" border="false":::

- Scan for hardware changes in Device manager:

    1. Go to **Start** > **Control panel**.
    2. Search for Device Manager and open it.
    3. Select your computer name, then select **Actions** > **Scan for hardware changes**. This will find new devices and install the drivers.

- Download the most current drivers from the manufacturer's web site and install them.

#### I can't hear others

If you can't hear audio, check the following:

- In the Teams meeting, point to the **Phone/Mic** icon, then select the **DEVICES** tab. Make sure the device you want is selected, and the volume is high. Adjust the volume using the speaker icon if needed.

  :::image type="content" source="media/how-to-join-a-teams-meeting/set-volume-in-devices.png" alt-text="Set volume in DEVICES tab" border="false":::

- Check the speakers and volume on your computer as well. Select the sound button on the lower-right corner of your computer, and use the sliders to change the volume of the device you want.

  :::image type="content" source="media/how-to-join-a-teams-meeting/check-speakers-and-volume-on-computers.png" alt-text="Check the speakers and volume on your computer" border="false":::

- If your device is connected to a USB hub, connect it directly to your computer.
- If you have a desk phone and the handset is on the cradle, make sure your speakerphone is on.
- If none of these suggestions solve the problem, try using a different device, or transfer the call to another phone. For more information, see [Transfer a Teams call](https://support.microsoft.com/office/transfer-a-call-in-teams-b7f40f14-e083-46b9-b739-68038c8f73a0).

#### People can't hear me

- Check to make sure you're not muted. When you're muted, the **Phone/Mic** icon in the meeting looks like ![the Phone/Mic icon](./media/how-to-join-a-teams-meeting/phone-mic-icon.png). Select the icon to unmute.
- In the Teams meeting, point to the **Phone/Mic** icon, then select the **DEVICES** tab. Make sure the device you're using is selected.
- Check the mic options in the Teams main window:

    1. In the Teams main window, go to **Options** ![the Options icon](./media/how-to-join-a-teams-meeting/options.png) > **Audio device**, and then choose the microphone you want.
    2. Use the slider to adjust the microphone volume. The blue indicator helps you choose the appropriate level for your mic as you speak.

       :::image type="content" source="media/how-to-join-a-teams-meeting/audio-device-settings.png" alt-text="Check the audio device settings" border="false":::

#### Low call quality or choppy audio

Low audio quality might happen for different reasons. Try the following suggestions as appropriate:

- For a quick workaround, transfer the audio to a landline or cell phone. See [Transfer a Teams call](https://support.microsoft.com/office/transfer-a-call-in-teams-b7f40f14-e083-46b9-b739-68038c8f73a0).
- If you're using wirelesses, use a wired connection for better network quality.
- Close any programs that you aren't using.
- If your device is connected to a USB hub, connect it directly to your computer.
- If you're running on battery, plug your computer to a power supply.
- Turn off your video.
- If possible, stop sharing your screen.
- Make sure you're not too close to your mic.
- If you are using a noise-canceling microphone, position it approximately 1 inch away from your mouth. This filters out unwanted background noise.
- Make a test call and adjust your mic volume and position. Select the audio icon on the lower left side of the Teams main window, then select **Check Call Quality**.

  :::image type="content" source="media/how-to-join-a-teams-meeting/check-call-quality.png" alt-text="the Check Call Quality option" border="false":::
- Use an audio device that's [qualified for Microsoft Teams](/microsoftteams/devices/usb-devices).
- Make sure your device drivers are up to date:
  - For Windows 7, see [Automatically get recommended drivers and updates for your hardware](https://support.microsoft.com/help/15054).
  - For windows 8, see [Download and install drivers in Windows 8.1](https://support.microsoft.com/help/15046).

#### I hear echo or a screeching sound

You may even get an alert:

> Check your audio - others might be hearing an echo...echo...ech...

:::image type="content" source="media/how-to-join-a-teams-meeting/alert-check-your-audio.png" alt-text="the Check your audio alert" border="false":::

- If using external speakers and mic, make sure your mic isn't too close to the speakers.
- Turn down your speaker volume to reduce the echo.
- If you're using your webcam's microphone or if you are using your computer speakers, try using a different audio device such as a headset, handset, or standard microphone.
- If you're in a room with several people and multiple audio devices, mute your microphone and speakers, and request others in the room to mute their audio.

> [!TIP]
> If you're in a conference room, use the room's audio by adding it to the meeting. Make sure everyone in the room mutes their speakers and microphones.

1. Pause on the **People** icon in the meeting, then select **Invite More People**.

   :::image type="content" source="media/how-to-join-a-teams-meeting/invite-more-people.png" alt-text="the Invite More People option" border="false":::

2. Type the conference room's phone number, and select **OK**. The room number is normally listed on the phone or the room information.
3. Answer the phone when Teams calls the room.

   :::image type="content" source="media/how-to-join-a-teams-meeting/invite-by-name-or-phone-number.png" alt-text="the Invite by Name or Phone Number page" border="false":::

If your problem is not resolved, see [Not able to join a Teams meeting](#not-able-to-join-a-teams-meeting).

### Troubleshoot meeting join

What do you need help with?

- [Teams: can't join the meeting](#join-with-teams-web-app-when-teams-is-installed)
- [Teams Web App: can't connect to meeting audio or see meeting content](#troubleshoot-using-the-teams-web-app)
- [Teams Web App: can't join the meeting](#troubleshoot-joining-a-meeting-with-teams-web-app)
- [Mobile devices: can't join the meeting](#troubleshoot-joining-a-teams-meeting-on-a-mobile-device)
