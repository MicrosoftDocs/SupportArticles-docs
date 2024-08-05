---
title: Windows Media Feature Pack for Windows 7 N and for Windows 7 KN
description: Describes the Windows Media Feature Pack for Windows 7 N and for Windows 7 KN.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Desktop and Shell Experience\Media issues with in-box apps (Windows Media Player, Groove, Movies and TV), csstroubleshoot
---
# Description of the Windows Media Feature Pack for Windows 7 N and for Windows 7 KN

This article describes the Windows Media Feature Pack for Windows 7 N and for Windows 7 KN.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 968211

## Summary

The N edition and the KN edition of the Windows 7 operating system do not include Windows Media Player or other Windows Media-related technologies, such as Windows Media Center and Windows DVD Maker. Therefore, you must install a separate media player in order to do any of the following:

- Play or create audio CDs, media files, and video DVDs
- Organize content in a media library
- Create playlists
- Convert audio CDs to media files
- View artist and title information about media files
- View album art about music files
- Transfer music to personal music players
- Record and playback TV broadcasts

Additionally, various Web sites and software programs rely on Windows Media-related files that are not incorporated into Windows 7 N and Windows 7 KN. These programs include Microsoft Office and Microsoft Encarta.

To enable all these Web sites and software programs to work correctly, you can install the Windows Media Feature Pack for Windows 7 N and for Windows 7 KN.

## More information

Windows 7 N and Windows 7 KN include the same functionality as Windows 7. However, these editions of Windows 7 do not include Windows Media Player or other Windows Media-related technologies. The programs that are not included in these editions of Windows 7 include the following:

- Windows Media Player User Experience: This feature enables Windows Media Player components, and lets you perform the following actions:
  - Play media files and audio CDs
  - Manage media in a library
  - Create a playlist
  - Provide metadata (including album art) for media
  - Create an audio CD
  - Transfer music to a portable music player
  - Play streamed content from the Web

- Windows Media Player ActiveX Control: This feature exposes methods and properties for manipulating multimedia playback from a Web page or from an application.

- Shell Media Property Display: This feature enables the display of metadata such as artist, song, and album information for media files in the Windows user interface, especially in the Music folder.

- Windows Media Player Visualizations: This feature contains visualizations that let you see visual imagery that is synchronized to the sound of the media content as it plays.

- Windows Media Format: This feature provides support for the following components:
  - The Advanced Systems Format (ASF) file container
  - Windows Media audio and video codecs
  - Basic network streaming capability
  - Digital Rights Management (DRM)

- Windows Media Digital Rights Management: This feature enables the secure delivery of protected content for playback on a computer, a portable device, or a network device.

- Windows Media Device Manager: This feature enables communications between an application, the Windows Media DRM system, and portable audio players.

- Media Sharing: This feature enables music, pictures, and videos on the computer to be shared with other computers and devices on the network. Media Sharing also enables the computer to find music, pictures, and videos on the network.

- Media Foundation: This feature provides support for content protection, audio and video quality. Media Foundation also provides interoperability for DRM.

- Windows Portable Devices Infrastructure: This feature communicates with media devices and storage devices that are attached to the computer, including Media Transfer Protocol devices. This system supersedes both Windows Media Device Manager and Windows Image Acquisition. This system lets computers communicate with music players, storage devices, mobile phones, cameras, and other kinds of devices.

- Windows Media Center: This feature lets you access the digital entertainment library on their personal computer or on their television. You can also use the mouse or the Media Center remote control to perform the following actions:
  - View photos in a cinematic slide show
  - Browse their music collection by cover art
  - Easily play DVDs
  - Watch and record their favorite TV showsMedia Center also lets you download movies and watch them in a 10-foot mode on your television.

- Windows DVD Maker: This feature lets you create video DVDs of home movies and photos that can be viewed on DVD players, regardless of geographical region codes. Windows DVD Maker is included in Windows 7 Professional, Windows 7 Enterprise, and Windows 7 Ultimate. DVD Maker is removed from Windows 7 Professional N and KN, Windows 7 Enterprise N and KN, and Windows 7 Ultimate N and KN.

- Sample Ringtone: Media files in the .wma format are removed from Windows 7 N and from Windows 7 KN.

- Sample Media: Sample content for movies, music, and TV is not included in Windows 7 N or in Windows 7 KN.

- **Turn Windows features on or off** user experience: The media playback applications that let a user add or remove Windows DVD Maker, and Windows Media Center are removed.

## Impact on other components

The following components were not removed from Windows 7 N and from Windows 7 KN. However, these components are affected by the media programs that were removed from Windows 7 N and from Windows 7 KN.

- HomeGroup: You cannot share integrated media by using streaming features in Windows 7 N or in Windows 7 KN.

- SideShow: This feature does not work in Windows 7 Professional N or in Windows 7 Professional KN. This feature is not included in Windows 7 Starter N or in Windows 7 Starter KN.

- Windows Experience Index: This feature does not work in Windows 7 N or in Windows 7 KN.

- Windows 7 Games: Games that are included in Windows 7 N and in Windows 7 KN work but do not play back sound effects.

- Windows Mobile Devices: Media synchronization, image acquisition, and file browsing are not supported in Windows 7 N or in Windows 7 KN.

- Windows Photos: Cameras that use the Picture Transfer Protocol (PTP) do not function together with Windows 7 N or with Windows 7 KN.

- Sound Recorder: This feature only records files in the .wav format in Windows 7 N and in Windows 7 KN.

- Group Policy for removable disks: This feature enables computer administrators to set read and write permissions on removable disks. This feature does not work in Windows 7 Professional N or in Windows 7 Professional KN. This feature is not included in Windows 7 Starter N or in Windows 7 Starter KN.

- Microsoft TV Technologies: These do not work in Windows 7 N or in Windows 7 KN.

- MPEG-2 and Dolby Digital Codecs: These codecs are collectively known as "DVD Components." They enable Windows 7 software experiences such as Windows Media Player and Windows Media Center to support activities including the following:
  - DVD playback
  - DVD video burning
  - Television recording and playbackThe MPEG-2 components do not function in Windows 7 N or in Windows 7 KN. These features are not included in Windows 7 Starter N or in Windows 7 Starter KN.

- VC-1, MPEG-4, H.264 codecs: These codecs are collectively known as *standards-based codec* components. They enable Windows 7 software experiences to support various activities. These activities include playing back multimedia files and creating multimedia files. These files are encoded with the standards-based codecs. The standards-based codec components do not work in Windows 7 N or in Windows 7 KN.

- Windows Premium Sound Schemes: Windows 7 Home Premium and higher editions contain additional sound schemes encoded by using the MP3 codec format. These schemes are not included in Windows 7 N or in Windows 7 KN.

- Sensor and Location Platform: This feature does not work in Windows 7 N or in Windows 7 KN.

For more information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).
