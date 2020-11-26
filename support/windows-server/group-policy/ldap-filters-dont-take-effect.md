---
title: LDAP filters don't take effect
description: Updates Windows Server 2008 R2 and Windows 7 to fix an issue in which LDAP filters in the Group Policy preference settings do not take effect.
ms.date: 09/22/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, stevenxu, fengli
ms.prod-support-area-path: Security filtering and item-level targeting
ms.technology: GroupPolicy
---
# LDAP filters in the Group Policy preference settings do not take effect on a computer that is running Windows Server 2008 R2 or Windows 7

This article provides a solution to an issue where LDAP filters in the Group Policy preference settings do not take effect on a computer that is running Windows Server 2008 R2 or Windows 7.

_Original product version:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 976398

## Symptoms

Consider the following scenario:

- You configure some Group Policy preference settings in a Group Policy object.
- You apply one or more Lightweight Directory Access Protocol (LDAP) filters in these Group Policy preference settings.
- You apply this Group Policy object to a computer that is running Windows Server 2008 R2 or Windows 7.
In this scenario, the LDAP filters in the Group Policy preference settings do not take effect.

## Resolution

### Hotfix information

A supported hotfix is available from Microsoft. However, this hotfix is intended to correct only the problemP1 that P2 described in this article. Apply this hotfix only to systems that are experiencing the problemP1 described in this article. This hotfix might receive additional testing. Therefore, if you are not severely affected by this problem, we recommend that you wait for the next software update that contains this hotfix.

If the hotfix is available for download, there is a Hotfix download available section at the top of this Knowledge Base article. If this section does not appear, contact Microsoft Customer Service and Support to obtain the hotfix.

> [!NOTE]
> If additional issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and issues that do not qualify for this specific hotfix. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, [contact Microsoft Support](https://support.microsoft.com/home/expcontact/).

> [!NOTE]
> The **Hotfix download available** form displays the languages for which the hotfix is available. If you do not see your language, it is because a hotfix is not available for that language.

#### Prerequisites

To apply this hotfix, your computer must be running Windows Server 2008 R2 or Windows 7.

#### Restart requirement

You do not have to restart the computer after you apply this hotfix.

#### Hotfix replacement information

This hotfix does not replace a previously released hotfix. 

#### File information

The English (United States) version of this hotfix installs files that have the attributes that are listed in the following tables. The dates and times for these files are listed in Coordinated Universal Time (UTC). The dates and times for these files on your local computer are displayed in your local time and with your current daylight saving time (DST) bias. Additionally, the dates and times may change when you perform certain operations on the files.

##### Windows 7 and Windows Server 2008 R2 file information notes

> [!IMPORTANT]
> Windows 7 and Windows Server 2008 R2 hotfixes are included in the same packages. However, only one of these products may be listed on the "Hotfix Request" page. To request the hotfix package that applies to both Windows 7 and Windows Server 2008 R2, just select the product that is listed on the page.
>
> - The MANIFEST files (.manifest) and the MUM files (.mum) that are installed for each environment are listed separately in the "Additional file information for Windows Server 2008 R2 and for Windows 7" section. MUM and MANIFEST files, and the associated security catalog (.cat) files, are critical to maintaining the state of the updated component. The security catalog files, for which the attributes are not listed, are signed with a Microsoft digital signature.

##### For all supported x86-based versions of Windows 7

|File name|File version|File size|Date|Time|Platform|
|---|---|---|---|---|---|
|Gpprefcl.dll|6.1.7600.20555|582,656|22-Oct-2009|06:19|x86|

##### For all supported x64-based versions of Windows 7 and of Windows Server 2008 R2

|File name|File version|File size|Date|Time|Platform|Service branch|
|---|---|---|---|---|---|---|
|Gpprefcl.dll|6.1.7600.20555|781,824|22-Oct-2009|06:48|x64|Not Applicable|
|Gpprefcl.dll|6.1.7600.20555|582,656|22-Oct-2009|06:19|x86|WOW|

##### For all supported IA-64-based versions of Windows Server 2008 R2

|File name|File version|File size|Date|Time|Platform|
|---|---|---|---|---|---|
|Gpprefcl.dll|6.1.7600.20555|1,498,112|22-Oct-2009|05:06|IA-64|
  
## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

To use LDAP filters to configure the Group Policy preference settings, follow these steps:

1. Open the **Group Policy Management Console** (Gpmc.msc) on a domain controller that is running Windows Server 2008 R2.
2. Right-click a Group Policy object, and then select the **Edit** menu.
3. Locate the preference settings of a Group Policy.

    For example: User Configuration\Preferences\Windows Settings\Drive Maps

4. Right-click the empty area in the details panel, select **New**, and then select **\<item name>**.
5. In the **Common** tab, check **Item-level targeting**.
6. Click **Targeting**, select **New item**, and then click **LDAP Query** in the **Targeting Editor** window. Now, you can edit LDAP filters.

For more information about software update terminology, click the following article number to view the article in the Microsoft Knowledge Base:  
[824684](https://support.microsoft.com/help/824684) Description of the standard terminology that is used to describe Microsoft software updates  

### Additional file information

#### Additional file information for Windows 7 and for Windows Server 2008 R2

##### Additional files for all supported x86-based versions of Windows 7

|File name|File version|File size|Date|Time|Platform|
|---|---|---|---|---|---|
|Package_for_kb976398_rtm~31bf3856ad364e35~x86~~6.1.1.0.mum|Not Applicable|1,454|22-Oct-2009|18:12|Not Applicable|
|X86_microsoft-windows-g..ppolicy-policymaker_31bf3856ad364e35_6.1.7600.20555_none_37c9998bc354d271.manifest|Not Applicable|53,968|22-Oct-2009|06:50|Not Applicable|
|||||||

##### Additional files for all supported x64-based versions of Windows 7 and of Windows Server 2008 R2

|File name|File version|File size|Date|Time|Platform|
|---|---|---|---|---|---|
|Amd64_microsoft-windows-g..ppolicy-policymaker_31bf3856ad364e35_6.1.7600.20555_none_93e8350f7bb243a7.manifest|Not Applicable|53,972|22-Oct-2009|17:02|Not Applicable|
|Package_for_kb976398_rtm~31bf3856ad364e35~amd64~~6.1.1.0.mum|Not Applicable|2,658|22-Oct-2009|18:12|Not Applicable|
|Wow64_microsoft-windows-g..ppolicy-policymaker_31bf3856ad364e35_6.1.7600.20555_none_9e3cdf61b01305a2.manifest|Not Applicable|34,836|22-Oct-2009|06:38|Not Applicable|
|||||||

##### Additional files for all supported IA-64-based versions of Windows Server 2008 R2

|File name|File version|File size|Date|Time|Platform|
|---|---|---|---|---|---|
|Ia64_microsoft-windows-g..ppolicy-policymaker_31bf3856ad364e35_6.1.7600.20555_none_37cb3d81c352db6d.manifest|Not Applicable|53,970|22-Oct-2009|07:11|Not Applicable|
|Package_for_kb976398_rtm~31bf3856ad364e35~ia64~~6.1.1.0.mum|Not Applicable|1,954|22-Oct-2009|18:12|Not Applicable|
|||||||
