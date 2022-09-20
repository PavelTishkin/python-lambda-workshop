# Weather API query Lambda

## Description

The code for the Lambda to retrieve current weather from OpenWeatherMap API

## Deployment

Create a new blank Lambda function in AWS console

### Create a Lambda function

Create a new Python Lambda by providing a name, latest Python runtime, choose create a new role with basic Lambda permissions

![Lambda creation screen](/2_lambda/img/Lambda_create.png)

After the Lambda has been created, copy source code in the editor window and click Deploy
![Lambda adding code](/2_lambda/img/Add_code.png)

### Configure additional settings

Since it is not a good idea to embed API keys in the source code, it would be advantegeous to pass secrets through other means. One of the simplest ways is to use environment variables.

Navigate to Configuration -> Environment variables

Set variable API_KEY with the value of the OpenWeatherMap API key

![Setting environment variables](/2_lambda/img/Env_vars.png)

### Deploy packages layer

The Lambda has a limited amount of built in packages, any additional packages will need to be deployed either as part of Lambda source code or as a layer.

To deploy a layer, navigate to Lambda -> Layers -> Create layer.
The layer will accept a .zip package containing libraries under directory named python.

![Creating a layer](/2_lambda/img/Create_layer.png)

After the layer has been uploaded, it can now be added back in the Lambda Layers section

![Adding a layer](/2_lambda/img/Add_layer.png)