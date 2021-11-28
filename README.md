# udfclient-termux
very minor hack making udfclient compile on termux

you must cd into (quite-longly-named) special root directory after getting UDF prompt:

$ ./udfclient -W disk
--------------------------------
WARNING: writing enabled, use on own risc
        * DONT cancel program or data-loss might occure
        * set dataspace userlimits very high when writing thousands of files

Enjoy your writing!
--------------------------------


        bufcache thread initialising
Opening device disk
UDF device disk is a regular file

UDF Dump of disc in device disk
UDF sessions : Yes

Start mounting
        retrieving volume space
                `unallocated space descriptor' ignored
        eliminating predescessors
        retrieving logical volume dependencies 0xf6c0a000
                Logical volume  `619bfd4c95bc4357LinuxUDF`:`1`:`1`
                        integrity
                                marked closed at  (2021 11 22 at 23:27:56.16.12.51)
                                marked open   at  (2021 11 22 at 20:30:22.48.47.23)
                                marked closed at  (2021 11 22 at 20:31:34.50.25.93)
                                marked open   at  (2021 11 22 at 20:39:50.84.48.43)
                                marked closed at  (2021 11 22 at 20:40:27.20.07.65)
                        supporting tables
                        fileset(s)
                        checking writable filesets
                        used/freed space tables



Resulting list of alive sets :

UDF volume sets marked alive :
Volume set `619bfd4c95bc4357LinuxUDF` (1 volume) with 1 partition
        Partition number 0 at device `disk' session 0 from sector 257(+0) for 25080 sectors
        Primary volume `1` (part 1/1) created by implementator `*Linux UDFFS' by/for application `*Linux mkudffs 2.3'
                contains logical volume  `1`
                        mapping 0 on 0 as direct recording data metadata


Directory listing of /
drwxrwxrwx     -1     -1         176  619bfd4c95bc4357LinuxUDF:1:1:LinuxUDF
UDF working directory is     /
Current FS working directory /data/data/com.termux/files/home/udfclient/UDFclient.0.8.11
UDF> cd 619bfd4c95bc4357LinuxUDF:1:1:LinuxUDF
