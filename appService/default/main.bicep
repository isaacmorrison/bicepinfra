param location string = resourceGroup().location
param sku string 
param appServiceName string
param appServicePlanName string
param skuCapacity int

module appService 'br:ayapocacr.azurecr.io/bicepmodules/appservice:v1' = {
  name: 'appserviceDeploy'
  params:   {
    location: location
    sku: sku
    appServiceName: appServiceName
    appServicePlanName: appServicePlanName
    skuCapacity: skuCapacity
  }
}
