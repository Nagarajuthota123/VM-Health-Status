#!/bin/bash

echo "Audit Report - $(date)"

echo "Logged-in users:"

W

echo "Last login attempts:"

last -a | head-10

echo "Failed SSH logins:"

grep "Failed password" /var/log/auth.log | tail -5
