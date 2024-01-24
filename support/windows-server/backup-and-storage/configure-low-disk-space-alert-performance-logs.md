---
title: Configure a Low Disk Space Alert
description: Describes how to configure a Low Disk Space Alert by using the Performance Logs and Alerts Feature.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
ms.subservice: backup-and-storage
---
# Configure a Low Disk Space Alert by Using the Performance Logs and Alerts Feature

This article describes how to configure a Low Disk Space Alert by using the Performance Logs and Alerts Feature.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 324796

## Summary

This step-by-step article describes how to create and configure a low-disk-space alert by using the Performance Logs and Alerts feature in Microsoft Windows Server 2003.

### Create an Alert in System Monitor to Track Free Disk Space

1. Click Start, point to Administrative Tools, and then click Performance.
2. Expand **Performance Logs and Alerts**.
3. Right-click Alerts, and then click New Alert Settings.
4. In the New Alert Settings box, type a name for the new alert (for example, Free disk space), and then click OK.

    The **AlertName** dialog box appears, in which you configure settings for the alert that you created.
5. Click the General tab, and then in the Comment box, type Monitors free disk space on logical drive.

### Configure the Alert

1. Click Add to open the Add Counters dialog box.
2. Click **Select counters from computer**, and then select your computer in the list.
3. In the **Performance object** box, click LogicalDisk.
4. Click **Select counters from list**, and then click **% Free Space**.
5. Click **Select interfaces from list**, and then click the logical drive or volume that you want to monitor.
6. Click Add to add the counter, and then click Close.
7. In the **Alert when the value is** box, click Under, and then type the value that you want in the Limit box. For example, to trigger an alert message when disk space is under 1 megabyte (MB), type 1000.
8. Accept the default value of 5 seconds in the **Sample data interval**, or specify the value that you want.
9. Click Apply.
10. Click the Action tab, and then specify the action or actions that you want to perform when an alert occurs, as follows:

    - If you want the Performance Logs and Alerts service to create an entry in the application log of event viewer when an alert occurs, click to select the **Log an entry in the application event log** check box.
    - If you want the Performance Logs and Alerts service to trigger the Messenger service to send a message, click to select the **Send a network message to** check box, and then type the IP address or name of the computer on which the alert should be displayed.
    - To run a counter log when an alert occurs, click to select the **Start performance data log** check box, and then specify the counter log that you want to run.
    - To run a command or program when an alert occurs, click to select the **Run this program** check box, and then type the file path and name of the program or command that you want to run. Or, click Browse to locate the file.

    When an alert occurs, the service creates a process and runs the specified command file. The service also copies any command-line arguments that you define to the command line that is used to run the file. Click `Command Line Arguments`, and then click to select the appropriate check boxes to include the arguments that you want to implement when the program is run.
11. Click Apply.
12. Click the Schedule tab, and then specify the start and stop parameters for the scan, as follows:

    1. Under **Start scan**, do one of the following steps:

        - Click Manually if you want to manually start the scan. After you select this option, right-click the alert in the right pane, and then click Start to start the scan.
        - Click At to start the scan at a specific time and date, and then specify the time and date that you want.
    2. Under **Stop scan**, do one of the following steps:

        - Click Manually if you want to manually stop the scan. After you click this option, right-click the alert in the right pane, and then click Stop to stop the scan.
        - Click After to stop the scan after a specified duration, and then specify the time interval that you want.
        - Click At to stop the scan at a specific time and date, and then specify the time and date that you want.
    3. If you want to start a new scan after the alert scan is complete, click After, and then click to select the **Start a new scan** check box.
13. Click OK.

### Troubleshooting

After you complete the procedures in this article, monitoring starts at its scheduled time and sends alert messages when the threshold is reached or passed. However, the alert does not automatically restart each time after you restart the computer. To force the alert to automatically restart after you restart the computer, or after you log off and log on, follow these steps:

1. Click Start, point to Administrative Tools, and then click Performance.
2. Expand **Performance Logs and Alerts**.
3. Click Alerts  
4. In the right pane, right-click the alert that you created, and then click Properties.
5. Click the Schedule tab.
6. Under **Stop scan**, click After (if it is not already selected), and then set this value to a large number of days.

The maximum value is 100,000.
7. Click to select the **Start a new scan** check box.
8. Click OK. The alert runs continuously, even after you restart or log off and then log on to the computer.
