param location string = resourceGroup().location
param environmentName string
param appName string = 'quickshop'

var resourceNamePrefix = '${appName}-${environmentName}'
var appServicePlanName = '${resourceNamePrefix}-plan'
var appServiceName = '${resourceNamePrefix}-app'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: environmentName == 'production' ? 'P1V2' : 'B1'
    tier: environmentName == 'production' ? 'PremiumV2' : 'Basic'
  }
}

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output appServiceUrl string = 'https://${appService.properties.defaultHostName}'
