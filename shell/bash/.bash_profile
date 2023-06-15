#!/bin/bash

# Some OSes like Ubuntu/Mac expect bash_profile to be present
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
