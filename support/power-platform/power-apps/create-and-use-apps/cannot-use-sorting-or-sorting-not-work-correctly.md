# Cannot use sorting or sorting does not work correctly

We will consider the following cases:

1.  None of the columns are sortable in the grid

2.  Sorting does not seem to be correct after navigating to the grid or subgrid.

3.  Certain columns are not sortable in grid. Respective column header menu options are missing or disabled.

4.  Column is sortable but the data is not ordered correctly.

**<u>How to troubleshoot 1:</u>**

Sorting not available on all the columns is a strong indication that sorting is disabled on the grid control. Please use the monitoring tool to make sure the "enableSorting" grid property is set to "true".
![Image](images/image13.png)
If sorting is not enabled, then please update the respective grid property value.

**<u>How to troubleshoot 2:</u>**

If there's no [custom code](#steps-to-perform-before-starting-troubleshooting) that alters the sorting, the default sorting should correspond to the current view "Sort by" setting.
![Image](images/image14.png)
Make sure the view setting is set correctly and that all the changes are saved and published.

**<u>How to troubleshoot 3:</u>**

The most common reason a certain field is not sortable is because Dataverse does not support sorting on the underlying field type. Use the monitoring tool to ensure the sorting is not disabled by Dataverse:
![Image](images/image15.png)
If sorting is disabled (disableSorting: true) then this is a strong indication that the sorting is not permitted on the data field (column). More information about sortable columns can be found [here](https://learn.microsoft.com/en-us/power-apps/maker/data-platform/types-of-fields).

**<u>How to troubleshoot 4:</u>**

The first step in troubleshooting this issue is to ensure the column is in the expected format (see "datatype" and "Format" attributes in the image above). Please note that data sorting will always be performed based on the column type and format rather than based on the actual data. For example, the sorting will always be "alphabetical" on Text type columns, even if all the data in these fields is numeric.

The next step is to check if the data is sorted (ordered) by more than one column. The presence of sorting icons on more than one column indicates multi-column sorting, in which case the data sorting will be performed on the first sorted column (the column that was sorted first which is not necessarily the left-most column) and then on the second column. As shown in the example screenshot below, the data is sorted first by "Full Name" column ascending and then by "Company Name" column descending.
![Image](images/image16.png)
The multi-column sorting can be removing by re-applying the sorting on a column (without holding the Shift key down) or by simply refreshing the app.

Finally, the data ordering my be affected by [data customizers](https://learn.microsoft.com/en-us/power-apps/developer/component-framework/customize-editable-grid-control). Please note that the sorting (data ordering) will always be applied on raw data and not on enhanced data. A typical example is the case where raw numeric data is replaced by a user-friendly text in which case the ordering will be performed by the numeric data.