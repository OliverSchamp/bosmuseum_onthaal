import tkinter as tk
import os
import logging
from PIL import Image, ImageTk

#logging.basicConfig(filename='/tmp/display_message.log', level=logging.DEBUG, format='%(asctime)s %(levelname)s: %(message)s')

os.environ['DISPLAY'] = ':0'
#logging.debug("DISPLAY set to: %s", os.environ.get('DISPLAY'))

try:
    root = tk.Tk()
    root.title("PPT UPDATE")
    large_bold_font = ("Helvetica", 24, "bold")
    image_path = "/home/dietpi/bosmuseum_onthaal/projecten/automatisch_ppt/loading.jpg"
    image = Image.open(image_path)
    image = image.resize((100, 100), Image.LANCZOS)
    photo = ImageTk.PhotoImage(image)
    label = tk.Label(
        root,
        text="Aan het updaten.\nNiet afsluiten.",
        padx=20,
        pady=20,
        font=large_bold_font
    )
    label.pack(pady=10)

    image_label = tk.Label(root, image=photo)
    image_label.pack()
    # prevent garbage collection
    image_label.image = photo

    root.geometry("600x300")
    root.eval('tk::PlaceWindow . center')
    root.attributes('-topmost', True)
    root.mainloop()
except Exception as e:
    logging.error("Tkinter error: %s", e)
