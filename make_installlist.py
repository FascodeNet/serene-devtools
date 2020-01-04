#!/usr/bin/env python3

import subprocess
import configparser
import os
import errno


#installed = subprocess.run(["apt-mark", "showmanual", "|", "sort", "-u"], stdout=subprocess.PIPE)
installed = """
    tigervnc-standalone-server
    time
    tzdata
    ubiquity
    """

config = configparser.ConfigParser()
config_path = './serenebuilder.conf'

#エラー処理
if not os.path.exists(config_path):
    raise FileNotFoundError(errno.ENOENT, os.strerror(errno.ENOENT), config_path)

config.read(config_path, encoding='utf-8')

def makelist(item, name):
    read = config[item]
    packages = read.get(name)
    if packages is None:
        return "None"
    return {i for i in packages.split()}

install_package = makelist('Add', 'Package')

for i in installed.split():
    install_package.add(i)

remove_package = makelist('Ignore', 'Package')
add_dir = makelist('Add', 'Dir')
remove_dir = makelist('Ignore', 'Dir')

#read_ignore = config['Ignore']
#ignore_packages = read_ignore.get('Package')
#remove_package = {i for i in ignore_packages.split()}

#read_add = config['Add']
#add_packages = read_add.get('Package')
#install_package = {i for i in installed.split() + add_packages.split()}





def out(var):
    print(str(var).translate(str.maketrans({'{': '', ',': '', '}': '', '\'': ''})))

out(install_package)
out(remove_package)
out(add_dir)
out(remove_dir)