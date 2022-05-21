---
title: Add or Remove Features window is blank
description: This article provides a resolution for the problem that occurs when you attempting to add or remove a feature for Microsoft Dynamics GP 2010 through the Select Features window.
ms.topic: troubleshooting
ms.reviewer: kyouells
ms.date: 03/31/2021
---
# The Add/Remove Features window is blank for Microsoft Dynamics GP 2010

This article provides a resolution for the problem that occurs when you attempting to add or remove a feature for Microsoft Dynamics GP 2010 through the **Select Features** window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2581260

## Symptoms

When attempting to add or remove a feature for Microsoft Dynamics GP 2010 through the **Select Features** window, the window is blank and no features appear.

## Cause

The **Country** entry in the Microsoft Dynamics GP 2010 Registry key is missing a value. This entry is required to view the list of features into the 'Select Features' window.

## Resolution

Enter the appropriate country/region in Microsoft Dynamics GP 2010 Registry key. Follow the steps below:

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Click **Start**, click **Run**, type **Regedit**, and then click **OK** to open the Registry Editor window.

2. Browse to one of the following locations depending if you use a 32-bit or x64 operating system:

    - 32-bit `HKEY_Local_Machine\SOFTWARE\Microsoft\Business Solutions\Great Plains\v11.0\1033\`

    - x64 `HKEY_Local_Machine\SOFTWARE\Wow6432Node\Microsoft\Business Solutions\Great Plains\v11.0\1033\`

3. Right-click the instance folder for the instance of Microsoft Dynamics GP that has the issue, and then click **Export**. Export the key to a location to back up the Registry key.

4. Expand the instance of Microsoft Dynamics GP 2010 that has this problem. For example, the default instance is under the DEFAULT folder.

5. Click the *SETUP* folder to view the contents in the right-hand pane.

6. Double-click the **Country** key and enter the appropriate value. The **Country** value should match the country/region that was selected during the installation of Microsoft Dynamics GP 2010. For example, for a United States install enter *United States*.

7. Click **OK**.

8. Close the Registry Editor window.

9. Open the Select Features window again for Microsoft Dynamics GP 2010 and the features will now be available to be installed or removed.
