import numpy as np
from google.cloud import secretmanager
from dotenv import load_dotenv
import os
from os.path import join, dirname

load_dotenv(verbose=True)
dotenv_path = join(dirname(__file__), ".env")
load_dotenv(dotenv_path)

PROJECT_ID = os.environ.get("PROJECT_ID")
SECRET_NAME = os.environ.get("SECRET_NAME")
VERSION = os.environ.get("VERSION")

def process(n: int):
    result = n * 2 * 34 / 12 % 23
    return str(result)

def get_secret(project_id: str, secret_name: str, version: str):
    client = secretmanager.SecretManagerServiceClient()
    name = client.secret_version_path(project_id, secret_name, version)
    response = client.access_secret_version(name=name)
    return response.payload.data.decode("UTF-8")



def main(*args):
    credential_data = get_secret(PROJECT_ID, SECRET_NAME, VERSION)
    print("secret: ", credential_data)
    arr = np.arange(1000000)
    vprocess = np.vectorize(process)
    result = vprocess(arr)
    return repr(result)


if __name__ == "__main__":
    """
    適当な処理
    """
    print(main())