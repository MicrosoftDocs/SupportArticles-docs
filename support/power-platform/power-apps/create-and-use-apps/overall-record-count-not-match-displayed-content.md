# The overall record count does not match the displayed content

A typical example of this issue is when the displayed number of records is lower than the records count that is displayed at the bottom of the page (See Image 1 and 2 above).

**<u>How to troubleshoot:</u>**

The most likely reason is that the data that is displayed in the grid contains duplicate records (by the value in primary field). The issue is usually caused by pulling related-record duplicates from the same table.

Use the monitoring tool to check the total number of records (see image 5 above). If the "recordsCount" matches the total number of records displayed at the bottom of the grid while the data in the grid has less records, this is a strong indication that the data contains duplicate records. Please use the monitoring tool get the current view fetchXML request.
![Image](images/image7.png)

Very often the issue can be solved by just adding distinct="true" to the fetchXML (see [this doc](https://learn.microsoft.com/en-us/power-apps/developer/data-platform/use-fetchxml-construct-query) for more information). If adding distinct="true" does not help, then please consider changing the query to avoid pulling duplicate records. The primary column (field) can be also found by using the monitoring tool:
![Image](images/image8.png)