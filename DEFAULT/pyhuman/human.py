import argparse
import signal
import os
import random
import sys
import datetime
from importlib import import_module
from time import sleep
from datetime import time
from random import randint

TASK_CLUSTER_COUNT = 5
TASK_INTERVAL_SECONDS = 10
GROUPING_INTERVAL_SECONDS = 500 #3600
EXTRA_DEFAULTS = []

GO_TO_BED_START = '23:59:59' 
GO_TO_BED_END = '00:00:00' 

SLEEP_TIME_AMOUNT_MIN = 0 #14400
SLEEP_TIME_AMOUNT_MAX = 0 #43200

def emulation_loop(clustersize, workflows, taskinterval, taskgroupinterval, gtbstart, gtbend,
        sleepmin, sleepmax, extra):
    while True:
        for c in range(clustersize):
            sleep(random.randrange(taskinterval))
            index = random.randrange(len(workflows))
            print(workflows[index].display)
            workflows[index].action(extra)
        sleep(random.randrange(taskgroupinterval))
        
        if datetime.datetime.now().time() > datetime.datetime.strptime(gtbstart, '%H:%M:%S').time() or datetime.datetime.now().time() < datetime.datetime.strptime(gtbend, '%H:%M:%S').time():
            sleepyTime = randint(sleepmin, sleepmax) 
            print("SLEEPING FOR",sleepyTime,"SECONDS")
            sleep(sleepyTime)


def import_workflows():
    extensions = []
    for root, dirs, files in os.walk(os.path.join(os.path.dirname(os.path.realpath(__file__)), 'app', 'workflows')):
        files = [f for f in files if not f[0] == '.' and not f[0] == "_"]
        dirs[:] = [d for d in dirs if not d[0] == '.' and not d[0] == "_"]
        for file in files:
            try:
                extensions.append(load_module('app/workflows', file))
            except Exception as e:
                print('Error could not load workflow. {}'.format(e))
    return extensions


def load_module(root, file):
    module = os.path.join(*root.split('/'), file.split('.')[0]).replace(os.path.sep, '.')
    workflow_module = import_module(module)
    return getattr(workflow_module, 'load')()


def run(clustersize, taskinterval, taskgroupinterval, gtbstart, gtbend,
        sleepmin, sleepmax, extra):

    random.seed()
    workflows = import_workflows()

    def signal_handler(sig, frame):
        for workflow in workflows:
            workflow.cleanup()
        exit(0)
    
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    emulation_loop(clustersize=clustersize, workflows=workflows, taskinterval=taskinterval,
                    taskgroupinterval=taskgroupinterval, gtbstart=gtbstart,gtbend=gtbend,
                    sleepmin=sleepmin, sleepmax=sleepmax, extra=extra)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Emulate human behavior on a system')
    parser.add_argument('--clustersize', type=int, default=TASK_CLUSTER_COUNT)
    parser.add_argument('--taskinterval', type=int, default=TASK_INTERVAL_SECONDS)
    parser.add_argument('--taskgroupinterval', type=int, default=GROUPING_INTERVAL_SECONDS)

    parser.add_argument('--gtbstart', type=str, default=GO_TO_BED_START)
    parser.add_argument('--gtbend', type=str, default=GO_TO_BED_END)
    parser.add_argument('--sleepmin', type=int, default=SLEEP_TIME_AMOUNT_MIN)
    parser.add_argument('--sleepmax', type=int, default=SLEEP_TIME_AMOUNT_MAX)

    parser.add_argument('--extra', nargs='*', default=EXTRA_DEFAULTS)
    args = parser.parse_args()

    try:
        run(
            clustersize=args.clustersize,
            taskinterval=args.taskinterval,
            taskgroupinterval=args.taskgroupinterval,
            
            gtbstart=args.gtbstart,
            gtbend=args.gtbend,
            sleepmin=args.sleepmin,
            sleepmax=args.sleepmax,



            extra=args.extra
        )
    except KeyboardInterrupt:
        print(" Terminating human execution...")
        sys.exit()