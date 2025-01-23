<!-- Learn / Troubleshoot / Microsoft Dynamics 365 / Dynamics 365 Supply Chain Management / Asset Management -->

# Changing work order lifecycle state doesn't generate fault cause or fault remedy error

## Symptoms  

When we change a **Work order** to a **Lifecycle state** - which has been setup to enable validation of *Fault cause* and*Fault remedy* - the system does not return any error for*Fault cause* or*Fault remedy* thus allowing the change of**Lifecycle state** despite the validation setup.

## Resolution

It is not possible to validate Asset *Fault Cause* and Asset*Fault Remedy* if they don't have a fault registration and therefore no error message is thrown in that case when updating the **Lifecycle state** of the Work order.  

### Prerequisites

As mentioned in the Symptoms section above, the **Lifecycle state**(s) must first be set up to enable validation of *Fault cause* and *Fault remedy*. This is done by following this path:

**Asset Management module &gt; Setup &gt; Work orders &gt; Lifecycle states**

Select the **Work order lifecycle state** in question and then select *Edit*. Under the**Validate** fast tab it is possible to set up the message type (*Error* in this case), and to enable validation for *Fault Cause*, *Fault Remedy* and more.

Furthermore, the **Work order type** must first be set up to enable validation of *Fault cause* and*Fault remedy* by making them mandatory for work orders. This is done by following this path:

**Asset Management module &gt; Setup &gt; Work orders &gt; Work order types**

Select the **Work order type** in question and then select *Edit*. Under the **General** FastTab it is possible to make *Fault Cause*, *Fault Remedy* and more mandatory.

### Fault registration

To enable the system to return the expected error message, follow these steps:

1. Go to: **Asset Management &gt; Work orders &gt; All work orders.**

2. Select the **Work order** in question. For the simplicity of this example let's assume that it is a new **Work order**, which means **Current lifecycle state** is *New.*

3. In the Action Pane, go to the **Asset** group and select **Asset fault**.

4. Expand the **Symptoms** fast tab and select **Add line**.

5. In the field **Fault symptom** select the relevant symptom from the drop down. Select **Save** and then go back to the **Work order**.

6. In the Action Pane, go to the **Lifecycle state** group and select **Update work order state**.

7. In the **Update work order state** window select the **Lifecycle state** which has the validation setup (see prerequisites above). For the simplicity of this example let's assume that it is the **Lifecycle state** of *Released*. Then select*OK*.

8. Select the **Action Centre/notification bell** in the upper right corner, and then select **Message details**. The **Message details** will say: *The fault cause for symptom X on asset Y is missing. Update has been cancelled.* Close the**Message details** window. In the upper right corner of the **Work order** the **Lifecycle state** is still shown as *New*.

9. In the Action Pane of the **Work order**, go to the **Asset** group and select **Asset fault**.

10. Expand the **Causes for selected symptom** fast tab and select **Add line**.

11. In the field **Fault cause** select the relevant cause from the drop down. Select **Save** and then go back to the **Work order**.

12. In the Action Pane, go to the **Lifecycle state** group and click on **Update work order state**.

13. In the **Update work order state** window select the **Lifecycle state** which has the validation setup (see prerequisites above). For the simplicity of this example let's assume that it is the **Lifecycle state** of *Released*. Then select*OK*.

14. Select the **Action Centre/notification bell** in the upper right corner, and then select the new **Message details** (the upper one). The **Message details** will say: *Fault remedy for cause Z on symptom X on asset Y is missing. Update has been cancelled.* Close the**Message details** window. In the upper right corner of the **Work order** the **Lifecycle state** is still shown as *New*.

15. In the Action Pane of the **Work order**, go to the **Asset** group and select **Asset fault**.

16. Expand the **Remedies for selected symptom** fast tab and select **Add line**.

17. In the field **Fault remedy** select the relevant remedy from the drop down. Select **Save** and then go back to the **Work order**.

18. In the Action Pane, go to the **Lifecycle state** group and select **Update work order state**.

19. In the **Update work order state** window select the **Lifecycle state** which has the validation setup (see prerequisites above). For the simplicity of this example let's assume that it is the **Lifecycle state** of *Released*. Then select*OK*.

20. Select the **Action Centre/notification bell** in the upper right corner. The first two attempts above to update the **Work order** resulted correctly in error messages and no update of the **Lifecycle state**. In this third attempt no error message was generated, and the **Lifecycle state** of the **Work order** is also correctly updated to *Released*.
