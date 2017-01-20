#!/bin/sh
# Set USB sound card as a default sink
pacmd set-default-sink alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo
pulseaudiocontrol u 1
pulseaudiocontrol d 1
