---
title: Consume WCF service over TCP transport
description: Describes how to consume WCF Service over TCP transport in Silverlight 4.
ms.date: 06/11/2020
ms.prod-support-area-path: 
---
# Consume WCF service over TCP transport in Silverlight 4

This article describes how to consume Windows Communication Foundation (WCF) Service over Transmission Control Protocol (TCP) transport in Microsoft Silverlight 4.

_Original product version:_ &nbsp; Silverlight  
_Original KB number:_ &nbsp; 2425652

## Summary

Silverlight 4 supports a netTcp transport binding element that gives us a new choice to implement duplex WCF. This code sample demonstrates how to consume netTcp WCF in Silverlight by creating a weather report subscription.

To demonstrate Silverlight accessing WCF, you may need a WCF service and a Silverlight WCF client. To create a weather report subscription application, follow these three steps:

## Step 1: Create a Duplex WCF service with NetTcpBinding

1. Create a new console project `NetTcpWCFService`. Then add a new WCF Service `WeatherService` to the project.
2. Open an *IWeatherService.cs* file, run the following code to define the service contract:

    ```csharp
     namespace NetTcpWCFService
    {
        [ServiceContract(CallbackContract=typeof(IWeatherServiceCallback))]
        public interface IWeatherService
        {
            [OperationContract(IsOneWay = true)]
            void Subscribe();
                [OperationContract(IsOneWay = true)]
            void UnSubscribe();
        }
        public interface IWeatherServiceCallback
        {
            [OperationContract(IsOneWay=true)]
            void WeatherReport(string report);
        }
    }
    ```

3. Open a *WeatherService.cs* file, use static event approach to implement subscription service. You first need to prefix the `ServiceBehavior` attribute to the existing `WeatherService` class, set an `InstanceContext` mode to a `PerSession` service. Then, run the following code to replace the default contents of the `WeatherService` class:

    ```csharp
    [ServiceBehavior(InstanceContextMode=InstanceContextMode.PerSession)]
        public class WeatherService : IWeatherService
        {
            static event EventHandler<WeatherEventArgs> WeatherReporting;
            IWeatherServiceCallback _callback;
            public void Subscribe()
            {
                _callback = OperationContext.Current.GetCallbackChannel<IWeatherServiceCallback>();
                WeatherReporting += new EventHandler<WeatherEventArgs>(WeatherService_WeatherReporting);
            }
            public void UnSubscribe()
            {
                WeatherReporting -= new EventHandler<WeatherEventArgs>(WeatherService_WeatherReporting);
            }
            void WeatherService_WeatherReporting(object sender, WeatherEventArgs e)
            {
                // Remember check the callback channel's status before using it.
                if (((ICommunicationObject)_callback).State == CommunicationState.Opened)
                    _callback.WeatherReport(e.WeatherReport);
                else
                    UnSubscribe();
            }
        }
        class WeatherEventArgs:EventArgs
        {
            public string WeatherReport{set;get;}
        }
    ```

4. Create a separate thread to generate a mock weather report periodically. Run the following code to add the `System.Threading` namespace, in a static constructor of the `WeatherService` class:  

    ```csharp
    static WeatherService()
    {
        ThreadPool.QueueUserWorkItem
        (
            new WaitCallback(delegate
            {
                string[] weatherArray = { "Sunny", "Windy", "Snow", "Rainy" };
                Random rand = new Random();

                while (true)
                {
                    Thread.Sleep(1000);
                    if (WeatherReporting != null)
                        WeatherReporting(
                            null,
                            new WeatherEventArgs
                            {
                                WeatherReport = weatherArray[rand.Next(weatherArray.Length)]
                            });
                }
            })
        );
    }
    ```

5. To add a `netTcpbinding` endpoint to WCF service, run the following code to configure an *app.config*:

    ```xml
     <system.serviceModel>
        <behaviors>
            <serviceBehaviors>
                <behavior name="NetTcpWCFService.WeatherServiceBehavior">
                    <serviceMetadata />
                    <serviceDebug includeExceptionDetailInFaults="false" />
                </behavior>
            </serviceBehaviors>
        </behaviors>
        <services>
            <service behaviorConfiguration="NetTcpWCFService.WeatherServiceBehavior"
                name="NetTcpWCFService.WeatherService">
                <endpoint address="" binding="netTcpBinding" bindingConfiguration="b1"
                  contract="NetTcpWCFService.IWeatherService" />
                <endpoint address="mex" binding="mexTcpBinding" contract="IMetadataExchange" />
                <host>
                    <baseAddresses>
                        <add baseAddress="net.tcp://localhost:4504/WeatherService" />
                    </baseAddresses>
                </host>
            </service>
        </services>
            <bindings>
                <netTcpBinding>
                    <binding name="b1">
                        <security mode="None"/>
                    </binding>
                </netTcpBinding>
            </bindings>
    </system.serviceModel>
    ```

    > [!NOTE]
    > Only a few ports that are from 4502 to 4534 are allowed to be accessed by Silverlight, and you need a client access policy file to permit Silverlight access. For more information about how to permit Silverlight access, please refer to [Step 3](#step-3-deploying-cross-domain-policy-file).

6. Open a *Program.cs* file, add a namespace `System.ServiceModel`. Run the following code to start a `ServiceHost` service in `Main` method:

    ```csharp
    static void Main(string[] args)
    {
        using (var host = new ServiceHost(typeof(WeatherService)))
        {
            host.Open();
            Console.WriteLine("Service is running...");
            Console.WriteLine("Service address: "+host.BaseAddresses[0]);
            Console.Read();
        }
    }
    ```

## Step 2: Create a Silverlight WCF client

Create a Silverlight application to consume the WCF. You need a button to subscribe or unsubscribe service, and a listbox to display the weather report from service.

1. Create a new Silverlight project *CSSL4WCFNetTcp*. In the **New Silverlight Application** dialog box, you need to check the **Host the Silverlight application in a new Web site** checkbox, and then set the **Silverlight Version** to Silverlight 4.

2. Run the following code to open a *MainPage.xaml* file and edit the default Grid element:

    ```xml
    <Grid x:Name="LayoutRoot" Background="White">
        <Grid.RowDefinitions>
            <RowDefinition Height="46*" />
            <RowDefinition Height="26*" />
            <RowDefinition Height="228*" />
        </Grid.RowDefinitions>
        <TextBlock Text="Silverlight NetTcp Sample" Grid.Row="0" Margin="0,0,0,10" FontSize="24"/>
        <StackPanel Orientation="Horizontal" Grid.Row="1">
            <Button Content="Subscribe weather report" Name="btnSubscribe" Click="Button_Click"/>
            <TextBlock VerticalAlignment="Center" FontStyle="Italic" Foreground="Red" Margin="5,0,0,0" Name="tbInfo"/>
        </StackPanel>
        <ListBox Name="lbWeather" Grid.Row="2" Margin="0,5,0,0"/>
    </Grid>
    ```

3. Add a Service Reference to the `weatherService` class in WCF service. To do it, set the NetTcpWCFService project as a startup project, press Ctrl+F5 to start the service. Then, right-click the Silverlight project, select **Add Service Reference** option, in the **Add Service Reference** dialog box, input the weatherservice address, and press **OK**. And then, Visual studio 2010 generates WCF proxy code in Silverlight project.

4. Run the following code to open the *MainPage.xaml.cs* file, and Initialize the WCF proxy in `Loaded` event:

    ```csharp
    public partial class MainPage : UserControl,IWeatherServiceCallback
    {
        public MainPage()
        {
            InitializeComponent();
            Loaded += new RoutedEventHandler(MainPage_Loaded);
        }
        bool _subscribed;
        WeatherServiceClient _client;
        void MainPage_Loaded(object sender, RoutedEventArgs e)
        {
            _client = new WeatherServiceClient(
                new System.ServiceModel.InstanceContext(this));
            _client.SubscribeCompleted += _client_SubscribeCompleted;
            _client.UnSubscribeCompleted += _client_UnSubscribeCompleted;
        }
        void _client_UnSubscribeCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                _subscribed = false;
                btnSubscribe.Content = "Subscribe weather report";
                tbInfo.Text = "";
            }else
                tbInfo.Text = "Unable to connect to service.";
            btnSubscribe.IsEnabled = true;
        }
        void _client_SubscribeCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
        {
            if (e.Error == null)
            {
                _subscribed = true;
                btnSubscribe.Content = "UnSubscribe weather report";
                tbInfo.Text = "";
            }
            else
                tbInfo.Text="Unable to connect to service.";
            btnSubscribe.IsEnabled = true;
        }
        // Display report when callback channel get called.
        public void WeatherReport(string report)
        {
            lbWeather.Items.Insert(
                0,
                new ListBoxItem
                {
                    Content = string.Format("{0} {1}",DateTime.Now, report)
                });
        }
    }
    ```

5. Run the following code to add an event handler to handle button click event:

    ```csharp
    private void Button_Click(object sender, RoutedEventArgs e)
    {
        if (!_subscribed)
        {
            _client.SubscribeAsync();
        }
        else
        {
            _client.UnSubscribeAsync();
        }
        btnSubscribe.IsEnabled = false;
    }
    ```

## Step 3: Deploying cross domain policy file

1. Create an xml file *clientaccesspolicy.xml*, use the following code to configure content:

    ```xml
    <access-policy>
        <cross-domain-access>
            <policy>
                <allow-from>
                    <domain uri="*"/>
                </allow-from>
                <grant-to>
                    <socket-resource port="4502-4506" protocol="tcp" />
                </grant-to>
            </policy>
        </cross-domain-access>
    </access-policy>
    ```

    > [!NOTE]
    > This file grants permissions to the Silverlight clients that are from any domain to access the server ports that are between 4502 to 4506.

2. Find out the path of root physical directory (by default, `C:\inetpub\wwwroot` if you use IIS) of the server web site, place the policy file in the path.
