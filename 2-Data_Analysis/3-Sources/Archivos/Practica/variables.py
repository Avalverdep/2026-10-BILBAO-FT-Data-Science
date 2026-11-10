import os
doc_types = ('.doc', '.docx', '.txt', '.pdf', '.xls', '.ppt', '.xlsx', '.pptx')
img_types = ('.jpg', '.jpeg', '.png', '.svg', '.gif', 'webp')
software_types = ('.exe', '.py','.ipynb')
home = os.path.expanduser('~')  #establecer home como ruta del pc donde se pruebe esto
descargas = os.path.join(home, 'Downloads') #tira de home y agrega descargas como carpeta para mover
directorio_n = os.path.join(home, 'Desktop', 'Descargas_n') #crear carpeta clon en el escritorio tirando de home como antes