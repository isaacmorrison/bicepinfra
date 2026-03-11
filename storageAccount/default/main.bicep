param location string = resourceGroup().location
param storageName string

module storage 'br:pocacr.azurecr.io/bicepmodules/storage:v1' = {
  name: 'storageDeploy'
  params:{
    location: location
    storageName: storageName
  }
}
