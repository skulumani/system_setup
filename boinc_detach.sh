#!/bin/bash

for url in $(boinccmd --get_project_status | sed -n 's/\s*master URL: //p'); do
  boinccmd --project ${url} detach;
done
