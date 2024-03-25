---
title: Cannot establish connection to Access Database Engine OLE DB
description: Provides a resolution for the issue that you can't establish a connection with database actions to Access Database Engine OLE DB in Power Automate for desktop.
ms.reviewer: adija, pefelesk
ms.date: 03/19/2024
ms.subservice: power-automate-desktop-flows
---
# Can't establish a connection to Access Database Engine OLE DB

This article provides a resolution to an issue where you can't establish a connection to Access Database Engine OLE DB in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5004577

## Symptoms

Consider the following scenario in Microsoft Power Automate for desktop:

1. Access Database Engine OLE DB provider doesn't show in the **Data Link Properties** window list when you establish a connection with database actions.

2. When you use a connection string directly, you may receive the following error message:

   > Can’t connect to data source The 'Microsoft.ACE.OLEDB.1x.0.' provider is not registered on the local machine.

## Cause

This error message occurs because the appropriate 64-bit driver isn't installed on your machine. Kindly note that Power Automate for desktop is based on 64-bit architecture and thus is only compatible to 64-bit database drivers.

## Resolution

Verify that you have 64-bit Access Database driver installed on your machine by going to ODBC Data Source Administrator (64-bit) application on windows and then the **Drivers** tab. If you don't see "Microsoft Access Driver" in the list, you need to download and install the 64-bit version from [Microsoft Access Database Engine 2016 Redistributable](https://www.microsoft.com/download/details.aspx?id=54920).

> [!TIP]
> If you have 32-bit Office installed on your windows and can't upgrade to 64-bit version of Office, continue reading the rest of the article.

Follow the steps below to have both 32-bit and 64-bit Access drivers co-exist on your machine:

1. Uninstall all the Access driver versions from your machine.

2. Go to the registry editor on your desktop (You can search for it in the search bar) and navigate to both the paths below if they exist:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Common\FilesPaths`

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Common\FilesPaths`

3. Check if the "mso.dll" registry key is present in both the above paths. If the key is present, this means that you haven't uninstalled all the drivers. Verify the drivers on your system and uninstall all the Access drivers and verify the registry editors' paths mentioned in step 2 again.

4. Download a new version of Microsoft Access Database Engine from the Microsoft official website, and then install the 64-bit driver using command prompt (CMD) with the command `AccessDatabaseEngine_x64.exe /quiet` for 2016 Redistributable.

5. Go back to registry editor and delete the "mso.dll" registry key and its value in the following path:

   - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Common\FilesPaths`

Lastly, install the 32-bit driver using command prompt (CMD) with the command `AccessDatabaseEngine.exe /quiet` for 2016 Redistributable. This will allow both the 32-bit and 64-bit drivers to co-exist on your machine.
