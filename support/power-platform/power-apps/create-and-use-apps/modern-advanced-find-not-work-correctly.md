# Modern Advanced Find does not work correctly

We will consider the following cases:

1.  Some filter conditions re-appear again after they're deleted.

2.  Some filter conditions are not rendered correctly.

3.  Unexpected data after applying Modern Advanced Find filters.

**<u>How to troubleshoot 1:</u>**

Check if the filters that are re-applied automatically are related to page filters. Some entities (Activities and Queues) support page filters (See image 7 above). Those filters cannot be removed from Modern Advanced Find window.

**<u>How to troubleshoot 2:</u>**

The following conditions are currently not supported by Modern Advanced Find:

-   Date type fields with standard operators. Please note that Date type fields must be used with field specific operators (for example, "on" instead of "eq" and "on-or-before" instead of "lt").

-   "in" type conditions. To ensure compatibility with Modern Advanced Find, the "in" type condition should be replaced with several "eq". For example, the \[city in "Redmond", "Washington" \] should be replaced with \[city eq "Redmond" Or city eq "Washington"\]

**<u>How to troubleshoot 3:</u>**

Use the monitoring tool to obtain the fetchXML query (see Image 6 above) and the "recordsCount" attribute (see image 5 above). Check all the filters from the fetchXML query (see Image 8 above) and make sure they're all expected. If the fetchXML query contains extra filters, please check any extra filters that may be applied (see the item \#3 from [this section](#cannot-use-column-filters-on-a-grid-or-subgrid-or-filtering-does-not-work-correctly)).