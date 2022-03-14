@description('The Azure region into which the resources should be deployed.')
param location string = 'swedencentral'

var sku = {
  name: 'F1'
  capacity: 1
}

resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
  name: 'F1'
  location: location
  sku: sku
}

@secure()
param adminPassword string
param adminUser string

resource pgsql 'Microsoft.DBForPostgreSQL/servers@2017-12-01' = {
  name: 'postgres-dbapp'
  location: location
  sku: {
    name: 'B_Gen5_1'
    tier: 'Basic'
    family: 'Gen5'
    capacity: 1
  }
  properties: {
    createMode: 'Default'
    publicNetworkAccess: 'Enabled'
    administratorLogin: adminUser
    administratorLoginPassword: adminPassword
  }
}
