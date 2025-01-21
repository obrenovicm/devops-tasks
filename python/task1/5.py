import argparse
import os
import sys
import platform
import shutil
import cpuinfo

if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    
    # -d distro, -m memory, -c CPU, -u user info, -l load average, -i IP address

    parser.add_argument('-d', help='Display distribution information', action='store_true')
    parser.add_argument('-m', help='Display memory information', action='store_true')
    parser.add_argument('-u', help='Display user information', action='store_true')
    parser.add_argument('-l', help='Display load average', action='store_true')
    parser.add_argument('-i', help='Display IP address', action='store_true')
    parser.add_argument('-c', help='Display CPU information', action='store_true')
    args = parser.parse_args()

    print(f'Arguments passed to program : {args}')

    if args.d:
        print(f"Distribution information : {platform.system()} ; {platform.release()} ; {platform.platform()}")

    if args.m:
        print(f'Memory information : {shutil.disk_usage("/")}')

    if args.u:
        print(f"User information: {os.popen('whoami').read()}")

    if args.l:
        print(f"Load average : {os.getloadavg()}")

    if args.i:
        print(f"IP address : {os.popen('ipconfig getifaddr en0').read()}")

    if args.c:
        print(f"CPU information: {cpuinfo.get_cpu_info()['brand_raw']}")