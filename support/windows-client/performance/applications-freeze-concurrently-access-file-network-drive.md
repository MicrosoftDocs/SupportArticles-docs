---
title: Applications freeze when they concurrently try to access a file on a network drive in Windows
description: Discusses an issue in which applications freeze when they try to access the same file on a network drive in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:System Performance\App, Process, Service Performance (slow, unresponsive), csstroubleshoot
---
# Applications freeze when they concurrently try to access a file on a network drive in Windows

This article provides a workaround to an issue in which applications freeze when they try to access the same file on a network drive in Windows.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4039810

## Symptoms

Consider the following scenario:

- You create a share folder on a server, and then you add a file to the folder.
- On a client that is running Windows 10, Windows 8.1, or Windows 7, you mount the shared folder as a network drive.
- You install third-party security software that includes a file system minifilter driver that is associated with an application.
- The minifilter is attached to both a local drive that holds the %SystemRoot% path (for example, a C drive) and the network drive for the shared folder that you created.
- The minifilter sends a message (by using the **FltSendMessage** function) that includes the file name in the network drive to the application.
- The application tries to open the file by using the file name that it receives.
- Another application on the same computer that is not associated with the minifilter tries to open the same file on the network drive at the same time.

In this scenario, both applications freeze.

## Cause  

This problem occurs because of a resource lock that is held by the Windows Client-Side Caching Driver (Csc.sys). When this issue occurs, Csc.sys gets a resource lock on a file, and then it requests a driver that's above it in a driver stack to open the file. This makes all applications that try to access the file wait. This also makes the minifilter's thread wait for its associated application to respond.

## Workaround

If this problem has already occurred, restart the client.

To avoid this problem, disable **Offline Files**  by using the **Local Group Policy Editor** (gpedit.msc). To do this, use the **Allow or disallow use of the Offline Files feature** Group Policy setting in **Computer Configuration\\Administrative Templates\\Network\\Offline Files**.
> [!Note]
> If you have to use **Offline Files**, there is no workaround.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the beginning of the article.

## More Information

It's generally a bad idea to hold locks across calls to the file system. The reason for this is documented in the following Developer Blog article:  
[Issuing IO in minifilters: Part 1 - FltCreateFile](/archive/blogs/alexcarp/issuing-io-in-minifilters-part-1-fltcreatefile)

To identify a minifilter that is attached to multiple drives as described in the "Symptoms" section, run the following commands at an administrative command prompt:

```console
fltmc instances -v C:

fltmc instances -v \Device\Mup
```
