# Weather API query Lambda

## Description

In this lab we will create a new Lambda function in AWS Console to retrieve current weather from OpenWeatherMap API

## Deployment

Search for the Lambda service in the list of services and create a new blank Lambda function

![Lambda service search](/2_lambda/img/Lambda_service.png)

### Create a Lambda function

Create a new Python Lambda by providing a name, latest Python runtime, choose to create a new role with basic Lambda permissions

![Lambda creation screen](/2_lambda/img/Lambda_create.png)

After the Lambda has been created, copy [source code](lambda_function.py) in the editor window and click Deploy

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

After the layer has been uploaded, it can now be added back in the Lambda Layers section (navigate back to the Lambda function created and look at the bottom of the Code tab)

![Adding a layer](/2_lambda/img/Add_layer.png)

### Running the function

Now that everything is set up, we can execute our function and see the results.

![Running Lambda](/2_lambda/img/Lambda_run.png)

Click on the Test button, the first execution will require you to create a test event.

Since our Lambda needs to know the name of the city we would like to get the weather for, we can pass it in as part of the event

![Creating test event](/2_lambda/img/Create_test_event.png)

Now we can run our function with the test event and get the results

![Run results](/2_lambda/img/Lambda_results.png)

### Reading logs

As an optional part of the lab, explore logs that Lambda creates in Cloudwatch. Those logs are created automatically by the Lambda based on the data being printed in the Lambda function.

You can find the logs either by going to the Lambda Monitor tab and clicking on View CloudWatch logs or going to Cloudwatch service directly and look around to see if you can find the log group for your Lambda

### Teardown

After you have ensured that the deployment works, you can clean up the changes you deployed by navigating to Lambda and deleting Lambda function and Lambda layer. Additionally you can delete Cloudwatch log group and IAM role created for the Lambda
