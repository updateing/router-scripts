#!/bin/sh
ip6tables -F
ip6tables -P FORWARD ACCEPT
# Following is needed on Tomato but not Merlin
ip6tables -P INPUT ACCEPT
