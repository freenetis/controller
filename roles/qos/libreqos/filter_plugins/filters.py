import unicodedata


def qos_network(qos_classes):

    network = {}
    parents = {}
    root = None

    for id, cls in qos_classes.items():

        if not len(cls['children']):
            continue

        id = int(id)
        name = unidecode(cls['name'])

        item = {
            'downloadBandwidthMbps': int(round(cls['d_ceil'] / 1048576)),
            'uploadBandwidthMbps': int(round(cls['u_ceil'] / 1048576)),
        }

        parents[id] = item

        if cls['parent']:

            if "children" not in parents[cls['parent']]:
                parents[cls['parent']]['children'] = {}

            parents[cls['parent']]['children'][name] = item

            if cls['parent'] == root:
                network[name] = item
        else:
            root = id

    return network


def unidecode(str):
    nfkd_form = unicodedata.normalize("NFKD", str)
    return nfkd_form.encode("ASCII", "ignore").decode()


class FilterModule(object):
    def filters(self):
        return {
            "unidecode": unidecode,
            "qos_network": qos_network
        }
