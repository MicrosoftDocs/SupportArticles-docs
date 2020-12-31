---
title: 
description: Fixes a SSL binding issue that occurs when you try to add a CTL to a secure sockets layer binding by using a .
ms.date: 12/31/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: stevenxu, v-yuluo
---
# "SSL Certificate add failed, Error: 1312" error message when you try to add a CTL in Windows Server 2008 R2 or in Windows 7

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 981506

## Symptoms

You try to run the following netsh command on a computer that is running Windows Server 2008 R2 or Windows 7:
 netsh http add sslcert ipport= **<IP address and port for the SSL binding>** certhash= **<certificate hash>** appid= **```
<GUID of the owning application>** slctlstorename= **<store name in which the CTL is stored>** sslctlidentifier= **<value of the CTL>**  
> [!NOTE]
> This command adds a certificate trust list (CTL) to a secure sockets layer (SSL) binding.

However, the operation fails, and you receive an error message that resembles the following:
SSL Certificate add failed, Error: 1312
A specified logon session does not exist. It may already have been terminated.

## Cause

This issue occurs because the Unicode strings in the struct parameters are incorrectly truncated when these strings are passed to a remote procedure call (RPC). Therefore, the authentication operation fails.

## Resolution

### Hotfix information

A supported hotfix is available from Microsoft. However, this hotfix is intended to correct only the problem that is described in this article. Apply this hotfix only to systems that are experiencing the problem described in this article. This hotfix might receive additional testing. Therefore, if you are not severely affected by this problem, we recommend that you wait for the next software update that contains this hotfix.

If the hotfix is available for download, there is a "Hotfix download available" section at the top of this Knowledge Base article. If this section does not appear, contact Microsoft Customer Service and Support to obtain the hotfix.

> [!NOTE]
> If additional issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and issues that do not qualify for this specific hotfix. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, visit the following Microsoft Web site: [https://support.microsoft.com/contactus/?ws=support](/contactus/?ws=support) 
> [!NOTE]
> The "Hotfix download available" form displays the languages for which the hotfix is available. If you do not see your language, it is because a hotfix is not available for that language. 

#### Prerequisites

There are no prerequisites.

#### Registry information

To use the hotfix in this package, you do not have to make any changes to the registry.

#### Restart requirement

You may have to restart the computer after you apply this hotfix. 

#### Hotfix replacement information

This hotfix does not replace a previously released hotfix. 

#### File information

The global version of this hotfix installs files that have the attributes that are listed in the following tables. The dates and the times for these files are listed in Coordinated Universal Time (UTC). The dates and the times for these files on your local computer are displayed in your local time together with your current daylight saving time (DST) bias. Additionally, the dates and the times may change when you perform certain operations on the files.

##### Windows 7 and Windows Server 2008 R2 file information notes

> [!IMPORTANT]
> Windows 7 hotfixes and Windows Server 2008 R2 hotfixes are included in the same packages. However, hotfixes on the Hotfix Request page are listed under both operating systems. To request the hotfix package that applies to one or both operating systems, select the hotfix that is listed under "Windows 7/Windows Server 2008 R2" on the page. Always refer to the "Applies To" section in articles to determine the actual operating system that each hotfix applies to.
- The MANIFEST files (.manifest) and the MUM files (.mum) that are installed for each environment are [listed separately](#manifests1) in the "Additional file information for Windows Server 2008 R2 and for Windows 7" section. MUM and MANIFEST files, and the associated security catalog (.cat) files, are extremely important to maintain the state of the updated components. The security catalog files, for which the attributes are not listed, are signed with a Microsoft digital signature.

##### For all supported x86-based versions of Windows 7

|File name|File version|File size|Date|Time|Platform|
|---|---|---|---|---|---|
|Cng.sys|6.1.7600.16385|369,568|14-Jul-2009|01:17|x86|
|Ksecdd.sys|6.1.7600.20667|67,472|13-Mar-2010|07:16|x86|
|Ksecpkg.sys|6.1.7600.20667|133,512|13-Mar-2010|07:16|x86|
|Lsasrv.dll|6.1.7600.20667|1,037,312|13-Mar-2010|07:13|x86|
|Lsasrv.mof|Not applicable|13,780|10-Jun-2009|21:33|Not applicable|
|Lsass.exe|6.1.7600.16385|22,528|14-Jul-2009|01:14|x86|
|Secur32.dll|6.1.7600.16385|22,016|14-Jul-2009|01:16|x86|
|Sspicli.dll|6.1.7600.20667|100,352|13-Mar-2010|07:13|x86|
|Sspisrv.dll|6.1.7600.20667|15,360|13-Mar-2010|07:13|x86|
|||||||

##### For all supported x64-based versions of Windows 7 and of Windows Server 2008 R2

|File name|File version|File size|Date|Time|Platform|
|---|---|---|---|---|---|
|Cng.sys|6.1.7600.16385|460,504|14-Jul-2009|01:43|x64|
|Ksecdd.sys|6.1.7600.20667|95,624|13-Mar-2010|08:00|x64|
|Ksecpkg.sys|6.1.7600.20667|152,968|13-Mar-2010|08:00|x64|
|Lsasrv.dll|6.1.7600.20667|1,446,912|13-Mar-2010|07:57|x64|
|Lsasrv.mof|Not applicable|13,780|10-Jun-2009|20:52|Not applicable|
|Lsass.exe|6.1.7600.16385|31,232|14-Jul-2009|01:39|x64|
|Secur32.dll|6.1.7600.16385|28,160|14-Jul-2009|01:41|x64|
|Sspicli.dll|6.1.7600.20667|136,192|13-Mar-2010|07:57|x64|
|Sspisrv.dll|6.1.7600.20667|28,672|13-Mar-2010|07:57|x64|
|Lsasrv.mof|Not applicable|13,780|22-Jul-2009|23:19|Not applicable|
|Secur32.dll|6.1.7600.20667|22,016|13-Mar-2010|07:13|x86|
|Sspicli.dll|6.1.7600.20667|96,768|13-Mar-2010|07:11|x86|
|||||||

##### For all supported IA-64-based versions of Windows Server 2008 R2

|File name|File version|File size|Date|Time|Platform|
|---|---|---|---|---|---|
|Cng.sys|6.1.7600.16385|787,736|14-Jul-2009|01:52|IA-64|
|Ksecdd.sys|6.1.7600.20667|179,600|13-Mar-2010|06:42|IA-64|
|Ksecpkg.sys|6.1.7600.20667|307,088|13-Mar-2010|06:42|IA-64|
|Lsasrv.dll|6.1.7600.20667|2,654,720|13-Mar-2010|06:34|IA-64|
|Lsasrv.mof|Not applicable|13,780|10-Jun-2009|20:57|Not applicable|
|Lsass.exe|6.1.7600.16385|56,320|14-Jul-2009|01:44|IA-64|
|Secur32.dll|6.1.7600.16385|48,640|14-Jul-2009|01:48|IA-64|
|Sspicli.dll|6.1.7600.20667|275,456|13-Mar-2010|06:38|IA-64|
|Sspisrv.dll|6.1.7600.20667|45,568|13-Mar-2010|06:38|IA-64|
|Lsasrv.mof|Not applicable|13,780|22-Jul-2009|23:19|Not applicable|
|Secur32.dll|6.1.7600.20667|22,016|13-Mar-2010|07:13|x86|
|Sspicli.dll|6.1.7600.20667|96,768|13-Mar-2010|07:11|x86|
|||||||  

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. 

## More Information

For more information about how to configure a port by using an SSL certificate, visit the following Microsoft Web site: [How to configure a port by using an SSL certificate](https://msdn.microsoft.com/library/ms733791.aspx <!--ERROR-->) 
 For more information about software update terminology, click the following article number to view the article in the Microsoft Knowledge Base:

[824684](https://support.microsoft.com/help/824684) Description of the standard terminology that is used to describe Microsoft software updates  

### Additional file information

#### Additional file information for Windows 7 and for Windows Server 2008 R2

##### Additional files for all supported x86-based versions of Windows 7

| File name|Update.mum|
|---|---|
| File version|Not applicable|
| File size|1,674|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|10:55|
| Platform|Not applicable|
||
| File name|X86_1421ac8a9f6ef3ce8b937b0ae56209ae_31bf3856ad364e35_6.1.7600.20667_none_23708961b103e635.manifest|
| File version|Not applicable|
| File size|691|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|10:55|
| Platform|Not applicable|
||
| File name|X86_microsoft-windows-lsa_31bf3856ad364e35_6.1.7600.20667_none_a6c221e8d72a628b.manifest|
| File version|Not applicable|
| File size|103,660|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|11:02|
| Platform|Not applicable|
|||

##### Additional files for all supported x64-based versions of Windows 7 and of Windows Server 2008 R2

| File name|Amd64_c1f3ccb091321f5245e74fc410074621_31bf3856ad364e35_6.1.7600.20667_none_649488b89ab1f4e7.manifest|
|---|---|
| File version|Not applicable|
| File size|1,032|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|10:55|
| Platform|Not applicable|
||
| File name|Amd64_efb13a188cefafdfd852e77573ce5875_31bf3856ad364e35_6.1.7600.20667_none_664f738e7e9b11f8.manifest|
| File version|Not applicable|
| File size|695|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|10:55|
| Platform|Not applicable|
||
| File name|Amd64_microsoft-windows-lsa_31bf3856ad364e35_6.1.7600.20667_none_02e0bd6c8f87d3c1.manifest|
| File version|Not applicable|
| File size|103,664|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|11:05|
| Platform|Not applicable|
||
| File name|Update.mum|
| File version|Not applicable|
| File size|1,906|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|10:55|
| Platform|Not applicable|
||
| File name|Wow64_microsoft-windows-lsa_31bf3856ad364e35_6.1.7600.20667_none_0d3567bec3e895bc.manifest|
| File version|Not applicable|
| File size|86,382|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|07:37|
| Platform|Not applicable|
|||

##### Additional files for all supported IA-64-based versions of Windows Server 2008 R2

| File name|Ia64_aba017386f21d586120feaa3c20f5705_31bf3856ad364e35_6.1.7600.20667_none_3341405f4af61718.manifest|
|---|---|
| File version|Not applicable|
| File size|1,030|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|10:55|
| Platform|Not applicable|
||
| File name|Ia64_microsoft-windows-lsa_31bf3856ad364e35_6.1.7600.20667_none_a6c3c5ded7286b87.manifest|
| File version|Not applicable|
| File size|103,662|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|10:55|
| Platform|Not applicable|
||
| File name|Update.mum|
| File version|Not applicable|
| File size|1,684|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|10:55|
| Platform|Not applicable|
||
| File name|Wow64_microsoft-windows-lsa_31bf3856ad364e35_6.1.7600.20667_none_0d3567bec3e895bc.manifest|
| File version|Not applicable|
| File size|86,382|
| Date (UTC)|13-Mar-2010|
| Time (UTC)|07:37|
| Platform|Not applicable|
|||
