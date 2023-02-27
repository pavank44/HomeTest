## AWS resource list Retrieval Script

This script retrieves the services used in an AWS account for the last 1 days, grouped by region and service name. It uses the AWS Cost Explorer API to retrieve the data and the boto3 Python library to interact with the API.

**Prerequisites**
Before running this script, make sure that you have the following:
- An AWS account with access to the Cost Explorer API.
- Python 3.x installed on your local machine.
- The boto3  module installed.
 
You can install the boto3  module using pip, the package installer for Python. Open a command prompt or terminal and run the following commands:

```shell
pip install boto3
```

**Usage**
To use this script, follow these steps:

- Open a text editor and copy the script into a new file.
- Replace ACCESS_KEY and SECRET_KEY with your own AWS access keys.
- Save the file with a .py extension, such as aws_cost_usage.py.
- Open a command prompt or terminal and navigate to the directory where the script is saved.
- Run the script by entering the following command:

```shell
python list_services.py
```