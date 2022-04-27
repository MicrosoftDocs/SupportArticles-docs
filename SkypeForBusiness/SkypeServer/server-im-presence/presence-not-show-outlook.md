---
title: Presence information of Lync Server 2010 may not show in Outlook
description: Describes how to fix an issue that occurs when the presence information for a Lync Server or Office Communications Server user is not displayed, or when this information is displayed intermittently. This issue occurs in Outlook 2010, in Outlook 2007, and in Outlook 2003 SP2.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto: 
  - Lync Server 2010
  - Outlook 2010
  - Outlook 2007
  - Outlook 2003 Service Pack 2
ms.date: 3/31/2022
---

# The presence information for a user of Lync Server 2010 or of Communications Server may not be displayed in Outlook 2003 SP2, in Outlook 2007, or in Outlook 2010

## Symptoms

The presence information for a user of Microsoft Lync Server 2010 or of Microsoft Office Communications Server may not be displayed as expected in Microsoft Office Outlook 2010, in Office Outlook 2007, or in Outlook 2003 Service Pack 2 (SP2). Or, this information may be displayed only intermittently. This issue occurs when a user's Session Initiation Protocol (SIP) Uniform Resource Identifier (URI) does not match the user's primary email address. Or, this issue occurs when the user has multiple email addresses. 

## Resolution

To resolve this problem, follow these steps.

### Step 1: Add an SIP proxy address in Exchange Server for the user account that specifies the user's SIP URI

**Microsoft Exchange Server 2003**

1. Open the Active Directory Users and Computers snap-in, and then double-click the name of the user in question.   
2. Click the **E-mail Addresses** tab, and then click **New**.    
Click **Custom Address**. Type the SIP URI in the **E-mail address** field, and then type "SIP" in the **E-mail type** field.

4. Click **OK** two times.    
5. Wait for the Active Directory directory service and Exchange Server to synchronize.    

Exchange Server 2010 and Exchange Server 2007

By default, Exchange Server 2010 and Exchange Server 2007 can obtain a Lync Server 2010 or Communications Server user's SIP URI from Active Directory. Then, Exchange can automatically populate the SIP proxy address.

### Step 2: Add two registry entries (Outlook 2003 SP2 only)

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:

[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

> [!NOTE]
> This step is not required for Outlook 2010 or for Outlook 2007.

Outlook 2003 SP2 does not search for the user's SIP address to obtain the presence information. If a user's SIP proxy address and the user's default e-mail address differ from one another, Outlook 2003 SP2 cannot show presence information. By adding the following registry keys for Outlook 2003 SP2, you can help prevent a problem if these addresses differ from one another.  

1. Click **Start**, click **Run**, type regedit, and then press ENTER.    
2. Locate the following registry subkey:**HKEY_CURRENT_USER\Software\Microsoft\Office\11.0\Common\PersonaMenu**   
3. Click **Edit**, point to
**New**, and then click **DWORD value**.  
4. Type QueryServiceForStatus, and then click **OK**.
5. Double-click **QueryServiceForStatus**, type **2**, and then click **OK**.    
6. Click **Edit**, point to
**New**, and then click **DWORD value**.  
7.  Type EnableDynamicPresence, and then click **OK**.   
8.  Double-click **EnableDynamicPresence**, type **1**, and then click **OK**.    
9. Exit Registry Editor.    
After you create these registry keys, Outlook 2003 SP2 shows presence information.

## More Information

In Outlook 2007, the **QueryServiceForStatus** and **EnableDynamicPresence** registry values that are required for Outlook 2003 SP2 are enabled by default and are not available in the Windows client that is hosting the Outlook 2007 local registry. However, the integrated Instant Messaging presence features in the Outlook 2007 can be administered through local policies or through domain group policies. The implementation of the 2007 Office system (SP2) Administrative Template files (ADM, ADMX, ADML) template file Office12.adm adds the registry values that manage the Office 2007 Person Name Smart Tag menu options. The list of Person Name Smart Tag group policy options are displayed under the following registry subkey for the Windows client: 

**HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\12.0\Common\PersonaMenu**

For more information about how to administer the 2007 Office group policy templates, visit the following Microsoft website:

[2007 Office system (SP2) Administrative Template files (ADM, ADMX, ADML) and Office Customization Tool](https://www.microsoft.com/downloads/details.aspx?familyid=73d955c0-da87-4bc2-bbf6-260e700519a8)

In Outlook 2010, the **QueryServiceForStatus** and **EnableDynamicPresence** registry values that are required for Outlook 2003 SP2 are enabled by default and are not available in the Windows client that is hosting the Outlook 2010 local registry. However, the integrated Instant Messaging presence features in the Outlook 2010 client can be administered through local policies or through domain group policies. The implementation of the Office 2010 Administrative Template files (ADM, ADMX, ADML) template file Office14.adm adds the registry values that manage the Office 2010 Contact Card presence features. The list of Contact Card presence features group policies will appear under the following registry key for the Windows client: 

**HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\14.0\Common\IM**

For more information about how to administer the Office 2010 group policy templates, visit the following Microsoft website:

[Office 2010 Administrative Template files (ADM, ADMX, ADML) and Office Customization Tool](/previous-versions/office/office-2013-resource-kit/cc178992(v=office.15))

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).