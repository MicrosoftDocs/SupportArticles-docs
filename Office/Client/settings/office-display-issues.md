---
title: Display issues in Office client applications.
description: Describes some display issues in Office client applications.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Reliability
  - CSSTroubleshoot
appliesto: 
  - Outlook 2016
  - Excel 2016
  - Word 2016
  - PowerPoint 2016
  - OneNote 2016
  - Microsoft Publisher 2016
  - Visio Professional 2016
  - Access 2016
  - Project Professional 2016
  - Word 2013
  - Excel 2013
  - Microsoft Lync 2013
  - Outlook 2013
  - PowerPoint 2013
  - OneNote 2013
  - Publisher 2013
  - Visio Professional 2013
  - Access 2013
  - Project Professional 2013
ms.date: 06/06/2024
---

# Display issues in Office client applications

## Symptoms

When you use Microsoft Office programs, you notice that visual features differ from one computer to another. For example, you see animations in Excel when you scroll through a worksheet on one computer, but you do not see the same animations on another computer. 

Additionally, you may experience one or more of the following symptoms that reduce the functionality of an Office program:

- An Office program is blurry.
- Your screen flickers or flashes.
- An Office program is either mostly all white or all black.
- Text in your document is not displayed well.
- Your Office program crashes.
- The performance of an Office program (other than startup and shutdown) is reduced.
- In Microsoft Lync, there may be video delays or slowness when you are on a video call.

## Cause

You may experience these symptoms if you have a video configuration on your computer that is incompatible with the Office feature set that is responsible for displaying the application and for animations in the application.

Office 2013 and later versions use a more efficient and accelerated method to draw the Office UI and the content. This includes relying on hardware acceleration, which is managed through the operating system. The hardware acceleration function of the operating system relies on up-to-date and compatible display drivers.

Note Hardware acceleration that uses the video card is always disabled when Office is running in a Remote Desktop session, and also when the application is started in safe mode.

## Resolution

The resolution varies depending on your version of Windows and the symptom you are experiencing.

### For the symptom: Poorly Displayed Text in Office Documents

If your symptom is "Poorly Displayed Text in Office Documents," try the following solutions first. Otherwise, skip to the next section titled All Other Symptoms.

#### Step 1: Use the "ClearType Text Tuner" Setting

1. Search for **ClearType**.

   Windows 10, Windows 8.1, and Windows 8: On the Start Screen, search for **ClearType**.

   Windows 7: Click **Start**, and then enter **ClearType** in the **Search Programs and Files** box.
2. Select **Adjust ClearType Text**.
3. In the **ClearType Text Tuner**, enable the **Turn on ClearType** option, and then click **Next**.
4. Tune your monitor by following the steps in the **ClearType Text Tuner**, and then click **Finish**.

If you are still experiencing a problem after you adjust the ClearType settings, go to Step 2.

#### Step 2: Disable the Sub-Pixel Positioning Feature

Word 2016 and Word 2013 use subpixel text rendering by default. While this provides optimal spacing, you may prefer the appearance of pixel-snapped text for a minor improvement in contrast. To disable the subpixel positioning feature in Word 2016 or Word 2013, follow these steps.
 
1.    On the **File** tab, click **Options**.
2.    Click **Advanced**.
3.    Under the **Display** group, clear the **Use the subpixel positioning to smooth fonts on-screen** option.
4.    Click **OK**.

If you are still experiencing a problem after you turn off the subpixel text rendering setting, re-enable the Use the subpixel positioning to smooth fonts on-screen setting, and then go to Step 3.

#### Step 3: On Windows 7 clients, install the Windows 8 Interoperatibility Pack

If you are using Windows10, Windows 8.1 or Windows 8, skip this section and go to the steps under the For All Other Symptoms section.

If you are using Windows 7, install the update for improving video-related components that is available in the following Knowledge Base article:

[2670838](https://support.microsoft.com/help/2670838/) Platform update for Windows 7 SP1 and Windows Server 2008 R2 SP1

If the previous steps did not resolve the "Poorly Displayed Text in Office Documents" symptom, continue to troubleshoot your issue by using the steps in the next section.

### For all other symptoms

#### Update your video driver

The best way to update your video driver is to run Windows Update to see whether a newer driver is available for your computer.

To run Windows Update based on your version of Windows, follow these steps:

**Windows 10, Windows 8.1 and Windows 8**

1.    On the Start Screen, click **Settings** on the Charms Bar.
2.    Click **Change PC Settings**.
3.    In the **PC settings** app, click **Windows Update**.
4.    Click **Check for updates now**.
5.    If updates are available, click the driver that you want to install, and then click **Install**.

**Windows 7**

1.    Click **Start**.
2.    Type Windows Update in the **Search programs and files** box.
3.    In the search results, click **Check for updates**.
4.    If updates are available, click the driver that you want to install, and then click **Install**.

If your video-related problems in Office were fixed by when you updated your video driver, you do not have to take any further steps. Go to step 2 if updating the video driver does not fix the problems.

> [!NOTE]
> Video card manufacturers frequently release updates to their drivers to improve performance or to fix compatibility issues with new programs. 
If you do not find an updated video driver for your computer through Windows Update and must have the latest driver for your video card, go to the support or download section of your video card manufacturer's website for information about how to download and install the newest driver.

## More Information

### Automatic disabling of hardware acceleration for some video cards

By default, hardware acceleration is automatically disabled in Office programs if certain video card and video card driver combinations are detected when you start an Office program. If hardware acceleration is automatically disabled by the program, nothing indicates that this change occurred. However, if you update your video card driver and it is more compatible with Office, hardware acceleration is automatically reenabled.

The list of video card/video driver combinations that trigger this automatic disabling of hardware graphics acceleration is not documented because the list is hard-coded in the Office programs and will be constantly changing as we discover additional video combinations that cause problems in Office programs. Therefore, if you do not see the same animation functionality on one computer that you see on another computer, we recommend that you update your video driver by using the instructions provided in the "Update your video driver" section. If you still do not see the expected animation on your computer, update your video driver again soon. Microsoft is working with the major video card manufacturers on this issue, and these video card manufacturers will be releasing new video drivers as such drivers are developed.

> [!NOTE]
> If two computers have the same video card/video driver combinations, you may still see a difference in the Office animation features between the two computers if one computer is running Windows 7 and the other computer is running Windows 8. On a computer that is running Windows 7, animations in Office are disabled if the video card/video driver combination appears on the incompatibility list. However, the same video combination on Windows 8 does not have animations disabled because of the improved video capabilities in Windows 8.
