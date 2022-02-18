import numpy as np
from google.cloud import secretmanager
from google.oauth2 import service_account
from dotenv import load_dotenv
import os
from os.path import join, dirname
import pprint

load_dotenv(verbose=True)
dotenv_path = join(dirname(__file__), ".env")
load_dotenv(dotenv_path)


keyfile_name = '/application/src/google-credential.json'


PROJECT_ID="79432760668"
SECRET_NAME="my-secrets"
VERSION=1


def process(n: int):
    result = n * 2 * 34 / 12 % 23
    return str(result)

def get_secret(project_id: str, secret_name: str, version: str):
    print("credentialを読み込む")
    credentials = service_account.Credentials.from_service_account_file(keyfile_name)
    print("credential読み込み成功")
    print("secretmanager clientの作成")
    client = secretmanager.SecretManagerServiceClient(credentials=credentials)
    print("secretmanager clientの作成成功")
    print("resourcename")
    name = client.secret_version_path(project_id, secret_name, version)
    print("resourcename 完了")
    response = client.access_secret_version(name=name)
    return response.payload.data.decode("UTF-8")



def main(*args):
    print("start!")
    with open(keyfile_name,mode="r",encoding="utf-8") as fr:
        print("そもそも読めるの？")
        print("読めた!")
    credential_data = get_secret(PROJECT_ID, SECRET_NAME, VERSION)
    print("secret: ", credential_data)
    arr = np.arange(100)
    vprocess = np.vectorize(process)
    result = vprocess(arr)
    print("Goal!")
    return repr(result)


if __name__ == "__main__":
    """
    適当な処理
    """
    print(main())