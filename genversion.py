#!/usr/bin/env python3
import tkinter
import tkinter.ttk
import datetime
import os
import signal

date = datetime.datetime.now()
quoter = -(-date.month // 3) - 1 if date.month >= 4 else 4
year = date.year if quoter != 4 else date.year - 1

root = tkinter.Tk()
root.title("SereneLinux ISO Builder")
root.geometry("300x50")

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
subver_piliod = tkinter.Label(text=" . ")
subver_piliod.place(x=120, y=10)

lastver = tkinter.ttk.Combobox(root, state='readonly', width=1)
lastver["values"] = ("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
lastver.current(0)
lastver.place(x=135, y=10)

#Button
def cleackd(root):
    print(label + "." + mejorver.get() + "." + subver.get() + "." + lastver.get())
    # Kill process
    root.destroy()

button = tkinter.Button(text="OK", command=lambda : cleackd(root) )
button.place(x=240, y=10)

root.mainloop()
