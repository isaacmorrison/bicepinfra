param nsgName string 
param location string = resourceGroup().location

module nsg 'br:ayapocacr.azurecr.io/bicepmodules/nsg:v1' = {
  name: 'nsgDeploy'
  params:{
    location: location
    nsgName: nsgName
  }
}
