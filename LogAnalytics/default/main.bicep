param logAnalyticsWorkspaceName string
param location string = resourceGroup().location

module loganalytics 'br:ayapocacr.azurecr.io/bicepmodules/loganalytics:v1' = {
  name: 'loganalyticsdeploy'
  params:{
    location: location
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
  }
}
