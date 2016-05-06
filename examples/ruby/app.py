#!/usr/bin/env python
import sys
import os

os.system(' '.join(["/opt/rbenv/shims/bundle exec ruby main.rb"] + sys.argv[1:]))
