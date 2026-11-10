import variables as vr
import os
import shutil

def moveralgo(entrada):
    os.chdir(vr.descargas)
    destino = os.path.join(vr.directorio_n, entrada)
    os.makedirs(destino, exist_ok=True)
    if entrada == 'Todo':
            for carpeta in ['img', 'Documentos', 'Software', 'Otros']:
                moveralgo(carpeta)
            return
    
    for i in os.listdir():
        match entrada:
    
            case 'img':
                if i.endswith(vr.img_types):
                    print("Imagen", i)
                    shutil.move(i, destino)
            case 'Documentos':
                if i.endswith(vr.doc_types):
                    print('Documento: ', i)
                    shutil.move(i, destino)
            case 'Software':
                if i.endswith(vr.software_types):
                    print('SW', i)
                    shutil.move(i, destino)
            case 'Otros':
                if not i.endswith(vr.img_types) and not i.endswith(vr.software_types) and not i.endswith(vr.doc_types):
                    print('Movidas variadas: ', i)
                    shutil.move(i, destino)
            case _:
                print('No es un caso válido')
                break

def devolveralgo(entrada):
    if entrada == 'Todo':
        for carpeta in ['img', 'Documentos', 'Software', 'Otros']:
            devolveralgo(carpeta)
        return

    origen = os.path.join(vr.directorio_n, entrada)
    if not os.path.isdir(origen):
        print('No existe la carpeta', entrada)
        return
    for i in os.listdir(origen):
        print('Devolviendo: ', i)
        shutil.move(os.path.join(origen, i), vr.descargas)

