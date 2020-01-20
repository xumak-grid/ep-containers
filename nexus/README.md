# Initial EP Nexus

You must have user:password for the EP proxy repositories and replace `PASSWORD-HERE` in `ep-nexus.json` and `ep-init-container.json` files

## Run EP Nexus in local container

- Go to [init-container/nexus](https://github.com/xumak-grid/init-containers/tree/master/nexus) project
- Follow the **Local Test** instructions using the follow env var

```sh
NEXUS_CONFIG_FILE="examples/ep-init-container.json"
```

## Deploy EP Nexus to K8s

Deploy a Nexus with all initial proxies, hosteds and groups using Bedrock API

- Go to [Bedrock-api](https://github.com/xumak-grid/bedrock) project and follow the steps to run the project in localhost
- See what versions of nexus are available

`http://localhost:8000/api/v1/vendors/artifactory/list`

- Then make a POST request to the server with the JSON body [ep-nexus.json](ep-nexus.json)

`POST: http://localhost:8000/api/v1/clients/ep-client/artifactory`
