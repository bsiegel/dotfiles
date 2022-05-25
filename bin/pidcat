#!/usr/bin/env -S python3 -u
# -*- coding: utf-8 -*-

'''
Copyright 2009, The Android Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
'''

# Script to highlight adb logcat output for console
# Originally written by Jeff Sharkey, http://jsharkey.org/
# Piping detection and popen() added by other Android team members
# Package filtering and output improvements by Jake Wharton, http://jakewharton.com


import os
import re
import sys
import datetime
import shutil
import logging
import argparse
import subprocess

__version__ = '3.0.0'  # 3 for py3


#####################
#   Global Logger   #
#####################

def init_mylogger():
    logging.getLogger().setLevel(logging.DEBUG)  # set root logger level
    mylogger = logging.getLogger("pidcat")
    formatter = logging.Formatter("%(asctime)s - %(filename)s[line:%(lineno)d] - [%(levelname)s] : %(message)s", "%y-%m-%d %H:%M:%S")
    if mylogger.hasHandlers():
        mylogger.handlers = []
    sh = logging.StreamHandler(sys.stdout)
    sh.setLevel(logging.INFO)  # stdout logging level
    sh.setFormatter(formatter)
    mylogger.addHandler(sh)
    mylogger.propagate = False
    return mylogger


#########################
#   Global Const Zone   #
#########################

LOG_LEVELS = 'VDIWEF'
LOG_LEVELS_MAP = dict([(LOG_LEVELS[i], i) for i in range(len(LOG_LEVELS))])

BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)
RESET = '\033[0m'
LAST_USED = [RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN]
KNOWN_TAGS = {
    'dalvikvm': WHITE,
    'Process': WHITE,
    'ActivityManager': WHITE,
    'ActivityThread': WHITE,
    'AndroidRuntime': CYAN,
    'jdwp': WHITE,
    'StrictMode': WHITE,
    'DEBUG': YELLOW,
}

PID_LINE = re.compile(r'^\w+\s+(\w+)\s+\w+\s+\w+\s+\w+\s+\w+\s+\w+\s+\w\s([\w|\.|\/|:]+)$')
PID_START = re.compile(r'^.*: Start proc ([a-zA-Z0-9._:]+) for ([a-z]+ [^:]+): pid=(\d+) uid=(\d+) gids=(.*)$')
PID_START_5_1 = re.compile(r'^.*: Start proc (\d+):([a-zA-Z0-9._:]+)/([a-z0-9])+ for (.*)$')  # mostly now
PID_START_DALVIK = re.compile(r'^E/dalvikvm\(\s*(\d+)\): >>>>> ([a-zA-Z0-9._:]+) \[ userId:0 \| appId:(\d+) \]$')

PID_KILL = re.compile(r'^Killing (\d+):([a-zA-Z0-9._:]+)/[^:]+: (.*)$')
PID_LEAVE = re.compile(r'^No longer want ([a-zA-Z0-9._:]+) \(pid (\d+)\): .*$')
PID_DEATH = re.compile(r'^Process ([a-zA-Z0-9._:]+) \(pid (\d+)\) has died.?$')

LOG_LINE = re.compile(r'^([A-Z])/(.+?)\( *(\d+)\): (.*?)$')  # each line of logcat -v brief
BUG_LINE = re.compile(r'.*nativeGetEnabledTags.*')  # seems not useful
BACKTRACE_LINE = re.compile(r'^#(.*?)pc\s(.*?)$')

##############################
#   Global Variable Zone 1   #
##############################

My_Logger = init_mylogger()
Min_Level = 'V'
Pkg_Names = []
Pkg_Pids = set()
Header_Size = 28
Terminal_Width = -1
Work_Path = os.getcwd()


#######################
#   Colorize Relate   #
#######################

def termcolor(fg=None, bg=None):
    codes = []
    if fg is not None: codes.append('3%d' % fg)
    if bg is not None: codes.append('10%d' % bg)
    return '\033[%sm' % ';'.join(codes) if codes else ''


def colorize(message, fg=None, bg=None):
    return termcolor(fg, bg) + message + RESET


def indent_wrap(message):
    if Terminal_Width == -1:
        return message
    message = message.replace('\t', '    ')
    wrap_area = Terminal_Width - Header_Size
    messagebuf = ''
    current = 0
    while current < len(message):
        next = min(current + wrap_area, len(message))
        messagebuf += message[current:next]
        if next < len(message):
            messagebuf += '\n'
            messagebuf += ' ' * Header_Size
        current = next
    return messagebuf


def allocate_color(tag):
    # this will allocate a unique format for the given tag
    # since we dont have very many colors, we always keep track of the LRU
    if tag not in KNOWN_TAGS:
        KNOWN_TAGS[tag] = LAST_USED[0]
    color = KNOWN_TAGS[tag]
    if color in LAST_USED:
        LAST_USED.remove(color)
        LAST_USED.append(color)
    return color

##########################
# Shell Execute Wrapper  #
##########################

def exec_shell_daemon(cmd):
    # My_Logger.info(cmd)
    return subprocess.Popen(cmd, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)


def exec_shell(cmd, t=120):
    # My_Logger.debug(cmd)
    ret = {}
    try:
        p = subprocess.run(cmd, stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=True, encoding='utf-8', timeout=t)
        if p.returncode == 0:
            ret['d'] = p.stdout
        else:
            ret['e'] = p.stderr
    except subprocess.TimeoutExpired:
        ret['e'] = 'timeout'
    return ret


def gen_log_file_name():
    filename = datetime.datetime.now().strftime('%Y-%m-%d-%H-%M-%S.log')
    return filename


##########################
#   Parse command args   #
##########################

def init_argparse():
    parser = argparse.ArgumentParser(description='Filter logcat by package name')

    parser.add_argument('package', nargs='*', help='Application package name(s)')

    parser.add_argument('-w', '--tag-width', metavar='N', dest='tag_width', type=int, default=23,
                        help='Width of log tag')
    parser.add_argument('-l', '--min-level', dest='min_level', type=str, choices=LOG_LEVELS + LOG_LEVELS.lower(),
                        default='V', help='Minimum level to be displayed')

    parser.add_argument('--color-gc', dest='color_gc', action='store_true', help='Color garbage collection')
    parser.add_argument('--always-display-tags', dest='always_tags', action='store_true',
                        help='Always display the tag name')

    parser.add_argument('-n', '--current', dest='current_app', action='store_true',
                        help='Filter logcat by current running app')
    parser.add_argument('-a', '--all', dest='all', action='store_true', default=False, help='Print all log messages')

    parser.add_argument('-s', '--serial', dest='device_serial', help='Device serial number (adb -s option)')
    parser.add_argument('-d', '--device', dest='use_device', action='store_true',
                        help='Use first device for log input (adb -d option)')
    parser.add_argument('-e', '--emulator', dest='use_emulator', action='store_true',
                        help='Use first emulator for log input (adb -e option)')

    parser.add_argument('-c', '--clear', dest='clear_logcat', action='store_true',
                        help='Clear the entire log before running')

    parser.add_argument('-t', '--tag', dest='tag', action='append', help='Filter output by specified tag(s)')
    parser.add_argument('-i', '--ignore-tag', dest='ignored_tag', action='append',
                        help='Filter output by ignoring specified tag(s)')

    parser.add_argument('-v', action='version', version='%(prog)s ' + __version__,
                        help='Print the version number and exit')

    parser.add_argument('-y', '--yes', dest='pidcat_tags_ignore', action='store_true',
                        help='Use .pidcat_tags_ignore for filter.')

    parser.add_argument('-o', '--log',
                        nargs="?",
                        type=argparse.FileType('w', encoding='UTF-8'),
                        const=gen_log_file_name(),
                        dest='log_to_file',
                        help='Output original-form content to log file')

    return parser.parse_args()


def prepare_from_args(args):
    global Min_Level, Pkg_Names, Header_Size, Terminal_Width

    Min_Level = LOG_LEVELS_MAP[args.min_level.upper()]
    Pkg_Names = args.package

    base_adb_command = ['adb']
    if args.device_serial:
        base_adb_command.extend(['-s', args.device_serial])
    if args.use_device:
        base_adb_command.append('-d')
    if args.use_emulator:
        base_adb_command.append('-e')

    if args.current_app:
        cmd = "adb shell dumpsys activity top"
        system_dump = exec_shell_daemon(cmd).communicate()[0].decode("utf-8")
        running_package_name, running_package_pid = re.findall(r'ACTIVITY\s+(\S*)\/\S*.*pid=(\d+)', system_dump)[-1]
        Pkg_Names.append(running_package_name)
        Pkg_Pids.add(running_package_pid)

    # My_Logger.info(Pkg_Names)

    if not Pkg_Names:
        args.all = True

    # Store the names of packages for which to match all processes.
    catchall_package = list(filter(lambda package: package.find(":") == -1, Pkg_Names))

    Header_Size = args.tag_width + 1 + 3 + 1  # space, level, space

    try:
        # Terminal_Height = os.get_terminal_size().lines
        Terminal_Width = os.get_terminal_size().columns
        # When use pipe like `pidcat | grep Activity` throws:
        # OSError: [Errno 25] Inappropriate ioctl for device
        # See:
        #   [[2020-07-20] eclipse - How to allocate a pseudo-tty in which to run scripts from IDE? - Stack Overflow](https://stackoverflow.com/questions/44851652/how-to-allocate-a-pseudo-tty-in-which-to-run-scripts-from-ide/44852103#44852103)
        #   [[2020-07-20] module - Pycharm os.get_terminal_size() not working - Stack Overflow](https://stackoverflow.com/questions/56817448/pycharm-os-get-terminal-size-not-working/56818020)

    except Exception as e:
        try:
            # Another more compatible way to get the current terminal width.
            import fcntl, termios, struct
            h, Terminal_Width = struct.unpack('cool', fcntl.ioctl(0, termios.TIOCGWINSZ, struct.pack('cool', 0, 0)))
            My_Logger.error(Terminal_Width)
        except Exception as e:
            pass

    # Only enable GC coloring if the user opted-in
    if args.color_gc:
        # GC_CONCURRENT freed 3617K, 29% free 20525K/28648K, paused 4ms+5ms, total 85ms
        key = re.compile(
            r'^(GC_(?:CONCURRENT|FOR_M?ALLOC|EXTERNAL_ALLOC|EXPLICIT) )(freed <?\d+.)(, \d+\% free \d+./\d+., )(paused \d+ms(?:\+\d+ms)?)')
        val = r'\1%s\2%s\3%s\4%s' % (termcolor(GREEN), RESET, termcolor(YELLOW), RESET)

        RULES[key] = val

    adb_command = base_adb_command[:]
    adb_command.append('logcat')
    adb_command.extend(['-v', 'brief'])

    # Clear log before starting logcat
    if args.clear_logcat:
        adb_clear_command = list(adb_command)
        adb_clear_command.append('-c')
        adb_clear = subprocess.Popen(adb_clear_command)

        # may take a while
        while adb_clear.poll() is None:
            pass

    # Dealing with Use .pidcat_tags_ignore for filter.
    if args.pidcat_tags_ignore:
        try:
            with open(".pidcat_tags_ignore", mode='r', encoding='utf-8') as f:
                file_content = f.readlines()
                if len(file_content) < 1:
                    raise FileNotFoundError

                if not args.tag:
                    args.tag = []
                if not args.ignored_tag:
                    args.ignored_tag = []

                for line in file_content:
                    if line[0] == '#' or not line.strip():
                        continue
                    if line[0] == '!':
                        args.ignored_tag.append(line[1:].strip())
                    else:
                        args.tag.append(line.strip())
        except FileNotFoundError:
            try:
                with open(".pidcat_tags_ignore", mode='w', encoding='utf-8') as f:
                    pass
                print("[Error] Turn on -y with empty .pidcat_tags_ignore file.")
                exit(-1)
            except Exception as e:
                print(e)

    My_Logger.debug("args.tag:")
    My_Logger.debug(args.tag)
    My_Logger.debug("ignored_tag.tag:")
    My_Logger.debug(args.ignored_tag)

    return adb_command


##############################
#   Global Variable Zone 2   #
##############################

RULES = {
    # StrictMode policy violation; ~duration=319 ms: android.os.StrictMode$StrictModeDiskWriteViolation: policy=31 violation=1
    re.compile(r'^(StrictMode policy violation)(; ~duration=)(\d+ ms)')
    : r'%s\1%s\2%s\3%s' % (termcolor(RED), RESET, termcolor(YELLOW), RESET),
}

TAGTYPES = {
    'V': colorize(' V ', fg=WHITE, bg=BLACK),
    'D': colorize(' D ', fg=BLACK, bg=BLUE),
    'I': colorize(' I ', fg=BLACK, bg=GREEN),
    'W': colorize(' W ', fg=BLACK, bg=YELLOW),
    'E': colorize(' E ', fg=BLACK, bg=RED),
    'F': colorize(' F ', fg=BLACK, bg=RED),
}


######################
#   Message Utils    #
######################

def match_packages(token):
    if not Pkg_Names:
        return True
    if token in Pkg_Names:
        return True
    index = token.find(':')
    return (token in Pkg_Names) if index == -1 else (token[:index] in Pkg_Names)


def parse_death(tag, message):
    if tag != 'ActivityManager':
        return None, None
    kill = PID_KILL.match(message)
    if kill:
        pid = kill.group(1)
        package_line = kill.group(2)
        if match_packages(package_line) and pid in Pkg_Pids:
            return pid, package_line
    leave = PID_LEAVE.match(message)
    if leave:
        pid = leave.group(2)
        package_line = leave.group(1)
        if match_packages(package_line) and pid in Pkg_Pids:
            return pid, package_line
    death = PID_DEATH.match(message)
    if death:
        pid = death.group(2)
        package_line = death.group(1)
        if match_packages(package_line) and pid in Pkg_Pids:
            return pid, package_line
    return None, None


def parse_start_proc(line):
    start = PID_START_5_1.match(line)
    if start is not None:
        # My_Logger.info("PID_START_5_1")  # mostly
        # I/ActivityManager( 1678): Start proc 24541:com.miui.hybrid/u0a89 for service com.miui.hybrid/.statistics.StatsService caller=com.miui.home
        line_pid, line_package, line_uid, target = start.groups()
        return line_package, target, line_pid, line_uid, ''
    start = PID_START.match(line)
    if start is not None:
        # My_Logger.info("PID_START")
        line_package, target, line_pid, line_uid, line_gids = start.groups()
        return line_package, target, line_pid, line_uid, line_gids
    start = PID_START_DALVIK.match(line)
    if start is not None:
        # My_Logger.info("PID_START_DALVIK")
        line_pid, line_package, line_uid = start.groups()
        return line_package, '', line_pid, line_uid, ''
    return None


def tag_in_tags_regex(tag, tags):
    return any(re.match(r'^' + t + r'$', tag) for t in map(str.strip, tags))


def get_pids():
    ps_pid = exec_shell_daemon("adb shell ps")
    while True:
        try:
            line = ps_pid.stdout.readline().decode('utf-8', 'replace').strip()
        except KeyboardInterrupt:
            break
        if len(line) == 0:
            break

        pid_match = PID_LINE.match(line)
        if pid_match is not None:
            pid = pid_match.group(1)
            proc = pid_match.group(2)
            # .debug(pid + " " + proc)
            if proc in Pkg_Names:
                Pkg_Pids.add(pid)


##################
#   Main Entry   #
##################

if __name__ == '__main__':
    My_Logger.debug(os.getcwd())
    my_args = init_argparse()
    My_Logger.debug(my_args)
    adb_command = prepare_from_args(my_args)
    get_pids()

    cmd = " ".join(adb_command).strip()
    My_Logger.debug(cmd)

    logcat_process = exec_shell_daemon(cmd)

    last_tag = None
    app_pid = None

    My_Logger.debug(my_args)

    while logcat_process.poll() is None:
        try:
            line = logcat_process.stdout.readline().decode('utf-8', 'replace').strip()
        except KeyboardInterrupt:
            if my_args.log_to_file:
                print("...Saving logs to :" + my_args.log_to_file.name)
                my_args.log_to_file.close()
            break
        if len(line) == 0:
            break

        # seems not useful
        bug_line = BUG_LINE.match(line)
        if bug_line is not None:
            continue

        # each line of logcat -v brief
        log_line = LOG_LINE.match(line)
        if log_line is None:
            continue

        # Store log file
        if my_args.log_to_file:
            my_args.log_to_file.write(line)
            my_args.log_to_file.write("\n")

        level, tag, owner, message = log_line.groups()
        tag = tag.strip()
        start = parse_start_proc(line)
        if start:
            line_package, target, line_pid, line_uid, line_gids = start
            if match_packages(line_package):
                Pkg_Pids.add(line_pid)

                app_pid = line_pid

                linebuf = '\n'
                linebuf += colorize(' ' * (Header_Size - 1), bg=WHITE)
                linebuf += indent_wrap(' Process %s created for %s\n' % (line_package, target))
                linebuf += colorize(' ' * (Header_Size - 1), bg=WHITE)
                linebuf += ' PID: %s   UID: %s   GIDs: %s' % (line_pid, line_uid, line_gids)
                linebuf += '\n'
                print(linebuf)
                last_tag = None  # Ensure next log gets a tag printed

        dead_pid, dead_pname = parse_death(tag, message)
        if dead_pid:
            Pkg_Pids.remove(dead_pid)
            linebuf = '\n'
            linebuf += colorize(' ' * (Header_Size - 1), bg=RED)
            linebuf += ' Process %s (PID: %s) ended' % (dead_pname, dead_pid)
            linebuf += '\n'
            print(linebuf)
            last_tag = None  # Ensure next log gets a tag printed

        # Make sure the backtrace is printed after a native crash
        if tag == 'DEBUG':
            bt_line = BACKTRACE_LINE.match(message.lstrip())
            if bt_line is not None:
                message = message.lstrip()
                owner = app_pid

        if not my_args.all and owner not in Pkg_Pids:
            continue
        if level in LOG_LEVELS_MAP and LOG_LEVELS_MAP[level] < Min_Level:
            continue
        if my_args.ignored_tag and tag_in_tags_regex(tag, my_args.ignored_tag):
            continue
        if my_args.tag and not tag_in_tags_regex(tag, my_args.tag):
            continue

        linebuf = ''

        if my_args.tag_width > 0:
            # right-align tag title and allocate color if needed
            if tag != last_tag or my_args.always_tags:
                last_tag = tag
                color = allocate_color(tag)
                tag = tag[-my_args.tag_width:].rjust(my_args.tag_width)
                linebuf += colorize(tag, fg=color)
            else:
                linebuf += ' ' * my_args.tag_width
            linebuf += ' '

        # write out level colored edge
        if level in TAGTYPES:
            linebuf += TAGTYPES[level]
        else:
            linebuf += ' ' + level + ' '
        linebuf += ' '

        # format tag message using rules
        for matcher in RULES:
            replace = RULES[matcher]
            message = matcher.sub(replace, message)

        linebuf += indent_wrap(message)
        print(linebuf)
