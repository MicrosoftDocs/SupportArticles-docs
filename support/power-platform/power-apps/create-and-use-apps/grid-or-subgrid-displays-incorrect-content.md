# Grid or sub-grid displays incorrect content

This is the case when the grid does not display the expected content immediately after navigating to the parent page or form. In this case, data is rendered but the content does not match the default view or the view selected from the view selector.

See also: [Grid or sub-grid does not display all the records](#grid-or-sub-grid-does-not-display-all-the-records) and [The overall record count does not match the displayed content](#the-overall-record-count-does-not-match-the-displayed-content).

**<u>How to troubleshoot:</u>**

The first step in troubleshooting this issue is to check if the grid is receiving the expected data. Use [the monitoring tool](#useful-tools) to investigate the latest "GridChecker" event that is related to the grid or sub-grid.

![Image](images/image5.png)
Image 5. Use monitoring tool to get page and records information.

If the "recordsCount" and "initialPageSize" matches the actual content displayed in the grid, then this is a strong indication that the view is not configured correctly. Please check the view configuration (columns and filters). If the issue happens in sub-grid, please also check if the grid is configured to only show related records.