import falcon
import json


class QuoteResource:
    def on_get(self, req, resp):
        """Handles GET requests"""
        quote = {
                'quote': 'I\'ve alaways been more instresi',
                'author': 'Grace Hopper',
                }
        resp.body = json.dumps(quote)

api = falcon.API()
api.add_route('/quote', QuoteResource())

