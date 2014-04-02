# helper tasks for the big paper

BIB = 'references.bib'
CSL = 'acm-sigchi-proceedings.csl'
DOC = 'sample'

import os
import shutil

from shovel import task  # pip install shovel
import envoy  # pip install envoy


@task
def html(doc=None):
    """
    TODO html fragment task?
    """
    if doc is None:
        doc = DOC
    if not os.path.isdir('./gen') or not os.path.isdir('./gen/css'):
        os.makedirs('./gen/css')
    for f in os.listdir('./css'):
        shutil.copy('./css/' + f, './gen/css')
    cmd = 'pandoc -s -S --biblio={0}.bib --csl={1} --from=markdown --to=html5 --template=./template-html5-bootstrap.html --section-divs --toc --css=./css/normalize.css --css=./css/bootstrap.min.css --css=./css/letterpress.css -o ./gen/{2}.html ./content/{2}.md'
    r = envoy.run(cmd.format(doc, CSL, doc))
    #r = envoy.run('open {0}.html'.format(FNAME))
    print(r.status_code)
