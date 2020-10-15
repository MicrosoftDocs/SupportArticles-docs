---
title: Active and retired troubleshooters for Windows 10
description: Active and retired troubleshooters for Windows 10.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: ksharma, kaushika
ms.prod-support-area-path: TPM
ms.technology: WindowsSecurity
---
# Active and retired troubleshooters for Windows 10

This article provides a list of active and retired troubleshooters for Windows 10, including a description of what the troubleshooter does, the problem that it addresses, and which devices it applies to. To learn more about troubleshooters, see [keep your device running smoothly with recommended troubleshooting](https://support.microsoft.com/en-us/help/4487232/keep-your-device-running-smoothly-with-recommended-troubleshooting).


## More information

<table>
<thead>
<tr>
<th>Troubleshooter text</th>
<th>Description</th>
<th>Activation date</th>
<th>Retirement date</th>
<th>More information</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><strong>Files On-Demand troubleshooter</strong></p>
<p>You may have lost access to your Files On-Demand. This troubleshooter restores access or prevents the loss of access from happening in the near future. Important: Please reboot your device once the troubleshooter is finished.</p></td>
<td><p>After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy <a href="https://docs.microsoft.com/en-us/windows-hardware/drivers/ifs/about-file-system-filter-drivers">file system filter drivers </a>might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter mitigates the issue.</p>
<p>Devices that successfully ran the "Hardware and devices" troubleshooter will be notified and asked to run this troubleshooter. This troubleshooter cannot be run manually.</p></td>
<td>6/30/20</td>
<td>-</td>
<td><a href="https://aka.ms/AA8vtwr">https://aka.ms/AA8vtwr</a></td>
</tr>
<tr class="even">
<td><p><strong>Hardware and devices troubleshooter</strong></p>
<p>Automatically repairs system files and settings to fix a problem on your device</p></td>
<td><p>After updating to Windows 10, version 2004, some older devices or devices that have certain older apps installed that use legacy <a href="https://docs.microsoft.com/en-us/windows-hardware/drivers/ifs/about-file-system-filter-drivers">file system filter drivers </a>might be unable to connect to OneDrive through the OneDrive app. Affected devices might not be able to download new Files On-Demand content or open previously synced or downloaded files. This troubleshooter detects the presence of this issue.</p>
<p>This troubleshooter runs automatically on devices that meet the following criteria:</p>
<ul>
<li><p>Runs on Windows 10, version 2004</p></li>
<li><p>Uses a Cloud files filter (OneDrive, iCloud, Workfolders)</p></li>
</ul>
<p><strong>Note:</strong> This troubleshooter cannot be run manually.</p></td>
<td>6/30/20</td>
<td>-</td>
<td><a href="https://aka.ms/AA8vtwr">https://aka.ms/AA8vtwr</a></td>
</tr>
<tr class="odd">
<td><p><strong>Storage Spaces cleanup troubleshooter</strong></p>
<p>Automatically restores your previous settings and environment for Storage Spaces.</p></td>
<td><p>Devices that use Parity Storage Spaces might not be able to use or access their storage spaces after you update to Windows 10, version 2004 (the May 2020 update) or Windows Server, version 2004. After <a href="https://support.microsoft.com/en-us/help/4568831">KB4568831</a> has been applied to your device, this troubleshooter restores your previous Storage Spaces settings.</p>
<p><strong>Note:</strong> This troubleshooter runs automatically on devices that meet the following criteria:</p>
<ul>
<li><p>Successfully ran the "Hardware and devices" or "Storage space" troubleshooter</p></li>
</ul>
<p><strong>Note:</strong> This troubleshooter cannot be run manually.</p></td>
<td>7/30/2020</td>
<td>-</td>
<td><a href="https://aka.ms/AA8uojg">https://aka.ms/AA8uojg</a></td>
</tr>
<tr class="even">
<td><p><strong>Storage space troubleshooter</strong></p>
<p>Data corruption was detected on your parity storage space. This troubleshooter takes actions to prevent further corruption. It also restores write access if the space was previously marked read-only. For more information and recommended actions please see the link below.</p></td>
<td><p>Devices that use Parity Storage Spaces might experience issues when they try to use or access their storage spaces after they update to Windows 10, version 2004 (the May 2020 Update) or Windows Server, version 2004. This troubleshooter mitigates the issue for some users and restores read and write access to your Parity Storage Spaces. </p>
<p>This troubleshooter runs automatically on devices that meet the following criteria.</p>
<ul>
<li><p>Successfully ran the "Hardware and devices" or "Storage Space" troubleshooter</p></li>
</ul>
<p><strong>Note:</strong> This troubleshooter cannot be run manually.</p></td>
<td>7/2/2020</td>
<td>-</td>
<td><a href="https://aka.ms/AA8uojg">https://aka.ms/AA8uojg</a></td>
</tr>
<tr class="odd">
<td><p><strong>Hardware and devices troubleshooter</strong></p>
<p>Automatically changes system settings to fix a problem on your device.</p>
<p>OR</p>
<p><strong>Storage space troubleshooter</strong></p>
<p>Data corruption was detected on your parity storage space. To prevent further corruption, the volume has been marked as Read-Only. Your data is still accessible at this time. For more information and recommended actions please see the link below.</p></td>
<td><p>Devices that use Parity Storage Spaces might experience issues when they try to use or access their storage spaces after they are updated to Windows 10, version 2004 (the May 2020 Update) or Windows Server, version 2004. This troubleshooter helps prevent issues that affect the data on your storage spaces. After the troubleshooter runs, you will not be able to write to your storage spaces.</p>
<p>This troubleshooter runs two times on devices that meet the following criteria:</p>
<ul>
<li><p>Runs Windows 10, version 2004</p></li>
<li><p>Uses storage spaces</p></li>
</ul>
<p>The first time, the troubleshooter runs automatically. The second time, it notifies the user.</p></td>
<td>6/26/2020</td>
<td>-</td>
<td><a href="https://aka.ms/AA8uojg">https://aka.ms/AA8uojg</a></td>
</tr>
<tr class="even">
<td><strong>Windows Update troubleshooter<br />
</strong>Automatically changes system settings to fix a problem on your device.</td>
<td><p>Some devices might not start if Disk Cleanup runs after you install the Windows version 19041.21 update. This troubleshooter temporarily disables the feature to automatically run Disk Cleanup until devices install the Windows 10, version 19041.84 update.</p>
<p>This troubleshooter automatically runs two times. It runs the first time on all devices on Windows 10, version 19041.21. It then runs again after devices are upgraded to Windows 10, version 19041.84.<br />
<br />
<strong>Note:</strong> This troubleshooter cannot be run manually.</p></td>
<td>2/7/2020</td>
<td>-</td>
<td><a href="https://aka.ms/AA7afc1">https://aka.ms/AA7afc1</a></td>
</tr>
</tbody>
</table>
