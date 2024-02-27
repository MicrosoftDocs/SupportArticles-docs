---
title: Policy template deploys DisableCrossAccountCopy incorrectly
description: Provides a resolution for the issue that the Outlook policy template deploys DisableCrossAccountCopy as REG_EXPAND_SZ instead of REG_MULTI_SZ.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: lahren, aruiz, jeffconn, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Outlook policy template deploys DisableCrossAccountCopy as REG_EXPAND_SZ instead of REG_MULTI_SZ

## Symptoms

An Active Directory administrator deploys the Microsoft Outlook 2010 or Microsoft Outlook 2013 policy **Prevent copying or moving items between accounts**. However, although the policy is applied to Microsoft Windows workstations, Outlook does not restrict users from copying or moving organization email messages to an Outlook Data (.pst) file or other email account.

## Cause

The Outlook 2010 and Outlook 2013 Administrative Template files (ADM/ADMX/ADML) set the **DisableCrossAccountCopy** registry value by using the REG_EXPAND_SZ (expandable data string) data type. However, the **DisableCrossAccountCopy** registry value must be a REG_MULTI_SZ (multiple string) data type.

## Resolution

The organization's AD administrator can use the following information to deploy the **DisableCrossAccountCopy** registry value by using Group Policy:

**Action**: Replace  
**Hive**: HKEY_CURRENT_USER (HKU\\.DEFAULT)  
**Key Path**: Software\Policies\Microsoft\Office\14.0\Outlook  
**Value name**: DisableCrossAccountCopy  
**Value type**: REG_MULTI_SZ

Set **Value data** to one of the following three strings:

1. An asterisk (*) will restrict copying or moving messages out of any account or Outlook data file (.pst).
2. Domain name of email account to be restricted. You can specify the domain of the accounts that you want to restrict. For example, `contoso.com`.
3. **SharePoint** This string will restrict copying or moving data out of all SharePoint lists.

In Windows Server 2008 and Windows Server 2012 environments, you can use the Group Policy Registry preference extension to deploy registry settings. For more information about how to use the Registry preference extension to deploy the **DisableCrossAccountCopy** registry value, see [Configure a Registry Item](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753092(v=ws.11)).

> [!NOTE]
> In a Windows Server 2003 environment, the registry change can be distributed by using a logon script. For more information about using a logon script to deploy a registry setting, see [How to add, modify, or delete registry subkeys and values by using a .reg file](https://support.microsoft.com/topic/how-to-add-modify-or-delete-registry-subkeys-and-values-by-using-a-reg-file-9c7f37cf-a5e9-e1cd-c4fa-2a26218a1a23).

For more information about the **DisableCrossAccountCopy** setting, see [Plan for compliance and archiving in Outlook 2010](/previous-versions/office/office-2010/ff800883(v=office.14)).

> [!IMPORTANT]
> If you are an Outlook user and are experiencing the behavior that is mentioned in the Symptoms section, contact the administrator for your organization. Any change that you make to the **Policies** hive of the registry will be overwritten by the organization's policy settings. Therefore, you must contact your administrator to have the necessary changes applied.

## More information

Alternatively, administrators can make changes to the ADMX and ADML templates. This should first be tested in the customer's environment with a limited number of Active Directory user objects to make sure it results in the expected Outlook behavior. Then, the policy can be applied more broadly. To update the administrative templates, make the following changes to the outlk14.admx and the outlk14.adml files. These changes update the template to use the correct REG_MULTI_SZ value:

The default outlk14.admx has the following section for this policy:

```output
<policy name="L_PreventCopyingOrMovingItemsBetweenAccounts" class="User" displayName="$(string.L_PreventCopyingOrMovingItemsBetweenAccounts)" explainText="$(string.L_PreventCopyingOrMovingItemsBetweenAccountsExplain)" presentation="$(presentation.L_PreventCopyingOrMovingItemsBetweenAccounts)" key="software\policies\microsoft\office\14.0\outlook">
          <parentCategory ref="L_Exchangesettings" />
          <supportedOn ref="windows:SUPPORTED_WindowsVista" />
          <elements>
             <text id="L_PreventCopyingOrMovingItemsBetweenAccountsID" valueName="disablecrossaccountcopy" required="true" expandable="true" />
          </elements>
       </policy>
```

This needs to be changed to the following:

```output
<policy name="L_PreventCopyingOrMovingItemsBetweenAccounts" class="User" displayName="$(string.L_PreventCopyingOrMovingItemsBetweenAccounts)" explainText="$(string.L_PreventCopyingOrMovingItemsBetweenAccountsExplain)" presentation="$(presentation.L_PreventCopyingOrMovingItemsBetweenAccounts)" key="software\policies\microsoft\office\14.0\outlook">
         <parentCategory ref="L_Exchangesettings" />
         <supportedOn ref="windows:SUPPORTED_WindowsVista" />
         <elements>
            <multiText id="L_PreventCopyingOrMovingItemsBetweenAccountsID" valueName="disablecrossaccountcopy" maxStrings="25" maxLength="100"/>
         </elements>
      </policy>
```

The default outlk14.adml has the following section for this policy:

```output
<presentation id="L_PreventCopyingOrMovingItemsBetweenAccounts">
            <textBox refId="L_PreventCopyingOrMovingItemsBetweenAccountsID">
               <label>SMTP address domain</label>
            </textBox>
         </presentation>
```

This needs to be changed to the following:

```output
<presentation id="L_PreventCopyingOrMovingItemsBetweenAccounts">
            <multiTextBox refId="L_PreventCopyingOrMovingItemsBetweenAccountsID">
            </multiTextBox>
         </presentation>
```
