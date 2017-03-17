
import json
# This converts from JSON to a python dict
parsed_input = json.loads('terraform.tfstate')

# Now, all of your static variables are referenceable as keys:
secret = parsed_input['modules']

pprint(secret)
