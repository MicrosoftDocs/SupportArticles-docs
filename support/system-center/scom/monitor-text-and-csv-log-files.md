---
title: Monitor text and CSV log files in Operations Manager
description: Describes how to configure System Center Operations Manager to monitor plain text and delimited text log files.
ms.date: 04/15/2024
ms.reviewer: lamosley
---
# Monitor text and CSV log files in System Center Operations Manager

Configuring System Center Operations Manager to monitor plain text and delimited text log files from various sources is straightforward but there are some scenarios of which to be aware.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2691973

## Create a monitor for a delimited (CSV) log file

See the link below for instructions on how to create a **Simple Event Detection** monitor for a plain text (non-delimited) log file in System Center 2012 Operations Manager:

[How to Create a Log File Simple Event Detection Unit Monitor in Operations Manager 2007](/previous-versions/system-center/operations-manager-2007-r2/bb381375(v=technet.10)?redirectedfrom=MSDN)

Follow the procedure at the link above to create a monitor for a delimited (CSV) log file with the following exceptions:

Step 7: In the Create Monitor Wizard, on the **Select a Monitor Type** page, expand **Log Files**, expand **Text Log (CSV)**, expand **Simple Event Detection**, select **Event Reset**, and then select **Next**.

Step 10: The separator must also be entered on the **Application Log Data Source** page. The separator does not have to be a comma, but it must be a printable character.

Step 12: When entering a parameter name, the number in **Params/Param[*x*]** represents the field on which the operation will take place. For example, **Params/Param[1]** is the first field of the delimited file; **Params/Param[2]** is the second field of the delimited file, and so forth.

## Create a rule to monitor a log file

The following steps illustrate how to create a rule that targets the Windows Computer class and monitors a log file in System Center Operations Manager.

1. Log on to the computer with an account that's a member of the Operations Manager Administrators user role or Operations Manager Authors user role for the Operations Manager management group.
2. In the Operations console, select the **Authoring** button.
3. In the Authoring pane, expand **Authoring**, expand **Management Pack Objects**, and then select **Rules**.
4. In the toolbar, select **Scope**.

5. In the **Scope Management Packs Objects** dialog box, type **Windows Computer** in the **Find** text box, select the **Windows Computer** target check box, and then select **OK**.

6. In the Rules pane, right-click **Windows Computer** and then select **Create a New Rule**.

7. In the Create Rule Wizard, on the **Select the type of rule to create** page, expand **Collection Rules**, expand **Event Based**, and then select **Generic Text Log** or **Generic CSV Text Log**.

   > [!NOTE]
   > If an alert will be configured, choose **Alert Generating Rules**, expand **Event Based**, and then select **Generic Text Log** or **Generic CSV Text Log**.

8. Select a management pack from the **Select destination management pack** list (in System Center Operations Manager 2012, this list picker is labeled **Select Management Pack**). Or, create a new unsealed management pack by selecting **New**. By default, when creating a management pack object, an override, or disabling a rule or monitor, Operations Manager saves the setting to the **Default Management Pack**. As a best practice, create a separate management pack for each sealed management pack to be, rather than saving customized settings to the **Default Management Pack**. For more information, see [Default Management Pack](/previous-versions/system-center/operations-manager-2007-r2/ee191599(v=technet.10)?redirectedfrom=MSDN).

9. Select **Next**  
10. On the **General** page, in the **Name** box, type a name for the rule, and then as an option, you can type a description.
11. Select the **Rule Category** arrow, select the appropriate category, and then select **Next**.

12. On the **Application Log Data Source** page under **Define the application log data source**, in the **Directory** text box, type a path to where the log files are located, for example, *C:\logfiles*.

13. In the **Pattern** text box, type a pattern string to select log files. For example, *application??.log* will find any log file that starts with **application** followed by zero to two characters with an extension of **.log** (such as *application.log*, *application1.log*, *application01.log*, and so on).

14. For CSV log types, enter the separator. The separator does not have to be a comma, but it must be a printable character.

15. Select **UTF8** if applicable, and then select **Next**.

16. On the **Build Event Expression** page (for the Build First Expression), select **Insert** and then do the following:

    1. Under **Parameter Name** (on the left), type **Params/Param[1]**. **Params/Param[1]** is the only field available for **Generic Text Log**, since each line in the file is considered a single field. For **Generic CSV Text Log**, the number in **Params/Param[*x*]** represents the field on which the operation will take place. For example, **Params/Param[1]** is the first field of the delimited file; **Params/Param[2]** is the second field of the delimited file, and so forth.

    1. Under **Operator**, select the pull-down menu and then select an operator, for example **Contains**.

    1. Under **Value**, enter the text that this monitor should trigger on as found in the log file, for example **error**.

17. Select **Create** to create the rule. If **Alert Generating Rules** was chosen in step 7, select **Next** to configure the alert, then select **Create** to create the rule.

After the rule is created, edit the properties of the new rule to generate an alert when the rule is triggered. For more information, see [How to Edit Properties of a Rule in Operations Manager 2007](/previous-versions/system-center/operations-manager-2007-r2/bb309699(v=technet.10)?redirectedfrom=MSDN).

Steps for creating a text log alert rule on System Center 2012 Operations Manager can be found at [Creating Text Log Rules and Monitors](/previous-versions/system-center/system-center-2012-R2/hh457567(v=sc.12)?redirectedfrom=MSDN#creating-text-log-rules-and-monitors).

To reference the fields that were read from the log when the rule is triggered in an alert, use the **Params/Param[*x*]** syntax.

For more information on the various settings available in the **Create a unit monitor** and **Create Rule Wizard** wizards, see [Text Log Wizard Options](/previous-versions/system-center/system-center-2012-R2/hh457567(v=sc.12)?redirectedfrom=MSDN#text-log-wizard-options).

## More information

Each line of a log file must end with a new line (0x0A0x0A hex sequence) before it will be read and processed by Operations Manager.  

If a rule or monitor is configured to match a pattern for log file names (such as using the `?` or `*` wildcard characters), it's important that only one log that matches the pattern is written. If multiple logs that match the pattern are being written to, the high water mark is reset to the beginning of the file with each write to a different file. The result is that all previous log entries will be reprocessed.

Example:

The log file name pattern is *generic_csv??.txt*.

- The current log is *generic_csv01.txt* and writes happen to this log.
- A new log, *generic_csv02.txt*, is created. Writes occur to this log.
- When the next line is written to *generic_csv01.txt*, the Operations Manager will read from the beginning of generic_csv.txt, not from the last point that was read from *generic_csv01.txt*. Lines previously processed will be processed again, possibly resulting in alerts or other actions (depending on the rule configuration).

Starting with Operations Manager 2012 Service Pack 1, if a log file is cleared or renamed/deleted and then recreated, Operations Manager will read the file from the first line. Prior versions of Operations Manager behave as follows:

When monitoring a log file, Operations Manager remembers the last line read within the file (a high water mark). It will not re-read data before this point unless the file is deleted and recreated, or renamed and recreated, which will reset the high water mark.

If a log file is deleted and recreated with the same name within the same minute, the high water mark will not be reset, and log entries will be ignored until the high water mark is exceeded.

An implication of this is that log files that are cleared periodically without being renamed and recreated, or deleted and recreated, will not have entries in them processed before the log is cleared until the high water mark is exceeded.

Operations Manager cannot monitor circular log files (for example, log files that get to a certain size or line count, then start writing the newest entries at the beginning of the log) for the same reason. The log file must be deleted or renamed and then recreated, or the application configured to write to a new log once the current log is filled.
