@description('Globally unique web app name')
param appName string
param location string = resourceGroup().location


resource plan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: '${appName}-plan'
  location: location
  sku: {
    name: 'S1'      // Standard — required for slots
    tier: 'Standard'
  }
  kind: 'linux'
  properties: {
    reserved: true  // required for Linux plans
  }
}

resource web 'Microsoft.Web/sites@2024-04-01' = {
  name: appName
  location: location
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      appSettings: [
        { name: 'SLOT_NAME', value: 'production' }
        { name: 'SLOT_COLOR', value: 'green' }
        { name: 'ASPNETCORE_URLS', value: 'http://0.0.0.0:8080' }
        { name: 'WEBSITE_RUN_FROM_PACKAGE', value: '1' }
      ]
    }
  }
}

resource staging 'Microsoft.Web/sites/slots@2024-04-01' = {
  parent: web
  name: 'staging'
  location: location
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      appSettings: [
        { name: 'SLOT_NAME', value: 'staging' }
        { name: 'SLOT_COLOR', value: 'orange' }
        { name: 'ASPNETCORE_URLS', value: 'http://0.0.0.0:8080' }
        { name: 'WEBSITE_RUN_FROM_PACKAGE', value: '1' }
        { name: 'WEBSITE_SWAP_WARMUP_PING_PATH', value: '/health' }
        { name: 'WEBSITE_SWAP_WARMUP_PING_STATUSES', value: '200,202' }
      ]
    }
  }
}

resource dev 'Microsoft.Web/sites/slots@2024-04-01' = {
  parent: web
  name: 'dev'
  location: location
  identity: { type: 'SystemAssigned' }
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      appSettings: [
        { name: 'SLOT_NAME', value: 'dev' }
        { name: 'SLOT_COLOR', value: 'blue' }
        { name: 'ASPNETCORE_URLS', value: 'http://0.0.0.0:8080' }
        { name: 'WEBSITE_RUN_FROM_PACKAGE', value: '1' }
        { name: 'WEBSITE_SWAP_WARMUP_PING_PATH', value: '/health' }
        { name: 'WEBSITE_SWAP_WARMUP_PING_STATUSES', value: '200,202' }
      ]
    }
  }
}

// Pin SLOT_NAME/SLOT_COLOR as sticky so they never travel during a swap
resource stickyProd 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: web
  name: 'slotConfigNames'
  properties: {
    appSettingNames: [ 'SLOT_NAME', 'SLOT_COLOR' ]
  }
}

output defaultHostName string = web.properties.defaultHostName
