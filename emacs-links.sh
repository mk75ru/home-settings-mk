#!/bin/sh

rm ../.emacs.el
ln -s  -T ~/home-settings-mk/.emacs_mk.el  ../.emacs.el

rm ../.emacs.d/local
ln -s -T ~/home-settings-mk/.emacs_nilsdeppe_and_local.d/local  ../.emacs.d/local

rm ../.ycm_extra_conf.py
ln -s  -T ~/home-settings-mk/.ycm_extra_conf_nilsdeppe.py  ../.ycm_extra_conf.py



