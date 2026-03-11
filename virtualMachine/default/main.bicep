param location string = 'westus'
param adminPassword string
param adminUsername string
param domainJoinUserName string
param domainJoinUserPassword string
param vmList array
param vNet string 

module vm 'br:pocacr.azurecr.io/bicepmodules/virtualmachine:v1' = {
  name: 'vmDeploy'
  params: {
    location:location
    adminPassword:adminPassword
    adminUsername:adminUsername
    domainJoinUserName:domainJoinUserName
    domainJoinUserPassword:domainJoinUserPassword
    vmList:vmList
    vNet:vNet
  }
}
