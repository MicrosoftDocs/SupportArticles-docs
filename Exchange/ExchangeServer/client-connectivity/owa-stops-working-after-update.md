---
title: OWA or ECP stops working after you install a security update
description: OWA/ECP stops working after a security update is manually installed on Exchange server without elevated permissions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: batre; ninob
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - CI 144977
  - CI 147050
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
  - Exchange Server 2010 Service Pack 3
ms.date: 01/24/2024
---

# OWA or ECP stops working after you install a security update

## Symptoms

After you install a security update on a server that's running Microsoft Exchange Server, either Outlook on the web (OWA) or Exchange Control Panel (ECP), or both applications stop working on the server.

OWA displays the following error message:

> Something went wrong</br>
> Your request couldn't be completed. HTTP Status code: 500

:::image type="content" source="./media/owa-stops-working-after-update/exchange-server-owa-something-went-wrong.png" alt-text="Screenshot of the OWA error message.":::

ECP displays the following error message:

>Server Error in '/ecp' Application.</br>
Could not load file or assembly 'Microsoft.Exchange.Common, Version=15.0.0.0 …Culture=neutral, PublicKeyToken=31bf3856ad364e54' or one of its dependencies. The system cannot find the file specified.

:::image type="content" source="./media/owa-stops-working-after-update/could-not-load-file-or-assembly.png" alt-text="Screenshot of the E C P error message.":::

## Cause

These errors occur if the security update was manually installed on a server that has User Account Control (UAC) enabled, but without using elevated permissions.

## Resolution

Use elevated permissions to reinstall the security update on the server.

1. Select **Start**, and then type *cmd*.
1. Right-click **Command Prompt** from the search results, and then select **Run as administrator**.
1. If the **User Account Control** window appears, select the option to open an elevated Command Prompt window, and then select **Continue**.
   If the UAC window doesn't appear, continue to the next step.
1. Type the full path of the .msp file for the security update, and then press **Enter**.
1. After the update installs, restart the server.

Check whether you can now access OWA and ECP on the server without getting an error message.

If the ECP error message continues to display, do the following:

1. Start **IIS Manager** on the server.
1. Navigate to **Exchange Backend website** > **ECP Virtual directory**.
1. Select **Application settings** > **BinsearchFolder**.
1. Check the paths to the Exchange directories that are listed. You might see directory paths that resemble the following:

    > *%ExchangeInstallDir%bin;<br/>%ExchangeInstallDir%bin\CmdletExtensionAgents;<br>%ExchangeInstallDir%ClientAccess\Owa\bin*

1. Replace the paths with the following paths:

    >*C:\Program Files\Microsoft\Exchange Server\V15\bin;<br/>
    C:\Program Files\Microsoft\Exchange Server\V15\bin\CmdletExtensionAgents;<br/>
    C:\Program Files\Microsoft\Exchange Server\V15\ClientAccess\Owa\bin*

    **Note** The paths must point to where Exchange Server is installed. The following examples assume that the program is installed on drive C and that the version is Microsoft Exchange Server 2013. If it is installed on a different drive on your server, or if you're using a different version such as Microsoft Exchange Server 2010, then use the path and version information that's appropriate for your installation.

1. Navigate to a folder that includes Exchange Server scripts. By default, scripts are located in the following path for Exchange Server 2013:

    >*C:\Program Files\Microsoft\Exchange Server\v15\Bin*

    **Note** For Exchange Server 2010, the scripts will be in the *:::no-loc text="V14":::* folder instead.

1. Start Exchange Management Shell as an administrator and run the following scripts:
`.\UpdateCas.ps1` and `.\UpdateConfigFiles.ps1`.

1. Exit Exchange Management Shell and open a Command Prompt window as an administrator.
1. Run `iisreset`.
1. Restart the server, and verify that you no longer get an error message when you access ECP.
