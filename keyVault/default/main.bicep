param location string = resourceGroup().location
param keyvaultName string

module keyvault 'br:pocacr.azurecr.io/bicepmodules/keyvault:v1' = {
  name: 'keyvaultDeploy'
  params:{
    location: location
    keyvaultName: keyvaultName
  }
}
