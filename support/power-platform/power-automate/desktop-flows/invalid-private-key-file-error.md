---
title: Invalid Private key file error
description: Provides a resolution to correct the private key file format in Power Automate for desktop.
ms.reviewer: adija
ms.date: 09/20/2022
ms.subservice: power-automate-desktop-flows
---
# "Invalid Private key file" error in Open secure FTP connection action

This article provides a resolution to solve the error that occurs when you use a private key file that isn't using OpenSSH format in the "Open secure FTP connection" action in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5003728

## Symptoms

In Microsoft Power Automate for desktop, when you use a private key file as an authentication method in the "Open secure FTP connection" action, you may receive the following error message:

> Error message: "Can't connect to _ServerHost_".  
> More error details: "Robin.Core.ActionException: Can't connect to _ServerHost_ ---> Renci.SshNet.Common.SshException: Invalid private key file".

Here _ServerHost_ is the FTP server host address used in the action.

## Cause

This error can occur if the format of the private key file isn't using OpenSSH format. Power Automate for desktop explicitly checks that the private key file format is OpenSSH, where the key should start with:

```output
---- BEGIN ___ PRIVATE KEY ----
```

## Resolution

To correct the private key file format (OpenSSH Format), make sure that the text in the file looks similar to the following:

```output
----BEGIN ___ PRIVATE KEY----

.............................

.............................

----END ___ PRIVATE KEY----
```

You can also use PuTTY Key Generator (_PuttyGen.exe_) to convert the key file to the OpenSSH format. To do that:

1. Load your existing private key file in PuTTY Key Generator.
2. Select **Conversions** > **Export OpenSSH key** (not the **force new file format** option).
