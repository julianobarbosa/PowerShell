# create a DSC configuration to install IIS and support remote management
configuration IISConfig {
    # define input parameter
    param(
        [string[]]$computerName = 'localhost'
    )
    
    # target machine(s) based on input param
    node $computerName {
        # install the IIS server role
        WindowsFeature IIS {
            Ensure = 'Present'
            Name = 'Web-Server'
        }
        
        # install the IIS remote management service
        WindowsFeature IISManagement {
            Name = 'Web-Mgmt-Service'
            Ensure = 'Present'
            DependsOn ' @('[WindowsFeature]IIS')
        }
        
        # enable IIS remote management
        Registry RemoteManagement {
            Key = 'HKLM:\SOFTWARE\Microsoft\WebManagement\Server'
            ValueName = 'EnableRemoteManagement'
            ValueType = 'Dword'
            ValueData = '1'
            DependsOn = @('[WindowsFeature]IIS', '[WindowsFeature]IISManagement')
        }
        
        # configure remote management service
        Service WMSVC {
            Name = 'WMSVC'
            
        }
    }
}
