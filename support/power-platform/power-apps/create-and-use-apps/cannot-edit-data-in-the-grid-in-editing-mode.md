# Cannot edit data in the grid after enabling editing mode

There could be 2 separate cases:

1.  The entire grid control is not editable even though editing mode has been enabled.

2.  Only certain cells from certain columns are not editable.

**<u>How to troubleshoot 1:</u>**

The first step is to check grid and column parameters using the monitoring tool:
![Image](images/image9.png)

Make sure the grid editable mode is set to "yes". If this is not the case, then please check the grid configuration and make sure the last configuration is saved and published. Please also note that the form may also forcibly set sub-grids to read-only or disabled modes in certain cases (for example, when the currently edited record is de-activated). You can troubleshoot this by checking the "isControlDisabled" attribute.
![Image](images/image10.png)

**<u>How to troubleshoot 2:</u>**

Using the monitoring tool, check the attributes of the column that is not editable (see the image above). If the "IsEditable" attribute is set to "false", then editing is not allowed here. Possible reasons include but are not limited to:

-   Dataverse does not support editing of the underlying column type (for example, calculated type columns are not editable).

-   The user may not have permission to edit that column.

-   A [custom script](#steps-to-perform-before-starting-troubleshooting) is altering the cell attribute making it permanently or conditionally read-only.