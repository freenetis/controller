import unicodedata


def unidecode(str):
    nfkd_form = unicodedata.normalize("NFKD", str)
    return nfkd_form.encode("ASCII", "ignore").decode()


class FilterModule(object):
    def filters(self):
        return {"unidecode": unidecode}
