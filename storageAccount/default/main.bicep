param location string = resourceGroup().location
param storageName string

module storage 'br:ayapocacr.azurecr.io/bicepmodules/storage:v1' = {
  name: 'storageDeploy'
  params:{
    location: location
    storageName: storageName
  }
}
