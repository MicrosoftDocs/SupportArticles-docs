---
title: How to discover Office and Windows KMS hosts and remove unauthorized instances
description: Describes how to discover Office and Windows KMS hosts through DNS, and how to remove unauthorized KMS hosts.
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: ericspli
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# How to discover Office and Windows KMS hosts through DNS and remove unauthorized instances

This article was written by [Eric Ellis](https://social.technet.microsoft.com/profile/Eric+Ellis+%5BMSFT%5D), Senior Support Escalation Engineer.

When you troubleshoot KMS configuration and activation issues, you may find unexpected Windows or Office KMS hosts in their environment. This article describes how to discover Office and Windows KMS hosts through DNS, and how to remove unauthorized KMS hosts.

> [!NOTE]
> The following steps are similar in Office KMS 2010, 2013, 2016, and 2019.

## Discover Office and Windows KMS hosts through DNS

By default, Windows and Office clients discover KMS hosts through DNS and a related *_vlmcs* SRV record. To determine whether a KMS client can locate a KMS host or whether unwanted KMS hosts exist on the network, run a command similar to the following:

`nslookup -type=srv _vlmcs._tcp >%temp%\kms.txt`

Review the *kms*.txt file, and it should contain one or more entries similar to the following:

```output
_vlmcs._tcp.contoso.com                            SRV service location:
                  priority       = 0
                  weight         = 0
                  port           = 1688
                  svr hostname   = kms-server.contoso.com |
```

Running this `nslookup` command frequently reveals *_vlmcs* SRV entries that are tied to unauthorized Windows or Office KMS hosts.

## Remove unauthorized Windows KMS hosts

In many cases, Windows KMS hosts may be unintentionally set up by users who mistakenly entered a KMS host product key, instead of a Windows client product key. To resolve this issue, follow these steps on the computer(s) in question, replace the KMS product key and convert it to a KMS or MAK client:

1. Open an elevated command prompt.
1. Run `cscript slmgr.vbs /ipk xxxxx-xxxxx-xxxxx-xxxxx-xxxxx`, where *xxxxx-xxxxx-xxxxx-xxxxx-xxxxx* is Windows product key (there should be 25 numbers).
1. To prevent instability in the license service, restart the system or the Software Protection Service. To restart the Software Protection Service, run the following commands:

   ```console
   net stop sppsvc
   net start sppsvc
   ```

1. Run the following command to display the license information for the installed and active Windows edition:

   `cscript slmgr.vbs /dli`

1. In DNS Manager, locate the appropriate forward lookup zone, and then delete the *_vlmcs* SRV records that exist for each computer which is not to serve as a Windows KMS host.

For more information, see the following articles:

- [Slmgr.vbs Options](https://technet.microsoft.com/library/ff793433.aspx)
- [Deploying KMS Activation](https://technet.microsoft.com/library/ff793409.aspx)

## Remove unauthorized Office KMS hosts

It's not common to create an Office KMS host unintentionally, because setting up an Office KMS requires a specific product key and the installation of the [Microsoft Office 2010 KMS Host License Pack](https://www.microsoft.com/download/details.aspx?id=25095).

To determine whether a computer has the Office 2010 KMS Host License Pack installed and has an active Office KMS host, run the following command:

`cscript slmgr.vbs /dlv bfe7a195-4f8f-4f0b-a622-cf13c7d16864`

The output of a computer which has the Office 2010 KMS Host License Pack installed resembles the following. In the following example, key items are **Partial Product Key: XXXXX** and **License Status: Licensed**. These items indicate that the Office 2010 KMS host key is successfully installed and activated. To pull all the products installed, including all Office KMS host installations, run the following command:

`cscript slmgr.vbs /dlv All >C:\<path>\KMSInfo.txt`

In this command, \<path> equals where you want to write the output. In this file, search for Office and find all the instances for the Office KMS host installations. If you only want to pull specific Office KMS information, replace the Activation ID that is mentioned earlier in the command (**bfe7a195-4f8f-4f0b-a622-cf13c7d16864**) with the Activation ID for Office 2013, 2016, or 2019. An example of the output resembles the following:

```output
Name: Microsoft Office 2010, KMSHost edition
Description: Microsoft Office 2010 KMS, VOLUME_KMS channel
Activation ID: bfe7a195-4f8f-4f0b-a622-cf13c7d16864
Application ID: 59a52881-a989-479d-xxxx-xxxxxxxxxx
Extended PID: 
Installation ID: 
Processor Certificate URL: https://go.microsoft.com/fwlink/p/?LinkID=88342
Machine Certificate URL: https://go.microsoft.com/fwlink/p/?LinkID=88343
Use License URL: https://go.microsoft.com/fwlink/p/?LinkID=88345
Product Key Certificate URL: https://go.microsoft.com/fwlink/p/?LinkID=88344
Partial Product Key: XXXXX
License Status: Licensed
Remaining Windows rearm count: 1
Trusted time:
Key Management Service is enabled on this computer
Current count: 0
Listening on Port: 1688
DNS publishing enabled
KMS priority: Normal
```

Then, follow these steps to remove an Office KMS host in your environment:

1. Open an elevated command prompt.
1. Run the following command to uninstall Office KMS host product key:

   `cscript slmgr.vbs /upk bfe7a195-4f8f-4f0b-a622-cf13c7d16864`

   > [!WARNING]
   > If the command is run without the Office activation ID (**bfe7a195-4f8f-4f0b-a622-cf13c7d16864**), all installed product keys are uninstalled, including those for Windows.

1. Run the following command again to check the status of the Office KMS host:

   `cscript slmgr.vbs /dlv bfe7a195-4f8f-4f0b-a622-cf13c7d16864`

1. If the Office KMS host product key is removed, the output resembles the following. The key items are **This license is not in use** and **License Status: Unlicensed**.

   ```output
   Name: Microsoft Office 2010, KMSHost edition
   Description: Microsoft Office 2010 KMS, VOLUME_KMS channel
   Activation ID: bfe7a195-4f8f-4f0b-a622-cf13c7d16864
   Application ID: 59a52881-a989-479d-xxxx-xxxxxxxxxx
   Extended PID: 
   Installation ID: 
   Processor Certificate URL: https://go.microsoft.com/fwlink/?LinkID=88342
   Machine Certificate URL: https://go.microsoft.com/fwlink/?LinkID=88343
   Use License URL: https://go.microsoft.com/fwlink/?LinkID=88345
   Product Key Certificate URL: https://go.microsoft.com/fwlink/?LinkID=88344
   This license is not in use.
   License Status: Unlicensed
   Remaining Windows rearm count: 1
   Trusted time: 
   ```

1. In DNS Manager, locate the appropriate forward lookup zone, and then delete the *_vlmcs* SRV records that exist for each computer which is not to serve as an Office KMS host.

For more information, see the following articles:

- [KMS activation of Office 2013](https://technet.microsoft.com/library/ee624357.aspx)
- [Troubleshoot volume activation for Office 2013](https://technet.microsoft.com/library/ee624355.aspx)
- [KMS Activation of Office 2016/2019](/deployoffice/vlactivation/activate-office-by-using-kms)
