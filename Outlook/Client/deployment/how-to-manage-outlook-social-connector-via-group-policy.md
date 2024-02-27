---
title: How to manage Outlook Social Connector by using Group Policy
description: This article introduces how to manage the Outlook Social Connector by using Group Policy.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: gregmans, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# How to manage the Outlook Social Connector by using Group Policy

## Summary

Several features and components of the Outlook Social Connector (OSC) can be managed by using Group Policy. This article contains a custom Group Policy template that you can use to manage the following tasks:

- Loading the Outlook Social Connector
- Configuring People Pane notifications
- Specifying the activity synchronization interval period
- Specifying the global address list (GAL) synchronization interval
- Specifying the social network contact synchronization interval period
- Blocking social network activity synchronization
- Block social network contact synchronization
- Blocking Global Address List synchronization with local contacts
- Preventing configuration of social network accounts
- Blocking the download of Active Directory details
- Blocking on-demand activity synchronization
- Blocking specific providers
- Configuring the specific providers to load
- Displaying contact photos
- Configuring the maximum number of items to display in the People Pane

For detailed information about the Group Policy settings that are available to manage the Outlook Social Connector, see the "More information" section.

## More information

The process for managing the Outlook Social Connector varies slightly between the different versions of Outlook. Use one of the following methods, depending on your version of Outlook.

### Outlook 2013 or Outlook 2016

1. Download the Group Policy template appropriate for your version of Office from the following Microsoft website:

    Office 2016: [Administrative Template files (ADMX/ADML) for Microsoft 365 Apps for enterprise/Office LTSC 2021/Office 2019/Office 2016 and the Office Customization Tool for Office 2016](https://www.microsoft.com/download/details.aspx?id=49030)  
    Office 2013: [Office 2013 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=35554)

2. Extract the admintemplates_32bit.exe or admintemplates_64bit.exe, and then copy the appropriate .admx file for your Office version to the _C:\Windows\PolicyDefinitions_ folder.

    Office 2016: Outlk16.admx  
    Office 2013: Outlk15.admx

3. Copy the appropriate .adml file for your version of Outlook to the C:\Windows\PolicyDefinitions\xx-xx directory, where xx-xx is a Language Culture name. For example, for English (US), the Language Culture name is en-us. For more information about Language Culture names, see [Table of Language Culture Names, Codes, and ISO Values [C++]](/previous-versions/commerce-server/ee797784(v=cs.20)).

    Office 2016: Outlk16.adml  
    Office 2013: Outlk15.adml

4. Start the Group Policy Object Editor or the Group Policy Management Console.

    > [!NOTE]
    > Because you may be applying the policy setting to an organizational unit and not to the whole domain, the steps may vary in this aspect of applying a policy setting. Therefore, check your Windows documentation for more information.

5. In the Group Policy Object Editor or the Group Policy Management Console, under **User Configuration**, expand **Administrative Templates**, expand your version of **Microsoft Outlook**, and then select the **Outlook Social Connector** node.

6. Double-click any setting in the details pane to configure the Group Policy setting. For example, double-click **Do not show social network info-bars** to manage the display of info-bar messages in the People Pane.

7. In the dialog box for the policy setting, select **Enabled** to enable the policy. For example, the following figure shows the **Do not show social network info-bars** policy in an **Enabled** state.

8. Select **OK**.
9. Configure any remaining policy settings for the Outlook Social Connector.

> [!NOTE]
> For detailed information about each policy setting for the Outlook Social Connector, see the [Group Policy Setting Details](#group-policy-setting-details) section.

### Outlook 2010

> [!NOTE]
> The custom OutlookSocialConnector.adm template contains more settings for the OSC than are contained in the Outlk14.adm template file (referenced earlier in this article). Therefore, we recommend that you use the OutlookSocialConnector.adm template that is mentioned in the "Outlook 2003 or Outlook 2007" section with Outlook 2010 clients.
>
> However, if you use the OutlookSocialConnector.adm template to configure Group Policy settings for the Outlook Social Connector on Outlook 2010 clients, do not also configure Outlook Social Connector settings from the Outlk14.adm template. If you configure the same settings for the OSC by using both template files, you might create overlapping or inconsistent policies.

To manage the Outlook Social Connector in Outlook 2010 only if you're using the Outlk14.adm template, follow these steps:

1. Download the Office 2010 Group Policy templates from the following Microsoft website:

   [Office 2010 Administrative Template files (ADM, ADMX/ADML) and Office Customization Tool download](https://www.microsoft.com/download/details.aspx?id=18968)

2. Add the Outlk14.adm file to your domain controller.

    > [!NOTE]
    > The steps to add the .adm file to a domain controller vary, depending on the version of Windows that you are running. Also, because you may be applying the policy to an organizational unit (OU) and not to the whole domain, the steps may also vary in this aspect of applying a policy. Therefore, check your Windows documentation for details.

3. Under **User Configuration**, expand **Classic Administrative Templates (ADM)** and then **Microsoft Outlook 2010**, and then select **Outlook Social Connector**.

   :::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/outlook-social-connector.png" alt-text="The Outlook Social Connector setting under Microsoft Outlook 2010 in User Configuration.":::

4. Double-click any setting in the details pane to configure the Group Policy setting. For example, double-click **Do not show social network info-bars** to manage the display of info-bar messages in the People Pane.

5. In the dialog box for the policy setting, select **Enabled** to enable the policy. For example, the following figure shows the **Do not show social network info-bars**  policy in an **Enabled** state (The screenshot for this step is listed below).

   :::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/do-not-show-social-network-info-bars.png" alt-text="Enable the Do not show social network info-bars policy setting." border="false":::

6. Select **OK**.
7. Configure any remaining policy settings for the Outlook Social Connector.

> [!NOTE]
> For detailed information about each policy setting for the Outlook Social Connector, see the [Group Policy Setting Details](#group-policy-setting-details) section.

### Outlook 2007 or Outlook 2003

1. Download the Outlook 2003 and Outlook 2007 Group Policy template (OutlookSocialConnector.adm) for the Outlook Social Connector from [Outlook Social Connector](https://download.microsoft.com/download/2/8/D/28D04E42-71A9-4DF4-B4E3-283B30CF39ED/OutlookSocialConnector.zip).

    > [!NOTE]
    > You can use the OutlookSocialConnector.adm template with Outlook 2010 clients. However, if you use the OutlookSocialConnector.adm template to configure Group Policy settings for the Outlook Social Connector on Outlook 2010 clients, do not also use the Outlk14.adm template to configure settings for the Outlook Social Connector. If you configure the same settings for the OSC by using both template files, you might create overlapping or inconsistent policies.

2. Add the OutlookSocialConnector.adm file to your domain controller.

   > [!NOTE]
   > The steps to add the .adm file to a domain controller vary, depending on the version of Windows that you are running. Also, because you may be applying the policy to an organizational unit (OU) and not to the whole domain, the steps may vary in this aspect of applying a policy. Therefore, check your Windows documentation for details.

3. Under **User Configuration**, expand **Classic Administrative Templates (ADM)**, and then select **Outlook Social Connector**.

   :::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/outlook-social-connector-under-adm.png" alt-text="The Outlook Social Connector setting under Classic Administrative Templates (ADM) in User Configuration.":::

4. Double-click any setting in the details pane to configure the Group Policy setting. For example, double-click **Do not display contact photo** to manage the display of contact photos in the People Pane.

5. In the dialog box for the policy setting, select **Enabled** to enable the policy. For example, the following figure shows the **Do not display contact photo** policy configured as **Enabled**.

   :::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/do-not-display-contact-photo.png" alt-text="Enable the Do not display contact photo policy setting." border="false":::

6. Select **OK**.
7. Configure any remaining policy setting for the Outlook Social Connector.

> [!NOTE]
> For detailed information about each policy setting for the Outlook Social Connector, see the [Group Policy Setting Details](#group-policy-setting-details) section.

## Group Policy Setting Details

Each of the Group Policy settings for the Outlook Social Connector is discussed in detail in the following table. All these settings are available in the OutlookSocialConnector.adm template. However, not every setting is available or functioning in the Outlk14.adm and Outlk15.admx templates. See the following table to determine the availability of these Group Policy settings.

|Group Policy Setting  | Available in OutlookSocialConnector.adm | Available in Outlk14.adm | Available in Outlk15.admx |Available in Outlk16.admx |
|---|---|---|---|---|
|Turn off Outlook Social Connector|yes|yes|yes|yes|
|Do not show social network info-bars|yes|yes|yes|yes|
|Specify activity feed synchronization interval|yes|yes|yes|yes|
|Set GAL contact synchronization interval|yes|yes|yes|yes|
|Set network contact synchronization interval|yes|no|no|no|
|Block network activity synchronization|yes|yes|yes|yes|
|Block social network contact synchronization|yes|yes|yes|yes|
|Block Global address list synchronization|yes|yes|yes|yes|
|Prevent social network connectivity **or** Disable Office connections to social networks|yes|yes|yes|yes|
|Do not download details from Active Directory **or** Do not download photos from Active Directory|yes|yes, but does not function in the Outlk14.adm template.|yes|yes|
|Do not allow on-demand activity synchronization|yes|yes|yes|yes|
|Block specific social network providers|yes|yes|yes|yes|
|Specify list of social network providers to load|yes|yes|yes|yes|
|Do not display contact photo|yes|no|no|no|
|Maximum number of items displayed in the People Pane|yes|no|no|no|

The following items provide details about the Group Policy settings and about the registry data that is associated with them.

### Turn off Outlook Social Connector

This policy setting lets you turn on or turn off the Outlook Social Connector. If you enable this policy setting, the Outlook Social Connector is turned off. If you disable this policy setting or if you don't configure it, the Outlook Social Connector is turned on.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **RunOSC**  
Values:  
0 = Policy enabled. The Outlook Social Connector does not display any user interface options and synchronization with the GAL does not occur.  
1 = Policy disabled. (default) The Outlook Social Connector is turned on.

> [!NOTE]
> If **RunOSC** = 0, the Outlook Social Connector add-in is still loaded by Outlook. However, it does not provide any functionality.

### Do not show the social network info-bar

This policy setting controls whether info-bar messages that prompt you to install social network providers are displayed in the People Pane. If you enable this policy setting, the info-bar messages aren't shown in the People Pane. If you disable or don't configure this policy setting, the info-bar messages are shown in the People Pane.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **UnmanagedInfobars**  
Values:  
1 = Policy enabled. The People Pane does not display info-bar prompts to add social network providers.
0 = Policy disabled. (default) The People Pane displays info-bar prompts to add social network providers.

> [!NOTE]
> The following is an info-bar message that is displayed in the People Pane that is affected by this policy (The screenshot for this step is listed below).
>
> Connect to social networks to show profile photos and activity updates of your colleagues in Outlook. Select here to add networks.

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/connect-to-social-networks-to-show-profile-photos-message.png" alt-text="The info-bar message that is affected by this policy setting." border="false":::

You're prompted with this message when you don't have any social network providers configured in your Outlook profile.

### Specify activity feed synchronization interval

This policy setting controls how frequently activity feed information is synchronized between Outlook and connected social networks (in minutes). If you enable this policy setting, you can specify the interval in which activity information is synchronized. If you disable or you don't configure this policy setting, activity information is synchronized at the default interval (60 minutes).

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **ActivitySyncInterval**  
Values: Any integer between 1 and 10080.

> [!NOTE]
> Activity feed synchronization includes information displayed on the **Activities** tab and on the **Status Updates** tab in the People Pane.

### Set GAL contact synchronization interval

This policy setting controls how frequently contact information is synchronized between Outlook and the global address list (in minutes). If you enable this policy setting, you may specify the specified interval (in minutes) in which contact information is synchronized. If you disable or you don't configure this policy setting, contact information is synchronized at the default interval (one time every 4 days, or 5760 minutes).

This policy setting is controlled by the following registry information:

Key: HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **ContactSyncInterval**  
Values: Any integer between 1 and 10080.

### Set network contact synchronization interval (not available in the Outlk14.adm template)

This policy setting controls how frequently contact information is synchronized between Outlook and connected social networks (in minutes). If you enable this policy setting, you may specify the specified interval (in minutes) in which contact information is synchronized. If you disable or you don't configure this policy setting, contact information is synchronized at the default interval (one time per day, or 1440 minutes).

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **NetContactSyncInterval**  
Values: Any integer between 1 and 10080.

### Block network activity synchronization

This policy setting lets you block synchronization of activities and status updates between Outlook and social networks. If you enable this policy setting, social network activity synchronization is blocked. If you disable or you don't configure this policy setting, social network activity synchronization is allowed.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **DisableActivityDownload**  
Values:  
1 = Policy enabled. The Outlook Social Connector does not synchronize activities and status updates from social networks.  
0 = Policy disabled. (default) The Outlook Social Connector synchronizes activities and status updates from social networks.

> [!NOTE]
> Activity feed synchronization includes information displayed on the **Activities** tab and **Status Updates** tab in the People Pane.

The following figure displays the expected results in the People Pane when **DisableActivityDownload** = 1.

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/activities-info-when-disableactivitydownload-is-1.png" alt-text="The expected results in the People Pane when Disable Activity Download is set to 1." border="false":::

### Block social network contact synchronization

This policy setting lets you block synchronization of contacts between Outlook and social networks. If you enable this policy setting, social network contact synchronization is blocked. If you disable or you don't configure this policy setting, social network contact synchronization is allowed.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **DisableContactDownload**  
Values:  
1 = Policy enabled. The Outlook Social Connector does not synchronize contacts with a social network provider.  
0 = Policy disabled. (default) The Outlook Social Connector synchronizes contacts with a social network provider.

When a social network synchronizes network contact information with Outlook, the network contact is stored in a local contacts folder in your mailbox. The following figure shows the LinkedIn contacts folder that was created by the default synchronization with a LinkedIn account.

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/linkedin-contacts-folder.png" alt-text="The LinkedIn contacts folder in your mailbox." border="false":::

This folder isn't created if **DisableContactDownload** = 1.

> [!NOTE]
> Activity synchronization with the social network still occurs when **DisableContactDownload** = 1. This is demonstrated in the following figure.

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/activity-synchronization-still-works-when-disablecontactdownload-is-1.png" alt-text="The activity synchronization with the social network still occurs when Disable Contact Download is set to 1." border="false":::

In this scenario, the contact photo isn't displayed in the People Pane because the photo isn't available when the local contacts folder isn't in your mailbox.

### Block global address list synchronization

This policy setting lets you block the synchronization of contacts between Outlook and the global address list (GAL). If you enable this policy setting, GAL contact synchronization is blocked. If you disable or you don't configure this policy setting, GAL contact synchronization is allowed.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **DisableContactGALSync**  
Values:  
1 = Policy enabled. The OSC does not synchronize Active Directory information with contacts (from the GAL) saved in your Contacts folder.  
0 = Policy disabled. (default) The OSC synchronizes Active Directory information with contacts (from the GAL) saved in your Contacts folder.

> [!NOTE]
> The contact item inspector displays the **Update** button even when **DisableContactGALSync** = 1. Select **Update** in the contact item to force a synchronization of the Active Directory information with the local contact item (The screenshot for this step is listed below).

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/update-button-in-contacts-card.png" alt-text="The Update button is still shown when Disable Contact G A L Sync is set to 1." border="false":::

### Prevent social network connectivity or Disable Office connections to social networks

This policy setting lets you prevent social network connectivity in the Outlook Social Connector. If you enable this policy setting, you can't configure social network accounts using the Outlook Social Connector, and existing social network accounts are disabled. If you disable or you don't configure this policy setting, social network connectivity is allowed.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **DisableSocialNetworkConnectivity**  
Values:  
1 = policy enabled. The Outlook Social Connector does not display any providers in the Social Network Accounts dialog box.  
0 = policy disabled. (default) The Outlook Social Connector displays all installed providers in the Social Network Accounts dialog box.

> [!NOTE]
> If it is enabled, GAL contact synchronization still occurs when **DisableSocialNetworkConnectivity** = 1.
>
> The following figure shows the **Social Network Accounts** dialog box when **DisableSocialNetworkConnectivity** = 1.

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/social-network-accounts-dialog-box.png" alt-text="The screenshot of the Social Network Accounts dialog box when Disable Social Network Connectivity is set to 1." border="false":::

### Do not download details from Active Directory (not available in the Outlk14.adm and Outlk15.admx templates)

This policy setting controls whether contact user details are downloaded from Active Directory. If you enable this policy setting, contact details (photo, title, and company) aren't downloaded. If you disable or you don't configure this policy setting, contact details are downloaded and displayed in the People Pane.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **DownloadDetailsFromAD**  
Values:  
0 = policy enabled. The information displayed in the People Pane depends on the source location for the contact details. If the information is available only in Active Directory, the information is not displayed in the People Pane.  
1 = policy disabled. (default) The OSC displays contact photos, title and company details, when they are available, in the People Pane.

> [!NOTE]
> When **DownloadDetailsFromAD** = 0, the information displayed in the People Pane depends on whether you are using a cached or online mode profile, and the location of the contact information.

#### Cached mode

When you are in cached mode and **DownloadDetailsFromAD** = 0, you'll see contact details (photo, company name, or title) if it comes from the following sources:

Offline Address Book (OAB)  
Contacts folder in your mailbox  
Network contact

If the contact details are stored only in Active Directory, such as a photo, the People Pane doesn't display the details. This can be seen in the following figure where the contact's photo is available only in Active Directory, but their company name (Wingtiptoys) and title (Tester) are available from the OAB.

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/contact-detials-not-showing-photo.png" alt-text="The screenshot of the contact details when the contact details are stored only in Active Directory." border="false":::

#### Online mode

When you are in online mode and **DownloadDetailsFromAD** = 0, you'll see contact details (photo, company name, or title) if it comes from the following sources:

Contacts folder in your mailbox  
Network contact

If the contact details are stored only in Active Directory, the People Pane doesn't display the contact details. This can be seen in the following figure where the first contact's photo, company name and title aren't displayed.

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/contact-details-in-online-mode.png" alt-text="The screenshot of the contact details in online mode when the contact details are stored only in Active Directory.":::

In this same figure, the second contact's details are available in the local Contacts folder, so they're displayed in the People Pane. The source of the contact details is confirmed if you put your pointer over the contact photo (The screenshot for this step is listed below).

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/contact-details-available-in-local-contacts-folder.png" alt-text="The screenshot of the contact details in online mode when the contact details are stored in the local Contacts folder.":::

### Do not allow on-demand activity synchronization

This policy setting lets you prevent on-demand synchronization of activity information between Outlook and social networks. If you enable this policy setting, on-demand synchronization is blocked. If you disable or you don't configure this policy setting, on-demand synchronization is allowed.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **OnDemandActivitySync**  
Values:  
0 = policy enabled. The OSC does not perform on-demand retrieval of contact activity information when a contact is selected in the People Pane.  
1 = policy disabled. (default) The OSC performs on-demand retrieval of contact activity information when a contact is selected in the People Pane.

> [!NOTE]
> On-demand activity retrieval by the OSC applies only to social network providers that support the dynamicActivitiesLookup capability. Contact the vendor of your social network provider to determine whether it supports the dynamicActivitiesLookup capability. Dynamic activity lookup makes sure that you always see the latest activities for contacts in the People Pane, but it will increase the number of calls from the provider to the social network.

### Block specific social network providers

This policy setting lets you specify the list of social network providers that will never be loaded by the Outlook Social Connector. If you enable this policy setting, social network providers added to the list will never be loaded by the Outlook Social Connector. This list is semicolon (;) delimited. If you disable or you don't configure this policy setting, the Outlook Social Connector can load any installed provider.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
String: **DisabledProvidersList**  
Value: Semicolon delimited list of currently installed providers (The current list of providers you can specify is provided below. See the vendor of your social connector provider if it isn't included in the list below.)

SharePoint: **OscAddin.SharePointProvider**  
LinkedIn: **OscAddIn.LinkedInProvider**  
MySpace: **MySpace.OSC**  
Windows Live Messenger: **OscAddin.WindowsLiveProvider**  
Facebook: **OscAddin.FacebookProvider**

> [!NOTE]
> If the **DisabledProvidersList** string value exists but is empty, all installed providers are displayed in the OSC.
>
> The SharePoint provider for the OSC is not available in Outlook 2003 or in Outlook 2007.

### Specify a list of social network providers to load

This policy setting determines the list of social network providers that are loaded by the Outlook Social Connector. If you enable this policy setting, you may enter a list of provider progIDs of social network providers that will be loaded by the Outlook Social Connector. This list is semicolon delimited. If you enable this policy setting, only social network providers that are on this list will be loaded by the Outlook Social Connector. No other social network providers will be loaded. If you disable or you don't configure this policy setting, the Outlook Social Connector can load any installed provider, except those specified under **DisabledProvidersList**.

This policy setting is controlled by the following registry information (note there are two values):

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **ProviderSecurityMode**
Values:  
1 = Policy enabled. The OSC only loads the list of providers specified in the **TrustedProvidersList** string value (see below).  
0 = Policy disabled. (default) The OSC loads all installed providers except those listed in the **DisabledProvidersList** string value

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
String: **TrustedProvidersList**  
Values: semicolon delimited list of currently installed providers (The current list of providers you can specify is provided below. See the vendor of your social connector provider if it is not included in the list below.)

SharePoint: **OscAddin.SharePointProvider**  
LinkedIn: **OscAddIn.LinkedInProvider**  
MySpace: **MySpace.OSC**  
Windows Live Messenger: **OscAddin.WindowsLiveProvider**  
Facebook: **OscAddin.FacebookProvider**

> [!NOTE]
> Make sure that you set **ProviderSecurityMode** = 1 if you want the OSC to only load the providers specified under **TrustedProvidersList**.
>
> The SharePoint provider for the OSC is not available in Outlook 2003 or in Outlook 2007.

### Do not display contact photo (not available in the Outlk14.adm, Outlk15.admx or Outlk16.admx templates)

This policy setting controls the display of photos in the People Pane. If you enable this policy setting, photos aren't displayed in the People Pane. If you are using Outlook 2010, this policy also affects the display of contact photos in the header of email messages and the Outlook contact card. The contact photos in the People Pane can come from either Active Directory or an item in your Contacts folder. If you disable or you don't configure this policy setting, photos are displayed in the People Pane if available for a contact.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Common`  
DWORD: **TurnOffPhotograph**  
Values:  
1 = policy enabled. Contact photos are not displayed in the People Pane. If you're using Outlook 2010, they're also not displayed in the header of email messages and the Outlook contact card.  
0 = (default) policy disabled. The Outlook Social Connector displays contact photos in the People Pane.

> [!NOTE]
> Look carefully at the registry key path for this policy. It is the only policy setting for the OSC under the \Office\14.0 path. Even though this policy path is under the **\14.0** key, it works for Outlook 2003, for Outlook 2007, and for Outlook 2010.

By default in Outlook 2010, when the People Pane is collapsed, the message header displays the contact photo, when they're available (The screenshot for this step is listed below).

And, by default in Outlook 2010, if the People Pane is expanded, the contact photo is displayed only in the People Pane (The screenshot for this step is listed below).

When **TurnOffPhotograph** = 1, contact photos aren't displayed, as shown in the following figures.

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/contact-photos-not-shown-when-turnoffphotograph-is-set-to-1-example-1.png" alt-text="Example 1 about contact photo isn't displayed when Turn Off Photograph is set to 1." border="false":::

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/contact-photos-not-shown-when-turnoffphotograph-is-set-to-1-example-2.png" alt-text="Example 2 about contact photo isn't displayed when Turn Off Photograph is set to 1." border="false":::

When **TurnOffPhotograph** = 1, contact photos are also not displayed in the Outlook 2010 Contact Card or in the Outlook 2010 Address Book dialog box, as shown in the following figures. Outlook 2003 and Outlook 2007 don't have a contact card such as the one that is shown below, and these Outlook versions also don't display photos in the Address Book dialog box.

:::image type="content" source="media/how-to-manage-outlook-social-connector-via-group-policy/contact-card-that-does-not-has-photos-in-outlook-old-versions.png" alt-text="Outlook 2003 and Outlook 2007 don't display photos in the Address Book dialog box." border="false":::

### Maximum number of items displayed in the People Pane (not available in the Outlk14.adm and Outlk15.admx templates)

This policy controls the maximum number of items displayed in the People Pane. The default number is 100 items. If you enable this policy, you may specify a different value for the maximum number of items displayed in the People Pane. If you disable or you don't configure this policy setting, the default value of 100 items is used by the Outlook Social Connector.

This policy setting is controlled by the following registry information:

Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\Outlook\SocialConnector`  
DWORD: **MaxWDSSearchResults**  
Values: an integer between 1 and 100

> [!NOTE]
> It is untested to use a value that is greater than 100.

## Additional information

The LinkedIn Social Connector feature and the Facebook Connect feature are no longer available with the Outlook Social Connector. For more information, see the following articles:

- [LinkedIn is no longer available in the Outlook Social Connector](/outlook/troubleshoot/contacts/linkedin-is-no-longer-available-in-outlook-social-connector)
- [Facebook Connect is no longer available](https://support.microsoft.com/office/facebook-connect-is-no-longer-available-f31c8107-7b5a-4e3d-8a22-e506dacb6db6)
