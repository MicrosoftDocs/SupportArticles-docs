# Cannot use column filters on a grid or subgrid, or filtering does not work correctly

We will consider the following cases:

1.  Column filtering is not enabled on any of the columns.

2.  Column filtering options are missing or disabled on certain columns.

3.  Column filtering is enabled but not applied correctly.

**<u>How to troubleshoot 1:</u>**

Use the image above to make sure the "enableFiltering" grid property is set to "true". If it is set to false, then check the grid control configuration to make sure the respective "Enable Filtering" property is enabled.

**<u>How to troubleshoot 2:</u>**

After checking to ensure there's no [custom code](#steps-to-perform-before-starting-troubleshooting) that affects filtering, please use the monitoring tool to check the column type. Please note that Dataverse does not support filtering on certain columns. More information about searchable columns can be found [here](https://learn.microsoft.com/en-us/power-apps/maker/data-platform/types-of-fields). An example of a property type that does not have filtering support is shown below.
![Image](images/image17.png)
**<u>How to troubleshoot 3:</u>**

The most common case for this issue is extra filters that are applied to the current view. Please use the monitoring tool to inspect the fetchXML query (see Image 6). Review all the filters that are present in the query. Other filters can be present from:

1.  QuickFind search.

2.  Jump bar filters.
![Image](images/image18.png)
3.  Relationships with the parent entity.
![Image](images/image19.png)
4.  Entity specific filters (for example Queues or Activities).  
	![Image](images/image20.png)

The monitoring tool can be used to inspect grid-related filters (see the screenshot below) and compare them with the final fetchXML query (see Image 6 above):
![Image](images/image21.png)
![Image](images/image22.png)
In the screenshot above, the following grid column filter has been used: "name like %Coffee%" or "name contains Coffee"