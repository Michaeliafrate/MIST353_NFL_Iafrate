#!/bin/bash
python -m gunicorn --pythonpath API -w 4 -k uvicorn.workers.UvicornWorker nfl_playoffs_api:app
