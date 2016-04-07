#!/bin/bash
route add -net 224.0.0.0 netmask 240.0.0.0 dev he
cvlc --repeat file_uscablehe_playout_238.ts --sout="#std{access=udp{ttl=5},dst=224.1.1.10:1234,mux=ts{pid-video=256,pid-audio=512}}" --sout-keep
