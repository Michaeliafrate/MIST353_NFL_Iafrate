#!/bin/bash
cd API
gunicorn -w 4 -k uvicorn.workers.UvicornWorker nfl_playoffs_api:app
