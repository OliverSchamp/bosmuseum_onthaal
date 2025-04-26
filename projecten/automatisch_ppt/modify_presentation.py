print("started python script")

import uno
from com.sun.star.beans import PropertyValue
from com.sun.star.uno import Exception as UnoException

print("finished importing")

def modify_presentation(file_path):
    # Connect to LibreOffice in headless mode
    local_context = uno.getComponentContext()
    resolver = local_context.ServiceManager.createInstanceWithContext(
        "com.sun.star.bridge.UnoUrlResolver", local_context)
    context = resolver.resolve("uno:socket,host=localhost,port=2002;urp;StarOffice.ComponentContext")
    desktop = context.ServiceManager.createInstanceWithContext("com.sun.star.frame.Desktop", context)

    # Open the presentation
    args = (PropertyValue("Hidden", 0, True, 0),)
    print(file_path)
    doc = desktop.loadComponentFromURL(f"file://{file_path}", "_blank", 0, args)

    # Set slide transitions for all slides
    slides = doc.getDrawPages()
    for i in range(slides.getCount()):
        slide = slides.getByIndex(i)
        slide.Change = 1  # Automatic transition
        slide.TransitionType = 1  # Fade effect (simple animation)
        slide.TransitionFadeColor = 0  # Black fade (default)
        slide.TransitionDuration = 2  # 2 seconds for animation
        slide.Duration = 5  # 5 seconds wait before next slide

    # Set presentation to loop indefinitely
    presentation_settings = doc.getPresentation()
    presentation_settings.IsEndless = True  # Loop indefinitely
    presentation_settings.Pause = 0  # No delay between loops

    # Save and close
    doc.store()
    doc.dispose()

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python3 modify_presentation.py /path/to/presentation.odp")
        sys.exit(1)
    file_path = sys.argv[1]
    try:
        modify_presentation(file_path)
        print(f"Modified {file_path} successfully.")
    except UnoException as e:
        print(f"Modified {file_path} unsuccessfully.")
        print(f"Error: {e}")
        sys.exit(1)
