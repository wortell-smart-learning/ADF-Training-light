@description('Your initials (so for Koos van Strien that would be KvS)')
param initials string = ''

var unique_string = '${substring(uniqueString(resourceGroup().id), 0, 3)}${toLower(initials)}'
var location = resourceGroup().location
var administratorLogin = 'sqladmin'
var administratorLoginPassword = 'WortellSmartLearning.nl'
var containerName = 'data'

resource server 'Microsoft.Sql/servers@2020-02-02-preview' = {
  name: 'sql-${unique_string}'
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource serverName_sourceDB 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  parent: server
  name: 'sqldb-source'
  location: location
  properties: {
    sampleName: 'AdventureWorksLT'
  }
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource serverName_targetDB 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  parent: server
  name: 'sqldb-target'
  location: location
  properties: {}
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource serverName_AllowAllIps 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: server
  name: 'AllowAllIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'st${unique_string}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource storageAccount_blobservice 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = {
  parent: storageAccount
  name: 'default'
}

resource storageAccountName_default_container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  parent: storageAccount_blobservice
  name: containerName
}

resource dataLake 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'dl${unique_string}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    isHnsEnabled: true
  }
}
resource dataLake_BlobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: dataLake
  name: 'default'
}

resource dataLake_default_container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: dataLake_BlobService
  name: containerName
}

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: 'adf-${unique_string}'
  location: location
  properties: {}
  identity: {
    type: 'SystemAssigned'
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' = {
  name: 'kv-${unique_string}'
  location: location
  properties: {
    tenantId: subscription().tenantId
    enableSoftDelete: false
    accessPolicies: [
      {
        objectId: dataFactory.identity.principalId
        tenantId: subscription().tenantId
        permissions: {
          secrets: [
            'list'
            'get'
          ]
        }
      }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

resource keyVaultName_administratorLogin 'Microsoft.KeyVault/vaults/secrets@2021-04-01-preview' = {
  parent: keyVault
  name: administratorLogin
  properties: {
    value: administratorLoginPassword
  }
}
