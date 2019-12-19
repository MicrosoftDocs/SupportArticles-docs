---
title: How to configure the default e-mail client using Group Policy
description: Explains how to configure the default e-mail client using Group Policy
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Outlook
---

# How to configure the default e-mail client using Group Policy

## Symptoms

When you use Group Policy to administer the default e-mail client you are unable to locate a setting to make this configuration.

## Cause

The default Group Policy templates for Outlook do not include a setting to configure the default e-mail client.

## Resolution

To configure the default e-mail client using Group Policy, create a custom .adm template. Then, add this template to your Group Policy Editor so you can configure the policy setting.

1. Open a new text file in Notepad.
1. Copy and paste the following text into the text file:

    ```AsciiDoc
    CLASS MACHINE
    CATEGORY !!Default_E-mail_Client
     POLICY !!Default_Client
     KEYNAME "SOFTWARE\Clients\Mail"
     EXPLAIN !!Explain_Default_Client
      PART !!labeltext_Default_Client EDITTEXT
       VALUENAME ""
     DEFAULT "Microsoft Outlook"
       END PART
      END POLICY
    END CATEGORY
     
    [strings]
    Default_E-mail_Client="Default e-mail client policy"
    Default_Client="Default e-mail client"
    Explain_Default_Client="This policy configures Outlook as the default e-mail client"
    labeltext_Default_Client="Default E-mail Client:"
    Microsoft_Outlook="Microsoft Outlook"
    ```

1. Save the file as **DefaultEmailClient.adm**.
1. Close the file.
1. Add the file to the Group Policy Editor.

    **Note** The steps to add the DefaultEmailClient.adm file to the Group Policy Editor vary. Please consult your Windows documentation for details.

1. Under **Computer Configuration** expand **Administrative Templates**.
1. Select the **Default e-mail client policy** node in the policy tree.
1. Double-click the **Default e-mail client** setting in the right pane.

    **Note** If you do not see the **Default e-mail client** policy setting in the right pane of the Group Policy editor, make sure your Group Policy editor filtering settings are not hiding unmanaged policies. For example, in Windows Server 2003, click **Filtering** on the **View** menu. Then, click to clear the **Only show policy settings that can be fully managed** check box.

1. Click to select **Enabled**.
1. Specify the default e-mail client to be configured by this policy. (The default is configured for Microsoft Outlook)

    **Note** If you are unsure of the e-mail clients registered on a workstation, examine the subkeys under the following key in the registry.

    **HKEY_LOCAL_MACHINE\Software\Clients\Mail**

    The name of each subkey is the name of an installed e-mail client on the workstation.
1. Click **OK**.

## More Information

The default e-mail client is typically configured through the **Programs** tab in the **Internet Properties** dialog box. However, if you are not a member of the local adminisrators group you may not have enough permission to make this change (because the setting is stored under the HKEY_LOCAL_MACHINE hive in the registry).
