import platform


def get_os():
    grains = {}

    grains['sv'] = {"kernel": platform.system()}
    grains['yas'] = "123"
    return grains


if __name__ == '__main__':
    get_os()
