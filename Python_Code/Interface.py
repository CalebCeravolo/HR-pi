import tkinter as tk
import subprocess

# result = subprocess.run(["./myprog", "arg1", "arg2"], capture_output=True, text=True)
# print(result.stdout)   # program output
# print(result.stderr)   # error output (if needed)
class Viewing_Window:
    "Top level window for viewing command output"
    def __init__(self, top=None, command=None):
        '''This class configures and populates the toplevel window.
           top is the toplevel containing window.'''
        self.command = command
        top.protocol("WM_DELETE_WINDOW", self.on_closing)
        top.geometry("1178x589+104+110")
        top.minsize(120, 1)
        top.maxsize(1444, 881)
        top.resizable(1,  1)
        top.title("Main")
        top.configure(background="#d9d9d9")
        top.configure(highlightbackground="#d9d9d9")
        top.configure(highlightcolor="#000000")
    def command_loop(self):    
        result = subprocess.run([self.command], capture_output=True, text=True)
top = tk.Tk()

# result = subprocess.run(
#     ["./myprog"],
#     input="hello world\n",          # data sent to stdin
#     capture_output=True,
#     text=True
# )
top_window = Viewing_Window(top)
# print("Output:", result.stdout)

top.mainloop()




