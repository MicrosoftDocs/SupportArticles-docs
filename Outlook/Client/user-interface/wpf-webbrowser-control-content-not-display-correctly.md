---
title: WPF WebBrowser control doesn't display content correctly in an Office application
description: Describes the issue that the WebBrowser control content isn't displayed or functioned correctly in an Office application. It occurs when the control is hosted inside a CustomTaskPane control.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: v-venum, mhaque, catagh
appliesto: 
  - Office Products
  - Outlook Development
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# WebBrowser or WPF control doesn't display content correctly in an Office application when hosted inside a CustomTaskPane control

_Original KB number:_ &nbsp;4490421

## Symptoms

In some situations, the WebBrowser or WPF control content might not display or function correctly in a Microsoft Office application when the control is hosted inside a CustomTaskPane control or Outlook FormRegion.

## Cause

These issues might be caused either by the host application not returning focus to the HTML elements rendered inside your controls or by high DPI and DPI scaling in Microsoft Office solutions as indicated in the Handle high DPI and DPI scaling within your Microsoft Office solution article.

## Workaround 1: Issue with the high DPI and DPI scaling

Add a class named `NativeImports` to your code, as illustrated below, and add the following line to the `ThisAddIn_Startup` method:

```console
NativeImports.SetThreadDpiHostingBehavior(NativeImports.DPI_HOSTING_BEHAVIOR.DPI_HOSTING_BEHAVIOR_MIXED);

// ThisAddIn.cs

namespace TaskPaneWorkaround
{
    public partial class ThisAddIn
    {
        private MyUserControl myUserControl1;
        private Microsoft.Office.Tools.CustomTaskPane myCustomTaskPane;

        private void ThisAddIn_Startup(object sender, System.EventArgs e)
        {
            // Workaround for the rendering issues to do with DPI

NativeImports.SetThreadDpiHostingBehavior(NativeImports.DPI_HOSTING_BEHAVIOR.DPI_HOSTING_BEHAVIOR_MIXED);

            myUserControl1 = new MyUserControl();
            myCustomTaskPane = this.CustomTaskPanes.Add(myUserControl1, "My Task Pane");
            myCustomTaskPane.Visible = true;
        }

        private void ThisAddIn_Shutdown(object sender, System.EventArgs e)
        {
        }

        #region VSTO generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>

        private void InternalStartup()
        {
            this.Startup += new System.EventHandler(ThisAddIn_Startup);
            this.Shutdown += new System.EventHandler(ThisAddIn_Shutdown);
        }

        #endregion
    }
}


// NativeImports.cs

namespace TaskPaneWorkaround
{
    class NativeImports
    {

        internal enum DPI_HOSTING_BEHAVIOR
        {
            DPI_HOSTING_BEHAVIOR_INVALID = -1,
            DPI_HOSTING_BEHAVIOR_DEFAULT = 0,
            DPI_HOSTING_BEHAVIOR_MIXED = 1
        };

        [DllImport("user32.dll")]
        internal static extern DPI_HOSTING_BEHAVIOR SetThreadDpiHostingBehavior(DPI_HOSTING_BEHAVIOR value);

        [DllImport("user32.dll", SetLastError = true)]
        private static extern IntPtr SetParent(IntPtr hWndChild, IntPtr hWndNewParent);
    }

}
```

## Workaround 2: Issue with the host application not returning focus

Add an intermediary form between the CustomTaskPane and the actual WebBrowser or WPF control.

For more information on adding a custom task pane to an application, see [Add a custom task pane to an application](/visualstudio/vsto/how-to-add-a-custom-task-pane-to-an-application).

For WPF rendering issues, the workaround consists of hosting a WPF UserControl inside a WindowsForm as described in [Walkthrough: Host a 3D WPF Composite Control in Windows Forms](/dotnet/desktop/wpf/advanced/walkthrough-hosting-a-3-d-wpf-composite-control-in-windows-forms).

Here is an example of a user control called MyUserControl that implements this workaround:

1. Add a **UserControl** to your add-in, named **MyUserControl**.
2. Modify the source code of your **UserControl** and declare the Load, Paint, and Resize event handlers as indicated in the example below.
3. Add a **WindowsForm** form to your project. Name it **WorkaroundForm** and declare the Load event handler.
4. Add your **WebBrowser** control to **WorkaroundForm** as indicated in the example below.
5. Create a **CustomTaskPane** and add an instance of MyUserControl to it.

    ```console
    // ThisAddIn.cs

    namespace TaskPaneWorkaround
    {
        public partial class ThisAddIn
        {
            private MyUserControl myUserControl1;
            private Microsoft.Office.Tools.CustomTaskPane myCustomTaskPane;

            private void ThisAddIn_Startup(object sender, System.EventArgs e)
            {
                myUserControl1 = new MyUserControl();
                myCustomTaskPane = this.CustomTaskPanes.Add(myUserControl1, "My Task Pane");
                myCustomTaskPane.Visible = true;
            }

            private void ThisAddIn_Shutdown(object sender, System.EventArgs e)
            {
            }

            #region VSTO generated code
            /// <summary>
            /// Required method for Designer support - do not modify
            /// the contents of this method with the code editor.
            /// </summary>

            private void InternalStartup()
            {
                this.Startup += new System.EventHandler(ThisAddIn_Startup);
                this.Shutdown += new System.EventHandler(ThisAddIn_Shutdown);
            }

            #endregion
        }
    }

    // MyUserControl.cs

    using System;
    using System.Windows.Forms;
    using System.Runtime.InteropServices;

    namespace TaskPaneWorkaround
    {
        public partial class MyUserControl : UserControl
        {
            bool isformdisplayed = false;
            WorkaroundForm workaroundForm;

            [DllImport("user32.dll", SetLastError = true)]
            private static extern IntPtr SetParent(IntPtr hWndChild, IntPtr hWndNewParent);

            public MyUserControl()
            {
                this.SuspendLayout();
                this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
                this.Name = "MyUserControl";
                this.Paint += new System.Windows.Forms.PaintEventHandler(this.MyUserControl_Paint);
                this.Resize += new System.EventHandler(this.MyUserControl_Resize);
                this.ResumeLayout(false);

                this.Paint += MyUserControl_Paint;
                this.Resize += MyUserControl_Resize;
            }

            private void MyUserControl_Load(object sender, System.EventArgs e)
            {
               this.Paint += MyUserControl_Paint;
            }

            private void MyUserControl_Paint(object sender, PaintEventArgs e)
            {
                if (!isformdisplayed)
                {
                    this.SuspendLayout();
                    workaroundForm = new WorkaroundForm();
                    SetParent(workaroundForm.Handle, this.Handle);
                    workaroundForm.Dock = DockStyle.Fill;
                    workaroundForm.Width = Width;
                    workaroundForm.Height = Height;
                    workaroundForm.Show();
                    isformdisplayed = true;
                    this.ResumeLayout();
                }
            }

            private void MyUserControl_Resize(object sender, EventArgs e)
            {
                if (isformdisplayed)
                {
                    workaroundForm.Width = this.Width;
                    workaroundForm.Height = this.Height;
                }
            }
        }
    }

    //WorkaroundForm.cs

    using System;
    using System.Drawing;
    using System.Windows.Forms;

    namespace TaskPaneWorkaround
    {
        public partial class WorkaroundForm : Form
        {
            public WorkaroundForm()
            {
                this.SuspendLayout();
                this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
                this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
                this.ClientSize = new System.Drawing.Size(509, 602);
                this.Name = "Form1";
                this.Text = "Form1";
                this.Load += new System.EventHandler(this.WorkaroundForm_Load);
                this.ResumeLayout(false);
            }
            private void WorkaroundForm_Load(object sender, EventArgs e)
            {
                this.SuspendLayout();
                this.Location = new Point(0, 0);
                this.Dock = DockStyle.Fill;
                this.FormBorderStyle = FormBorderStyle.None;
                WebBrowser webBrowser = new WebBrowser();
                this.Controls.Add(webBrowser);
                webBrowser.Location = new Point(0, 0);
                webBrowser.Dock = DockStyle.Fill;
                this.ResumeLayout();
                webBrowser.Focus();
                webBrowser.Navigate(new System.Uri("https://bing.com"));
            }

        }
    }
    ```

## More information

Most WebBrowser and WPF control rendering issues have been addressed by hotfixes. However, if you run into any problems where the content isn't rendered correctly, focus isn't returned to the HTML elements rendered inside the control, or certain key combinations don't work as expected, consider the workarounds mentioned above.

A code sample illustrating the workarounds is available on [GitHub](https://github.com/developermessaging/TaskPaneWorkaroundAddIn_KB4490421).
