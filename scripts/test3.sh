#!/bin/bash

USAGE: ls * | ./test3.sh

awk '\
BEGIN 	{ print "File\t\t\t\t\t\tOwner" } \
		{ print $9, "\t\t\t\t\t", $3}	\
END   	{ print " - DONE -" } \
'