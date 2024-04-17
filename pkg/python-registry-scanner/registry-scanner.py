import json
import requests
import subprocess
import urllib3

urllib3.disable_warnings()
req = requests.get("https://localhost:5000/v2/_catalog", auth=('admin', 'admin123'), verify=False)
resp = json.loads(req.text)
for repository in resp['repositories']:
    tag_req = requests.get("https://localhost:5000/v2/{}/tags/list".format(repository), auth=('admin','admin123'), verify=False)
    tag_resp = json.loads(tag_req.text)
    for tag in tag_resp['tags']:
        print("{}:{}".format(repository, tag))
        #subprocess.call(["grype", "{}:{}".format(repository, tag)])
