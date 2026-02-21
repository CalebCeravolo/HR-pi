#!/usr/bin/env bash
gpio mode $1 output
sudo gpio write $1 1