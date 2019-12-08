#!/usr/bin/env python3

"""

Copyright (C) 2020 Vanessa Sochat.

This Source Code Form is subject to the terms of the
Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed
with this file, You can obtain one at http://mozilla.org/MPL/2.0/.

"""

from bs4 import BeautifulSoup

import markdown
import os
import re
import sys

# The README.md must exist
root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
print('Root of repository is %s' % root)

readme = os.path.join(root, 'README.md')

print('Looking for readme %s' % readme)

if not os.path.exists(readme):
    sys.exit("README.md not found at root of respository.")

with open(readme, 'r') as filey:
    html = markdown.markdown(filey.read())

# Convert to beautiful soup
soup = BeautifulSoup(html, "lxml")

# Supported span prefixes
prefixes = ["question", "example"]
prefix_regex = "^(%s)" % "|".join(prefixes)

# Ensure that each span is all lowercase, with no extra characters
for span in soup.find_all("span"):

    # The span is required to have an id
    identifier = span.attrs.get('id')
    if not identifier:
        sys.exit('Span %s is missing an identifier.' % span)

    # The span id must start with a valid prefix
    if not re.search(prefix_regex, identifier):
        sys.exit('Span %s does not start with %s' %(identifier, prefix_regex))
 
    # The span id must have all lowercase, no special characters or spaces
    if re.search("[^A-Za-z0-9-]+", identifier):
        sys.exit("Span %s is invalid: can only have lowercase and '-'" % identifier)

print("%s is valid!" % readme)
