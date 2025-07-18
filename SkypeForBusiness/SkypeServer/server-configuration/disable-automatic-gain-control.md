---
title: How to disable Automatic Gain Control in Skype for Business on Windows
description: Describes methods to disable the Automatic Gain Control feature in Skype for Business in Microsoft 365 Click-to-Run version 16.0.8625.2055 or a later version.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
appliesto: 
  - Skype for Business 2016
ms.date: 03/31/2022
---

# How to disable Automatic Gain Control in Skype for Business on Windows

If you're using Microsoft 365 Click-to-Run version 16.0.8625.2055 or a later version, you can disable the Automatic Gain Control (AGC) feature in Skype for Business. To disable the feature, use one of the following methods. 

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

## Method 1: Disable the feature in the Audio Device settings

By default, there is no AGC option displayed in the UI. To display and set the option, follow these steps: 
 
1. In Registry Editor, create and set the following registry entry:

    **HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Lync]**

    **"ShowAutomaticGainControlOption"=dword:00000001**    
2. In Skype for Business, click **Tools** > **Options** > **Audio Device**.    
3. Click to clear the **Automatically adjust microphone volume on calls** check box.

    :::image type="content" source="./media/disable-automatic-gain-control/checkbox.png" alt-text="Screenshot that shows the Automatically adjust microphone volume on calls checkbox.":::
 
## Method 2: Disable the feature in the registry

In Registry Editor, create and set the following registry entry: 

**HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Lync]**

**"DisableAutomaticGainControl"=dword:00000001**

## Method 3: Use Group Policy to display and disable the feature

1. In Group Policy Management, create a Group Policy object.  
2. Right-click the new Group Policy object, and then select **Edit**.    
3. Expand **Computer Configuration** or **User Configuration** > **Preferences** > **Windows Settings**.    
4. Right-click **Registry**, select **New**, and then select **Registry Item**.    
5. In the **New Registry Properties** dialog box, specify the following information, and then select **OK**:

    **Action:** Create

    **Hive:** HKEY_CURRENT_USER

    **Key path:** Software\Policies\Microsoft\Office\16.0\Lync

    **Value name:** ShowAutomaticGainControlOption

    **Value type:** REG_DWORD

    **Value data:** 1

    **Base:** Decimal    

6. Create another registry item by specifying the following information:

    **Action:** Create

    **Hive:** HKEY_CURRENT_USER

    **Key path:** Software\Policies\Microsoft\Office\16.0\Lync

    **Value name:** DisableAutomaticGainControl

    **Value type:** REG_DWORD

    **Value data:** 1

    **Base:** Decimal    

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
