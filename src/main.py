import numpy as np



def process(n: int):
    result = n * 2 * 34 / 12 % 23
    return str(result)

# 引数にrequestを追加する
# flask.requestが引数に渡されるため、
def main(request) -> str:
    arr = np.arange(1000000)
    vprocess = np.vectorize(process)
    result = vprocess(arr)
    return repr(result)


if __name__ == "__main__":
    """
    適当な処理
    """
    print(main())