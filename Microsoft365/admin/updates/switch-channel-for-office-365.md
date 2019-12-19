---
title: How to switch from Semi-Annual Channel to Monthly Channel for the Office 365
description: Describes how to switch from the Semi-Annual Channel to the Monthly Channel channels for the Office 365 ProPlus product family.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Office 365 ProPlus
---

# How to switch from Semi-Annual Channel to Monthly Channel for the Office 365 suite

## Summary

If you have just installed Office 365, and you're on the default Semi-Annual update channel, you might have a reason to move to the Monthly update channel. For example, a fix or a new feature has been released, and you want to move to the Monthly Channel to receive it.  

To switch from the Semi-Annual Channel to the Monthly Channel, follow these steps: 
 
1. Identify the value of the **CDNBaseURL** registry keyfor the channel that you want to switch to. To learn how, see [this Docs article](https://docs.microsoft.com/sccm/sum/deploy-use/manage-office-365-proplus-updates#change-the-update-channel-after-you-enable-office-365-clients-to-receive-updates-from-configuration-manager).    
2. Start Notepad, paste the following script into Notepad, and then save the file by using a .bat extension:

    > [!NOTE]
    > In the following script, notice that the value of **CDNBaseURL** is set to the URL of the Monthly channel that’s identified in step 1. If you want to switch to a different channel, you can use the appropriate URL from the referenced article in step 1.

    ```powershell
    setlocal 
    reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration\ /v CDNBaseUrl if %errorlevel%==0 (goto SwitchChannel) else (goto End) 
    :SwitchChannel 
    reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v CDNBaseUrl /t REG_SZ /d "https://officecdn.microsoft.com/pr/492350f6-3a01-4f97-b9c0-c7c6ddf67d60" /f 
    reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v UpdateUrl /f 
    reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v UpdateToVersion /f 
    reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\Updates /v UpdateToVersion /f 
    reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Office\16.0\Common\OfficeUpdate\ /f 
    :End 
    Endlocal
    ```
3. Right-click the script file, and then click **Run as administrator**. 
4. Start an Office application (such as Excel), and then select **File** > **Account**.    
5. In the **Product Information** section, select **Update Options** > **Update Now**.    

To switch to a different channel by using the Office Deployment Tool (ODT), follow these steps: 

1. Download the latest version of the ODT (setup.exe) from the [Microsoft Download Center](https://go.microsoft.com/fwlink/p/?LinkID=626065).    
2. Identify the name of the channel to which you want to switch. To learn how, see [Channel attribute](https://docs.microsoft.com/DeployOffice/configuration-options-for-the-office-2016-deployment-tool#channel-attribute-part-of-add-element).    
3. Create a configuration XML file that specifies the appropriate channel name, such as the following update.xml file.  

    ```xml
    <Configuration> 
    <Updates Channel="Monthly" /> 
    </Configuration>
    ```
1. From an elevated command prompt, switch to the folder location where setup.exe resides, and then run the following command:  

    ```powershell
    setup.exe /configure update.xml
    ```
1. Start an Office application (such as Excel), and then select **File** > **Account**. In the **Product Information** section, select **Update Options** > **Update Now**.  

For switching channels for a large group of users or through System Center Configuration Manager (SCCM), [configure the **Update Channel** setting](https://docs.microsoft.com/DeployOffice/overview-of-update-channels-for-office-365-proplus?redirectSourcePath=%252fen-us%252farticle%252f9ccf0f13-28ff-4975-9bd2-7e4ea2fefef4#configure-the-update-channel-to-be-used-by-office-365-proplus) by using GPO. After the setting is applied, verify that the **UpdateChannel** and **CDNBaseURL** registry keys are set to the desired update channel's URL. To learn how, see [Change the update channel after you enable Office 365](https://docs.microsoft.com/sccm/sum/deploy-use/manage-office-365-proplus-updates#change-the-update-channel-after-you-enable-office-365-clients-to-receive-updates-from-configuration-manager).  

Consider using the [ForceAppShutdown](https://docs.microsoft.com/deployoffice/configuration-options-for-the-office-2016-deployment-tool#forceappshutdown-property-part-of-property-element) setting in case Office updates are not applied to some users because of opened Office applications. 
For more information, see the following articles: 
- [Find CDNBaseURL for each Office Update Channel](https://docs.microsoft.com/sccm/sum/deploy-use/manage-office-365-proplus-updates#change-the-update-channel-after-you-enable-office-365-clients-to-receive-updates-from-configuration-manager)    
- [Overview of update channels for Office 365 ProPlus](https://docs.microsoft.com/DeployOffice/overview-of-update-channels-for-office-365-proplus?redirectSourcePath=%252fen-us%252farticle%252f9ccf0f13-28ff-4975-9bd2-7e4ea2fefef4)    

## More Information

By default, Office 365 ProPlus suite installation sets the update channel to **Semi-Annual Channel**. To learn more about the various channels in the Office 365 suite, see [Overview of update channels for Office 365 ProPlus](https://technet.microsoft.com/library/mt455210.aspx).

> [!NOTE]
> This sample script is provided "as is" with no warranty or support from Microsoft. It's a demonstration, and is used for informational purposes only. The script has not been rigorously tested in all environments and doesn't contain error handling. You must make it "production ready" if you use it in any development solution.
