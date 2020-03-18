#!/usr/bin/env python3
import tkinter
import tkinter.ttk
import datetime
import os
import signal

date = datetime.datetime.now()
<<<<<<< HEAD
quoter = -(-date.month // 3) - 1 if date.month >= 3 else 4
=======
quoter = -(-date.month // 3) - 1 if date.month >= 4 else 4
>>>>>>> 20.04
year = date.year if quoter != 4 else date.year - 1

root = tkinter.Tk()
root.title("SereneLinux ISO Builder")
<<<<<<< HEAD
root.geometry("300x50")
=======
root.geometry("200x50")
>>>>>>> 20.04

#Label
label = str(year)[2:] + "q" + str(quoter)
Static1 = tkinter.Label(text=label + " . ")
Static1.place(x=10, y=10)

#Entry
mejorver = tkinter.ttk.Combobox(root, state='readonly', width=1)
mejorver["values"] = ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
mejorver.current(0)
mejorver.place(x=55, y=10)
mejorver_piliod = tkinter.Label(text=" . ")
mejorver_piliod.place(x=80, y=10)

subver = tkinter.ttk.Combobox(root, state='readonly', width=1)
subver["values"] = ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
subver.current(0)
subver.place(x=95, y=10)
<<<<<<< HEAD
subver_piliod = tkinter.Label(text=" . ")
subver_piliod.place(x=120, y=10)

lastver = tkinter.ttk.Combobox(root, state='readonly', width=1)
lastver["values"] = ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
lastver.current(0)
lastver.place(x=135, y=10)

#Button
def cleackd(root):
    print(label + "." + mejorver.get() + "." + subver.get() + "." + lastver.get())
=======

#Button
def cleackd(root):
    print(label + "." + mejorver.get() + "." + subver.get())
>>>>>>> 20.04
    # Kill process
    root.destroy()

button = tkinter.Button(text="OK", command=lambda : cleackd(root) )
<<<<<<< HEAD
button.place(x=240, y=10)
=======
button.place(x=150, y=7)
>>>>>>> 20.04

root.mainloop()
